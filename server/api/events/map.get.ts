import { eventListQuerySchema } from '#shared/schemas/event'
import { listMapEvents } from '../../services/events-repository'
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

  const points = await listMapEvents({
    ...parsed.data,
    statuses,
  })

  return { points }
})
