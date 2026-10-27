import {
  chainImportContinue,
  parseImportCronMode,
  parseImportCronSources,
  runImportUntilBudget,
} from '../../utils/import-cron'

/**
 * Suite d’un import quotidien si la première invocation a atteint le budget temps.
 * Auth : Authorization Bearer CRON_SECRET (même secret que le cron Vercel).
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

  const budgetMs = Math.max(30_000, Number(config.importCronBudgetMs) || 240_000)
  const outcome = await runImportUntilBudget({
    runId,
    sources: parseImportCronSources(config.importCronSources),
    mode: parseImportCronMode(config.importCronMode),
    actorId: 'cron:daily',
    budgetMs,
  })

  if (!outcome.done) {
    chainImportContinue({
      runId: outcome.runId,
      siteUrl: String(config.public.siteUrl || ''),
      cronSecret: secret,
    })
  }

  console.info('[cron:imports] continue', outcome)
  return outcome
})
