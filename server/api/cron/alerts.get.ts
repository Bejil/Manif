import { runAlertsCronStep } from '../../utils/alerts-cron'

/**
 * Déclenchement manuel des digests d’alertes.
 * En prod, les alertes partent aussi automatiquement à la fin du cron d’import.
 * Auth : Authorization Bearer CRON_SECRET.
 */
export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const secret = String(config.cronSecret || process.env.CRON_SECRET || '')
  const auth = getHeader(event, 'authorization') || ''

  if (!secret || auth !== `Bearer ${secret}`) {
    throw createError({ statusCode: 401, statusMessage: 'Unauthorized' })
  }

  return runAlertsCronStep()
})
