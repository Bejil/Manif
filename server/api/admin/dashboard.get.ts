import { requireAdmin } from '../../utils/admin-auth'
import { listAllEventsAdmin } from '../../services/events-repository'
import { listPendingSubmissions } from '../../services/submissions-repository'
import { countOpenReports } from '../../services/reports-repository'
import { getEventCounts } from '../../services/engagements-repository'
import { useMockDb } from '../../utils/supabase'
import { getMockStore } from '../../services/mock-store'

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const pending = await listPendingSubmissions()
  const allEvents = await listAllEventsAdmin()
  const published = allEvents.filter(e => e.publicationStatus === 'published')
  const openReports = await countOpenReports()
  const withoutCoords = published.filter(e => e.latitude == null || e.longitude == null)

  const anomalies: string[] = []
  for (const e of published.slice(0, 100)) {
    const counts = await getEventCounts(e.id)
    if (counts.supports < 0 || counts.participations < 0) {
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
    pendingSubmissions: pending.length,
    publishedEvents: published.length,
    openReports,
    eventsWithoutCoords: withoutCoords.length,
    countingAnomalies: anomalies,
  }
})
