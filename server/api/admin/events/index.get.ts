import { requireAdmin } from '../../../utils/admin-auth'
import { listAllEventsAdmin } from '../../../services/events-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const items = await listAllEventsAdmin()
  return { items }
})
