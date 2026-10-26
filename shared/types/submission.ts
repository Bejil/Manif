import type { EventCategoryId } from '../constants/categories'

export type SubmissionVerificationStatus = 'pending' | 'verified' | 'expired'
export type SubmissionModerationStatus =
  | 'awaiting_verification'
  | 'pending_moderation'
  | 'changes_requested'
  | 'approved'
  | 'rejected'

export interface EventSubmissionRecord {
  id: string
  title: string
  description: string
  category: EventCategoryId
  cityName: string
  locationName: string
  /** null = lieu publié immédiatement à l’approbation */
  locationRevealHoursBefore: number | null
  /** null = date à confirmer */
  startAt: string | null
  endAt: string | null
  organizerName: string | null
  sourceUrl: string | null
  practicalInfo: string | null
  proposerEmail: string
  verificationStatus: SubmissionVerificationStatus
  verificationTokenDigest: string | null
  verificationExpiresAt: string | null
  /** Jeton e-mail pour éditer après « modifications demandées » */
  editTokenDigest: string | null
  editTokenExpiresAt: string | null
  moderationStatus: SubmissionModerationStatus
  rejectionReason: string | null
  publishedEventId: string | null
  createdAt: string
  updatedAt: string
}
