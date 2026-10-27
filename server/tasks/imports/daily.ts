import {
  chainImportContinue,
  parseImportCronMode,
  parseImportCronSources,
  runImportUntilBudget,
} from '../../utils/import-cron'

/**
 * Import multi-sources quotidien (Vercel Cron via Nitro scheduledTasks).
 * Sécurisé par CRON_SECRET côté handler Vercel.
 */
export default defineTask({
  meta: {
    name: 'imports:daily',
    description: 'Import multi-sources quotidien (scrape → prepare → apply)',
  },
  async run({ context }) {
    const config = useRuntimeConfig()

    if (config.public.useMockDb) {
      console.info('[cron:imports] ignoré (USE_MOCK_DB)')
      return { result: { skipped: true, reason: 'mock-db' } }
    }

    if (config.importCronEnabled === false) {
      console.info('[cron:imports] désactivé (IMPORT_CRON_ENABLED=false)')
      return { result: { skipped: true, reason: 'disabled' } }
    }

    const sources = parseImportCronSources(config.importCronSources)
    const mode = parseImportCronMode(config.importCronMode)
    const budgetMs = Math.max(30_000, Number(config.importCronBudgetMs) || 240_000)

    const outcome = await runImportUntilBudget({
      sources,
      mode,
      actorId: 'cron:daily',
      budgetMs,
    })

    if (!outcome.done) {
      const secret = String(config.cronSecret || process.env.CRON_SECRET || '')
      chainImportContinue({
        runId: outcome.runId,
        siteUrl: String(config.public.siteUrl || ''),
        cronSecret: secret,
        waitUntil: context.waitUntil?.bind(context),
      })
    }

    console.info('[cron:imports] daily', outcome)
    return { result: outcome }
  },
})
