import {
  chainImportContinue,
  IMPORT_CRON_MAX_HOPS,
  parseImportCronMode,
  parseImportCronSources,
  runImportUntilBudget,
} from '../../utils/import-cron'
import { runAlertsCronStep } from '../../utils/alerts-cron'
import { cancelImportRun } from '../../services/import-orchestrator'
import { getImportRun } from '../../services/import-repository'

/**
 * Suite d’un import quotidien si la première invocation a atteint le budget temps.
 * À la fin du pipeline, lance les digests d’alertes.
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

  const query = getQuery(event)
  const runId = typeof query.runId === 'string' ? query.runId.trim() : ''
  if (!runId) {
    throw createError({ statusCode: 400, statusMessage: 'runId requis' })
  }

  const hop = Math.max(0, Number(query.hop) || 0)
  if (hop >= IMPORT_CRON_MAX_HOPS) {
    await cancelImportRun(runId)
    const alerts = await runAlertsCronStep()
    return { runId, done: true, reason: 'max-hops', hop, alerts }
  }

  const live = await getImportRun(runId)
  if (!live) {
    const alerts = await runAlertsCronStep()
    return { runId, done: true, reason: 'missing', alerts }
  }
  if (live.status === 'cancelled' || live.status === 'failed' || live.status === 'completed') {
    const alerts = await runAlertsCronStep()
    return { runId, done: true, reason: live.status, hop, alerts }
  }

  const budgetMs = Math.max(30_000, Number(config.importCronBudgetMs) || 240_000)
  const outcome = await runImportUntilBudget({
    runId,
    sources: parseImportCronSources(config.importCronSources),
    mode: parseImportCronMode(config.importCronMode),
    actorId: 'cron:daily',
    budgetMs,
  })

  const stopReasons = new Set(['cancelled', 'failed', 'missing', 'max-age', 'stalled', 'max-steps'])
  const shouldChain = !outcome.done
    && outcome.steps > 0
    && !stopReasons.has(outcome.reason || '')

  if (shouldChain) {
    chainImportContinue({
      runId: outcome.runId,
      siteUrl: String(config.public.siteUrl || ''),
      cronSecret: secret,
      hop,
    })
    console.info('[cron:imports] continue', { ...outcome, hop })
    return { ...outcome, hop, alerts: { deferred: true, reason: 'continue' } }
  }

  const alerts = await runAlertsCronStep()
  console.info('[cron:imports] continue', { ...outcome, hop })
  return { ...outcome, hop, alerts }
})
