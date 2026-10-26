import type { ParticipationKind } from '../utils/event-time'

export interface EngagementRecord {
  id: string
  eventId: string
  eventScopedTokenDigest: string
  supportsAt: string | null
  participatesAt: string | null
  participationKind: ParticipationKind | null
  updatedAt: string
}

export type EngagementAction =
  | 'support'
  | 'withdraw_support'
  | 'participate'
  | 'withdraw_participate'

export interface EngagementState {
  supported: boolean
  participating: boolean
  participationKind: ParticipationKind | null
}

export interface EventEngagementCounts {
  supports: number
  participations: number
}
