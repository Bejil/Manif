import { requireAdmin } from '../../../utils/admin-auth'
import {
  getSubmissionForAdmin,
  listChangesRequestedSubmissions,
  listModerationQueue,
  listPendingSubmissions,
} from '../../../services/submissions-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const query = getQuery(event)
  if (query.id && typeof query.id === 'string') {
    return { item: await getSubmissionForAdmin(query.id) }
  }
  return {
    items: await listModerationQueue(),
    pending: await listPendingSubmissions(),
    changesRequested: await listChangesRequestedSubmissions(),
  }
})

