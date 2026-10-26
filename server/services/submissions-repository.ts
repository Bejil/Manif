import { DateTime } from 'luxon'
import type { EventSubmissionRecord } from '#shared/types/submission'
import type { EventRecord } from '#shared/types/event'
import { createEventSlug, ensureUniqueSlug } from '#shared/utils/slug'
import { computeLocationRevealAt } from '#shared/utils/location'
import { digestEditToken, digestVerificationToken, randomToken } from '../utils/crypto'
import { badRequest, notFound } from '../utils/errors'
import { rowToSubmission } from '../utils/mappers'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { timezoneFromPostalOrCity } from '../utils/timezone'
import { buildChangesRequestedEmail, buildVerificationEmail, sendEmail } from './email'
import { geocodeCityCenter, geocodeFrenchPlace } from './geocoding'
import { getMockStore, newId, nowIso, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'
import { upsertEvent } from './events-repository'

function ensureSeeded() {
  if (useMockDb()) seedMockStore(buildDemoEvents())
}

function maskEmail(email: string) {
  const [user, domain] = email.split('@')
  if (!domain) return '***'
  return `${user.slice(0, 2)}***@${domain}`
}

function sanitizeSubmission(s: EventSubmissionRecord, opts?: { includeEmail?: boolean }) {
  const {
    proposerEmail,
    verificationTokenDigest: _v,
    editTokenDigest: _e,
    ...rest
  } = s
  return {
    ...rest,
    proposerEmailMasked: maskEmail(proposerEmail),
    ...(opts?.includeEmail ? { proposerEmail } : {}),
  }
}

export type SanitizedSubmission = ReturnType<typeof sanitizeSubmission> & {
  mapLatitude?: number | null
  mapLongitude?: number | null
  mapPrecision?: 'place' | 'city' | 'none'
  mapLabel?: string
}

export async function createSubmission(input: {
  title: string
  description: string
  category: EventSubmissionRecord['category']
  cityName: string
  locationName: string
  locationRevealHoursBefore?: number | null
  startAt: string | null
  endAt: string | null
  organizerName?: string
  sourceUrl?: string
  practicalInfo?: string
  proposerEmail: string
  pepper: string
  siteUrl: string
}) {
  ensureSeeded()
  const rawToken = randomToken(32)
  const digest = digestVerificationToken(rawToken, input.pepper)
  const now = nowIso()
  const expires = DateTime.utc().plus({ hours: 24 }).toISO()!

  const base = {
    title: input.title,
    description: input.description,
    category: input.category,
    cityName: input.cityName,
    locationName: input.locationName,
    locationRevealHoursBefore: input.locationRevealHoursBefore ?? null,
    startAt: input.startAt,
    endAt: input.endAt,
    organizerName: input.organizerName ?? null,
    sourceUrl: input.sourceUrl ?? null,
    practicalInfo: input.practicalInfo ?? null,
    proposerEmail: input.proposerEmail.toLowerCase(),
    verificationStatus: 'pending' as const,
    verificationTokenDigest: digest,
    verificationExpiresAt: expires,
    editTokenDigest: null,
    editTokenExpiresAt: null,
    moderationStatus: 'awaiting_verification' as const,
    rejectionReason: null,
    publishedEventId: null,
    createdAt: now,
    updatedAt: now,
  }

  let id: string
  if (useMockDb()) {
    id = newId()
    getMockStore().submissions.push({ id, ...base })
  }
  else {
    const supabase = getServiceSupabase()
    const { data, error } = await supabase.from('event_submissions').insert({
      title: base.title,
      description: base.description,
      category: base.category,
      city_name: base.cityName,
      location_name: base.locationName,
      location_reveal_hours_before: base.locationRevealHoursBefore,
      start_at: base.startAt,
      end_at: base.endAt,
      organizer_name: base.organizerName,
      source_url: base.sourceUrl,
      practical_info: base.practicalInfo,
      proposer_email: base.proposerEmail,
      verification_status: base.verificationStatus,
      verification_token_digest: base.verificationTokenDigest,
      verification_expires_at: base.verificationExpiresAt,
      moderation_status: base.moderationStatus,
    }).select('id').single()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    id = data.id
  }

  const email = buildVerificationEmail({
    siteUrl: input.siteUrl,
    token: rawToken,
    title: input.title,
  })
  const sent = await sendEmail({
    to: base.proposerEmail,
    subject: email.subject,
    html: email.html,
    text: email.text,
  })

  return {
    id,
    emailMocked: sent.mocked,
    ...(import.meta.dev ? { devVerificationToken: rawToken, devLink: email.link } : {}),
  }
}

export async function verifySubmission(token: string, pepper: string) {
  ensureSeeded()
  const digest = digestVerificationToken(token, pepper)

  if (useMockDb()) {
    const submission = getMockStore().submissions.find(s => s.verificationTokenDigest === digest)
    if (!submission) throw notFound('Lien de vérification invalide')
    if (submission.verificationStatus === 'verified') {
      return { alreadyVerified: true, id: submission.id }
    }
    if (
      !submission.verificationExpiresAt
      || DateTime.fromISO(submission.verificationExpiresAt) < DateTime.utc()
    ) {
      submission.verificationStatus = 'expired'
      throw badRequest('Ce lien de vérification a expiré (24 h).')
    }
    submission.verificationStatus = 'verified'
    submission.verificationTokenDigest = null
    submission.verificationExpiresAt = null
    submission.moderationStatus = 'pending_moderation'
    submission.updatedAt = nowIso()
    return { alreadyVerified: false, id: submission.id }
  }

  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .eq('verification_token_digest', digest)
    .maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  if (!data) throw notFound('Lien de vérification invalide')
  const submission = rowToSubmission(data)
  if (submission.verificationStatus === 'verified') {
    return { alreadyVerified: true, id: submission.id }
  }
  if (
    !submission.verificationExpiresAt
    || DateTime.fromISO(submission.verificationExpiresAt) < DateTime.utc()
  ) {
    await supabase.from('event_submissions').update({ verification_status: 'expired' }).eq('id', submission.id)
    throw badRequest('Ce lien de vérification a expiré (24 h).')
  }
  await supabase.from('event_submissions').update({
    verification_status: 'verified',
    verification_token_digest: null,
    verification_expires_at: null,
    moderation_status: 'pending_moderation',
    updated_at: nowIso(),
  }).eq('id', submission.id)
  return { alreadyVerified: false, id: submission.id }
}

export async function listPendingSubmissions() {
  ensureSeeded()
  if (useMockDb()) {
    return getMockStore().submissions
      .filter(s => s.moderationStatus === 'pending_moderation')
      .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
      .map(sanitizeSubmission)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .eq('moderation_status', 'pending_moderation')
    .order('created_at', { ascending: false })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToSubmission).map(sanitizeSubmission)
}

export async function listModerationQueue() {
  ensureSeeded()
  if (useMockDb()) {
    return getMockStore().submissions
      .filter(s =>
        s.moderationStatus === 'pending_moderation'
        || s.moderationStatus === 'awaiting_verification'
        || s.moderationStatus === 'changes_requested',
      )
      .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
      .map(sanitizeSubmission)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .in('moderation_status', ['pending_moderation', 'awaiting_verification', 'changes_requested'])
    .order('created_at', { ascending: false })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToSubmission).map(sanitizeSubmission)
}

export async function listChangesRequestedSubmissions() {
  ensureSeeded()
  if (useMockDb()) {
    return getMockStore().submissions
      .filter(s => s.moderationStatus === 'changes_requested')
      .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
      .map(sanitizeSubmission)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .eq('moderation_status', 'changes_requested')
    .order('created_at', { ascending: false })
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToSubmission).map(sanitizeSubmission)
}

export async function getSubmission(id: string, opts?: { includeEmail?: boolean }) {
  ensureSeeded()
  let raw: EventSubmissionRecord | null = null
  if (useMockDb()) {
    raw = getMockStore().submissions.find(x => x.id === id) ?? null
  }
  else {
    const supabase = getServiceSupabase()
    const { data, error } = await supabase.from('event_submissions').select('*').eq('id', id).maybeSingle()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    raw = data ? rowToSubmission(data) : null
  }
  return raw ? sanitizeSubmission(raw, opts) : null
}

/** Détail admin : e-mail + coords carte (lieu ou centre-ville). */
export async function getSubmissionForAdmin(id: string): Promise<SanitizedSubmission | null> {
  const base = await getSubmission(id, { includeEmail: true })
  if (!base) return null

  const place = await geocodeFrenchPlace({
    cityName: base.cityName,
    locationName: base.locationName,
  })
  if (place) {
    return {
      ...base,
      mapLatitude: place.latitude,
      mapLongitude: place.longitude,
      mapPrecision: 'place',
      mapLabel: place.label,
    }
  }
  const city = await geocodeCityCenter({ cityName: base.cityName })
  if (city) {
    return {
      ...base,
      mapLatitude: city.latitude,
      mapLongitude: city.longitude,
      mapPrecision: 'city',
      mapLabel: city.label,
    }
  }
  return {
    ...base,
    mapLatitude: null,
    mapLongitude: null,
    mapPrecision: 'none',
    mapLabel: undefined,
  }
}

async function loadRawSubmission(id: string): Promise<EventSubmissionRecord | null> {
  if (useMockDb()) {
    return getMockStore().submissions.find(x => x.id === id) ?? null
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase.from('event_submissions').select('*').eq('id', id).maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return data ? rowToSubmission(data) : null
}

export async function approveSubmission(id: string, actorId: string) {
  ensureSeeded()
  const submission = await loadRawSubmission(id)
  if (!submission) throw notFound()
  if (
    submission.moderationStatus !== 'pending_moderation'
    && submission.moderationStatus !== 'changes_requested'
  ) {
    throw badRequest('Cette proposition n\'est pas en attente de modération.')
  }

  const geo = await geocodeFrenchPlace({
    cityName: submission.cityName,
    locationName: submission.locationName,
  })

  let existingSlugs: Set<string>
  if (useMockDb()) {
    existingSlugs = new Set(getMockStore().events.map(e => e.slug))
  }
  else {
    const supabase = getServiceSupabase()
    const { data } = await supabase.from('events').select('slug')
    existingSlugs = new Set((data ?? []).map(r => r.slug as string))
  }

  const baseSlug = createEventSlug(submission.title, submission.cityName, submission.startAt)
  const slug = ensureUniqueSlug(baseSlug, existingSlugs)
  const now = nowIso()

  const event: EventRecord = {
    id: newId(),
    slug,
    title: submission.title,
    description: submission.practicalInfo
      ? `${submission.description}\n\nInformations pratiques : ${submission.practicalInfo}`
      : submission.description,
    category: submission.category,
    cityName: geo?.cityName || submission.cityName,
    postalCode: geo?.postalCode ?? null,
    localityCode: null,
    countryCode: 'FR',
    timezone: geo?.timezone || timezoneFromPostalOrCity(null, submission.cityName),
    locationName: submission.locationName,
    latitude: geo?.latitude ?? null,
    longitude: geo?.longitude ?? null,
    locationRevealAt: computeLocationRevealAt(
      submission.startAt,
      submission.locationRevealHoursBefore,
    ),
    startAt: submission.startAt,
    endAt: submission.endAt,
    endIsEstimated: !submission.endAt,
    organizerName: submission.organizerName,
    sourceUrl: submission.sourceUrl,
    sourceVerificationStatus: submission.sourceUrl ? 'source_provided' : 'unconfirmed',
    publicationStatus: 'published',
    eventStatusOverride: null,
    createdAt: now,
    updatedAt: now,
    publishedAt: now,
    isDemo: false,
  }

  await upsertEvent(event)

  if (useMockDb()) {
    const store = getMockStore()
    const s = store.submissions.find(x => x.id === id)!
    s.moderationStatus = 'approved'
    s.publishedEventId = event.id
    s.updatedAt = now
    store.audit.push({
      id: newId(),
      action: 'submission.approve',
      entityType: 'event_submission',
      entityId: submission.id,
      actorId,
      createdAt: now,
      metadata: { eventId: event.id },
    })
  }
  else {
    const supabase = getServiceSupabase()
    await supabase.from('event_submissions').update({
      moderation_status: 'approved',
      published_event_id: event.id,
      updated_at: now,
    }).eq('id', id)
    await supabase.from('admin_audit').insert({
      action: 'submission.approve',
      entity_type: 'event_submission',
      entity_id: id,
      actor_id: actorId,
      metadata: { eventId: event.id },
    })
  }

  return { event }
}

export async function rejectSubmission(id: string, actorId: string, reason?: string) {
  ensureSeeded()
  const submission = await loadRawSubmission(id)
  if (!submission) throw notFound()
  if (
    submission.moderationStatus !== 'pending_moderation'
    && submission.moderationStatus !== 'changes_requested'
  ) {
    throw badRequest('Cette proposition ne peut pas être refusée dans cet état.')
  }
  const now = nowIso()

  if (useMockDb()) {
    submission.moderationStatus = 'rejected'
    submission.rejectionReason = reason ?? null
    submission.updatedAt = now
    getMockStore().audit.push({
      id: newId(),
      action: 'submission.reject',
      entityType: 'event_submission',
      entityId: id,
      actorId,
      createdAt: now,
      metadata: { reason },
    })
  }
  else {
    const supabase = getServiceSupabase()
    await supabase.from('event_submissions').update({
      moderation_status: 'rejected',
      rejection_reason: reason ?? null,
      updated_at: now,
    }).eq('id', id)
    await supabase.from('admin_audit').insert({
      action: 'submission.reject',
      entity_type: 'event_submission',
      entity_id: id,
      actor_id: actorId,
      metadata: { reason },
    })
  }
  return { ok: true }
}

export async function requestSubmissionChanges(
  id: string,
  actorId: string,
  message: string,
  siteUrl: string,
  pepper: string,
) {
  ensureSeeded()
  const submission = await loadRawSubmission(id)
  if (!submission) throw notFound()
  if (
    submission.moderationStatus !== 'pending_moderation'
    && submission.moderationStatus !== 'changes_requested'
  ) {
    throw badRequest('Impossible de demander des modifications dans cet état.')
  }
  const now = nowIso()
  const trimmed = message.trim()
  if (trimmed.length < 10) throw badRequest('Précisez la demande (10 caractères minimum).')

  const rawEditToken = randomToken(32)
  const editDigest = digestEditToken(rawEditToken, pepper)
  const editExpires = DateTime.utc().plus({ days: 14 }).toISO()!

  if (useMockDb()) {
    submission.moderationStatus = 'changes_requested'
    submission.rejectionReason = trimmed
    submission.editTokenDigest = editDigest
    submission.editTokenExpiresAt = editExpires
    submission.updatedAt = now
    getMockStore().audit.push({
      id: newId(),
      action: 'submission.changes_requested',
      entityType: 'event_submission',
      entityId: id,
      actorId,
      createdAt: now,
      metadata: { message: trimmed },
    })
  }
  else {
    const supabase = getServiceSupabase()
    const { error } = await supabase.from('event_submissions').update({
      moderation_status: 'changes_requested',
      rejection_reason: trimmed,
      edit_token_digest: editDigest,
      edit_token_expires_at: editExpires,
      updated_at: now,
    }).eq('id', id)
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    await supabase.from('admin_audit').insert({
      action: 'submission.changes_requested',
      entity_type: 'event_submission',
      entity_id: id,
      actor_id: actorId,
      metadata: { message: trimmed },
    })
  }

  const email = buildChangesRequestedEmail({
    siteUrl,
    title: submission.title,
    message: trimmed,
    editToken: rawEditToken,
  })
  const sent = await sendEmail({
    to: submission.proposerEmail,
    subject: email.subject,
    html: email.html,
    text: email.text,
  })

  return {
    ok: true,
    emailMocked: sent.mocked,
    ...(import.meta.dev ? { devEditLink: email.editLink } : {}),
  }
}

async function loadSubmissionByEditToken(
  token: string,
  pepper: string,
): Promise<EventSubmissionRecord> {
  ensureSeeded()
  const digest = digestEditToken(token, pepper)

  let submission: EventSubmissionRecord | null = null
  if (useMockDb()) {
    submission = getMockStore().submissions.find(s => s.editTokenDigest === digest) ?? null
  }
  else {
    const supabase = getServiceSupabase()
    const { data, error } = await supabase
      .from('event_submissions')
      .select('*')
      .eq('edit_token_digest', digest)
      .maybeSingle()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    submission = data ? rowToSubmission(data) : null
  }

  if (!submission) throw notFound('Lien de modification invalide ou déjà utilisé')
  if (submission.moderationStatus !== 'changes_requested') {
    throw badRequest('Cette proposition n’est plus en attente de modifications.')
  }
  if (
    !submission.editTokenExpiresAt
    || DateTime.fromISO(submission.editTokenExpiresAt) < DateTime.utc()
  ) {
    throw badRequest('Ce lien de modification a expiré (14 jours).')
  }
  return submission
}

/** Données formulaire pour le proposant (jeton e-mail). */
export async function getSubmissionForEdit(token: string, pepper: string) {
  const s = await loadSubmissionByEditToken(token, pepper)
  const tz = timezoneFromPostalOrCity(null, s.cityName)
  let date = ''
  let startTime = ''
  let endTime = ''
  let dateToConfirm = !s.startAt
  if (s.startAt) {
    const start = DateTime.fromISO(s.startAt, { setZone: true }).setZone(tz)
    date = start.toFormat('yyyy-MM-dd')
    startTime = start.toFormat('HH:mm')
    if (s.endAt) {
      const end = DateTime.fromISO(s.endAt, { setZone: true }).setZone(tz)
      endTime = end.toFormat('HH:mm')
    }
  }
  return {
    id: s.id,
    title: s.title,
    description: s.description,
    category: s.category,
    cityName: s.cityName,
    locationName: s.locationName,
    locationRevealHoursBefore: s.locationRevealHoursBefore,
    dateToConfirm,
    date,
    startTime,
    endTime,
    organizerName: s.organizerName ?? '',
    sourceUrl: s.sourceUrl ?? '',
    practicalInfo: s.practicalInfo ?? '',
    proposerEmailMasked: maskEmail(s.proposerEmail),
    adminMessage: s.rejectionReason,
  }
}

export async function updateSubmissionAfterChanges(input: {
  editToken: string
  pepper: string
  title: string
  description: string
  category: EventSubmissionRecord['category']
  cityName: string
  locationName: string
  locationRevealHoursBefore?: number | null
  startAt: string | null
  endAt: string | null
  organizerName?: string
  sourceUrl?: string
  practicalInfo?: string
}) {
  const submission = await loadSubmissionByEditToken(input.editToken, input.pepper)
  const now = nowIso()

  const patch = {
    title: input.title,
    description: input.description,
    category: input.category,
    cityName: input.cityName,
    locationName: input.locationName,
    locationRevealHoursBefore: input.locationRevealHoursBefore ?? null,
    startAt: input.startAt,
    endAt: input.endAt,
    organizerName: input.organizerName ?? null,
    sourceUrl: input.sourceUrl ?? null,
    practicalInfo: input.practicalInfo ?? null,
    moderationStatus: 'pending_moderation' as const,
    // Conserver le message admin pour l’historique ; le statut repasse en file
    editTokenDigest: null as string | null,
    editTokenExpiresAt: null as string | null,
    updatedAt: now,
  }

  if (useMockDb()) {
    Object.assign(submission, patch)
  }
  else {
    const supabase = getServiceSupabase()
    const { error } = await supabase.from('event_submissions').update({
      title: patch.title,
      description: patch.description,
      category: patch.category,
      city_name: patch.cityName,
      location_name: patch.locationName,
      location_reveal_hours_before: patch.locationRevealHoursBefore,
      start_at: patch.startAt,
      end_at: patch.endAt,
      organizer_name: patch.organizerName,
      source_url: patch.sourceUrl,
      practical_info: patch.practicalInfo,
      moderation_status: patch.moderationStatus,
      edit_token_digest: null,
      edit_token_expires_at: null,
      updated_at: now,
    }).eq('id', submission.id)
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return { ok: true, id: submission.id }
}

/** Remet une proposition « modifications demandées » en file de modération. */
export async function reopenSubmissionForModeration(id: string, actorId: string) {
  ensureSeeded()
  const submission = await loadRawSubmission(id)
  if (!submission) throw notFound()
  if (submission.moderationStatus !== 'changes_requested') {
    throw badRequest('Seules les propositions avec modifications demandées peuvent être rouvertes.')
  }
  const now = nowIso()

  if (useMockDb()) {
    submission.moderationStatus = 'pending_moderation'
    submission.updatedAt = now
    getMockStore().audit.push({
      id: newId(),
      action: 'submission.reopen',
      entityType: 'event_submission',
      entityId: id,
      actorId,
      createdAt: now,
      metadata: {},
    })
  }
  else {
    const supabase = getServiceSupabase()
    await supabase.from('event_submissions').update({
      moderation_status: 'pending_moderation',
      updated_at: now,
    }).eq('id', id)
    await supabase.from('admin_audit').insert({
      action: 'submission.reopen',
      entity_type: 'event_submission',
      entity_id: id,
      actor_id: actorId,
      metadata: {},
    })
  }
  return { ok: true }
}
