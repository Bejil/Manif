import type { EngagementAction, EngagementRecord } from '#shared/types/engagement'
import {
  canDeclareParticipation,
  canDeclareSupport,
  resolveParticipationKind,
} from '#shared/utils/event-time'
import { digestParticipationToken } from '../utils/crypto'
import { badRequest, conflict, forbidden, notFound } from '../utils/errors'
import { rowToEngagement } from '../utils/mappers'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { getEventById } from './events-repository'
import { getMockStore, newId, nowIso, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'

function ensureSeeded() {
  if (useMockDb()) seedMockStore(buildDemoEvents())
}

export async function getEventCounts(eventId: string) {
  const map = await getEventCountsBatch([eventId])
  return map.get(eventId) ?? { supports: 0, participations: 0 }
}

/** Compteurs pour plusieurs événements en une requête (admin / listes). */
export async function getEventCountsBatch(eventIds: string[]) {
  const empty = () => ({ supports: 0, participations: 0 })
  const result = new Map<string, { supports: number, participations: number }>()
  for (const id of eventIds) result.set(id, empty())
  if (!eventIds.length) return result

  ensureSeeded()
  if (useMockDb()) {
    const store = getMockStore()
    for (const id of eventIds) {
      result.set(id, {
        supports: store.engagements.filter(e => e.eventId === id && e.supportsAt).length,
        participations: store.engagements.filter(e => e.eventId === id && e.participatesAt).length,
      })
    }
    return result
  }

  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('engagements')
    .select('event_id, supports_at, participates_at')
    .in('event_id', eventIds)

  if (error) {
    const legacy = await supabase
      .from('participations')
      .select('event_id, intended_at, attended_at')
      .in('event_id', eventIds)
    if (legacy.error) throw createError({ statusCode: 500, statusMessage: error.message })
    for (const row of legacy.data ?? []) {
      const cur = result.get(row.event_id as string) ?? empty()
      if (row.intended_at || row.attended_at) cur.participations += 1
      result.set(row.event_id as string, cur)
    }
    return result
  }

  for (const row of data ?? []) {
    const id = row.event_id as string
    const cur = result.get(id) ?? empty()
    if (row.supports_at) cur.supports += 1
    if (row.participates_at) cur.participations += 1
    result.set(id, cur)
  }
  return result
}

export async function upsertEngagement(input: {
  eventId: string
  eventScopedToken: string
  action: EngagementAction
  pepper: string
  participationEnabled: boolean
}) {
  if (!input.participationEnabled) {
    throw forbidden(
      'La collecte d\'engagements est désactivée tant que la validation de confidentialité n\'est pas obtenue.',
    )
  }

  const event = await getEventById(input.eventId)
  if (!event || event.publicationStatus !== 'published') {
    throw notFound('Manifestation introuvable')
  }

  const timeInput = {
    startAt: event.startAt,
    endAt: event.endAt,
    endIsEstimated: event.endIsEstimated,
    timezone: event.timezone,
    statusOverride: event.eventStatusOverride,
  }

  const digest = digestParticipationToken(
    input.eventId,
    input.eventScopedToken,
    input.pepper,
  )

  if (useMockDb()) {
    return mockUpsert(input.eventId, digest, input.action, timeInput)
  }
  return supabaseUpsert(input.eventId, digest, input.action, timeInput)
}

/** @deprecated */
export const upsertParticipation = upsertEngagement

async function mockUpsert(
  eventId: string,
  digest: string,
  action: EngagementAction,
  timeInput: Parameters<typeof canDeclareParticipation>[0],
) {
  const store = getMockStore()
  let row = store.engagements.find(
    e => e.eventId === eventId && e.eventScopedTokenDigest === digest,
  )
  const now = nowIso()

  if (action === 'support') {
    if (!canDeclareSupport(timeInput)) throw badRequest('Soutien indisponible.')
    if (!row) {
      row = {
        id: newId(),
        eventId,
        eventScopedTokenDigest: digest,
        supportsAt: now,
        participatesAt: null,
        participationKind: null,
        updatedAt: now,
      }
      store.engagements.push(row)
    }
    else if (!row.supportsAt) {
      row.supportsAt = now
      row.updatedAt = now
    }
  }
  else if (action === 'withdraw_support') {
    if (!row?.supportsAt) throw conflict('Aucun soutien à retirer.')
    row.supportsAt = null
    row.updatedAt = now
    if (!row.participatesAt) {
      store.engagements = store.engagements.filter(e => e.id !== row!.id)
      row = undefined
    }
  }
  else if (action === 'participate') {
    if (!canDeclareParticipation(timeInput)) {
      throw badRequest('Les déclarations de participation sont fermées pour cet événement.')
    }
    const kind = resolveParticipationKind(timeInput)!
    if (!row) {
      row = {
        id: newId(),
        eventId,
        eventScopedTokenDigest: digest,
        supportsAt: null,
        participatesAt: now,
        participationKind: kind,
        updatedAt: now,
      }
      store.engagements.push(row)
    }
    else if (!row.participatesAt) {
      row.participatesAt = now
      row.participationKind = kind
      row.updatedAt = now
    }
    // idempotent : ne change pas le kind d'une déclaration déjà enregistrée
  }
  else if (action === 'withdraw_participate') {
    if (!row?.participatesAt) throw conflict('Aucune participation à retirer.')
    if (!canDeclareParticipation(timeInput)) {
      throw forbidden('La période de retrait de participation est close.')
    }
    row.participatesAt = null
    row.participationKind = null
    row.updatedAt = now
    if (!row.supportsAt) {
      store.engagements = store.engagements.filter(e => e.id !== row!.id)
      row = undefined
    }
  }

  const live = row ? store.engagements.find(e => e.id === row!.id) : null
  return {
    ok: true as const,
    counts: await getEventCounts(eventId),
    state: {
      supported: Boolean(live?.supportsAt),
      participating: Boolean(live?.participatesAt),
      participationKind: live?.participationKind ?? null,
    },
  }
}

async function supabaseUpsert(
  eventId: string,
  digest: string,
  action: EngagementAction,
  timeInput: Parameters<typeof canDeclareParticipation>[0],
) {
  const supabase = getServiceSupabase()
  const now = nowIso()

  const { data: existing, error: findError } = await supabase
    .from('engagements')
    .select('*')
    .eq('event_id', eventId)
    .eq('event_scoped_token_digest', digest)
    .maybeSingle()
  if (findError) throw createError({ statusCode: 500, statusMessage: findError.message })

  let row: EngagementRecord | null = existing ? rowToEngagement(existing) : null

  if (action === 'support') {
    if (!canDeclareSupport(timeInput)) throw badRequest('Soutien indisponible.')
    if (!row) {
      const { data, error } = await supabase.from('engagements').insert({
        event_id: eventId,
        event_scoped_token_digest: digest,
        supports_at: now,
        participates_at: null,
        participation_kind: null,
        updated_at: now,
      }).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
    else if (!row.supportsAt) {
      const { data, error } = await supabase.from('engagements').update({
        supports_at: now,
        updated_at: now,
      }).eq('id', row.id).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
  }
  else if (action === 'withdraw_support') {
    if (!row?.supportsAt) throw conflict('Aucun soutien à retirer.')
    if (!row.participatesAt) {
      await supabase.from('engagements').delete().eq('id', row.id)
      row = null
    }
    else {
      const { data, error } = await supabase.from('engagements').update({
        supports_at: null,
        updated_at: now,
      }).eq('id', row.id).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
  }
  else if (action === 'participate') {
    if (!canDeclareParticipation(timeInput)) {
      throw badRequest('Les déclarations de participation sont fermées pour cet événement.')
    }
    const kind = resolveParticipationKind(timeInput)!
    if (!row) {
      const { data, error } = await supabase.from('engagements').insert({
        event_id: eventId,
        event_scoped_token_digest: digest,
        supports_at: null,
        participates_at: now,
        participation_kind: kind,
        updated_at: now,
      }).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
    else if (!row.participatesAt) {
      const { data, error } = await supabase.from('engagements').update({
        participates_at: now,
        participation_kind: kind,
        updated_at: now,
      }).eq('id', row.id).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
  }
  else if (action === 'withdraw_participate') {
    if (!row?.participatesAt) throw conflict('Aucune participation à retirer.')
    if (!canDeclareParticipation(timeInput)) {
      throw forbidden('La période de retrait de participation est close.')
    }
    if (!row.supportsAt) {
      await supabase.from('engagements').delete().eq('id', row.id)
      row = null
    }
    else {
      const { data, error } = await supabase.from('engagements').update({
        participates_at: null,
        participation_kind: null,
        updated_at: now,
      }).eq('id', row.id).select('*').single()
      if (error) throw createError({ statusCode: 500, statusMessage: error.message })
      row = rowToEngagement(data)
    }
  }

  return {
    ok: true as const,
    counts: await getEventCounts(eventId),
    state: {
      supported: Boolean(row?.supportsAt),
      participating: Boolean(row?.participatesAt),
      participationKind: row?.participationKind ?? null,
    },
  }
}

export async function eraseEngagementByToken(input: {
  eventId: string
  eventScopedToken: string
  pepper: string
}) {
  const digest = digestParticipationToken(input.eventId, input.eventScopedToken, input.pepper)
  if (useMockDb()) {
    const store = getMockStore()
    const before = store.engagements.length
    store.engagements = store.engagements.filter(
      e => !(e.eventId === input.eventId && e.eventScopedTokenDigest === digest),
    )
    return { deleted: before !== store.engagements.length }
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('engagements')
    .delete()
    .eq('event_id', input.eventId)
    .eq('event_scoped_token_digest', digest)
    .select('id')
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return { deleted: (data?.length ?? 0) > 0 }
}

/** @deprecated */
export const eraseParticipationByToken = eraseEngagementByToken

/** Invalide les participations lors d'un report (soutiens conservés) */
export async function invalidateParticipationsForEvent(eventId: string) {
  if (useMockDb()) {
    const store = getMockStore()
    for (const e of store.engagements.filter(x => x.eventId === eventId)) {
      e.participatesAt = null
      e.participationKind = null
      e.updatedAt = nowIso()
    }
    store.engagements = store.engagements.filter(
      e => e.eventId !== eventId || e.supportsAt || e.participatesAt,
    )
    return
  }
  const supabase = getServiceSupabase()
  await supabase.from('engagements').update({
    participates_at: null,
    participation_kind: null,
    updated_at: nowIso(),
  }).eq('event_id', eventId).not('participates_at', 'is', null)

  // Supprime les lignes sans aucun engagement
  await supabase.from('engagements')
    .delete()
    .eq('event_id', eventId)
    .is('supports_at', null)
    .is('participates_at', null)
}
