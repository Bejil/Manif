import { adminEventPatchSchema } from '#shared/schemas/event'
import { requireAdmin } from '../../../utils/admin-auth'
import { patchEvent } from '../../../services/events-repository'
import { badRequest, notFound } from '../../../utils/errors'
import { getMockStore, newId, nowIso } from '../../../services/mock-store'
import { getServiceSupabase, useMockDb } from '../../../utils/supabase'

export default defineEventHandler(async (event) => {
  const admin = requireAdmin(event)
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const body = await readBody(event)
  const parsed = adminEventPatchSchema.safeParse(body)
  if (!parsed.success) throw badRequest('Données invalides', parsed.error.flatten())

  const p = parsed.data
  const mapped: Parameters<typeof patchEvent>[1] = {}
  if (p.title !== undefined) mapped.title = p.title
  if (p.description !== undefined) mapped.description = p.description
  if (p.category !== undefined) mapped.category = p.category as never
  if (p.cityName !== undefined) mapped.cityName = p.cityName
  if (p.postalCode !== undefined) mapped.postalCode = p.postalCode
  if (p.locationName !== undefined) mapped.locationName = p.locationName
  if (p.latitude !== undefined) mapped.latitude = p.latitude
  if (p.longitude !== undefined) mapped.longitude = p.longitude
  if (p.locationRevealAt !== undefined) mapped.locationRevealAt = p.locationRevealAt
  if (p.timezone !== undefined) mapped.timezone = p.timezone
  if (p.startAt !== undefined) mapped.startAt = p.startAt
  if (p.endAt !== undefined) mapped.endAt = p.endAt
  if (p.endIsEstimated !== undefined) mapped.endIsEstimated = p.endIsEstimated
  if (p.organizerName !== undefined) mapped.organizerName = p.organizerName
  if (p.sourceUrl !== undefined) mapped.sourceUrl = p.sourceUrl
  if (p.imageUrls !== undefined) mapped.imageUrls = p.imageUrls
  if (p.videoUrls !== undefined) mapped.videoUrls = p.videoUrls
  if (p.publicationStatus !== undefined) mapped.publicationStatus = p.publicationStatus
  if (p.eventStatusOverride !== undefined) mapped.eventStatusOverride = p.eventStatusOverride

  const updated = await patchEvent(id, mapped)

  if (useMockDb()) {
    getMockStore().audit.push({
      id: newId(),
      action: 'event.patch',
      entityType: 'event',
      entityId: id,
      actorId: admin.email,
      createdAt: nowIso(),
      metadata: p as Record<string, unknown>,
    })
  }
  else {
    await getServiceSupabase().from('admin_audit').insert({
      action: 'event.patch',
      entity_type: 'event',
      entity_id: id,
      actor_id: admin.email,
      metadata: p,
    })
  }

  return { ok: true, event: updated }
})
