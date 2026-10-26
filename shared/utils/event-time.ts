import { DateTime } from 'luxon'
import type {
  DisplayEventStatus,
  EventStatusOverride,
  TemporalStatus,
} from '../constants/statuses'

/** Durée estimée par défaut lorsque end_at est absent (heures) */
export const DEFAULT_EVENT_DURATION_HOURS = 3

export const DATE_PENDING_LABEL = 'Date à venir'

export interface EventTimeInput {
  startAt: string | Date | null
  endAt: string | Date | null
  endIsEstimated: boolean
  timezone: string
  statusOverride?: EventStatusOverride | null
}

export function toUtcDateTime(value: string | Date): DateTime {
  if (value instanceof Date) {
    return DateTime.fromJSDate(value, { zone: 'utc' })
  }
  const parsed = DateTime.fromISO(value, { setZone: true })
  if (!parsed.isValid) {
    throw new Error(`Date invalide: ${value}`)
  }
  return parsed.toUTC()
}

/** Fin effective : end_at ou début + 3h (estimée). Requiert un début. */
export function resolveEndAt(input: {
  startAt: string | Date
  endAt: string | Date | null
  timezone: string
}): { endAt: DateTime, endIsEstimated: boolean } {
  const start = toUtcDateTime(input.startAt)
  if (input.endAt) {
    return { endAt: toUtcDateTime(input.endAt), endIsEstimated: false }
  }
  return {
    endAt: start.plus({ hours: DEFAULT_EVENT_DURATION_HOURS }),
    endIsEstimated: true,
  }
}

export function hasConfirmedStart(input: Pick<EventTimeInput, 'startAt'>): boolean {
  return input.startAt != null && String(input.startAt).length > 0
}

export function computeTemporalStatus(
  input: EventTimeInput,
  now: DateTime = DateTime.utc(),
): TemporalStatus {
  // Sans date confirmée → traité comme « à venir » pour rester visible dans l’agenda
  if (!hasConfirmedStart(input)) return 'upcoming'
  const start = toUtcDateTime(input.startAt!)
  const { endAt } = resolveEndAt({
    startAt: input.startAt!,
    endAt: input.endAt,
    timezone: input.timezone,
  })

  if (now < start) return 'upcoming'
  if (now < endAt) return 'ongoing'
  return 'past'
}

export function computeDisplayStatus(
  input: EventTimeInput,
  now: DateTime = DateTime.utc(),
): DisplayEventStatus {
  if (input.statusOverride === 'cancelled') return 'cancelled'
  if (input.statusOverride === 'postponed') return 'postponed'
  return computeTemporalStatus(input, now)
}

/** Soutien : toujours possible tant que la fiche est publiée */
export function canDeclareSupport(
  _input: EventTimeInput,
  _now: DateTime = DateTime.utc(),
): boolean {
  return true
}

/**
 * Participation déclarable avant ou pendant l'événement.
 * Fermée sans date confirmée, après la fin, si annulée.
 */
export function canDeclareParticipation(
  input: EventTimeInput,
  now: DateTime = DateTime.utc(),
): boolean {
  if (input.statusOverride === 'cancelled') return false
  if (!hasConfirmedStart(input)) return false
  if (input.statusOverride === 'postponed') return true
  const { endAt } = resolveEndAt({
    startAt: input.startAt!,
    endAt: input.endAt,
    timezone: input.timezone,
  })
  return now < endAt
}

export type ParticipationKind = 'planned' | 'during'

export function resolveParticipationKind(
  input: EventTimeInput,
  now: DateTime = DateTime.utc(),
): ParticipationKind | null {
  if (!canDeclareParticipation(input, now)) return null
  const temporal = computeTemporalStatus(input, now)
  if (temporal === 'upcoming' || input.statusOverride === 'postponed') return 'planned'
  if (temporal === 'ongoing') return 'during'
  return null
}

export function participationButtonLabel(
  input: EventTimeInput,
  now: DateTime = DateTime.utc(),
): string | null {
  if (input.statusOverride === 'cancelled') return null
  if (!hasConfirmedStart(input)) return null
  if (input.statusOverride === 'postponed') return 'Je vais participer'
  const temporal = computeTemporalStatus(input, now)
  if (temporal === 'upcoming') return 'Je vais participer'
  if (temporal === 'ongoing') return 'Je participe'
  return null
}

export function formatEventDateTime(
  isoUtc: string | Date,
  timezone: string,
  options: Intl.DateTimeFormatOptions = {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  },
): string {
  const dt = toUtcDateTime(isoUtc).setZone(timezone)
  return dt.setLocale('fr').toLocaleString(options)
}

export function formatEventTime(
  isoUtc: string | Date,
  timezone: string,
): string {
  return toUtcDateTime(isoUtc)
    .setZone(timezone)
    .setLocale('fr')
    .toLocaleString(DateTime.TIME_SIMPLE)
}
