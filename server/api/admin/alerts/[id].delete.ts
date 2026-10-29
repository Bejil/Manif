import { requireAdmin } from '../../../utils/admin-auth'
import { notFound } from '../../../utils/errors'
import { deleteAlertById } from '../../../services/alerts-repository'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const ok = await deleteAlertById(id)
  if (!ok) throw notFound('Alerte introuvable')

  return { ok: true }
})
