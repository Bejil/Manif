import { DateTime } from 'luxon'
import { DATE_PENDING_LABEL, formatEventDateTime, formatEventTime } from '#shared/utils/event-time'
import { categoryLabel } from '#shared/constants/categories'

export function useEventFormat() {
  function formatDate(startAt: string | null, timezone: string) {
    if (!startAt) return DATE_PENDING_LABEL
    return formatEventDateTime(startAt, timezone, {
      weekday: 'long',
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    })
  }

  function formatTimeRange(
    startAt: string | null,
    endAt: string | null,
    endIsEstimated: boolean,
    timezone: string,
  ) {
    if (!startAt) return DATE_PENDING_LABEL
    const start = formatEventTime(startAt, timezone)
    if (!endAt && endIsEstimated) {
      const estimated = DateTime.fromISO(startAt)
        .setZone(timezone)
        .plus({ hours: 3 })
      const endLabel = estimated.setLocale('fr').toLocaleString(DateTime.TIME_SIMPLE)
      return `${start} – ${endLabel} (fin estimée)`
    }
    if (endAt) {
      return `${start} – ${formatEventTime(endAt, timezone)}`
    }
    return start
  }

  return {
    formatDate,
    formatTimeRange,
    categoryLabel,
  }
}
