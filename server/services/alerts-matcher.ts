import type { EventAlertRecord } from '#shared/types/alert'
import type { EventRecord } from '#shared/types/event'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { getMockStore, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'
import { rowToEvent } from '../utils/mappers'

const EARTH_RADIUS_KM = 6371
const MAX_DIGEST_EVENTS = 15

/** Distance haversine en km. */
export function haversineKm(
  lat1: number,
  lon1: number,
  lat2: number,
  lon2: number,
): number {
  const toRad = (d: number) => (d * Math.PI) / 180
  const dLat = toRad(lat2 - lat1)
  const dLon = toRad(lon2 - lon1)
  const a = Math.sin(dLat / 2) ** 2
    + Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2
  return 2 * EARTH_RADIUS_KM * Math.asin(Math.min(1, Math.sqrt(a)))
}

export interface AlertMatchEvent {
  id: string
  slug: string
  title: string
  cityName: string
  startAt: string | null
  publishedAt: string | null
  latitude: number
  longitude: number
  distanceKm: number
}

/** Événements publiés depuis `sinceIso` (exclu), avec coordonnées. */
export async function listPublishedEventsSince(sinceIso: string): Promise<EventRecord[]> {
  if (useMockDb()) {
    seedMockStore(buildDemoEvents())
    return getMockStore().events.filter((e) => {
      if (e.publicationStatus !== 'published') return false
      if (e.latitude == null || e.longitude == null) return false
      const pub = e.publishedAt || e.createdAt
      return pub > sinceIso
    })
  }

  const { data, error } = await getServiceSupabase()
    .from('events')
    .select('*')
    .eq('publication_status', 'published')
    .not('latitude', 'is', null)
    .not('longitude', 'is', null)
    .gt('published_at', sinceIso)
    .order('published_at', { ascending: true })
    .limit(500)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToEvent)
}

export function matchEventsForAlert(
  alert: EventAlertRecord,
  candidates: EventRecord[],
): AlertMatchEvent[] {
  const since = alert.lastNotifiedAt || alert.confirmedAt || alert.createdAt
  const matched: AlertMatchEvent[] = []

  for (const e of candidates) {
    if (e.latitude == null || e.longitude == null) continue
    const pub = e.publishedAt || e.createdAt
    if (pub <= since) continue
    const distanceKm = haversineKm(
      alert.latitude,
      alert.longitude,
      e.latitude,
      e.longitude,
    )
    if (distanceKm > alert.radiusKm) continue
    matched.push({
      id: e.id,
      slug: e.slug,
      title: e.title,
      cityName: e.cityName,
      startAt: e.startAt,
      publishedAt: e.publishedAt,
      latitude: e.latitude,
      longitude: e.longitude,
      distanceKm: Math.round(distanceKm * 10) / 10,
    })
  }

  matched.sort((a, b) => {
    const da = a.startAt || a.publishedAt || ''
    const db = b.startAt || b.publishedAt || ''
    return da.localeCompare(db)
  })

  return matched.slice(0, MAX_DIGEST_EVENTS)
}

export { MAX_DIGEST_EVENTS }
