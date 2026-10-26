import { requireAdmin } from '../../../../utils/admin-auth'
import { reopenSubmissionForModeration } from '../../../../services/submissions-repository'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw createError({ statusCode: 404 })
  return reopenSubmissionForModeration(id, admin.email)
})
