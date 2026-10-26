import { requireAdmin } from '../../../utils/admin-auth'
import { listEventAdminHistory } from '../../../services/admin-audit'
import { getEventById, toPublic } from '../../../services/events-repository'
import { getEventCounts } from '../../../services/engagements-repository'
import { notFound } from '../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const record = await getEventById(id)
  if (!record) throw notFound('Manifestation introuvable')
  const pub = toPublic(record, await getEventCounts(record.id), { maskLocation: false })
  const history = await listEventAdminHistory(id)
  return { ...pub, history }
})
