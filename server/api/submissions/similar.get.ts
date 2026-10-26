import { z } from 'zod'
import { findSimilarEvents } from '../../services/events-repository'
import { badRequest } from '../../utils/errors'

const schema = z.object({
  title: z.string().min(3).max(160),
  cityName: z.string().min(2).max(120),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
})

export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const parsed = schema.safeParse(query)
  if (!parsed.success) throw badRequest('Paramètres invalides')

  const startAt = `${parsed.data.date}T12:00:00.000Z`
  const similar = await findSimilarEvents({
    title: parsed.data.title,
    cityName: parsed.data.cityName,
    startAt,
  })

  return {
    items: similar.map(e => ({
      id: e.id,
      slug: e.slug,
      title: e.title,
      cityName: e.cityName,
      startAt: e.startAt,
      displayStatus: e.displayStatus,
    })),
  }
})
