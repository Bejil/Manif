import { z } from 'zod'
import { listMySubmissionsPublic } from '../../services/submissions-repository'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'
import { getRequestIP } from 'h3'

const bodySchema = z.object({
  ids: z.array(z.string().uuid()).max(50),
})

export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const parsed = bodySchema.safeParse(body)
  if (!parsed.success) throw badRequest('Identifiants invalides')

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({
    key: `submissions-mine:${ip}`,
    limit: 30,
    windowMs: 60_000,
  })
  if (!rl.ok) throw tooManyRequests()

  const items = await listMySubmissionsPublic(parsed.data.ids)
  return { items }
})
