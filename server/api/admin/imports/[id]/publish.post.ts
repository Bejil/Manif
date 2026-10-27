import { requireAdmin } from '../../../../utils/admin-auth'
import { notFound, badRequest } from '../../../../utils/errors'
import { getImportRun, listCandidates } from '../../../../services/import-repository'
import { getEventById, patchEvent } from '../../../../services/events-repository'
import { nowIso } from '../../../../services/mock-store'

/**
 * Publie tous les événements créés/liés par ce run encore en brouillon.
 * Corrige le cas « import en mode draft → invisible sur le site public ».
 */
export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const run = await getImportRun(id)
  if (!run) throw notFound('Import introuvable')

  const { items, total } = await listCandidates(id, { status: 'applied', limit: 2000, offset: 0 })
  if (!total) throw badRequest('Aucun candidat appliqué sur ce run')

  let published = 0
  let skipped = 0
  let missing = 0

  for (const c of items) {
    const eventId = c.appliedEventId || c.matchEventId
    if (!eventId) {
      missing++
      continue
    }
    const existing = await getEventById(eventId)
    if (!existing) {
      missing++
      continue
    }
    if (existing.publicationStatus === 'published') {
      skipped++
      continue
    }
    await patchEvent(eventId, {
      publicationStatus: 'published',
      publishedAt: existing.publishedAt || nowIso(),
    })
    published++
  }

  return {
    ok: true,
    runId: id,
    candidates: total,
    published,
    alreadyPublished: skipped,
    missing,
  }
})
