import { dispatchAlertDigests } from '../services/alerts-dispatch'

/**
 * Digests d’alertes après la fin du cron d’import (ou si l’import est coupé).
 */
export async function runAlertsCronStep(): Promise<{
  skipped?: boolean
  reason?: string
  subscribers?: number
  sent?: number
  skipped_empty?: number
  errors?: number
}> {
  const config = useRuntimeConfig()

  if (config.public.useMockDb) {
    return { skipped: true, reason: 'mock-db' }
  }
  if (config.alertsCronEnabled === false) {
    return { skipped: true, reason: 'disabled' }
  }

  const pepper = String(config.participationTokenPepper || '')
  if (!pepper) {
    return { skipped: true, reason: 'missing-pepper' }
  }

  const outcome = await dispatchAlertDigests({
    siteUrl: String(config.public.siteUrl || ''),
    pepper,
  })

  console.info('[cron:alerts]', outcome)
  return {
    subscribers: outcome.subscribers,
    sent: outcome.sent,
    skipped_empty: outcome.skipped,
    errors: outcome.errors,
  }
}
