import { requireAdmin } from '../../../../utils/admin-auth'
import { approveSubmission } from '../../../../services/submissions-repository'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw createError({ statusCode: 404 })
  return approveSubmission(id, admin.email)
})
