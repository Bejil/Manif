import { getRequestIP } from 'h3'
import { z } from 'zod'
import { getEventById, getEventBySlug } from '../../../../services/events-repository'
import { eraseEngagementByToken } from '../../../../services/engagements-repository'
import { badRequest, notFound, tooManyRequests } from '../../../../utils/errors'
import { checkRateLimit } from '../../../../utils/rate-limit'
import { verifyTurnstile } from '../../../../utils/turnstile'

const schema = z.object({
  eventScopedToken: z.string().min(16).max(128),
  turnstileToken: z.string().min(1).optional(),
  confirmation: z.literal(true),
})

/**
 * Effacement complet des engagements (soutien + participation) via le jeton local.
 */
export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('Données invalides', parsed.error.flatten())

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `erase:${ip}`, limit: 10, windowMs: 60 * 60_000 })
  if (!rl.ok) throw tooManyRequests()

  const turnstileOk = await verifyTurnstile(event, parsed.data.turnstileToken, 'engage')
  if (!turnstileOk) throw badRequest('Vérification antibot échouée')

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  const record = isUuid ? await getEventById(id) : null
  const resolved = record ?? (await getEventBySlug(id))
  if (!resolved) throw notFound('Manifestation introuvable')

  const config = useRuntimeConfig()
  const result = await eraseEngagementByToken({
    eventId: resolved.id,
    eventScopedToken: parsed.data.eventScopedToken,
    pepper: config.participationTokenPepper,
  })

  return { ok: true, ...result }
})
