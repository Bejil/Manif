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
import {
  buildAdminPendingModerationEmail,
  buildChangesRequestedEmail,
  buildSubmissionApprovedEmail,
  buildSubmissionRejectedEmail,
  buildVerificationEmail,
  sendEmail,
} from './email'
import { geocodeCityCenter, geocodeFrenchPlace, requireGeocodedPlace } from './geocoding'
import { getMockStore, newId, nowIso, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'
import { listEntityHistory, type AdminHistoryEntry } from './admin-audit'
import { upsertEvent } from './events-repository'

function ensureSeeded() {
  if (useMockDb()) seedMockStore(buildDemoEvents())
}

function maskEmail(email: string) {
  const [user, domain] = email.split('@')
  if (!domain) return '***'
  return `${user.slice(0, 2)}***@${domain}`
}

/** Notifie l’admin qu’une proposition entre (ou revient) en file de modération. */
async function notifyAdminPendingModeration(opts: {
  title: string
  cityName: string
  submissionId: string
  kind: 'new' | 'updated'
}) {
  const config = useRuntimeConfig()
  const to = String(config.adminEmail || '').trim()
  if (!to) return
  const email = buildAdminPendingModerationEmail({
    siteUrl: String(config.public.siteUrl || ''),
    title: opts.title,
    cityName: opts.cityName,
    submissionId: opts.submissionId,
    kind: opts.kind,
  })
  try {
    await sendEmail({
      to,
      subject: email.subject,
      html: email.html,
      text: email.text,
    })
  }
  catch (e) {
    console.error('[email] notification admin modération échouée', e)
  }
}

async function notifyProposerSubmissionDecision(opts: {
  to: string
  title: string
  kind: 'approved' | 'rejected'
  eventSlug?: string
  reason?: string | null
}) {
  const to = opts.to.trim().toLowerCase()
  if (!to) return
  const config = useRuntimeConfig()
  try {
    if (opts.kind === 'approved' && opts.eventSlug) {
      const email = buildSubmissionApprovedEmail({
        siteUrl: String(config.public.siteUrl || ''),
        title: opts.title,
        eventSlug: opts.eventSlug,
      })
      await sendEmail({
        to,
        subject: email.subject,
        html: email.html,
        text: email.text,
      })
      return
    }
    if (opts.kind === 'rejected') {
      const email = buildSubmissionRejectedEmail({
        title: opts.title,
        reason: opts.reason,
      })
      await sendEmail({
        to,
        subject: email.subject,
        html: email.html,
        text: email.text,
      })
    }
  }
  catch (e) {
    console.error('[email] notification proposant (décision) échouée', e)
  }
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
  imageUrls?: string[]
  videoUrls?: string[]
  practicalInfo?: string
  proposerEmail: string
  pepper: string
  siteUrl: string
}) {
  ensureSeeded()
  // Refuse dès la proposition si le lieu n’est pas géocodable (BAN)
  await requireGeocodedPlace({
    cityName: input.cityName,
    locationName: input.locationName,
  })
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
    imageUrls: input.imageUrls ?? [],
    videoUrls: input.videoUrls ?? [],
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
      image_urls: base.imageUrls,
      video_urls: base.videoUrls,
      practical_info: base.practicalInfo,
      proposer_email: base.proposerEmail,
      verification_status: base.verificationStatus,
      verification_token_digest: base.verificationTokenDigest,
      verification_expires_at: base.verificationExpiresAt,
      moderation_status: base.moderationStatus,
    }).select('id').single()
    if (error) {
      if (/row-level security/i.test(error.message)) {
        throw createError({
          statusCode: 503,
          statusMessage:
            'Écriture refusée par Supabase (RLS). Vérifiez NUXT_SUPABASE_SERVICE_ROLE_KEY (clé service_role / sb_secret_, pas anon).',
        })
      }
      throw createError({ statusCode: 500, statusMessage: error.message })
    }
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
    await notifyAdminPendingModeration({
      title: submission.title,
      cityName: submission.cityName,
      submissionId: submission.id,
      kind: 'new',
    })
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
  await notifyAdminPendingModeration({
    title: submission.title,
    cityName: submission.cityName,
    submissionId: submission.id,
    kind: 'new',
  })
  return { alreadyVerified: false, id: submission.id }
}

export async function listPendingSubmissions() {
  return listAdminSubmissionsByStatus(['pending_moderation'])
}

export async function listModerationQueue() {
  return listAdminSubmissionsByStatus([
    'pending_moderation',
    'awaiting_verification',
    'changes_requested',
  ])
}

