import { requireAdmin } from '../../../utils/admin-auth'
import { notFound } from '../../../utils/errors'
import {
  findEventIdBySourceUrl,
  getImportRun,
  listCandidates,
} from '../../../services/import-repository'
import { getEventById } from '../../../services/events-repository'
import type { PublicationStatus } from '#shared/constants/statuses'

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
  const kind = kindRaw === 'updated' || kindRaw === 'all' ? kindRaw : 'new'

  // Compat : onlyNew=0 → all
  const legacyAll = query.onlyNew === '0' || query.onlyNew === 'false'
  const effectiveKind = legacyAll ? 'all' : kind

  const candidates = await listCandidates(id, {
    limit: pageSize,
    offset: (page - 1) * pageSize,
    onlyNew: effectiveKind === 'new',
    onlyUpdated: effectiveKind === 'updated',
  })

  const items = await Promise.all(candidates.items.map(async (c) => {
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

  return { run, candidates: { ...candidates, items }, kind: effectiveKind }
})
