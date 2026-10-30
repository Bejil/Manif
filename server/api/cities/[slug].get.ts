import { listEventsByCitySlug } from '../../services/events-repository'
import { notFound } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')
  if (!slug) throw notFound()

  const query = getQuery(event)
  const page = Math.max(1, Number(query.page) || 1)
  const pageSize = Math.min(50, Math.max(1, Number(query.pageSize) || 20))
  const statuses = typeof query.statuses === 'string' && query.statuses
    ? query.statuses.split(',').map(s => s.trim()).filter(Boolean)
    : ['upcoming', 'ongoing', 'past', 'cancelled', 'postponed']

  const result = await listEventsByCitySlug(slug, {
    page,
    pageSize,
    statuses: statuses as Array<'upcoming' | 'ongoing' | 'past' | 'cancelled' | 'postponed'>,
  })

  if (!result.city) throw notFound('Ville introuvable')

  return result
})
