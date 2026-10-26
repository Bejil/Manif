import { z } from 'zod'
import { requireAdmin } from '../../../../utils/admin-auth'
import { rejectSubmission } from '../../../../services/submissions-repository'
import { badRequest } from '../../../../utils/errors'

const schema = z.object({
  reason: z.string().max(1000).optional(),
})

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw createError({ statusCode: 404 })
  const body = await readBody(event).catch(() => ({}))
  const parsed = schema.safeParse(body ?? {})
  if (!parsed.success) throw badRequest('Données invalides')
  return rejectSubmission(id, admin.email, parsed.data.reason)
})
