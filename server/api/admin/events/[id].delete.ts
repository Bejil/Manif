import { requireAdmin } from '../../../utils/admin-auth'
import { deleteEvent } from '../../../services/events-repository'
import { notFound } from '../../../utils/errors'
import { getMockStore, newId, nowIso } from '../../../services/mock-store'
import { getServiceSupabase, useMockDb } from '../../../utils/supabase'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  await deleteEvent(id)

  if (useMockDb()) {
    getMockStore().audit.push({
      id: newId(),
      action: 'event.delete',
      entityType: 'event',
      entityId: id,
      actorId: admin.email,
      createdAt: nowIso(),
      metadata: {},
    })
  }
  else {
    await getServiceSupabase().from('admin_audit').insert({
      action: 'event.delete',
      entity_type: 'event',
      entity_id: id,
      actor_id: admin.email,
      metadata: {},
    })
  }

  return { ok: true }
})
