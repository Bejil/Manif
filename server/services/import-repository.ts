import { randomUUID } from 'node:crypto'
import { DateTime } from 'luxon'
import type { ImportSourceId, ImportModeId } from '#shared/constants/import-sources'
import type {
  ImportCandidateRecord,
  ImportCandidateStatus,
  ImportRunProgress,
  ImportRunRecord,
  ImportRunStats,
  ImportRunStatus,
  ImportScrapedEvent,
} from '#shared/types/import'
import { normalizeSearchText, titleSimilarity } from '#shared/utils/search'
import { getMockStore, nowIso } from './mock-store'
import { getServiceSupabase, useMockDb } from '../utils/supabase'

/** Seuil titre : check secondaire (moins fort que l’URL source). */
export const IMPORT_TITLE_DUP_THRESHOLD = 0.72

export type ImportMatchReason = 'source_url' | 'title'

export interface ImportMatch {
  eventId: string
  reason: ImportMatchReason
  score: number
}

type ImportMockStore = ReturnType<typeof getMockStore> & {
  importRuns: ImportRunRecord[]
  importCandidates: ImportCandidateRecord[]
}

function emptyStats(): ImportRunStats {
  return {
    scraped: 0,
    ready: 0,
    duplicates: 0,
    created: 0,
    updated: 0,
    skipped: 0,
    errors: 0,
    bySource: {},
  }
}

function emptyProgress(totalUnits = 0): ImportRunProgress {
  return { cursor: 0, totalUnits, unitsDone: [] }
}

function ensureMockImports(): ImportMockStore {
  const store = getMockStore() as ImportMockStore
  if (!store.importRuns) store.importRuns = []
  if (!store.importCandidates) store.importCandidates = []
  return store
}

function rowToRun(row: Record<string, unknown>): ImportRunRecord {
  return {
    id: String(row.id),
    status: row.status as ImportRunStatus,
    mode: row.mode as ImportModeId,
    sources: (row.sources as ImportSourceId[]) || [],
    options: (row.options as ImportRunRecord['options']) || {},
    progress: (row.progress as ImportRunProgress) || emptyProgress(),
    stats: (row.stats as ImportRunStats) || emptyStats(),
    errorMessage: (row.error_message as string | null) ?? null,
    actorId: (row.actor_id as string | null) ?? null,
    startedAt: row.started_at ? String(row.started_at) : null,
    finishedAt: row.finished_at ? String(row.finished_at) : null,
    createdAt: String(row.created_at),
    updatedAt: String(row.updated_at),
  }
}

function rowToCandidate(row: Record<string, unknown>): ImportCandidateRecord {
  return {
    id: String(row.id),
    runId: String(row.run_id),
    source: row.source as ImportSourceId,
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
    status: row.status as ImportCandidateStatus,
    matchEventId: (row.match_event_id as string | null) ?? null,
    appliedEventId: (row.applied_event_id as string | null) ?? null,
    errorMessage: (row.error_message as string | null) ?? null,
    createdAt: String(row.created_at),
    updatedAt: String(row.updated_at),
  }
}

export async function createImportRun(input: {
  sources: ImportSourceId[]
  mode: ImportModeId
  options: ImportRunRecord['options']
  totalUnits: number
  actorId: string
}): Promise<ImportRunRecord> {
  const now = nowIso()
  const run: ImportRunRecord = {
    id: randomUUID(),
    status: 'pending',
    mode: input.mode,
    sources: input.sources,
    options: input.options,
    progress: emptyProgress(input.totalUnits),
    stats: emptyStats(),
    errorMessage: null,
    actorId: input.actorId,
    startedAt: null,
    finishedAt: null,
    createdAt: now,
    updatedAt: now,
  }

  if (useMockDb()) {
    ensureMockImports().importRuns.unshift(run)
    return run
  }

  const supabase = getServiceSupabase()
  const { data, error } = await supabase.from('import_runs').insert({
    id: run.id,
    status: run.status,
    mode: run.mode,
    sources: run.sources,
    options: run.options,
    progress: run.progress,
    stats: run.stats,
    actor_id: run.actorId,
  }).select('*').single()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return rowToRun(data)
}

export async function getImportRun(id: string): Promise<ImportRunRecord | null> {
  if (useMockDb()) {
    return ensureMockImports().importRuns.find(r => r.id === id) ?? null
  }
  const { data, error } = await getServiceSupabase()
    .from('import_runs').select('*').eq('id', id).maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return data ? rowToRun(data) : null
}

