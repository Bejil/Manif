import { randomUUID } from 'node:crypto'
import type { ImportModeId, ImportSourceId } from '#shared/constants/import-sources'
import type { EventRecord } from '#shared/types/event'
import type { ImportCandidateRecord, ImportRunRecord, ImportRunStats } from '#shared/types/import'
import { createEventSlug, ensureUniqueSlug } from '#shared/utils/slug'
import { timezoneFromPostalOrCity } from '../utils/timezone'
import { geocodeFrenchPlace } from './geocoding'
import { buildImportWorkUnits } from './importers'
import {
  countCandidatesByStatuses,
  createImportRun,
  findImportMatch,
  getImportRun,
  getPendingCandidates,
  insertCandidates,
  updateCandidate,
  updateImportRun,
  type ImportMatchReason,
} from './import-repository'
import { getEventById, upsertEvent } from './events-repository'
import { getMockStore, nowIso } from './mock-store'
import { useMockDb } from '../utils/supabase'

export async function startImportRun(input: {
  sources: ImportSourceId[]
  mode: ImportModeId
  militantOnly?: boolean
  geocode?: boolean
  maxPerSource?: number
  actorId: string
}): Promise<ImportRunRecord> {
  const units = buildImportWorkUnits(input.sources, {
    militantOnly: input.militantOnly,
    maxPerSource: input.maxPerSource,
  })
  const run = await createImportRun({
    sources: input.sources,
    mode: input.mode,
    options: {
      militantOnly: input.militantOnly !== false,
      geocode: input.geocode !== false,
      maxPerSource: input.maxPerSource,
    },
    totalUnits: units.length,
    actorId: input.actorId,
  })
  await updateImportRun(run.id, {
    status: 'running',
    startedAt: nowIso(),
    progress: {
      cursor: 0,
      totalUnits: units.length,
      unitsDone: [],
      message: 'Démarrage…',
    },
  })
  return (await getImportRun(run.id))!
}

/** Traite une unité de scrape (ou passe à la préparation / apply). */
export async function continueImportRun(runId: string): Promise<{
  run: ImportRunRecord
  done: boolean
  step: string
}> {
  let run = await getImportRun(runId)
  if (!run) throw createError({ statusCode: 404, statusMessage: 'Import introuvable' })
  if (run.status === 'failed' || run.status === 'cancelled') {
    return { run, done: true, step: run.status }
  }
  // Reprend un run « completed » qui a encore des candidats non écrits (bug prepare / boucle coupée)
  if (run.status === 'completed') {
    const pendingLeft = await countCandidatesByStatuses(runId, ['pending'])
    const toApply = await countCandidatesByStatuses(runId, ['ready', 'duplicate'])
    if (pendingLeft > 0) {
      run = await updateImportRun(runId, {
        status: 'scraped',
        finishedAt: null,
        progress: {
          ...run.progress,
          message: `Reprise — ${pendingLeft} candidat(s) encore à préparer…`,
        },
      })
    }
    else if (toApply > 0) {
      run = await updateImportRun(runId, {
        status: 'applying',
        finishedAt: null,
        progress: {
          ...run.progress,
          message: `Reprise — ${toApply} candidat(s) encore à écrire…`,
        },
      })
    }
    else {
      return { run, done: true, step: run.status }
    }
  }

  const units = buildImportWorkUnits(run.sources, {
    militantOnly: run.options.militantOnly,
    maxPerSource: run.options.maxPerSource,
  })

  if (run.status === 'running' || run.status === 'pending') {
    const cursor = run.progress.cursor ?? 0
    if (cursor < units.length) {
      const unit = units[cursor]!
      try {
        const scraped = await unit.run()
        const added = await insertCandidates(runId, scraped)
        const stats: ImportRunStats = {
          ...run.stats,
          scraped: (run.stats.scraped || 0) + added,
          bySource: {
            ...run.stats.bySource,
            [unit.source]: (run.stats.bySource[unit.source] || 0) + added,
          },
        }
        const progress = {
          cursor: cursor + 1,
          totalUnits: units.length,
          currentUnit: unit.label,
          unitsDone: [...run.progress.unitsDone, unit.id],
          message: `${unit.label} : +${added} candidats`,
        }
        const next = await updateImportRun(runId, {
          status: 'running',
          stats,
          progress,
          startedAt: run.startedAt || nowIso(),
        })
        return { run: next, done: false, step: `scrape:${unit.id}` }
      }
      catch (e) {
        const msg = e instanceof Error ? e.message : String(e)
        const progress = {
          cursor: cursor + 1,
          totalUnits: units.length,
          currentUnit: unit.label,
          unitsDone: [...run.progress.unitsDone, unit.id],
          message: `Erreur ${unit.label}: ${msg}`,
        }
        const stats = {
          ...run.stats,
          errors: (run.stats.errors || 0) + 1,
        }
        // continue malgré erreur source
        const next = await updateImportRun(runId, { status: 'running', progress, stats })
        return { run: next, done: false, step: `scrape-error:${unit.id}` }
      }
    }

    // Scrape terminé → préparer (match + géocode)
    await updateImportRun(runId, {
      status: 'scraped',
      progress: {
        ...run.progress,
        cursor: units.length,
        totalUnits: units.length,
        message: 'Scrape terminé — préparation des candidats…',
      },
    })
    return continueImportRun(runId)
  }

  if (run.status === 'scraped') {
    const prepared = await prepareCandidatesBatch(runId, run.options.geocode !== false)
    if (!prepared.exhausted) {
      const fresh = (await getImportRun(runId))!
      return { run: fresh, done: false, step: 'prepare' }
    }

    await updateImportRun(runId, {
      status: 'applying',
      progress: { ...run.progress, message: 'Application des candidats…' },
    })
    return continueImportRun(runId)
  }

  if (run.status === 'applying') {
    const applied = await applyCandidatesBatch(runId, run.mode)
    if (!applied.exhausted) {
      const fresh = (await getImportRun(runId))!
      return { run: fresh, done: false, step: 'apply' }
    }
    const next = await updateImportRun(runId, {
      status: 'completed',
      finishedAt: nowIso(),
      progress: {
        ...run.progress,
        message: 'Import terminé',
      },
    })
    return { run: next, done: true, step: 'completed' }
  }

  return { run, done: true, step: run.status }
}