export async function listChangesRequestedSubmissions() {
  return listAdminSubmissionsByStatus(['changes_requested'])
}

/** Liste admin : tous les statuts, du plus récent au plus ancien. */
export async function listAllSubmissionsAdmin() {
  ensureSeeded()
  if (useMockDb()) {
    return getMockStore().submissions
      .slice()
      .sort((a, b) => b.updatedAt.localeCompare(a.updatedAt))
      .map(sanitizeSubmission)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .order('updated_at', { ascending: false })
    .limit(500)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return (data ?? []).map(rowToSubmission).map(sanitizeSubmission)
}

async function listAdminSubmissionsByStatus(
  statuses: EventSubmissionRecord['moderationStatus'][],
) {
  ensureSeeded()
  if (useMockDb()) {
    return getMockStore().submissions
      .filter(s => statuses.includes(s.moderationStatus))
      .sort((a, b) => b.updatedAt.localeCompare(a.updatedAt))
      .map(sanitizeSubmission)
  }
  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('event_submissions')
    .select('*')
    .in('moderation_status', statuses)
    .order('updated_at', { ascending: false })
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

/** Détail admin : e-mail + coords carte + historique modération. */
export async function getSubmissionForAdmin(id: string): Promise<
  (SanitizedSubmission & { history: AdminHistoryEntry[] }) | null
> {
  const base = await getSubmission(id, { includeEmail: true })
  if (!base) return null

  const history = await listEntityHistory('event_submission', id)

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
      history,
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
      history,
    }
  }
  return {
    ...base,
    mapLatitude: null,
    mapLongitude: null,
    mapPrecision: 'none',
    mapLabel: undefined,
    history,
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

  const geo = await requireGeocodedPlace({
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
    cityName: geo.cityName || submission.cityName,
    postalCode: geo.postalCode ?? null,
    localityCode: null,
    countryCode: 'FR',
    timezone: geo.timezone || timezoneFromPostalOrCity(null, submission.cityName),
    locationName: submission.locationName,
    latitude: geo.latitude,
    longitude: geo.longitude,
    locationRevealAt: computeLocationRevealAt(
      submission.startAt,
      submission.locationRevealHoursBefore,
    ),
    startAt: submission.startAt,
    endAt: submission.endAt,
    endIsEstimated: !submission.endAt,
    organizerName: submission.organizerName,
    sourceUrl: submission.sourceUrl,
    imageUrls: submission.imageUrls ?? [],
    videoUrls: submission.videoUrls ?? [],
    sourceVerificationStatus: submission.sourceUrl ? 'source_provided' : 'unconfirmed',
    publicationStatus: 'published',
    eventStatusOverride: null,
    createdAt: now,
    updatedAt: now,
    publishedAt: now,
    viewCount: 0,
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

  await notifyProposerSubmissionDecision({
    to: submission.proposerEmail,
    title: submission.title,
    kind: 'approved',
    eventSlug: event.slug,
  })

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

  await notifyProposerSubmissionDecision({
    to: submission.proposerEmail,
    title: submission.title,
    kind: 'rejected',
    reason: reason ?? null,
  })

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
    imageUrls: s.imageUrls ?? [],
    videoUrls: s.videoUrls ?? [],
    practicalInfo: s.practicalInfo ?? '',
    proposerEmailMasked: maskEmail(s.proposerEmail),
    adminMessage: s.rejectionReason,
  }
}

function displayValue(v: string | number | null | undefined): string {
  if (v == null || v === '') return ''
  return String(v)
}

function sameInstant(a: string | null | undefined, b: string | null | undefined): boolean {
  if (a == null || a === '') return b == null || b === ''
  if (b == null || b === '') return false
  const ta = DateTime.fromISO(a, { setZone: true })
  const tb = DateTime.fromISO(b, { setZone: true })
  if (ta.isValid && tb.isValid) return ta.toMillis() === tb.toMillis()
  return a === b
}

function formatChangeValue(
  field: string,
  v: string | number | null | undefined,
): string {
  if (v == null || v === '') return '(vide)'
  if (field === 'startAt' || field === 'endAt') {
    const dt = DateTime.fromISO(String(v), { setZone: true }).setZone('Europe/Paris')
    if (dt.isValid) return dt.toFormat('dd/MM/yyyy HH:mm')
  }
  return displayValue(v)
}

function valuesEqual(
  field: string,
  before: string | number | null | undefined,
  after: string | number | null | undefined,
): boolean {
  if (field === 'startAt' || field === 'endAt') {
    return sameInstant(
      before == null ? null : String(before),
      after == null ? null : String(after),
    )
  }
  return displayValue(before) === displayValue(after)
}

function buildSubmissionChanges(
  before: EventSubmissionRecord,
  after: {
    title: string
    description: string
    category: string
    cityName: string
    locationName: string
    locationRevealHoursBefore: number | null
    startAt: string | null
    endAt: string | null
    organizerName: string | null
    sourceUrl: string | null
    imageUrls: string[]
    videoUrls: string[]
    practicalInfo: string | null
  },
) {
  const fields: Array<{
    field: keyof typeof after
    label: string
    before: string | number | null
    after: string | number | null
  }> = [
    { field: 'title', label: 'Titre', before: before.title, after: after.title },
    { field: 'description', label: 'Description', before: before.description, after: after.description },
    { field: 'category', label: 'Catégorie', before: before.category, after: after.category },
    { field: 'cityName', label: 'Ville', before: before.cityName, after: after.cityName },
    { field: 'locationName', label: 'Lieu', before: before.locationName, after: after.locationName },
    {
      field: 'locationRevealHoursBefore',
      label: 'Publication du lieu',
      before: before.locationRevealHoursBefore,
      after: after.locationRevealHoursBefore,
    },
    { field: 'startAt', label: 'Début', before: before.startAt, after: after.startAt },
    { field: 'endAt', label: 'Fin', before: before.endAt, after: after.endAt },
    { field: 'organizerName', label: 'Organisateur', before: before.organizerName, after: after.organizerName },
    { field: 'sourceUrl', label: 'URL source', before: before.sourceUrl, after: after.sourceUrl },
    {
      field: 'imageUrls',
      label: 'Images',
      before: (before.imageUrls ?? []).join('\n') || null,
      after: after.imageUrls.join('\n') || null,
    },
    {
      field: 'videoUrls',
      label: 'Vidéos',
      before: (before.videoUrls ?? []).join('\n') || null,
      after: after.videoUrls.join('\n') || null,
    },
    { field: 'practicalInfo', label: 'Infos pratiques', before: before.practicalInfo, after: after.practicalInfo },
  ]

  return fields
    .filter(f => !valuesEqual(f.field, f.before, f.after))
    .map(f => ({
      field: f.field,
      label: f.label,
      before: formatChangeValue(f.field, f.before),
      after: formatChangeValue(f.field, f.after),
    }))
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
  imageUrls?: string[]
  videoUrls?: string[]
  practicalInfo?: string
}) {
  const submission = await loadSubmissionByEditToken(input.editToken, input.pepper)
  await requireGeocodedPlace({
    cityName: input.cityName,
    locationName: input.locationName,
  })
  const now = nowIso()

  const nextValues = {
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
    imageUrls: input.imageUrls ?? [],
    videoUrls: input.videoUrls ?? [],
    practicalInfo: input.practicalInfo ?? null,
  }

  const changes = buildSubmissionChanges(submission, nextValues)
  const summary = changes.length
    ? `Champs modifiés : ${changes.map(c => c.label).join(', ')}.`
    : 'Aucun champ modifié (renvoi sans changement).'

  const patch = {
    ...nextValues,
    moderationStatus: 'pending_moderation' as const,
    // Conserver le message admin pour l’historique ; le statut repasse en file
    editTokenDigest: null as string | null,
    editTokenExpiresAt: null as string | null,
    updatedAt: now,
  }

  const auditMeta = { message: summary, changes }

  if (useMockDb()) {
    Object.assign(submission, patch)
    getMockStore().audit.push({
      id: newId(),
      action: 'submission.resubmitted',
      entityType: 'event_submission',
      entityId: submission.id,
      actorId: submission.proposerEmail,
      createdAt: now,
      metadata: auditMeta,
    })
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
      image_urls: patch.imageUrls,
      video_urls: patch.videoUrls,
      practical_info: patch.practicalInfo,
      moderation_status: patch.moderationStatus,
      edit_token_digest: null,
      edit_token_expires_at: null,
      updated_at: now,
    }).eq('id', submission.id)
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    await supabase.from('admin_audit').insert({
      action: 'submission.resubmitted',
      entity_type: 'event_submission',
      entity_id: submission.id,
      actor_id: submission.proposerEmail,
      metadata: auditMeta,
    })
  }

  await notifyAdminPendingModeration({
    title: patch.title,
    cityName: patch.cityName,
    submissionId: submission.id,
    kind: 'updated',
  })

  return { ok: true, id: submission.id, changesCount: changes.length }
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
