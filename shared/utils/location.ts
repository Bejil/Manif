import { DateTime } from 'luxon'

/** Libellé public tant que le lieu précis n’est pas encore dévoilé. */
export const LOCATION_PENDING_LABEL = 'Localisation à venir'

export type LocationAware = {
  locationName: string
  latitude: number | null
  longitude: number | null
  /** null = lieu toujours public */
  locationRevealAt: string | null
}

export function isLocationRevealed(
  event: Pick<LocationAware, 'locationRevealAt'>,
  now: DateTime = DateTime.utc(),
): boolean {
  if (!event.locationRevealAt) return true
  const at = DateTime.fromISO(event.locationRevealAt, { setZone: true })
  if (!at.isValid) return true
  return at.toUTC() <= now.toUTC()
}

/** Champs lieu exposés au public (masqués avant l’heure de révélation). */
export function publicLocationView(
  event: LocationAware,
  now: DateTime = DateTime.utc(),
): {
  locationName: string
  latitude: number | null
  longitude: number | null
  locationRevealed: boolean
  locationRevealAt: string | null
} {
  const revealed = isLocationRevealed(event, now)
  if (revealed) {
    return {
      locationName: event.locationName,
      latitude: event.latitude,
      longitude: event.longitude,
      locationRevealed: true,
      locationRevealAt: event.locationRevealAt,
    }
  }
  return {
    locationName: LOCATION_PENDING_LABEL,
    latitude: null,
    longitude: null,
    locationRevealed: false,
    locationRevealAt: event.locationRevealAt,
  }
}

export function computeLocationRevealAt(
  startAtIso: string | null | undefined,
  hoursBefore: number | null | undefined,
): string | null {
  if (!startAtIso || hoursBefore == null || hoursBefore <= 0) return null
  const start = DateTime.fromISO(startAtIso, { setZone: true })
  if (!start.isValid) return null
  return start.minus({ hours: hoursBefore }).toUTC().toISO()
}
