import { eventListQuerySchema } from '#shared/schemas/event'
import { listEvents } from '../../services/events-repository'
import { badRequest } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const parsed = eventListQuerySchema.safeParse(query)
  if (!parsed.success) {
    throw badRequest('Paramètres invalides', parsed.error.flatten())
  }

  const statuses = parsed.data.statuses as
    | Array<'upcoming' | 'ongoing' | 'past' | 'cancelled' | 'postponed'>
    | undefined

  return listEvents({
    ...parsed.data,
    statuses,
    sort: parsed.data.sort === 'category' ? 'category' : 'date',
    category: parsed.data.category as undefined,
    ids: parsed.data.ids,
  })
})
