import {
  IMPORT_SOURCE_IDS,
  type ImportModeId,
  type ImportSourceId,
} from '#shared/constants/import-sources'
import { cancelImportRun, continueImportRun, startImportRun } from '../services/import-orchestrator'
import { getImportRun } from '../services/import-repository'

const SOURCE_SET = new Set<string>(IMPORT_SOURCE_IDS)

/** Nombre max d’enchaînements HTTP après le cron initial. */
export const IMPORT_CRON_MAX_HOPS = 12
/** Durée max d’un run cron avant annulation automatique. */
export const IMPORT_CRON_MAX_AGE_MS = 45 * 60 * 1000

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

function runAgeMs(run: { startedAt: string | null, createdAt: string }): number {
  const iso = run.startedAt || run.createdAt
  const t = new Date(iso).getTime()
  if (Number.isNaN(t)) return 0
  return Date.now() - t
}

/** Boucle continue jusqu’à fin, annulation, timeout run, ou budget temps (limite Vercel). */
export async function runImportUntilBudget(opts: {
  runId?: string
  sources: ImportSourceId[]
  mode: ImportModeId
  actorId: string
  budgetMs: number
  maxSteps?: number
  maxAgeMs?: number
}): Promise<{
  runId: string
  done: boolean
  steps: number
  lastStep: string
  reason?: string
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
  const maxAgeMs = opts.maxAgeMs ?? IMPORT_CRON_MAX_AGE_MS
  let steps = 0
  let done = false
  let lastStep = 'start'
  let reason: string | undefined
  let stallCount = 0
  let prevStep = ''

  while (Date.now() - started < opts.budgetMs && steps < maxSteps) {
    const live = await getImportRun(runId)
    if (!live) {
      done = true
      reason = 'missing'
      break
    }
    if (live.status === 'cancelled' || live.status === 'failed') {
      done = true
      lastStep = live.status
      reason = live.status
      break
    }
    if (runAgeMs(live) > maxAgeMs) {
      await cancelImportRun(runId)
      done = true
      lastStep = 'cancelled'
      reason = 'max-age'
      break
    }

    const step = await continueImportRun(runId)
    steps++
    lastStep = step.step
    done = step.done

    // Boucle sans progrès (ex. apply-retry à l’infini)
    if (!done && step.step === prevStep && (step.step === 'apply-retry' || step.step === 'apply')) {
      stallCount++
      if (stallCount >= 5) {
        await cancelImportRun(runId)
        done = true
        lastStep = 'cancelled'
        reason = 'stalled'
        break
      }
    }
    else {
      stallCount = 0
    }
    prevStep = step.step

    if (done) break
  }

  if (!done && steps >= maxSteps) reason = 'max-steps'
  if (!done && Date.now() - started >= opts.budgetMs) reason = reason || 'budget'

  return { runId, done, steps, lastStep, reason }
}

/** Relance HTTP sécurisée si le budget est dépassé (profondeur limitée). */
export function chainImportContinue(opts: {
  runId: string
  siteUrl: string
  cronSecret: string
  hop: number
  waitUntil?: (promise: Promise<unknown>) => void
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  if (!base || !opts.cronSecret) return
  if (opts.hop >= IMPORT_CRON_MAX_HOPS) {
    console.warn('[cron:imports] enchaînement stoppé (max hops)', {
      runId: opts.runId,
      hop: opts.hop,
    })
    void cancelImportRun(opts.runId).catch(() => {})
    return
  }

  const url = `${base}/api/cron/imports-continue?runId=${encodeURIComponent(opts.runId)}&hop=${opts.hop + 1}`
  const promise = $fetch(url, {
    headers: { Authorization: `Bearer ${opts.cronSecret}` },
  }).catch((err: unknown) => {
    console.error('[cron:imports] enchaînement échoué', err)
  })

  if (opts.waitUntil) opts.waitUntil(promise)
  else void promise
}
