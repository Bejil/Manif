import { z } from 'zod'
import { requireAdmin } from '../../../utils/admin-auth'
import { patchReport } from '../../../services/reports-repository'
import { badRequest, notFound } from '../../../utils/errors'

const schema = z.object({
  status: z.enum(['open', 'in_progress', 'resolved', 'dismissed']),
  adminNote: z.string().max(2000).optional(),
})

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const body = await readBody(event)
  const parsed = schema.safeParse(body)
  if (!parsed.success) throw badRequest('Données invalides')

  const report = await patchReport(id, parsed.data)
  if (!report) throw notFound()
  return { ok: true, report }
})
