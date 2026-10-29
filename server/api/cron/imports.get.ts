import {
  chainImportContinue,
  parseImportCronMode,
  parseImportCronSources,
  runImportUntilBudget,
} from '../../utils/import-cron'
import { runAlertsCronStep } from '../../utils/alerts-cron'

/**
 * Point d’entrée Vercel Cron (GET /api/cron/imports) — 07:00 UTC.
 * Enchaîne l’import puis, une fois terminé, les digests d’alertes e-mail.
 * Auth : Authorization Bearer CRON_SECRET.
 */
export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const secret = String(config.cronSecret || process.env.CRON_SECRET || '')
  const auth = getHeader(event, 'authorization') || ''

  if (!secret || auth !== `Bearer ${secret}`) {
    throw createError({ statusCode: 401, statusMessage: 'Unauthorized' })
  }

  if (config.public.useMockDb) {
    return { skipped: true, reason: 'mock-db' }
  }

  // Import désactivé : on envoie quand même les alertes (nouveautés hors import du jour).
  if (config.importCronEnabled === false) {
    const alerts = await runAlertsCronStep()
    return { skipped: true, reason: 'import-disabled', alerts }
  }

  const query = getQuery(event)
  const runId = typeof query.runId === 'string' ? query.runId.trim() : undefined
  const sources = parseImportCronSources(config.importCronSources)
  const mode = parseImportCronMode(config.importCronMode)
  const budgetMs = Math.max(30_000, Number(config.importCronBudgetMs) || 240_000)

  const outcome = await runImportUntilBudget({
    runId: runId || undefined,
    sources,
    mode,
    actorId: 'cron:daily',
    budgetMs,
  })

  // Enchaîner si budget temps dépassé ; pas si annulé / bloqué / trop vieux
  const stopReasons = new Set(['cancelled', 'failed', 'missing', 'max-age', 'stalled', 'max-steps'])
  const shouldChain = !outcome.done
    && outcome.steps > 0
    && !stopReasons.has(outcome.reason || '')

  if (shouldChain) {
    chainImportContinue({
      runId: outcome.runId,
      siteUrl: String(config.public.siteUrl || ''),
      cronSecret: secret,
      hop: 0,
    })
    console.info('[cron:imports]', outcome)
    return { ...outcome, alerts: { deferred: true, reason: 'continue' } }
  }

  // Import terminé (succès ou arrêt) → digests alertes
  const alerts = await runAlertsCronStep()
  console.info('[cron:imports]', outcome)
  return { ...outcome, alerts }
})
