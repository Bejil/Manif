import type { EventCategoryId } from '../constants/categories'
import type {
  DisplayEventStatus,
  EventStatusOverride,
  PublicationStatus,
  SourceVerificationStatus,
} from '../constants/statuses'

export interface EventRecord {
  id: string
  slug: string
  title: string
  description: string
  category: EventCategoryId
  cityName: string
  postalCode: string | null
  localityCode: string | null
  countryCode: string
  timezone: string
  locationName: string
  latitude: number | null
  longitude: number | null
  /**
   * À partir de cette date le lieu précis (nom + GPS) est public.
   * null = toujours public.
   */
  locationRevealAt: string | null
  /** null = date à confirmer */
  startAt: string | null
  endAt: string | null
  endIsEstimated: boolean
  organizerName: string | null
  sourceUrl: string | null
  sourceVerificationStatus: SourceVerificationStatus
  publicationStatus: PublicationStatus
  eventStatusOverride: EventStatusOverride | null
  createdAt: string
  updatedAt: string
  publishedAt: string | null
  /** Legacy DB flag — non exposé dans l’UI */
  isDemo?: boolean
}

export interface EventCounts {
  supports: number
  participations: number
}

/** Fiche publique : la fiabilité source reste interne (jamais exposée). */
export interface EventPublic extends Omit<EventRecord, 'sourceVerificationStatus'> {
  displayStatus: DisplayEventStatus
  counts: EventCounts
  /** Lieu précis déjà visible pour le public */
  locationRevealed: boolean
  /**
   * Coordonnées pour la carte détail.
   * Lieu précis si révélé, sinon centre-ville (le point de RDV reste masqué).
   */
  mapLatitude: number | null
  mapLongitude: number | null
  /** Zoom conseillé : place ≈ 14, ville ≈ 11 */
  mapPrecision: 'place' | 'city' | 'none'
}

export interface EventMapPoint {
  id: string
  slug: string
  title: string
  cityName: string
  latitude: number
  longitude: number
  displayStatus: DisplayEventStatus
  startAt: string | null
  category: EventCategoryId
}

export interface EventListQuery {
  q?: string
  category?: EventCategoryId
  statuses?: Array<'upcoming' | 'ongoing' | 'past' | 'cancelled' | 'postponed'>
  dateFrom?: string
  dateTo?: string
  city?: string
  page?: number
  pageSize?: number
  bbox?: [number, number, number, number]
}