export async function listImportRuns(limit = 30): Promise<ImportRunRecord[]> {
  if (useMockDb()) {
    return ensureMockImports().importRuns.slice(0, limit)
  }
  const { data, error } = await getServiceSupabase()
    .from('import_runs')
    .select('*')
    .order('created_at', { ascending: false })
    .limit(limit)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToRun)
}

export async function updateImportRun(
  id: string,
  patch: Partial<{
    status: ImportRunStatus
    progress: ImportRunProgress
    stats: ImportRunStats
    errorMessage: string | null
    startedAt: string | null
    finishedAt: string | null
  }>,
): Promise<ImportRunRecord> {
  if (useMockDb()) {
    const store = ensureMockImports()
    const idx = store.importRuns.findIndex(r => r.id === id)
    if (idx < 0) throw createError({ statusCode: 404, statusMessage: 'Run introuvable' })
    const cur = store.importRuns[idx]!
    const next: ImportRunRecord = {
      ...cur,
      status: patch.status ?? cur.status,
      progress: patch.progress ?? cur.progress,
      stats: patch.stats ?? cur.stats,
      errorMessage: patch.errorMessage !== undefined ? patch.errorMessage : cur.errorMessage,
      startedAt: patch.startedAt !== undefined ? patch.startedAt : cur.startedAt,
      finishedAt: patch.finishedAt !== undefined ? patch.finishedAt : cur.finishedAt,
      updatedAt: nowIso(),
    }
    store.importRuns[idx] = next
    return next
  }

  const row: Record<string, unknown> = { updated_at: nowIso() }
  if (patch.status !== undefined) row.status = patch.status
  if (patch.progress !== undefined) row.progress = patch.progress
  if (patch.stats !== undefined) row.stats = patch.stats
  if (patch.errorMessage !== undefined) row.error_message = patch.errorMessage
  if (patch.startedAt !== undefined) row.started_at = patch.startedAt
  if (patch.finishedAt !== undefined) row.finished_at = patch.finishedAt

  const { data, error } = await getServiceSupabase()
    .from('import_runs').update(row).eq('id', id).select('*').single()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return rowToRun(data)
}

export async function insertCandidates(
  runId: string,
  events: ImportScrapedEvent[],
): Promise<number> {
  if (!events.length) return 0
  const now = nowIso()

  if (useMockDb()) {
    const store = ensureMockImports()
    let added = 0
    for (const ev of events) {
      if (store.importCandidates.some(c => c.runId === runId && c.sourceUrl === ev.sourceUrl)) continue
      store.importCandidates.push({
        id: randomUUID(),
        runId,
        source: ev.source,
        sourceUrl: ev.sourceUrl,
        externalId: ev.externalId ?? null,
        title: ev.title,
        description: ev.description,
        category: ev.category,
        cityName: ev.cityName,
        postalCode: ev.postalCode ?? null,
        locationName: ev.locationName,
        latitude: ev.latitude ?? null,
        longitude: ev.longitude ?? null,
        startAt: ev.startAt,
        endAt: ev.endAt,
        endIsEstimated: ev.endIsEstimated !== false,
        organizerName: ev.organizerName ?? null,
        timezone: ev.timezone || 'Europe/Paris',
        payload: ev.raw || {},
        status: 'pending',
        matchEventId: null,
        appliedEventId: null,
        errorMessage: null,
        createdAt: now,
        updatedAt: now,
      })
      added++
    }
    return added
  }

  const rows = events.map(ev => ({
    run_id: runId,
    source: ev.source,
    source_url: ev.sourceUrl,
    external_id: ev.externalId ?? null,
    title: ev.title,
    description: ev.description,
    category: ev.category,
    city_name: ev.cityName,
    postal_code: ev.postalCode ?? null,
    location_name: ev.locationName,
    latitude: ev.latitude ?? null,
    longitude: ev.longitude ?? null,
    start_at: ev.startAt,
    end_at: ev.endAt,
    end_is_estimated: ev.endIsEstimated !== false,
    organizer_name: ev.organizerName ?? null,
    timezone: ev.timezone || 'Europe/Paris',
    payload: ev.raw || {},
    status: 'pending',
  }))

  // upsert ignore duplicates within run
  const { error } = await getServiceSupabase()
    .from('import_candidates')
    .upsert(rows, { onConflict: 'run_id,source_url', ignoreDuplicates: true })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return rows.length
}

