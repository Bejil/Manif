import {
  IMPORT_SOURCE_IDS,
  type ImportModeId,
  type ImportSourceId,
} from '#shared/constants/import-sources'
import { continueImportRun, startImportRun } from '../services/import-orchestrator'

const SOURCE_SET = new Set<string>(IMPORT_SOURCE_IDS)

export function parseImportCronSources(raw: string | undefined): ImportSourceId[] {
  const parts = (raw || '')
    .split(',')
    .map(s => s.trim())
    .filter(Boolean)
  const picked = parts.filter((id): id is ImportSourceId => SOURCE_SET.has(id))
  return picked.length ? picked : [...IMPORT_SOURCE_IDS]
}

export function parseImportCronMode(raw: string | undefined): ImportModeId {
  return raw === 'draft' ? 'draft' : 'published'
}

/** Boucle continue jusqu’à fin ou budget temps (limite Vercel). */
export async function runImportUntilBudget(opts: {
  runId?: string
  sources: ImportSourceId[]
  mode: ImportModeId
  actorId: string
  budgetMs: number
  maxSteps?: number
}): Promise<{
  runId: string
  done: boolean
  steps: number
  lastStep: string
}> {
  let runId = opts.runId
  if (!runId) {
    const run = await startImportRun({
      sources: opts.sources,
      mode: opts.mode,
      militantOnly: true,
      geocode: true,
      actorId: opts.actorId,
    })
    runId = run.id
  }

  const started = Date.now()
  const maxSteps = opts.maxSteps ?? 2000
  let steps = 0
  let done = false
  let lastStep = 'start'

  while (Date.now() - started < opts.budgetMs && steps < maxSteps) {
    const step = await continueImportRun(runId)
    steps++
    lastStep = step.step
    done = step.done
    if (done) break
  }

  return { runId, done, steps, lastStep }
}

/** Relance HTTP sécurisée si le budget est dépassé. */
export function chainImportContinue(opts: {
  runId: string
  siteUrl: string
  cronSecret: string
  waitUntil?: (promise: Promise<unknown>) => void
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  if (!base || !opts.cronSecret) return

  const url = `${base}/api/cron/imports-continue?runId=${encodeURIComponent(opts.runId)}`
  const promise = $fetch(url, {
    headers: { Authorization: `Bearer ${opts.cronSecret}` },
  }).catch((err: unknown) => {
    console.error('[cron:imports] enchaînement échoué', err)
  })

  if (opts.waitUntil) opts.waitUntil(promise)
  else void promise
}
