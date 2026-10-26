import { describe, expect, it } from 'vitest'
import { DateTime } from 'luxon'
import {
  canDeclareParticipation,
  canDeclareSupport,
  computeDisplayStatus,
  computeTemporalStatus,
  participationButtonLabel,
  resolveEndAt,
  resolveParticipationKind,
} from '../../shared/utils/event-time'

describe('event-time', () => {
  const tz = 'Europe/Paris'
  const start = DateTime.fromISO('2026-06-15T12:00:00.000Z')
  const end = start.plus({ hours: 2 })

  const base = {
    startAt: start.toISO()!,
    endAt: end.toISO()!,
    endIsEstimated: false,
    timezone: tz,
  }

  it('estime la fin à +3h si absente', () => {
    const { endAt, endIsEstimated } = resolveEndAt({
      startAt: start.toISO()!,
      endAt: null,
      timezone: tz,
    })
    expect(endIsEstimated).toBe(true)
    expect(endAt.toMillis()).toBe(start.plus({ hours: 3 }).toMillis())
  })

  it('calcule upcoming / ongoing / past', () => {
    expect(computeTemporalStatus(base, start.minus({ minutes: 1 }))).toBe('upcoming')
    expect(computeTemporalStatus(base, start)).toBe('ongoing')
    expect(computeTemporalStatus(base, end.minus({ seconds: 1 }))).toBe('ongoing')
    expect(computeTemporalStatus(base, end)).toBe('past')
  })

  it('priorise annulé / reporté', () => {
    expect(computeDisplayStatus({ ...base, statusOverride: 'cancelled' }, start)).toBe('cancelled')
    expect(computeDisplayStatus({ ...base, statusOverride: 'postponed' }, start)).toBe('postponed')
  })

  it('autorise le soutien avant, pendant et après', () => {
    expect(canDeclareSupport(base, start.minus({ days: 1 }))).toBe(true)
    expect(canDeclareSupport(base, start)).toBe(true)
    expect(canDeclareSupport(base, end.plus({ days: 30 }))).toBe(true)
    expect(canDeclareSupport({ ...base, statusOverride: 'cancelled' })).toBe(true)
  })

  it('ouvre la participation avant/pendant et la ferme après', () => {
    expect(canDeclareParticipation(base, start.minus({ hours: 1 }))).toBe(true)
    expect(canDeclareParticipation(base, start)).toBe(true)
    expect(canDeclareParticipation(base, end.minus({ minutes: 1 }))).toBe(true)
    expect(canDeclareParticipation(base, end)).toBe(false)
    expect(canDeclareParticipation({ ...base, statusOverride: 'cancelled' }, start)).toBe(false)
    expect(canDeclareParticipation({ ...base, statusOverride: 'postponed' }, end.plus({ days: 1 }))).toBe(true)
  })

  it('libellés et kind selon le moment', () => {
    expect(participationButtonLabel(base, start.minus({ hours: 1 }))).toBe('Je vais participer')
    expect(participationButtonLabel(base, start)).toBe('Je participe')
    expect(participationButtonLabel(base, end)).toBeNull()
    expect(resolveParticipationKind(base, start.minus({ hours: 1 }))).toBe('planned')
    expect(resolveParticipationKind(base, start)).toBe('during')
    expect(resolveParticipationKind(base, end)).toBeNull()
  })

  it('utilise le fuseau outre-mer sans changer la borne UTC', () => {
    const reunionStart = DateTime.fromISO('2026-06-15T07:00:00', { zone: 'Indian/Reunion' })
    const status = computeTemporalStatus({
      startAt: reunionStart.toUTC().toISO()!,
      endAt: reunionStart.plus({ hours: 2 }).toUTC().toISO()!,
      endIsEstimated: false,
      timezone: 'Indian/Reunion',
    }, reunionStart.toUTC().plus({ hours: 1 }))
    expect(status).toBe('ongoing')
  })

  it('traite une date absente comme à venir et bloque la participation', () => {
    const tba = {
      startAt: null,
      endAt: null,
      endIsEstimated: true,
      timezone: tz,
    }
    expect(computeTemporalStatus(tba)).toBe('upcoming')
    expect(computeDisplayStatus(tba)).toBe('upcoming')
    expect(canDeclareParticipation(tba)).toBe(false)
    expect(participationButtonLabel(tba)).toBeNull()
    expect(canDeclareSupport(tba)).toBe(true)
  })
})
