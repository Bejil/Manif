import { requireAdmin } from '../../../../utils/admin-auth'
import { patchEvent } from '../../../../services/events-repository'
import { getServiceSupabase, useMockDb } from '../../../../utils/supabase'
import { getMockStore, newId, nowIso } from '../../../../services/mock-store'
import { notFound } from '../../../../utils/errors'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  await patchEvent(id, { eventStatusOverride: 'cancelled' })
  if (useMockDb()) {
    getMockStore().audit.push({
      id: newId(),
      action: 'event.cancel',
      entityType: 'event',
      entityId: id,
      actorId: admin.email,
      createdAt: nowIso(),
      metadata: {},
    })
  }
  else {
    await getServiceSupabase().from('admin_audit').insert({
      action: 'event.cancel',
      entity_type: 'event',
      entity_id: id,
      actor_id: admin.email,
      metadata: {},
    })
  }
  return { ok: true }
})
