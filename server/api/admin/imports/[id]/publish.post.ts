import { requireAdmin } from '../../../../utils/admin-auth'
import { notFound, badRequest } from '../../../../utils/errors'
import { getImportRun, listCandidates } from '../../../../services/import-repository'
import { getEventById, patchEvent } from '../../../../services/events-repository'
import { nowIso } from '../../../../services/mock-store'

/**
 * Publie les nouveaux événements de ce run encore en brouillon.
 * Les maj d’existants sont déjà écrites en base et n’apparaissent pas ici.
 */
export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const run = await getImportRun(id)
  if (!run) throw notFound('Import introuvable')

  const { items, total } = await listCandidates(id, { onlyNew: true, limit: 2000, offset: 0 })
  if (!total) throw badRequest('Aucun nouvel événement à publier sur ce run')

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
