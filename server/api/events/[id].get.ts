import { getEventById, getEventBySlug, toPublic, withPublicMapFocus } from '../../services/events-repository'
import { getEventCounts } from '../../services/engagements-repository'
import { notFound } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  if (isUuid) {
    const record = await getEventById(id)
    if (!record || record.publicationStatus !== 'published') throw notFound('Manifestation introuvable')
    return withPublicMapFocus(toPublic(record, await getEventCounts(record.id)))
  }

  const pub = await getEventBySlug(id)
  if (!pub) throw notFound('Manifestation introuvable')
  return pub
})