async function prepareCandidatesBatch(runId: string, doGeocode: boolean) {
  const pendingOnly = await getPendingCandidates(runId, 25)
  if (!pendingOnly.length) return { exhausted: true }

  const run = (await getImportRun(runId))!
  let ready = run.stats.ready || 0
  let duplicates = run.stats.duplicates || 0
  let errors = run.stats.errors || 0

  for (const c of pendingOnly) {
    try {
      let lat = c.latitude
      let lon = c.longitude
      let postal = c.postalCode
      let city = c.cityName
      let tz = c.timezone

      if (doGeocode && (lat == null || lon == null)) {
        const geo = await geocodeFrenchPlace({
          cityName: c.cityName,
          locationName: c.locationName,
          postalCode: c.postalCode || undefined,
        })
        if (geo) {
          lat = geo.latitude
          lon = geo.longitude
          postal = geo.postalCode || postal
          city = geo.cityName || city
          tz = geo.timezone || tz
        }
        await new Promise(r => setTimeout(r, 40))
      }

      const match = await findImportMatch({
        sourceUrl: c.sourceUrl,
        title: c.title,
        cityName: city,
        startAt: c.startAt,
      })

      if (match) {
        await updateCandidate(c.id, {
          status: 'duplicate',
          matchEventId: match.eventId,
          latitude: lat,
          longitude: lon,
          postalCode: postal,
          cityName: city,
          timezone: tz,
          payload: {
            ...c.payload,
            matchReason: match.reason,
            matchScore: match.score,
          },
        })
        duplicates++
      }
      else {
        await updateCandidate(c.id, {
          status: 'ready',
          latitude: lat,
          longitude: lon,
          postalCode: postal,
          cityName: city,
          timezone: tz,
        })
        ready++
      }
    }
    catch (e) {
      await updateCandidate(c.id, {
        status: 'error',
        errorMessage: e instanceof Error ? e.message : String(e),
      })
      errors++
    }
  }

  await updateImportRun(runId, {
    stats: { ...run.stats, ready, duplicates, errors },
    progress: {
      ...run.progress,
      message: `Préparation… prêts=${ready} doublons=${duplicates}`,
    },
  })

  return { exhausted: pendingOnly.length < 25 }
}

