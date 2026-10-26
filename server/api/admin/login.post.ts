import { getRequestIP } from 'h3'
import { z } from 'zod'
import { loginAdmin } from '../../utils/admin-auth'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'

const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8).max(200),
})

export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('Identifiants invalides')

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `admin-login:${ip}`, limit: 10, windowMs: 15 * 60_000 })
  if (!rl.ok) throw tooManyRequests()

  return loginAdmin(event, parsed.data.email, parsed.data.password)
})
