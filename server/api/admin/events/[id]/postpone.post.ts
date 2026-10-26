import { requireAdmin } from '../../../../utils/admin-auth'
import { patchEvent } from '../../../../services/events-repository'
import { invalidateParticipationsForEvent } from '../../../../services/engagements-repository'
import { notFound } from '../../../../utils/errors'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  await patchEvent(id, { eventStatusOverride: 'postponed' })
  // Les intentions de participation à l'ancienne date sont invalidées ;
  // les soutiens sont conservés.
  await invalidateParticipationsForEvent(id)
  return { ok: true }
})
