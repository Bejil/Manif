import {
  listActiveAlerts,
  markAlertNotified,
  rotateUnsubscribeToken,
} from './alerts-repository'
import { listPublishedEventsSince, matchEventsForAlert } from './alerts-matcher'
import { buildAlertDigestEmail, sendEmail } from './email'
import { nowIso } from './mock-store'

/**
 * Envoie les digests pour tous les abonnés actifs.
 * Fenêtre : événements publiés après le plus ancien last_notified_at (ou 7 j).
 */
export async function dispatchAlertDigests(opts: {
  siteUrl: string
  pepper: string
}): Promise<{
  subscribers: number
  sent: number
  skipped: number
  errors: number
}> {
  const alerts = await listActiveAlerts()
  if (!alerts.length) {
    return { subscribers: 0, sent: 0, skipped: 0, errors: 0 }
  }

  const oldest = alerts.reduce((min, a) => {
    const t = a.lastNotifiedAt || a.confirmedAt || a.createdAt
    return t < min ? t : min
  }, alerts[0]!.lastNotifiedAt || alerts[0]!.confirmedAt || alerts[0]!.createdAt)

  // Garde-fou : pas plus de 7 jours en arrière
  const weekAgo = new Date(Date.now() - 7 * 24 * 60 * 60_000).toISOString()
  const since = oldest < weekAgo ? weekAgo : oldest

  const candidates = await listPublishedEventsSince(since)
  const notifiedAt = nowIso()
  let sent = 0
  let skipped = 0
  let errors = 0

  for (const alert of alerts) {
    const matches = matchEventsForAlert(alert, candidates)
    if (!matches.length) {
      skipped++
      continue
    }
    try {
      const unsubToken = await rotateUnsubscribeToken(alert.id, opts.pepper)
      const email = buildAlertDigestEmail({
        siteUrl: opts.siteUrl,
        locationLabel: alert.locationLabel,
        radiusKm: alert.radiusKm,
        unsubscribeToken: unsubToken,
        events: matches,
      })
      await sendEmail({
        to: alert.email,
        subject: email.subject,
        html: email.html,
        text: email.text,
      })
      await markAlertNotified(alert.id, notifiedAt)
      sent++
    }
    catch (e) {
      errors++
      console.error('[alerts] envoi échoué', alert.id, e)
    }
  }

  return { subscribers: alerts.length, sent, skipped, errors }
}
