import { DateTime } from 'luxon'
import { getRequestIP } from 'h3'
import { submissionCreateSchema } from '#shared/schemas/event'
import { findSimilarEvents } from '../../services/events-repository'
import { createSubmission } from '../../services/submissions-repository'
import { timezoneFromPostalOrCity } from '../../utils/timezone'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'
import { verifyTurnstile } from '../../utils/turnstile'

export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const parsed = submissionCreateSchema.safeParse(body)
  if (!parsed.success) {
    throw badRequest('Données invalides', parsed.error.flatten())
  }

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `submission:${ip}`, limit: 5, windowMs: 60 * 60_000 })
  if (!rl.ok) throw tooManyRequests('Trop de propositions. Réessayez plus tard.')

  const emailRl = await checkRateLimit({
    key: `submission-email:${parsed.data.proposerEmail.toLowerCase()}`,
    limit: 3,
    windowMs: 60 * 60_000,
  })
  if (!emailRl.ok) throw tooManyRequests('Trop d\'envois pour cette adresse.')

  const turnstileOk = await verifyTurnstile(event, parsed.data.turnstileToken, 'propose')
  if (!turnstileOk) throw badRequest('Vérification antibot échouée')

  const timezone = timezoneFromPostalOrCity(null, parsed.data.cityName)
  const dateTba = parsed.data.dateToConfirm || !parsed.data.date || !parsed.data.startTime

  let startAt: string | null = null
  let endAt: string | null = null

  if (!dateTba) {
    const startLocal = DateTime.fromISO(
      `${parsed.data.date}T${parsed.data.startTime}`,
      { zone: timezone },
    )
    if (!startLocal.isValid) throw badRequest('Date ou heure invalide')

    if (parsed.data.endTime) {
      let endLocal = DateTime.fromISO(
        `${parsed.data.date}T${parsed.data.endTime}`,
        { zone: timezone },
      )
      if (endLocal <= startLocal) {
        endLocal = endLocal.plus({ days: 1 })
      }
      endAt = endLocal.toUTC().toISO()
    }
    startAt = startLocal.toUTC().toISO()!
  }

  const similar = startAt
    ? await findSimilarEvents({
        cityName: parsed.data.cityName,
        startAt,
        title: parsed.data.title,
      })
    : []

  const config = useRuntimeConfig()
  const created = await createSubmission({
    title: parsed.data.title,
    description: parsed.data.description,
    category: parsed.data.category as never,
    cityName: parsed.data.cityName,
    locationName: parsed.data.locationName,
    locationRevealHoursBefore: parsed.data.locationRevealHoursBefore ?? null,
    startAt,
    endAt,
    organizerName: parsed.data.organizerName,
    sourceUrl: parsed.data.sourceUrl,
    practicalInfo: parsed.data.practicalInfo,
    proposerEmail: parsed.data.proposerEmail,
    pepper: config.participationTokenPepper,
    siteUrl: config.public.siteUrl,
  })

  return {
    ...created,
    similarEvents: similar.map(e => ({
      id: e.id,
      slug: e.slug,
      title: e.title,
      cityName: e.cityName,
      startAt: e.startAt,
    })),
  }
})
