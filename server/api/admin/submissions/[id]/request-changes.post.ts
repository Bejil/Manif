import { z } from 'zod'
import { requireAdmin } from '../../../../utils/admin-auth'
import { requestSubmissionChanges } from '../../../../services/submissions-repository'
import { badRequest } from '../../../../utils/errors'

const schema = z.object({
  message: z.string().trim().min(10).max(2000),
})

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw createError({ statusCode: 404 })
  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('Message requis (10 caractères minimum)')
  const config = useRuntimeConfig()
  return requestSubmissionChanges(
    id,
    admin.email,
    parsed.data.message,
    config.public.siteUrl,
    config.participationTokenPepper,
  )
})
