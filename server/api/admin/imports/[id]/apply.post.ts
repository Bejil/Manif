import { requireAdmin } from '../../../../utils/admin-auth'
import { notFound } from '../../../../utils/errors'
import { applyImportRunManual } from '../../../../services/import-orchestrator'
import { getImportRun } from '../../../../services/import-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const run = await getImportRun(id)
  if (!run) throw notFound('Import introuvable')
  return applyImportRunManual(id)
})
