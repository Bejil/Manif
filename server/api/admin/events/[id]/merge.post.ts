import { z } from 'zod'
import { requireAdmin } from '../../../../utils/admin-auth'
import { mergeEvents } from '../../../../services/events-repository'
import { badRequest, notFound } from '../../../../utils/errors'

const schema = z.object({
  targetId: z.string().uuid(),
})

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const sourceId = getRouterParam(event, 'id')
  if (!sourceId) throw notFound()
  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('targetId requis')
  return mergeEvents(sourceId, parsed.data.targetId, admin.email)
})
