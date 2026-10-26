import { requireAdmin } from '../../../utils/admin-auth'
import {
  getSubmissionForAdmin,
  listAllSubmissionsAdmin,
} from '../../../services/submissions-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const query = getQuery(event)
  if (query.id && typeof query.id === 'string') {
    return { item: await getSubmissionForAdmin(query.id) }
  }
  const items = await listAllSubmissionsAdmin()
  return { items }
})
