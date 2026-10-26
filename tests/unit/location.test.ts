import { describe, expect, it } from 'vitest'
import { DateTime } from 'luxon'
import { LOCATION_PENDING_LABEL, computeLocationRevealAt, publicLocationView } from '../../shared/utils/location'

describe('location reveal', () => {
  const base = {
    locationName: 'Place de la République',
    latitude: 48.86,
    longitude: 2.36,
    locationRevealAt: null as string | null,
  }

  it('révèle immédiatement si pas de date', () => {
    const v = publicLocationView(base)
    expect(v.locationRevealed).toBe(true)
    expect(v.locationName).toBe('Place de la République')
  })

  it('masque avant l’heure de révélation', () => {
    const reveal = DateTime.utc().plus({ hours: 12 }).toISO()!
    const v = publicLocationView({ ...base, locationRevealAt: reveal })
    expect(v.locationRevealed).toBe(false)
    expect(v.locationName).toBe(LOCATION_PENDING_LABEL)
    expect(v.latitude).toBeNull()
  })

  it('calcule locationRevealAt depuis les heures', () => {
    const start = '2026-11-01T13:00:00.000Z'
    const at = computeLocationRevealAt(start, 24)
    expect(at).toBe('2026-10-31T13:00:00.000Z')
    expect(computeLocationRevealAt(start, null)).toBeNull()
    expect(computeLocationRevealAt(null, 24)).toBeNull()
  })
})
