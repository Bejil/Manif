import { getRequestIP } from 'h3'
import { z } from 'zod'
import { isFlagEnabled } from '#shared/utils/flags'
import { getEventById, getEventBySlug } from '../../../services/events-repository'
import { upsertEngagement } from '../../../services/engagements-repository'
import { badRequest, notFound, tooManyRequests } from '../../../utils/errors'
import { checkRateLimit } from '../../../utils/rate-limit'
import { verifyTurnstile } from '../../../utils/turnstile'

const schema = z.object({
  field: z.enum(['support', 'participate']),
  eventScopedToken: z.string().min(16).max(128),
  turnstileToken: z.string().min(1).optional(),
})

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('Données invalides', parsed.error.flatten())

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({
    key: `engagement-del:${ip}:${id}`,
    limit: 30,
    windowMs: 60_000,
  })
  if (!rl.ok) throw tooManyRequests()

  const turnstileOk = await verifyTurnstile(event, parsed.data.turnstileToken, 'engage')
  if (!turnstileOk) throw badRequest('Vérification antibot échouée')

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  const record = isUuid ? await getEventById(id) : null
  const resolved = record ?? (await getEventBySlug(id))
  if (!resolved) throw notFound('Manifestation introuvable')

  const config = useRuntimeConfig()
  return upsertEngagement({
    eventId: resolved.id,
    eventScopedToken: parsed.data.eventScopedToken,
    action: parsed.data.field === 'support' ? 'withdraw_support' : 'withdraw_participate',
    pepper: config.participationTokenPepper,
    participationEnabled: isFlagEnabled(
      config.public.engagementsEnabled ?? config.public.participationEnabled,
    ),
  })
})
