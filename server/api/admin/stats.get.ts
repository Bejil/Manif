import { requireAdmin } from '../../utils/admin-auth'
import { buildAdminStats } from '../../services/admin-stats'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const query = getQuery(event)
  const topLimit = Number(query.limit) || 15
  return buildAdminStats({ topLimit })
})