async function applyCandidatesBatch(runId: string, mode: ImportModeId) {
  const run = (await getImportRun(runId))!
  const { items } = await listCandidatesForApply(runId, 20)
  if (!items.length) return { exhausted: true }

  let created = run.stats.created || 0
  let updated = run.stats.updated || 0
  let skipped = run.stats.skipped || 0
  let errors = run.stats.errors || 0

  const existingSlugs = await loadSlugSet()
  const publicationStatus = mode === 'draft' ? 'draft' : 'published'

  for (const c of items) {
    try {
      const startAt = c.startAt
      let endAt = c.endAt
      if (startAt && endAt && endAt <= startAt) {
        endAt = new Date(new Date(startAt).getTime() + 3 * 3600 * 1000).toISOString().replace(/\.\d{3}Z$/, 'Z')
      }
      else if (startAt && !endAt) {
        endAt = new Date(new Date(startAt).getTime() + 3 * 3600 * 1000).toISOString().replace(/\.\d{3}Z$/, 'Z')
      }

      // Re-check au moment d’écrire (événements créés plus tôt dans le même run)
      let matchEventId = c.status === 'duplicate' ? c.matchEventId : null
      let matchReason: ImportMatchReason | null = (c.payload?.matchReason as ImportMatchReason | undefined) || null
      if (!matchEventId || c.status === 'ready') {
        const live = await findImportMatch({
          sourceUrl: c.sourceUrl,
          title: c.title,
          cityName: c.cityName,
          startAt: c.startAt,
        })
        if (live) {
          matchEventId = live.eventId
          matchReason = live.reason
        }
      }

      if (matchEventId) {
        const existing = await getEventById(matchEventId)
        if (!existing) {
          await updateCandidate(c.id, { status: 'skipped', errorMessage: 'Événement lié introuvable' })
          skipped++
          continue
        }
        const reason = matchReason || 'source_url'
        const patched: EventRecord = {
          ...existing,
          title: c.title,
          description: c.description,
          category: c.category,
          cityName: c.cityName,
          postalCode: c.postalCode,
          locationName: c.locationName,
          latitude: c.latitude,
          longitude: c.longitude,
          startAt,
          endAt,
          endIsEstimated: c.endIsEstimated !== false,
          organizerName: c.organizerName,
          timezone: c.timezone || existing.timezone,
          // Match titre : on conserve l’URL déjà en base pour ne pas casser le dédoublonnage source
          sourceUrl: reason === 'source_url' ? c.sourceUrl : (existing.sourceUrl || c.sourceUrl),
          updatedAt: nowIso(),
          publicationStatus: publicationStatus === 'published' ? 'published' : existing.publicationStatus,
          publishedAt: publicationStatus === 'published'
            ? (existing.publishedAt || nowIso())
            : existing.publishedAt,
        }
        await upsertEvent(patched)
        await updateCandidate(c.id, { status: 'applied', appliedEventId: existing.id })
        updated++
        continue
      }

      if (c.status !== 'ready' && c.status !== 'duplicate') {
        await updateCandidate(c.id, { status: 'skipped' })
        skipped++
        continue
      }

      const base = createEventSlug(c.title, c.cityName, startAt)
      const slug = ensureUniqueSlug(base, existingSlugs)
      existingSlugs.add(slug)
      const id = randomUUID()
      const now = nowIso()
      const record: EventRecord = {
        id,
        slug,
        title: c.title,
        description: c.description,
        category: c.category,
        cityName: c.cityName,
        postalCode: c.postalCode,
        localityCode: null,
        countryCode: 'FR',
        timezone: c.timezone || timezoneFromPostalOrCity(c.postalCode, c.cityName),
        locationName: c.locationName,
        latitude: c.latitude,
        longitude: c.longitude,
        locationRevealAt: null,
        startAt,
        endAt,
        endIsEstimated: c.endIsEstimated !== false,
        organizerName: c.organizerName,
        sourceUrl: c.sourceUrl,
        imageUrls: [],
        videoUrls: [],
        sourceVerificationStatus: 'source_provided',
        publicationStatus,
        eventStatusOverride: null,
        createdAt: now,
        updatedAt: now,
        publishedAt: publicationStatus === 'published' ? now : null,
        isDemo: false,
      }
      const saved = await upsertEvent(record)
      await updateCandidate(c.id, { status: 'applied', appliedEventId: saved.id })
      created++
    }
    catch (e) {
      await updateCandidate(c.id, {
        status: 'error',
        errorMessage: e instanceof Error ? e.message : String(e),
      })
      errors++
    }
  }

  await updateImportRun(runId, {
    stats: { ...run.stats, created, updated, skipped, errors },
    progress: {
      ...run.progress,
      message: `Application… créés=${created} maj=${updated}`,
    },
  })

  return { exhausted: items.length < 20 }
}