export async function listCandidates(
  runId: string,
  opts: {
    status?: ImportCandidateStatus
    /** Uniquement les créations (pas les maj auto d’existants) */
    onlyNew?: boolean
    limit?: number
    offset?: number
  } = {},
): Promise<{ items: ImportCandidateRecord[], total: number }> {
  const limit = opts.limit ?? 50
  const offset = opts.offset ?? 0

  if (useMockDb()) {
    let items = ensureMockImports().importCandidates.filter(c => c.runId === runId)
    if (opts.status) items = items.filter(c => c.status === opts.status)
    if (opts.onlyNew) {
      items = items.filter(c =>
        c.status === 'applied'
        && !c.matchEventId
        && c.payload?.applyKind !== 'updated',
      )
    }
    const total = items.length
    return { items: items.slice(offset, offset + limit), total }
  }

  let q = getServiceSupabase()
    .from('import_candidates')
    .select('*', { count: 'exact' })
    .eq('run_id', runId)
    .order('start_at', { ascending: true, nullsFirst: false })
    .range(offset, offset + limit - 1)
  if (opts.status) q = q.eq('status', opts.status)
  if (opts.onlyNew) {
    // Créations : applied sans match (les maj portent match_event_id)
    q = q.eq('status', 'applied').is('match_event_id', null)
  }
  const { data, error, count } = await q
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return { items: (data ?? []).map(rowToCandidate), total: count ?? 0 }
}

export async function getPendingCandidates(runId: string, limit = 40): Promise<ImportCandidateRecord[]> {
  // Uniquement « pending » : inclure « ready » faisait croire à tort que la
  // préparation était terminée (les plus anciens ready masquaient les pending restants).
  if (useMockDb()) {
    return ensureMockImports().importCandidates
      .filter(c => c.runId === runId && c.status === 'pending')
      .slice(0, limit)
  }
  const { data, error } = await getServiceSupabase()
    .from('import_candidates')
    .select('*')
    .eq('run_id', runId)
    .eq('status', 'pending')
    .order('created_at', { ascending: true })
    .limit(limit)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToCandidate)
}

export async function countCandidatesByStatuses(
  runId: string,
  statuses: ImportCandidateRecord['status'][],
): Promise<number> {
  if (!statuses.length) return 0
  if (useMockDb()) {
    return ensureMockImports().importCandidates
      .filter(c => c.runId === runId && statuses.includes(c.status))
      .length
  }
  const { count, error } = await getServiceSupabase()
    .from('import_candidates')
    .select('id', { count: 'exact', head: true })
    .eq('run_id', runId)
    .in('status', statuses)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return count ?? 0
}

/** Recalcule les compteurs d’écriture à partir des candidats (évite stats désync). */
export async function recountImportWriteStats(runId: string): Promise<{
  ready: number
  duplicates: number
  created: number
  updated: number
  skipped: number
  errors: number
}> {
  if (useMockDb()) {
    const items = ensureMockImports().importCandidates.filter(c => c.runId === runId)
    let ready = 0
    let duplicates = 0
    let created = 0
    let updated = 0
    let skipped = 0
    let errors = 0
    for (const c of items) {
      if (c.status === 'ready') ready++
      else if (c.status === 'duplicate') duplicates++
      else if (c.status === 'skipped') skipped++
      else if (c.status === 'error') errors++
      else if (c.status === 'applied') {
        if (c.payload?.applyKind === 'updated' || c.matchEventId) updated++
        else created++
      }
    }
    return { ready, duplicates, created, updated, skipped, errors }
  }

  const { data, error } = await getServiceSupabase()
    .from('import_candidates')
    .select('status, match_event_id, payload')
    .eq('run_id', runId)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })

  let ready = 0
  let duplicates = 0
  let created = 0
  let updated = 0
  let skipped = 0
  let errors = 0
  for (const row of data ?? []) {
    const status = String(row.status)
    const payload = (row.payload || {}) as Record<string, unknown>
    if (status === 'ready') ready++
    else if (status === 'duplicate') duplicates++
    else if (status === 'skipped') skipped++
    else if (status === 'error') errors++
    else if (status === 'applied') {
      if (payload.applyKind === 'updated' || row.match_event_id) updated++
      else created++
    }
  }
  return { ready, duplicates, created, updated, skipped, errors }
}

