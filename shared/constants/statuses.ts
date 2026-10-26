export const PUBLICATION_STATUSES = [
  'draft',
  'published',
  'unpublished',
] as const

export type PublicationStatus = (typeof PUBLICATION_STATUSES)[number]

export const SOURCE_VERIFICATION_STATUSES = [
  'cross_checked',
  'source_provided',
  'unconfirmed',
] as const

export type SourceVerificationStatus =
  (typeof SOURCE_VERIFICATION_STATUSES)[number]

export const EVENT_STATUS_OVERRIDES = [
  'cancelled',
  'postponed',
] as const

export type EventStatusOverride = (typeof EVENT_STATUS_OVERRIDES)[number]

/** Statuts temporels calculés (jamais stockés seuls) */
export const TEMPORAL_STATUSES = [
  'upcoming',
  'ongoing',
  'past',
] as const

export type TemporalStatus = (typeof TEMPORAL_STATUSES)[number]

/** Statut affiché = override prioritaire, sinon temporel */
export type DisplayEventStatus =
  | TemporalStatus
  | EventStatusOverride

export const REPORT_REASONS = [
  { id: 'wrong_date', label: 'Mauvaise date' },
  { id: 'wrong_location', label: 'Mauvais lieu' },
  { id: 'cancelled', label: 'Manifestation annulée' },
  { id: 'duplicate', label: 'Manifestation dupliquée' },
  { id: 'misleading', label: 'Informations trompeuses' },
  { id: 'problematic', label: 'Contenu problématique' },
  { id: 'other', label: 'Autre' },
] as const

export type ReportReasonId = (typeof REPORT_REASONS)[number]['id']

export const DISPLAY_STATUS_LABELS: Record<DisplayEventStatus, string> = {
  upcoming: 'À venir',
  ongoing: 'En cours',
  past: 'Terminée',
  cancelled: 'Annulée',
  postponed: 'Reportée',
}
