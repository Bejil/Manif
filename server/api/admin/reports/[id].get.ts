import { requireAdmin } from '../../../utils/admin-auth'
import { getReportForAdmin } from '../../../services/reports-repository'
import { notFound } from '../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const item = await getReportForAdmin(id)
  if (!item) throw notFound('Signalement introuvable')
  return item
})
