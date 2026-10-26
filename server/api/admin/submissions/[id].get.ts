import { requireAdmin } from '../../../utils/admin-auth'
import { getSubmissionForAdmin } from '../../../services/submissions-repository'
import { notFound } from '../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const item = await getSubmissionForAdmin(id)
  if (!item) throw notFound('Proposition introuvable')
  return item
})
