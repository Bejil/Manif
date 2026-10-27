import { requireAdmin } from '../../../utils/admin-auth'
import { listImportRuns } from '../../../services/import-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const items = await listImportRuns(40)
  return { items }
})
