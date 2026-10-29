import type { AlertRadiusKm } from '#shared/constants/alerts'
import type { EventAlertRecord } from '#shared/types/alert'
import {
  digestAlertConfirmToken,
  digestAlertUnsubscribeToken,
  randomToken,
} from '../utils/crypto'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { getMockStore, newId, nowIso } from './mock-store'

function normalizeEmail(email: string) {
  return email.trim().toLowerCase()
}

function rowToAlert(row: Record<string, unknown>): EventAlertRecord {
  return {
    id: String(row.id),
    email: String(row.email),
    locationLabel: String(row.location_label),
    latitude: Number(row.latitude),
    longitude: Number(row.longitude),
    radiusKm: Number(row.radius_km) as AlertRadiusKm,
    status: row.status as EventAlertRecord['status'],
    confirmTokenDigest: (row.confirm_token_digest as string | null) ?? null,
    unsubscribeTokenDigest: String(row.unsubscribe_token_digest),
    confirmedAt: (row.confirmed_at as string | null) ?? null,
    unsubscribedAt: (row.unsubscribed_at as string | null) ?? null,
    lastNotifiedAt: (row.last_notified_at as string | null) ?? null,
    createdAt: String(row.created_at),
    updatedAt: String(row.updated_at),
  }
}

function alertToRow(a: EventAlertRecord): Record<string, unknown> {
  return {
    id: a.id,
    email: a.email,
    location_label: a.locationLabel,
    latitude: a.latitude,
    longitude: a.longitude,
    radius_km: a.radiusKm,
    status: a.status,
    confirm_token_digest: a.confirmTokenDigest,
    unsubscribe_token_digest: a.unsubscribeTokenDigest,
    confirmed_at: a.confirmedAt,
    unsubscribed_at: a.unsubscribedAt,
    last_notified_at: a.lastNotifiedAt,
    created_at: a.createdAt,
    updated_at: a.updatedAt,
  }
}

export async function upsertAlertSubscription(input: {
  email: string
  locationLabel: string
  latitude: number
  longitude: number
  radiusKm: AlertRadiusKm
  pepper: string
}): Promise<{
  alert: EventAlertRecord
  confirmToken: string | null
  unsubscribeToken: string
  needsConfirmation: boolean
}> {
  const email = normalizeEmail(input.email)
  const now = nowIso()
  const confirmToken = randomToken()
  const unsubscribeToken = randomToken()
  const confirmDigest = digestAlertConfirmToken(confirmToken, input.pepper)
  const unsubDigest = digestAlertUnsubscribeToken(unsubscribeToken, input.pepper)

  const existing = await findAlertByEmail(email)

  if (existing?.status === 'active') {
    const updated: EventAlertRecord = {
      ...existing,
      locationLabel: input.locationLabel.trim(),
      latitude: input.latitude,
      longitude: input.longitude,
      radiusKm: input.radiusKm,
      unsubscribeTokenDigest: unsubDigest,
      updatedAt: now,
      // reste active — pas de re-confirmation
      confirmTokenDigest: null,
    }
    await saveAlert(updated)
    return {
      alert: updated,
      confirmToken: null,
      unsubscribeToken,
      needsConfirmation: false,
    }
  }

  const base: EventAlertRecord = {
    id: existing?.id || newId(),
    email,
    locationLabel: input.locationLabel.trim(),
    latitude: input.latitude,
    longitude: input.longitude,
    radiusKm: input.radiusKm,
    status: 'pending',
    confirmTokenDigest: confirmDigest,
    unsubscribeTokenDigest: unsubDigest,
    confirmedAt: null,
    unsubscribedAt: null,
    lastNotifiedAt: null,
    createdAt: existing?.createdAt || now,
    updatedAt: now,
  }
  await saveAlert(base)
  return {
    alert: base,
    confirmToken,
    unsubscribeToken,
    needsConfirmation: true,
  }
}

async function findAlertByEmail(email: string): Promise<EventAlertRecord | null> {
  if (useMockDb()) {
    return getMockStore().eventAlerts.find(a => a.email === email) || null
  }
  const { data, error } = await getServiceSupabase()
    .from('event_alerts')
    .select('*')
    .eq('email', email)
    .maybeSingle()
  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }
  return data ? rowToAlert(data) : null
}

async function saveAlert(alert: EventAlertRecord): Promise<void> {
  if (useMockDb()) {
    const store = getMockStore()
    const idx = store.eventAlerts.findIndex(a => a.id === alert.id)
    if (idx >= 0) store.eventAlerts[idx] = alert
    else store.eventAlerts.push(alert)
    return
  }
  const { error } = await getServiceSupabase()
    .from('event_alerts')
    .upsert(alertToRow(alert), { onConflict: 'id' })
  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }
}

