import {
  chainImportContinue,
  parseImportCronMode,
  parseImportCronSources,
  runImportUntilBudget,
} from '../../utils/import-cron'

/**
 * Point d’entrée Vercel Cron (GET /api/cron/imports).
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

  if (config.importCronEnabled === false) {
    return { skipped: true, reason: 'disabled' }
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
  if (!outcome.done && outcome.steps > 0 && !stopReasons.has(outcome.reason || '')) {
    chainImportContinue({
      runId: outcome.runId,
      siteUrl: String(config.public.siteUrl || ''),
      cronSecret: secret,
      hop: 0,
    })
  }

  console.info('[cron:imports]', outcome)
  return outcome
})
