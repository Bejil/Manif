import { requireAdmin } from '../../../../utils/admin-auth'
import { getEventById, patchEvent } from '../../../../services/events-repository'
import { notFound, badRequest } from '../../../../utils/errors'
import { getMockStore, newId, nowIso } from '../../../../services/mock-store'
import { useMockDb, getServiceSupabase } from '../../../../utils/supabase'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const existing = await getEventById(id)
  if (!existing) throw notFound('Manifestation introuvable')
  if (existing.publicationStatus === 'published') {
    throw badRequest('Déjà publié')
  }

  const updated = await patchEvent(id, {
    publicationStatus: 'published',
    publishedAt: existing.publishedAt || nowIso(),
  })

  if (useMockDb()) {
    getMockStore().audit.push({
      id: newId(),
      action: 'event.publish',
      entityType: 'event',
      entityId: id,
      actorId: admin.email,
      createdAt: nowIso(),
    })
  }
  else {
    await getServiceSupabase().from('admin_audit').insert({
      action: 'event.publish',
      entity_type: 'event',
      entity_id: id,
      actor_id: admin.email,
    })
  }

  return { ok: true, event: updated }
})
