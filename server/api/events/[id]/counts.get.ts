import { getEventById, getEventBySlug, getEventCounts } from '../../../services/events-repository'
import { notFound } from '../../../utils/errors'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  const record = isUuid ? await getEventById(id) : null
  const resolved = record ?? (await getEventBySlug(id))
  if (!resolved || resolved.publicationStatus !== 'published') {
    throw notFound('Manifestation introuvable')
  }

  return getEventCounts(resolved.id)
})
