import { requireAdmin } from '../../../utils/admin-auth'
import { notFound } from '../../../utils/errors'
import {
  findEventIdBySourceUrl,
  getImportRun,
  listCandidates,
} from '../../../services/import-repository'
import { getEventById } from '../../../services/events-repository'
import type { PublicationStatus } from '#shared/constants/statuses'
import type { ImportCandidateRecord } from '#shared/types/import'

type CandidateWithPublication = ImportCandidateRecord & {
  publicationStatus: PublicationStatus | null
}

async function enrichCandidates(candidates: ImportCandidateRecord[]): Promise<CandidateWithPublication[]> {
  return Promise.all(candidates.map(async (c) => {
    let eventId = c.appliedEventId || c.matchEventId
    if (!eventId) {
      eventId = await findEventIdBySourceUrl(c.sourceUrl)
    }
    if (!eventId) {
      return { ...c, appliedEventId: c.appliedEventId, publicationStatus: null as PublicationStatus | null }
    }
    const linked = await getEventById(eventId)
    return {
      ...c,
      appliedEventId: c.appliedEventId || eventId,
      matchEventId: c.matchEventId,
      publicationStatus: (linked?.publicationStatus ?? null) as PublicationStatus | null,
    }
  }))
}

/**
 * Détail d’un run + candidats « nouveaux » encore en brouillon / dépubliés.
 */
export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const run = await getImportRun(id)
  if (!run) throw notFound('Import introuvable')

  const query = getQuery(event)
  const page = Math.max(1, Number(query.page) || 1)
  const pageSize = Math.min(100, Math.max(1, Number(query.pageSize) || 30))

  const allNew = await listCandidates(id, {
    onlyNew: true,
    limit: 5000,
    offset: 0,
  })
  const enriched = await enrichCandidates(allNew.items)
  const pending = enriched.filter(c =>
    c.publicationStatus === 'draft' || c.publicationStatus === 'unpublished',
  )
  const total = pending.length
  const offset = (page - 1) * pageSize
  const items = pending.slice(offset, offset + pageSize)

  return { run, candidates: { items, total }, kind: 'new' }
})
