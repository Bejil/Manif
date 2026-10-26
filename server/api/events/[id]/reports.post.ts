import { getRequestIP } from 'h3'
import { reportCreateSchema } from '#shared/schemas/event'
import { getEventById, getEventBySlug } from '../../../services/events-repository'
import { createReport } from '../../../services/reports-repository'
import { badRequest, notFound, tooManyRequests } from '../../../utils/errors'
import { checkRateLimit } from '../../../utils/rate-limit'
import { verifyTurnstile } from '../../../utils/turnstile'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const body = await readBody(event)
  const parsed = reportCreateSchema.safeParse(body)
  if (!parsed.success) throw badRequest('Données invalides', parsed.error.flatten())

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `report:${ip}`, limit: 10, windowMs: 60 * 60_000 })
  if (!rl.ok) throw tooManyRequests()

  const turnstileOk = await verifyTurnstile(event, parsed.data.turnstileToken, 'report')
  if (!turnstileOk) throw badRequest('Vérification antibot échouée')

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  const record = isUuid ? await getEventById(id) : null
  const resolved = record ?? (await getEventBySlug(id))
  if (!resolved) throw notFound('Manifestation introuvable')

  await createReport({
    eventId: resolved.id,
    reason: parsed.data.reason as never,
    details: parsed.data.details || '',
  })

  return { ok: true }
})
