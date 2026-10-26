import { requireAdmin } from '../../../../utils/admin-auth'
import { patchEvent } from '../../../../services/events-repository'
import { notFound } from '../../../../utils/errors'
import { getMockStore, newId, nowIso } from '../../../../services/mock-store'
import { useMockDb, getServiceSupabase } from '../../../../utils/supabase'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()
  const updated = await patchEvent(id, { publicationStatus: 'unpublished' })
  if (useMockDb()) {
    getMockStore().audit.push({
      id: newId(),
      action: 'event.unpublish',
      entityType: 'event',
      entityId: id,
      actorId: admin.email,
      createdAt: nowIso(),
    })
  }
  else {
    await getServiceSupabase().from('admin_audit').insert({
      action: 'event.unpublish',
      entity_type: 'event',
      entity_id: id,
      actor_id: admin.email,
    })
  }
  return { ok: true, event: updated }
})
