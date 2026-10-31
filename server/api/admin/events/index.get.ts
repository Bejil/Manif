import { requireAdmin } from '../../../utils/admin-auth'
import { listEventsAdmin } from '../../../services/events-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const query = getQuery(event)

  const all = query.all === '1' || query.all === 'true'
  const page = Math.max(1, Number(query.page) || 1)
  const pageSize = Math.min(100, Math.max(1, Number(query.pageSize) || 30))
  const q = typeof query.q === 'string' ? query.q : ''
  const category = typeof query.category === 'string' ? query.category : ''
  const publication = typeof query.publication === 'string' ? query.publication : ''
  const withoutCoords = query.withoutCoords === '1' || query.withoutCoords === 'true'
  const statuses = typeof query.statuses === 'string' && query.statuses.trim()
    ? query.statuses.split(',').map(s => s.trim()).filter(Boolean)
    : undefined
  const sort = query.sort === 'category' ? 'category' as const : 'date' as const

  return listEventsAdmin({
    all,
    page,
    pageSize,
    q: q || undefined,
    category: category || undefined,
    publication: publication || undefined,
    withoutCoords: withoutCoords || undefined,
    statuses,
    sort,
  })
})
