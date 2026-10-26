/**
 * @deprecated Réexporte le dépôt engagements.
 * Préférer `engagements-repository`.
 */
export {
  getEventCounts,
  upsertEngagement as upsertParticipation,
  eraseEngagementByToken as eraseParticipationByToken,
  invalidateParticipationsForEvent,
} from './engagements-repository'