export async function updateCandidate(
  id: string,
  patch: Partial<ImportCandidateRecord>,
): Promise<void> {
  if (useMockDb()) {
    const store = ensureMockImports()
    const idx = store.importCandidates.findIndex(c => c.id === id)
    if (idx < 0) return
    store.importCandidates[idx] = {
      ...store.importCandidates[idx]!,
      ...patch,
      updatedAt: nowIso(),
    }
    return
  }
  const row: Record<string, unknown> = { updated_at: nowIso() }
  if (patch.status !== undefined) row.status = patch.status
  if (patch.latitude !== undefined) row.latitude = patch.latitude
  if (patch.longitude !== undefined) row.longitude = patch.longitude
  if (patch.postalCode !== undefined) row.postal_code = patch.postalCode
  if (patch.cityName !== undefined) row.city_name = patch.cityName
  if (patch.locationName !== undefined) row.location_name = patch.locationName
  if (patch.timezone !== undefined) row.timezone = patch.timezone
  if (patch.matchEventId !== undefined) row.match_event_id = patch.matchEventId
  if (patch.appliedEventId !== undefined) row.applied_event_id = patch.appliedEventId
  if (patch.errorMessage !== undefined) row.error_message = patch.errorMessage
  if (patch.description !== undefined) row.description = patch.description
  if (patch.payload !== undefined) row.payload = patch.payload
  const { error } = await getServiceSupabase().from('import_candidates').update(row).eq('id', id)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
}

function sourceUrlVariants(sourceUrl: string): string[] {
  const raw = sourceUrl.trim()
  if (!raw) return []
  const noSlash = raw.replace(/\/+$/, '')
  const withSlash = `${noSlash}/`
  const swapped = raw.startsWith('https://')
    ? `http://${raw.slice('https://'.length)}`
    : raw.startsWith('http://')
      ? `https://${raw.slice('http://'.length)}`
      : null
  const variants = [raw, noSlash, withSlash]
  if (swapped) {
    variants.push(swapped, swapped.replace(/\/+$/, ''), `${swapped.replace(/\/+$/, '')}/`)
  }
  return [...new Set(variants.filter(Boolean))]
}

export async function findEventIdBySourceUrl(sourceUrl: string): Promise<string | null> {
  const variants = sourceUrlVariants(sourceUrl)
  if (!variants.length) return null

  if (useMockDb()) {
    const events = getMockStore().events
    for (const v of variants) {
      const hit = events.find(e => e.sourceUrl === v)
      if (hit) return hit.id
    }
    return null
  }

  const { data, error } = await getServiceSupabase()
    .from('events')
    .select('id')
    .in('source_url', variants)
    .limit(1)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  const row = data?.[0]
  return row?.id ? String(row.id) : null
}

function citiesCompatible(a: string, b: string): boolean {
  const na = normalizeSearchText(a)
  const nb = normalizeSearchText(b)
  if (!na || !nb) return true
  return na === nb || na.includes(nb) || nb.includes(na)
}

async function listEventsOnSameUtcDay(startAt: string): Promise<Array<{
  id: string
  title: string
  cityName: string
  startAt: string | null
}>> {
  const dayStart = DateTime.fromISO(startAt, { zone: 'utc' }).startOf('day')
  if (!dayStart.isValid) return []
  const dayEnd = dayStart.plus({ days: 1 })
  const from = dayStart.toISO()
  const to = dayEnd.toISO()
  if (!from || !to) return []

  if (useMockDb()) {
    return getMockStore().events
      .filter((e) => {
        if (!e.startAt) return false
        const t = DateTime.fromISO(e.startAt, { zone: 'utc' })
        return t.isValid && t >= dayStart && t < dayEnd
      })
      .map(e => ({
        id: e.id,
        title: e.title,
        cityName: e.cityName,
        startAt: e.startAt,
      }))
  }

  const { data, error } = await getServiceSupabase()
    .from('events')
    .select('id, title, city_name, start_at')
    .gte('start_at', from)
    .lt('start_at', to)
    .limit(400)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map((row: Record<string, unknown>) => ({
    id: String(row.id),
    title: String(row.title || ''),
    cityName: String(row.city_name || ''),
    startAt: row.start_at ? String(row.start_at) : null,
  }))
}

/**
 * Dédoublonnage pondéré :
 * 1. URL source (score 1) — priorité absolue
 * 2. Titre proche + même jour + ville compatible (score = similarité titre, seuil 0.72)
 */
export async function findImportMatch(input: {
  sourceUrl: string
  title: string
  cityName: string
  startAt: string | null
}): Promise<ImportMatch | null> {
  const byUrl = await findEventIdBySourceUrl(input.sourceUrl)
  if (byUrl) {
    return { eventId: byUrl, reason: 'source_url', score: 1 }
  }

  if (!input.startAt || !input.title.trim()) return null

  const sameDay = await listEventsOnSameUtcDay(input.startAt)
  let best: ImportMatch | null = null
  for (const ev of sameDay) {
    if (!citiesCompatible(input.cityName, ev.cityName)) continue
    const score = titleSimilarity(input.title, ev.title)
    if (score < IMPORT_TITLE_DUP_THRESHOLD) continue
    if (!best || score > best.score) {
      best = { eventId: ev.id, reason: 'title', score }
    }
  }
  return best
}

export { emptyStats, emptyProgress }
