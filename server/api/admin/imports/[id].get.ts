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

const KINDS = new Set(['scraped', 'new', 'duplicates', 'updated', 'errors', 'all'])

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

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const run = await getImportRun(id)
  if (!run) throw notFound('Import introuvable')

  const query = getQuery(event)
  const page = Math.max(1, Number(query.page) || 1)
  const pageSize = Math.min(100, Math.max(1, Number(query.pageSize) || 30))

  const kindRaw = typeof query.kind === 'string' ? query.kind : ''
  const legacyAll = query.onlyNew === '0' || query.onlyNew === 'false'
  const effectiveKind = legacyAll
    ? 'all'
    : (KINDS.has(kindRaw) ? kindRaw : 'new')

  // Liste « nouveaux candidats » : on exclut ceux déjà publiés, avec pagination
  // sur le total filtré (sinon une page vidée par publication reste vide).
  if (effectiveKind === 'new') {
    const allNew = await listCandidates(id, {
      onlyNew: true,
      limit: 5000,
      offset: 0,
    })
    const enriched = await enrichCandidates(allNew.items)
    // File d’attente : brouillons / dépubliés encore liés à un événement.
    const pending = enriched.filter(c =>
      c.publicationStatus === 'draft' || c.publicationStatus === 'unpublished',
    )
    const total = pending.length
    const offset = (page - 1) * pageSize
    const items = pending.slice(offset, offset + pageSize)
    return { run, candidates: { items, total }, kind: effectiveKind }
  }

  const candidates = await listCandidates(id, {
    limit: pageSize,
    offset: (page - 1) * pageSize,
    onlyUpdated: effectiveKind === 'updated',
    status: effectiveKind === 'errors' ? 'error' : undefined,
    statuses: effectiveKind === 'duplicates' ? ['duplicate'] : undefined,
  })

  const items = await enrichCandidates(candidates.items)

  return { run, candidates: { ...candidates, items }, kind: effectiveKind }
})
