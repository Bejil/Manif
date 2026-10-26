import { getRequestIP } from 'h3'
import { submissionVerifySchema } from '#shared/schemas/event'
import { verifySubmission } from '../../services/submissions-repository'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'

export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const parsed = submissionVerifySchema.safeParse(body)
  if (!parsed.success) throw badRequest('Jeton invalide')

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `verify:${ip}`, limit: 20, windowMs: 60 * 60_000 })
  if (!rl.ok) throw tooManyRequests()

  const config = useRuntimeConfig()
  return verifySubmission(parsed.data.token, config.participationTokenPepper)
})
