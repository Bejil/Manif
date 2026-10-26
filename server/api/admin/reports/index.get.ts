import { requireAdmin } from '../../../utils/admin-auth'
import { listReports } from '../../../services/reports-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  return { items: await listReports() }
})
