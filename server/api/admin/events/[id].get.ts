import { requireAdmin } from '../../../utils/admin-auth'
import { getEventById, toPublic } from '../../../services/events-repository'
import { getEventCounts } from '../../../services/engagements-repository'
import { notFound } from '../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const record = await getEventById(id)
  if (!record) throw notFound('Manifestation introuvable')
  return toPublic(record, await getEventCounts(record.id), { maskLocation: false })
})