async function listCandidatesForApply(runId: string, limit: number): Promise<{ items: ImportCandidateRecord[] }> {
  if (useMockDb()) {
    const store = getMockStore() as ReturnType<typeof getMockStore> & {
      importCandidates?: ImportCandidateRecord[]
    }
    const items = (store.importCandidates || [])
      .filter(c => c.runId === runId && (c.status === 'ready' || c.status === 'duplicate'))
      .slice(0, limit)
    return { items }
  }
  const { getServiceSupabase } = await import('../utils/supabase')
  const { data, error } = await getServiceSupabase()
    .from('import_candidates')
    .select('*')
    .eq('run_id', runId)
    .in('status', ['ready', 'duplicate'])
    .order('created_at', { ascending: true })
    .limit(limit)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  const items: ImportCandidateRecord[] = (data ?? []).map((row: Record<string, unknown>) => ({
    id: String(row.id),
    runId: String(row.run_id),
    source: row.source as ImportCandidateRecord['source'],
    sourceUrl: String(row.source_url),
    externalId: (row.external_id as string | null) ?? null,
    title: String(row.title),
    description: String(row.description),
    category: row.category as ImportCandidateRecord['category'],
    cityName: String(row.city_name),
    postalCode: (row.postal_code as string | null) ?? null,
    locationName: String(row.location_name),
    latitude: (row.latitude as number | null) ?? null,
    longitude: (row.longitude as number | null) ?? null,
    startAt: row.start_at ? String(row.start_at) : null,
    endAt: row.end_at ? String(row.end_at) : null,
    endIsEstimated: Boolean(row.end_is_estimated ?? true),
    organizerName: (row.organizer_name as string | null) ?? null,
    timezone: String(row.timezone || 'Europe/Paris'),
    payload: (row.payload as Record<string, unknown>) || {},
    status: row.status as ImportCandidateRecord['status'],
    matchEventId: (row.match_event_id as string | null) ?? null,
    appliedEventId: (row.applied_event_id as string | null) ?? null,
    errorMessage: (row.error_message as string | null) ?? null,
    createdAt: String(row.created_at),
    updatedAt: String(row.updated_at),
  }))
  return { items }
}

async function loadSlugSet(): Promise<Set<string>> {
  if (useMockDb()) {
    return new Set(getMockStore().events.map(e => e.slug))
  }
  const { getServiceSupabase } = await import('../utils/supabase')
  const { data, error } = await getServiceSupabase().from('events').select('slug')
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return new Set((data ?? []).map((r: { slug: string }) => r.slug))
}

export async function cancelImportRun(runId: string) {
  return updateImportRun(runId, {
    status: 'cancelled',
    finishedAt: nowIso(),
    progress: {
      cursor: 0,
      totalUnits: 0,
      unitsDone: [],
      message: 'Annulé',
    },
  })
}

export async function applyImportRunManual(runId: string) {
  const run = await getImportRun(runId)
  if (!run) throw createError({ statusCode: 404, statusMessage: 'Import introuvable' })
  await updateImportRun(runId, {
    status: 'applying',
    finishedAt: null,
    progress: {
      ...run.progress,
      message: run.mode === 'draft'
        ? 'Application manuelle (brouillons)…'
        : 'Application manuelle (publication)…',
    },
  })
  return continueImportRun(runId)
}
