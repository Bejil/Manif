import type { EventRecord } from '#shared/types/event'
import type { EventSubmissionRecord } from '#shared/types/submission'
import type { EngagementRecord } from '#shared/types/engagement'
import type { ParticipationKind } from '#shared/utils/event-time'

export function rowToEvent(row: Record<string, unknown>): EventRecord {
  return {
    id: row.id as string,
    slug: row.slug as string,
    title: row.title as string,
    description: row.description as string,
    category: row.category as EventRecord['category'],
    cityName: row.city_name as string,
    postalCode: (row.postal_code as string | null) ?? null,
    localityCode: (row.locality_code as string | null) ?? null,
    countryCode: (row.country_code as string) || 'FR',
    timezone: row.timezone as string,
    locationName: row.location_name as string,
    latitude: (row.latitude as number | null) ?? null,
    longitude: (row.longitude as number | null) ?? null,
    locationRevealAt: row.location_reveal_at ? normalizeTs(row.location_reveal_at) : null,
    startAt: row.start_at ? normalizeTs(row.start_at) : null,
    endAt: row.end_at ? normalizeTs(row.end_at) : null,
    endIsEstimated: Boolean(row.end_is_estimated),
    organizerName: (row.organizer_name as string | null) ?? null,
    sourceUrl: (row.source_url as string | null) ?? null,
    sourceVerificationStatus: row.source_verification_status as EventRecord['sourceVerificationStatus'],
    publicationStatus: row.publication_status as EventRecord['publicationStatus'],
    eventStatusOverride: (row.event_status_override as EventRecord['eventStatusOverride']) ?? null,
    createdAt: normalizeTs(row.created_at),
    updatedAt: normalizeTs(row.updated_at),
    publishedAt: row.published_at ? normalizeTs(row.published_at) : null,
    isDemo: Boolean(row.is_demo),
  }
}

export function eventToRow(event: Partial<EventRecord> & { id?: string }) {
  return {
    ...(event.id ? { id: event.id } : {}),
    slug: event.slug,
    title: event.title,
    description: event.description,
    category: event.category,
    city_name: event.cityName,
    postal_code: event.postalCode ?? null,
    locality_code: event.localityCode ?? null,
    country_code: event.countryCode ?? 'FR',
    timezone: event.timezone,
    location_name: event.locationName,
    latitude: event.latitude ?? null,
    longitude: event.longitude ?? null,
    location_reveal_at: event.locationRevealAt ?? null,
    start_at: event.startAt,
    end_at: event.endAt ?? null,
    end_is_estimated: event.endIsEstimated,
    organizer_name: event.organizerName ?? null,
    source_url: event.sourceUrl ?? null,
    source_verification_status: event.sourceVerificationStatus,
    publication_status: event.publicationStatus,
    event_status_override: event.eventStatusOverride ?? null,
    is_demo: event.isDemo ?? false,
    published_at: event.publishedAt ?? null,
    updated_at: event.updatedAt,
    created_at: event.createdAt,
  }
}

export function rowToSubmission(row: Record<string, unknown>): EventSubmissionRecord {
  return {
    id: row.id as string,
    title: row.title as string,
    description: row.description as string,
    category: row.category as EventSubmissionRecord['category'],
    cityName: row.city_name as string,
    locationName: row.location_name as string,
    locationRevealHoursBefore: (row.location_reveal_hours_before as number | null) ?? null,
    startAt: row.start_at ? normalizeTs(row.start_at) : null,
    endAt: row.end_at ? normalizeTs(row.end_at) : null,
    organizerName: (row.organizer_name as string | null) ?? null,
    sourceUrl: (row.source_url as string | null) ?? null,
    practicalInfo: (row.practical_info as string | null) ?? null,
    proposerEmail: row.proposer_email as string,
    verificationStatus: row.verification_status as EventSubmissionRecord['verificationStatus'],
    verificationTokenDigest: (row.verification_token_digest as string | null) ?? null,
    verificationExpiresAt: row.verification_expires_at
      ? normalizeTs(row.verification_expires_at)
      : null,
    moderationStatus: row.moderation_status as EventSubmissionRecord['moderationStatus'],
    rejectionReason: (row.rejection_reason as string | null) ?? null,
    publishedEventId: (row.published_event_id as string | null) ?? null,
    createdAt: normalizeTs(row.created_at),
    updatedAt: normalizeTs(row.updated_at),
  }
}

export function rowToEngagement(row: Record<string, unknown>): EngagementRecord {
  return {
    id: row.id as string,
    eventId: row.event_id as string,
    eventScopedTokenDigest: row.event_scoped_token_digest as string,
    supportsAt: row.supports_at ? normalizeTs(row.supports_at) : null,
    participatesAt: row.participates_at ? normalizeTs(row.participates_at) : null,
    participationKind: (row.participation_kind as ParticipationKind | null) ?? null,
    updatedAt: normalizeTs(row.updated_at),
  }
}

function normalizeTs(value: unknown): string {
  if (typeof value === 'string') return value
  if (value instanceof Date) return value.toISOString()
  return String(value)
}
