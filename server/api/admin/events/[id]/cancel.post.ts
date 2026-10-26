import { requireAdmin } from '../../../../utils/admin-auth'
import { patchEvent } from '../../../../services/events-repository'
import { notFound } from '../../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  await patchEvent(id, { eventStatusOverride: 'cancelled' })
  return { ok: true }
})