export async function confirmAlert(
  token: string,
  pepper: string,
): Promise<{ ok: true, email: string } | { ok: false, reason: string }> {
  const digest = digestAlertConfirmToken(token, pepper)
  let alert: EventAlertRecord | null = null

  if (useMockDb()) {
    alert = getMockStore().eventAlerts.find(a => a.confirmTokenDigest === digest) || null
  }
  else {
    const { data, error } = await getServiceSupabase()
      .from('event_alerts')
      .select('*')
      .eq('confirm_token_digest', digest)
      .maybeSingle()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    alert = data ? rowToAlert(data) : null
  }

  if (!alert) return { ok: false, reason: 'invalid' }
  if (alert.status === 'active') return { ok: true, email: alert.email }
  if (alert.status === 'unsubscribed') return { ok: false, reason: 'unsubscribed' }

  const now = nowIso()
  const updated: EventAlertRecord = {
    ...alert,
    status: 'active',
    confirmTokenDigest: null,
    confirmedAt: now,
    lastNotifiedAt: now,
    unsubscribedAt: null,
    updatedAt: now,
  }
  await saveAlert(updated)
  return { ok: true, email: alert.email }
}

export async function unsubscribeAlert(
  token: string,
  pepper: string,
): Promise<{ ok: true } | { ok: false, reason: string }> {
  const digest = digestAlertUnsubscribeToken(token, pepper)
  let alert: EventAlertRecord | null = null

  if (useMockDb()) {
    alert = getMockStore().eventAlerts.find(a => a.unsubscribeTokenDigest === digest) || null
  }
  else {
    const { data, error } = await getServiceSupabase()
      .from('event_alerts')
      .select('*')
      .eq('unsubscribe_token_digest', digest)
      .maybeSingle()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    alert = data ? rowToAlert(data) : null
  }

  if (!alert) return { ok: false, reason: 'invalid' }
  if (alert.status === 'unsubscribed') return { ok: true }

  const now = nowIso()
  await saveAlert({
    ...alert,
    status: 'unsubscribed',
    confirmTokenDigest: null,
    unsubscribedAt: now,
    updatedAt: now,
  })
  return { ok: true }
}

export async function listActiveAlerts(): Promise<EventAlertRecord[]> {
  if (useMockDb()) {
    return getMockStore().eventAlerts.filter(a => a.status === 'active')
  }
  const { data, error } = await getServiceSupabase()
    .from('event_alerts')
    .select('*')
    .eq('status', 'active')
    .order('created_at', { ascending: true })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToAlert)
}

/** Vue admin : sans digests de jetons. */
export type AlertAdminRow = Omit<
  EventAlertRecord,
  'confirmTokenDigest' | 'unsubscribeTokenDigest'
>

function toAdminRow(a: EventAlertRecord): AlertAdminRow {
  const { confirmTokenDigest: _c, unsubscribeTokenDigest: _u, ...rest } = a
  return rest
}

export async function listAlertsAdmin(opts?: {
  status?: EventAlertRecord['status'] | 'all'
}): Promise<{ items: AlertAdminRow[], counts: Record<EventAlertRecord['status'], number> }> {
  const filter = opts?.status || 'all'

  let all: EventAlertRecord[]
  if (useMockDb()) {
    all = [...getMockStore().eventAlerts]
  }
  else {
    const { data, error } = await getServiceSupabase()
      .from('event_alerts')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(2000)
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    all = (data ?? []).map(rowToAlert)
  }

  const counts: Record<EventAlertRecord['status'], number> = {
    pending: 0,
    active: 0,
    unsubscribed: 0,
  }
  for (const a of all) counts[a.status] += 1

  const items = (filter === 'all' ? all : all.filter(a => a.status === filter))
    .map(toAdminRow)

  return { items, counts }
}

export async function deleteAlertById(id: string): Promise<boolean> {
  if (useMockDb()) {
    const store = getMockStore()
    const before = store.eventAlerts.length
    store.eventAlerts = store.eventAlerts.filter(a => a.id !== id)
    return store.eventAlerts.length < before
  }
  const { data, error } = await getServiceSupabase()
    .from('event_alerts')
    .delete()
    .eq('id', id)
    .select('id')
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data?.length ?? 0) > 0
}

export async function markAlertNotified(id: string, at: string): Promise<void> {
  if (useMockDb()) {
    const store = getMockStore()
    const alert = store.eventAlerts.find(a => a.id === id)
    if (alert) {
      alert.lastNotifiedAt = at
      alert.updatedAt = at
    }
    return
  }
  const { error } = await getServiceSupabase()
    .from('event_alerts')
    .update({ last_notified_at: at, updated_at: at })
    .eq('id', id)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
}

/** Nouveau jeton de désinscription (inclus dans chaque digest). */
export async function rotateUnsubscribeToken(
  id: string,
  pepper: string,
): Promise<string> {
  const token = randomToken()
  const digest = digestAlertUnsubscribeToken(token, pepper)
  const now = nowIso()
  if (useMockDb()) {
    const store = getMockStore()
    const alert = store.eventAlerts.find(a => a.id === id)
    if (alert) {
      alert.unsubscribeTokenDigest = digest
      alert.updatedAt = now
    }
    return token
  }
  const { error } = await getServiceSupabase()
    .from('event_alerts')
    .update({ unsubscribe_token_digest: digest, updated_at: now })
    .eq('id', id)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return token
}
