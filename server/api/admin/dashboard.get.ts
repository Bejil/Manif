import { requireAdmin } from '../../utils/admin-auth'
import { listAllEventsAdmin } from '../../services/events-repository'
import { listAllSubmissionsAdmin } from '../../services/submissions-repository'
import { countOpenReports } from '../../services/reports-repository'
import { listAlertsAdmin } from '../../services/alerts-repository'
import { useMockDb } from '../../utils/supabase'
import { getMockStore } from '../../services/mock-store'

export default defineEventHandler(async (event) => {
  requireAdmin(event)

  const [submissions, allEvents, openReports, alerts] = await Promise.all([
    listAllSubmissionsAdmin(),
    listAllEventsAdmin(),
    countOpenReports(),
    listAlertsAdmin({ status: 'all' }),
  ])

  const submissionsByStatus = {
    pending_moderation: 0,
    changes_requested: 0,
    awaiting_verification: 0,
    approved: 0,
    rejected: 0,
  }
  for (const s of submissions) {
    if (s.moderationStatus in submissionsByStatus) {
      submissionsByStatus[s.moderationStatus as keyof typeof submissionsByStatus] += 1
    }
  }

  const published = allEvents.filter(e => e.publicationStatus === 'published')
  const unpublished = allEvents.filter(e => e.publicationStatus === 'unpublished')
  const draft = allEvents.filter(e => e.publicationStatus === 'draft')
  const dateToConfirm = published.filter(e => !e.startAt)

  const eventsByStatus = {
    upcoming: 0,
    ongoing: 0,
    past: 0,
    cancelled: 0,
    postponed: 0,
  }
  let supports = 0
  let participations = 0
  for (const e of published) {
    if (e.displayStatus in eventsByStatus) {
      eventsByStatus[e.displayStatus as keyof typeof eventsByStatus] += 1
    }
    supports += e.counts.supports
    participations += e.counts.participations
  }

  const anomalies: string[] = []
  for (const e of published) {
    if (e.counts.supports < 0 || e.counts.participations < 0) {
      anomalies.push(`Compteurs négatifs sur ${e.slug}`)
    }
  }
  if (useMockDb()) {
    const orphans = getMockStore().engagements.filter(
      p => !getMockStore().events.some(e => e.id === p.eventId),
    )
    if (orphans.length) anomalies.push(`${orphans.length} engagement(s) orphelin(s)`)
  }

  return {
    pendingSubmissions: submissionsByStatus.pending_moderation,
    publishedEvents: published.length,
    openReports,
    activeAlerts: alerts.counts.active,
    pendingAlerts: alerts.counts.pending,
    countingAnomalies: anomalies,
    submissions: {
      total: submissions.length,
      ...submissionsByStatus,
    },
    events: {
      total: allEvents.length,
      published: published.length,
      unpublished: unpublished.length,
      draft: draft.length,
      dateToConfirm: dateToConfirm.length,
      byStatus: eventsByStatus,
      supports,
      participations,
    },
  }
})

