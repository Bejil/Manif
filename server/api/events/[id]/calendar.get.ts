import { DateTime } from 'luxon'
import { getEventById, getEventBySlug, resolveEndForEvent } from '../../../services/events-repository'
import { notFound } from '../../../utils/errors'

function foldLine(line: string): string {
  if (line.length <= 75) return line
  const parts: string[] = []
  let remaining = line
  parts.push(remaining.slice(0, 75))
  remaining = remaining.slice(75)
  while (remaining.length) {
    parts.push(` ${remaining.slice(0, 74)}`)
    remaining = remaining.slice(74)
  }
  return parts.join('\r\n')
}

function escapeIcs(text: string): string {
  return text
    .replace(/\\/g, '\\\\')
    .replace(/;/g, '\\;')
    .replace(/,/g, '\\,')
    .replace(/\n/g, '\\n')
}

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  const record = isUuid ? await getEventById(id) : null
  const resolved = record ?? (await getEventBySlug(id))
  if (!resolved || resolved.publicationStatus !== 'published') {
    throw notFound('Manifestation introuvable')
  }

  if (!resolved.startAt) {
    throw createError({
      statusCode: 409,
      statusMessage: 'Calendrier indisponible : la date n’est pas encore confirmée.',
    })
  }

  const config = useRuntimeConfig()
  const { endAt, endIsEstimated } = resolveEndForEvent(resolved)
  const start = DateTime.fromISO(resolved.startAt).toUTC()
  const url = `${config.public.siteUrl}/manifestations/${resolved.slug}`

  const description = [
    resolved.description,
    '',
    endIsEstimated ? 'Fin estimée (durée indicative de 3 heures).' : null,
    `Plus d'infos : ${url}`,
  ]
    .filter(Boolean)
    .join('\n')

  const lines = [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Manif//FR',
    'CALSCALE:GREGORIAN',
    'METHOD:PUBLISH',
    'BEGIN:VEVENT',
    `UID:${resolved.id}@manif`,
    `DTSTAMP:${DateTime.utc().toFormat("yyyyMMdd'T'HHmmss'Z'")}`,
    `DTSTART:${start.toFormat("yyyyMMdd'T'HHmmss'Z'")}`,
    `DTEND:${endAt.toUTC().toFormat("yyyyMMdd'T'HHmmss'Z'")}`,
    foldLine(`SUMMARY:${escapeIcs(resolved.title)}`),
    foldLine(`DESCRIPTION:${escapeIcs(description)}`),
    foldLine(`LOCATION:${escapeIcs(`${resolved.locationName}, ${resolved.cityName}`)}`),
    `URL:${url}`,
    'END:VEVENT',
    'END:VCALENDAR',
  ]

  const body = `${lines.join('\r\n')}\r\n`
  setHeader(event, 'Content-Type', 'text/calendar; charset=utf-8')
  setHeader(
    event,
    'Content-Disposition',
    `attachment; filename="manif-${resolved.slug}.ics"`,
  )
  return body
})
