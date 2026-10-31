import { eventListQuerySchema } from '#shared/schemas/event'
import { listEventsByCitySlug } from '../../services/events-repository'
import { badRequest, notFound } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')
  if (!slug) throw notFound()

  const query = getQuery(event)
  const parsed = eventListQuerySchema.safeParse({
    ...query,
    statuses: typeof query.statuses === 'string' && query.statuses
      ? query.statuses
      : 'upcoming,ongoing',
  })
  if (!parsed.success) {
    throw badRequest('Paramètres invalides', parsed.error.flatten())
  }

  const statuses = parsed.data.statuses as
    | Array<'upcoming' | 'ongoing' | 'past' | 'cancelled' | 'postponed'>
    | undefined

  const result = await listEventsByCitySlug(slug, {
    page: parsed.data.page,
    pageSize: parsed.data.pageSize,
    sort: parsed.data.sort === 'category' ? 'category' : 'date',
    statuses: statuses?.length ? statuses : ['upcoming', 'ongoing'],
    q: parsed.data.q,
    category: parsed.data.category as undefined,
  })

  if (!result.city) throw notFound('Ville introuvable')

  return result
})
