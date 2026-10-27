import { importRunCreateSchema } from '#shared/schemas/import'
import type { ImportSourceId, ImportModeId } from '#shared/constants/import-sources'
import { requireAdmin } from '../../../utils/admin-auth'
import { badRequest } from '../../../utils/errors'
import { startImportRun, continueImportRun } from '../../../services/import-orchestrator'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const body = await readBody(event)
  const parsed = importRunCreateSchema.safeParse(body)
  if (!parsed.success) throw badRequest('Paramètres invalides', parsed.error.flatten())

  const run = await startImportRun({
    sources: parsed.data.sources as ImportSourceId[],
    mode: parsed.data.mode as ImportModeId,
    militantOnly: parsed.data.militantOnly,
    geocode: parsed.data.geocode,
    maxPerSource: parsed.data.maxPerSource,
    actorId: admin.email,
  })

  // Premier tick immédiat
  const step = await continueImportRun(run.id)
  return step
})
