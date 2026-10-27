import { DateTime } from 'luxon'
import type { EventListQuery, EventMapPoint, EventPublic, EventRecord } from '#shared/types/event'
import type { DisplayEventStatus } from '#shared/constants/statuses'
import { computeDisplayStatus, resolveEndAt } from '#shared/utils/event-time'
import { publicLocationView } from '#shared/utils/location'
import { matchesSearch, normalizeSearchText, titleSimilarity } from '#shared/utils/search'
import { eventToRow, rowToEvent } from '../utils/mappers'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { getMockStore, newId, nowIso, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'
import { getEventCounts, getEventCountsBatch } from './engagements-repository'
import { geocodeCityCenter } from './geocoding'

function ensureSeeded() {
  seedMockStore(buildDemoEvents())
}

export function toPublic(
  event: EventRecord,
  counts = { supports: 0, participations: 0 },
  options: { maskLocation?: boolean } = {},
): EventPublic {
  const mask = options.maskLocation !== false
  const loc = mask
    ? publicLocationView(event)
    : {
        locationName: event.locationName,
        latitude: event.latitude,
        longitude: event.longitude,
        locationRevealed: publicLocationView(event).locationRevealed,
        locationRevealAt: event.locationRevealAt,
      }

  const { sourceVerificationStatus: _internal, ...rest } = event
  const revealed = loc.locationRevealed
  const hasPlace = revealed && loc.latitude != null && loc.longitude != null

  return {
    ...rest,
    locationName: loc.locationName,
    latitude: loc.latitude,
    longitude: loc.longitude,
    locationRevealAt: event.locationRevealAt,
    locationRevealed: loc.locationRevealed,
    mapLatitude: hasPlace ? loc.latitude : null,
    mapLongitude: hasPlace ? loc.longitude : null,
    mapPrecision: hasPlace ? 'place' : 'none',
    displayStatus: computeDisplayStatus({
      startAt: event.startAt,
      endAt: event.endAt,
      endIsEstimated: event.endIsEstimated,
      timezone: event.timezone,
      statusOverride: event.eventStatusOverride,
    }),
    counts,
  }
}

/** Complète la carte : centre-ville si le lieu précis n’est pas encore public. */
export async function withPublicMapFocus(pub: EventPublic): Promise<EventPublic> {
  if (pub.mapPrecision === 'place') return pub
  if (pub.locationRevealed && (pub.latitude == null || pub.longitude == null)) {
    return { ...pub, mapPrecision: 'none' }
  }
  const geo = await geocodeCityCenter({
    cityName: pub.cityName,
    postalCode: pub.postalCode,
  })
  if (!geo) return { ...pub, mapPrecision: 'none' }
  return {
    ...pub,
    mapLatitude: geo.latitude,
    mapLongitude: geo.longitude,
    mapPrecision: 'city',
  }
}

function sortEvents(a: EventPublic, b: EventPublic): number {
  const order: Record<DisplayEventStatus, number> = {
    ongoing: 0,
    upcoming: 1,
    postponed: 2,
    cancelled: 3,
    past: 4,
  }
  const diff = order[a.displayStatus] - order[b.displayStatus]
  if (diff !== 0) return diff
  // Dates à confirmer en tête des « à venir »
  if (!a.startAt && !b.startAt) return a.title.localeCompare(b.title, 'fr')
  if (!a.startAt) return -1
  if (!b.startAt) return 1
  return new Date(a.startAt).getTime() - new Date(b.startAt).getTime()
}

/** Colonnes utiles liste/carte — pas de médias ni payloads lourds. */
const LIST_COLUMNS = [
  'id', 'slug', 'title', 'description', 'category',
  'city_name', 'postal_code', 'locality_code', 'country_code', 'timezone',
  'location_name', 'latitude', 'longitude', 'location_reveal_at',
  'start_at', 'end_at', 'end_is_estimated', 'organizer_name', 'source_url',
  'source_verification_status', 'publication_status', 'event_status_override',
  'created_at', 'updated_at', 'published_at', 'is_demo',
].join(', ')

async function fetchPublishedForList(): Promise<EventRecord[]> {
  if (useMockDb()) {
    ensureSeeded()
    return getMockStore().events.filter(e => e.publicationStatus === 'published')
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('events')
    .select(LIST_COLUMNS)
    .eq('publication_status', 'published')
    .order('start_at', { ascending: true })
    .limit(2000)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(row => rowToEvent({
    ...row,
    image_urls: [],
    video_urls: [],
  }))
}

/** Réduit le JSON hydrate (la carte EventCard n’affiche pas ces champs). */
function slimListItem(event: EventPublic): EventPublic {
  return {
    ...event,
    description: '',
    imageUrls: [],
    videoUrls: [],
    sourceUrl: null,
    organizerName: null,
  }
}

function filterPublic(list: EventPublic[], query: EventListQuery): EventPublic[] {
  const defaultStatuses = new Set(['upcoming', 'ongoing'])
  const wanted = query.statuses?.length ? new Set(query.statuses) : defaultStatuses
  let result = list.filter(e => wanted.has(e.displayStatus))

  if (query.category) result = result.filter(e => e.category === query.category)
  if (query.city) result = result.filter(e => matchesSearch(e.cityName, query.city!))
  if (query.q) {
    const q = query.q
    result = result.filter(e =>
      matchesSearch(e.title, q)
      || matchesSearch(e.cityName, q)
      || matchesSearch(e.description, q)
      || matchesSearch(e.category, q)
      || (e.postalCode ? matchesSearch(e.postalCode, q) : false)
      || matchesSearch(e.locationName, q),
    )
  }
  if (query.dateFrom) {
    const from = DateTime.fromISO(query.dateFrom).toUTC()
    result = result.filter(e => e.startAt != null && DateTime.fromISO(e.startAt) >= from)
  }
  if (query.dateTo) {
    const to = DateTime.fromISO(query.dateTo).endOf('day').toUTC()
    result = result.filter(e => e.startAt != null && DateTime.fromISO(e.startAt) <= to)
  }
  return result.sort(sortEvents)
}

export async function listEvents(query: EventListQuery) {
  const pageSize = query.pageSize ?? 20
  let page = query.page ?? 1

  const published = await fetchPublishedForList()
  // Filtrage sans compteurs (évite N requêtes avant la pagination)
  const provisional = published.map(e => toPublic(e, { supports: 0, participations: 0 }))
  const all = filterPublic(provisional, query)

  if (query.focusId) {
    const idx = all.findIndex(e => e.id === query.focusId)
    if (idx >= 0) page = Math.floor(idx / pageSize) + 1
  }

  const start = (page - 1) * pageSize
  const pageItems = all.slice(start, start + pageSize)

  const countsMap = await getEventCountsBatch(pageItems.map(e => e.id))
  const items = pageItems.map(e => slimListItem({
    ...e,
    counts: countsMap.get(e.id) ?? { supports: 0, participations: 0 },
  }))

  return { items, total: all.length, page, pageSize }
}

export async function listAllEventsAdmin() {
  const mapAdmin = async (events: EventRecord[]) => {
    const countsMap = await getEventCountsBatch(events.map(e => e.id))
    return events.map(e => toPublic(
      e,
      countsMap.get(e.id) ?? { supports: 0, participations: 0 },
      { maskLocation: false },
    ))
  }

  if (useMockDb()) {
    ensureSeeded()
    return mapAdmin(getMockStore().events)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('events')
    .select('*')
    .order('start_at', { ascending: false, nullsFirst: false })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return mapAdmin((data ?? []).map(rowToEvent))
}

export async function getEventBySlug(slug: string): Promise<EventPublic | null> {
  const record = await getEventRecordBySlug(slug)
  if (!record || record.publicationStatus !== 'published') return null
  return withPublicMapFocus(toPublic(record, await getEventCounts(record.id)))
}

export async function getEventRecordBySlug(slug: string): Promise<EventRecord | null> {
  if (useMockDb()) {
    ensureSeeded()
    return getMockStore().events.find(e => e.slug === slug) ?? null
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase.from('events').select('*').eq('slug', slug).maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return data ? rowToEvent(data) : null
}

export async function getEventById(id: string): Promise<EventRecord | null> {
  if (useMockDb()) {
    ensureSeeded()
    return getMockStore().events.find(e => e.id === id) ?? null
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase.from('events').select('*').eq('id', id).maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return data ? rowToEvent(data) : null
}

export async function listMapEvents(query: EventListQuery): Promise<EventMapPoint[]> {
  const published = await fetchPublishedForList()
  const provisional = published.map(e => toPublic(e, { supports: 0, participations: 0 }))
  const filtered = filterPublic(provisional, query)
  return filtered
    .filter(e => e.latitude != null && e.longitude != null)
    .map(e => ({
      id: e.id,
      slug: e.slug,
      title: e.title,
      cityName: e.cityName,
      latitude: e.latitude!,
      longitude: e.longitude!,
      displayStatus: e.displayStatus,
      startAt: e.startAt,
      category: e.category,
    }))
}

export async function findSimilarEvents(input: {
  cityName: string
  startAt: string
  title: string
}): Promise<EventPublic[]> {
  const day = DateTime.fromISO(input.startAt).toUTC().toISODate()
  const { items } = await listEvents({
    city: input.cityName,
    statuses: ['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'],
    pageSize: 50,
  })
  return items.filter((e) => {
    if (!e.startAt) return false
    const sameDay = DateTime.fromISO(e.startAt).toUTC().toISODate() === day
    return sameDay && titleSimilarity(e.title, input.title) >= 0.45
  })
}

export function resolveEndForEvent(event: EventRecord) {
  if (!event.startAt) {
    throw createError({ statusCode: 409, statusMessage: 'Date de début non confirmée.' })
  }
  return resolveEndAt({
    startAt: event.startAt,
    endAt: event.endAt,
    timezone: event.timezone,
  })
}

export async function upsertEvent(event: EventRecord): Promise<EventRecord> {
  if (useMockDb()) {
    ensureSeeded()
    const store = getMockStore()
    const idx = store.events.findIndex(e => e.id === event.id)
    if (idx >= 0) store.events[idx] = event
    else store.events.push(event)
    return event
  }
  const supabase = getServiceSupabase()
  const row = eventToRow(event)
  const { data, error } = await supabase
    .from('events')
    .upsert(row, { onConflict: 'id' })
    .select('*')
    .single()
  if (error) {
    throw createError({
      statusCode: 500,
      statusMessage: `Écriture événement impossible: ${error.message}`,
    })
  }
  if (!data) {
    throw createError({ statusCode: 500, statusMessage: 'Écriture événement: aucune ligne retournée' })
  }
  return rowToEvent(data)
}

export async function patchEvent(
  id: string,
  patch: Partial<EventRecord>,
): Promise<EventRecord> {
  const existing = await getEventById(id)
  if (!existing) throw createError({ statusCode: 404, statusMessage: 'Manifestation introuvable' })
  const next: EventRecord = {
    ...existing,
    ...patch,
    updatedAt: nowIso(),
  }
  // Révélation du lieu : au plus tard au début
  if (next.locationRevealAt && next.startAt) {
    const reveal = DateTime.fromISO(next.locationRevealAt, { setZone: true })
    const start = DateTime.fromISO(next.startAt, { setZone: true })
    if (reveal.isValid && start.isValid && reveal.toUTC() > start.toUTC()) {
      next.locationRevealAt = next.startAt
    }
  }
  if (patch.publicationStatus === 'published' && !next.publishedAt) {
    next.publishedAt = nowIso()
  }
  return upsertEvent(next)
}

/** Suppression définitive (CASCADE engagements / signalements côté Postgres). */
export async function deleteEvent(id: string): Promise<void> {
  const existing = await getEventById(id)
  if (!existing) throw createError({ statusCode: 404, statusMessage: 'Manifestation introuvable' })

  if (useMockDb()) {
    ensureSeeded()
    const store = getMockStore()
    store.events = store.events.filter(e => e.id !== id)
    store.engagements = store.engagements.filter(e => e.eventId !== id)
    store.reports = store.reports.filter(r => r.eventId !== id)
    return
  }

  const supabase = getServiceSupabase()
  const { error } = await supabase.from('events').delete().eq('id', id)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
}

export async function mergeEvents(sourceId: string, targetId: string, actorId: string) {
  if (sourceId === targetId) {
    throw createError({ statusCode: 400, statusMessage: 'Impossible de fusionner un événement avec lui-même' })
  }
  const source = await getEventById(sourceId)
  const target = await getEventById(targetId)
  if (!source || !target) throw createError({ statusCode: 404, statusMessage: 'Événement introuvable' })

  if (useMockDb()) {
    const store = getMockStore()
    for (const eng of store.engagements.filter(x => x.eventId === sourceId)) {
      const existing = store.engagements.find(
        x => x.eventId === targetId && x.eventScopedTokenDigest === eng.eventScopedTokenDigest,
      )
      if (existing) {
        if (eng.supportsAt && !existing.supportsAt) existing.supportsAt = eng.supportsAt
        if (eng.participatesAt && !existing.participatesAt) {
          existing.participatesAt = eng.participatesAt
          existing.participationKind = eng.participationKind
        }
        existing.updatedAt = nowIso()
      }
      else {
        eng.eventId = targetId
        eng.updatedAt = nowIso()
      }
    }
    store.engagements = store.engagements.filter(e => e.eventId !== sourceId)
    for (const r of store.reports.filter(x => x.eventId === sourceId)) {
      r.eventId = targetId
    }
    source.publicationStatus = 'unpublished'
    source.updatedAt = nowIso()
    store.audit.push({
      id: newId(),
      action: 'event.merge',
      entityType: 'event',
      entityId: targetId,
      actorId,
      createdAt: nowIso(),
      metadata: { sourceId },
    })
    return { target, source }
  }

  const supabase = getServiceSupabase()
  const { data: sourceEngs } = await supabase
    .from('engagements')
    .select('*')
    .eq('event_id', sourceId)
  for (const row of sourceEngs ?? []) {
    const { data: existing } = await supabase
      .from('engagements')
      .select('*')
      .eq('event_id', targetId)
      .eq('event_scoped_token_digest', row.event_scoped_token_digest)
      .maybeSingle()
    if (existing) {
      await supabase.from('engagements').update({
        supports_at: existing.supports_at || row.supports_at,
        participates_at: existing.participates_at || row.participates_at,
        participation_kind: existing.participation_kind || row.participation_kind,
        updated_at: nowIso(),
      }).eq('id', existing.id)
      await supabase.from('engagements').delete().eq('id', row.id)
    }
    else {
      await supabase.from('engagements').update({
        event_id: targetId,
        updated_at: nowIso(),
      }).eq('id', row.id)
    }
  }
  await supabase.from('event_reports').update({ event_id: targetId }).eq('event_id', sourceId)
  await supabase.from('events').update({
    publication_status: 'unpublished',
    updated_at: nowIso(),
  }).eq('id', sourceId)
  await supabase.from('admin_audit').insert({
    action: 'event.merge',
    entity_type: 'event',
    entity_id: targetId,
    actor_id: actorId,
    metadata: { sourceId },
  })
  return { target, source: { ...source, publicationStatus: 'unpublished' as const } }
}

export { normalizeSearchText, getEventCounts }
