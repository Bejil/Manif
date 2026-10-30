<script setup lang="ts">
import {
  IMPORT_SOURCES,
  IMPORT_MODES,
  importSourceShortLabel,
} from '#shared/constants/import-sources'
import type { ImportModeId, ImportSourceId } from '#shared/constants/import-sources'
import type { ImportCandidateRecord, ImportRunRecord } from '#shared/types/import'
import type { PublicationStatus } from '#shared/constants/statuses'
definePageMeta({ layout: 'admin' })
useSeoMeta({ title: 'Imports multi-sources — Admin', robots: 'noindex' })

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me } = await useFetch('/api/admin/me', {
  headers: cookieHeaders,
  credentials: 'include',
})
if (!me.value?.authenticated) {
  await navigateTo('/admin')
}

type CandidateRow = ImportCandidateRecord & {
  publicationStatus?: PublicationStatus | null
}

const selectedSources = ref<ImportSourceId[]>(IMPORT_SOURCES.map(s => s.id))
const mode = ref<ImportModeId>('draft')
const busy = ref(false)
const publishingId = ref<string | null>(null)
const errorMsg = ref<string | null>(null)
const successMsg = ref<string | null>(null)
const activeRunId = ref<string | null>(null)
/** Affichage immédiat au lancement (avant la réponse API) — évite de garder l’ancien « terminé ». */
const optimisticRun = ref<ImportRunRecord | null>(null)

const { data: runsData, refresh: refreshRuns } = await useFetch<{ items: ImportRunRecord[] }>(
  '/api/admin/imports',
  { headers: cookieHeaders, credentials: 'include' },
)

const activeRun = computed(() =>
  optimisticRun.value
  || runsData.value?.items?.find(r => r.id === activeRunId.value)
  || runsData.value?.items?.[0]
  || null,
)

function emptyImportStats() {
  return {
    scraped: 0,
    pending: 0,
    ready: 0,
    duplicates: 0,
    created: 0,
    updated: 0,
    skipped: 0,
    errors: 0,
    bySource: {},
  }
}

function makeStartingRun(): ImportRunRecord {
  const now = new Date().toISOString()
  return {
    id: '__starting__',
    status: 'pending',
    mode: mode.value,
    sources: [...selectedSources.value],
    options: { militantOnly: true, geocode: true },
    progress: {
      cursor: 0,
      totalUnits: 0,
      unitsDone: [],
      message: 'Démarrage de l’import…',
      phase: 'scrape',
      percent: 0,
    },
    stats: emptyImportStats(),
    errorMessage: null,
    actorId: null,
    startedAt: now,
    finishedAt: null,
    createdAt: now,
    updatedAt: now,
  }
}

const candidatesPage = ref(1)

/** Liste = nouveaux candidats encore en brouillon / dépubliés. */
const candidatesQuery = computed(() => ({
  page: candidatesPage.value,
  pageSize: 30,
}))

const RUN_FINISHED = new Set(['completed', 'cancelled', 'failed'])
const RUN_LIVE = new Set(['pending', 'running', 'scraped', 'applying'])

/** Prêts/doublons encore non écrits (stats cumulatives côté préparation). */
const needsWrite = computed(() => {
  const s = activeRun.value?.stats
  if (!s) return false
  const prepared = (s.ready || 0) + (s.duplicates || 0)
  const written = (s.created || 0) + (s.updated || 0) + (s.skipped || 0) + (s.errors || 0)
  return prepared > written
})

/** Candidats encore en attente de préparation. */
const needsPrepare = computed(() => (activeRun.value?.stats?.pending || 0) > 0)

/** Vrai seulement pendant scrape / préparation / écriture — pas un « completed » désynchronisé. */
const runInProgress = computed(() => {
  const s = activeRun.value?.status
  return Boolean(s && RUN_LIVE.has(s))
})

/** Terminé côté statut, mais pipeline incomplet (pending ou écriture). */
const writeIncomplete = computed(() =>
  activeRun.value?.status === 'completed' && (needsWrite.value || needsPrepare.value),
)

const showCandidates = computed(() =>
  !!activeRun.value && activeRun.value.status === 'completed',
)

const { data: detailData, refresh: refreshDetail, pending: detailPending } = await useFetch<{
  run: ImportRunRecord
  candidates: { items: CandidateRow[], total: number }
}>(() => (
  showCandidates.value && activeRun.value
    ? `/api/admin/imports/${activeRun.value.id}`
    : null
), {
  headers: cookieHeaders,
  credentials: 'include',
  query: candidatesQuery,
  watch: [() => activeRun.value?.id, () => activeRun.value?.status, candidatesQuery],
})

const selectedCandidateIds = ref<string[]>([])
const bulkBusy = ref(false)
/** Ancre pour Shift+clic (sélection d’intervalle). */
const lastSelectAnchorId = ref<string | null>(null)

function clearCandidateSelection() {
  selectedCandidateIds.value = []
  lastSelectAnchorId.value = null
}

watch(activeRunId, () => {
  candidatesPage.value = 1
  clearCandidateSelection()
})

watch(candidatesPage, () => {
  clearCandidateSelection()
})

/** Recharge la page courante (ou la dernière valide) après pub / suppression. */
async function reloadCandidatesList(removedCount = 0) {
  clearCandidateSelection()
  const pageSize = 30
  const prevTotal = detailData.value?.candidates?.total ?? 0
  const nextTotal = Math.max(0, prevTotal - Math.max(0, removedCount))
  const maxPage = Math.max(1, Math.ceil(nextTotal / pageSize) || 1)
  if (candidatesPage.value > maxPage) {
    candidatesPage.value = maxPage
  }
  await refreshDetail()
  const after = detailData.value?.candidates
  if (after && after.items.length === 0 && after.total > 0) {
    const last = Math.max(1, Math.ceil(after.total / pageSize))
    if (candidatesPage.value !== last) {
      candidatesPage.value = last
      await refreshDetail()
    }
  }
}

function toggleSource(id: ImportSourceId) {
  if (selectedSources.value.includes(id)) {
    selectedSources.value = selectedSources.value.filter(s => s !== id)
  }
  else {
    selectedSources.value = [...selectedSources.value, id]
  }
}

function sourceLinkLabel(source: string) {
  return `Source ${importSourceShortLabel(source)}`
}

function excerpt(text: string, max = 160) {
  const clean = text.replace(/\s+/g, ' ').trim()
  if (clean.length <= max) return clean
  return `${clean.slice(0, max).trim()}…`
}

/** Coupe la boucle continue locale (reprise / lancement) dès qu’on annule. */
const abortContinue = ref(false)

async function loopContinue(runId: string) {
  let guard = 0
  while (guard++ < 2000) {
    if (abortContinue.value) break
    const step = await $fetch<{ run: ImportRunRecord, done: boolean, step: string }>(
      `/api/admin/imports/${runId}/continue`,
      { method: 'POST', credentials: 'include' },
    )
    if (abortContinue.value) break
    activeRunId.value = step.run.id
    await refreshRuns()
    if (step.done) {
      await refreshDetail()
      break
    }
    await new Promise(r => setTimeout(r, 80))
  }
}

async function resumeRun() {
  if (!activeRun.value) return
  abortContinue.value = false
  busy.value = true
  errorMsg.value = null
  try {
    await loopContinue(activeRun.value.id)
    await refreshDetail()
  }
  catch {
    if (!abortContinue.value) errorMsg.value = 'Impossible de reprendre l’import'
  }
  finally {
    busy.value = false
  }
}

async function startImport() {
  errorMsg.value = null
  successMsg.value = null
  if (!selectedSources.value.length) {
    errorMsg.value = 'Sélectionnez au moins une source.'
    return
  }
  abortContinue.value = false
  // Reset immédiat du panneau (titre, %, barre, timer, message)
  const starting = makeStartingRun()
  optimisticRun.value = starting
  activeRunId.value = starting.id
  candidatesPage.value = 1
  busy.value = true
  try {
    const step = await $fetch<{ run: ImportRunRecord, done: boolean }>(
      '/api/admin/imports/run',
      {
        method: 'POST',
        credentials: 'include',
        body: {
          sources: selectedSources.value,
          mode: mode.value,
          militantOnly: true,
          geocode: true,
        },
      },
    )
    optimisticRun.value = null
    activeRunId.value = step.run.id
    autoResumeTriedFor = step.run.id
    await refreshRuns()
    if (!step.done && !abortContinue.value) await loopContinue(step.run.id)
    await refreshDetail()
  }
  catch (e: unknown) {
    optimisticRun.value = null
    if (!abortContinue.value) {
      errorMsg.value = e && typeof e === 'object' && 'data' in e
        ? String((e as { data?: { statusMessage?: string } }).data?.statusMessage || 'Échec du lancement')
        : 'Échec du lancement'
    }
  }
  finally {
    optimisticRun.value = null
    busy.value = false
  }
}

function candidateAdminPath(c: CandidateRow): string | null {
  const id = c.appliedEventId || c.matchEventId
  return id ? `/admin/evenements/${id}` : null
}

function candidateUnavailableHint(c: CandidateRow): string | null {
  if (candidateAdminPath(c)) return null
  if (c.errorMessage) return c.errorMessage
  if (c.status === 'error') return 'Échec d’écriture — pas de fiche créée'
  if (c.status === 'skipped') return 'Candidat ignoré'
  if (c.status === 'pending' || c.status === 'ready') {
    return 'Pas encore écrit en base (import incomplet ou non terminé)'
  }
  return 'Aucune fiche associée'
}

function candidateHasEvent(c: CandidateRow): boolean {
  return Boolean(c.appliedEventId || c.matchEventId)
}

function canPublishCandidate(c: CandidateRow): boolean {
  if (!candidateHasEvent(c)) return false
  return c.publicationStatus !== 'published'
}

function canDeleteCandidate(c: CandidateRow): boolean {
  return candidateHasEvent(c)
}

const selectableCandidates = computed(() =>
  (detailData.value?.candidates?.items || []).filter(candidateHasEvent),
)

const selectedCandidates = computed(() =>
  selectableCandidates.value.filter(c => selectedCandidateIds.value.includes(c.id)),
)

const allSelectableSelected = computed(() =>
  selectableCandidates.value.length > 0
  && selectableCandidates.value.every(c => selectedCandidateIds.value.includes(c.id)),
)

const selectedCount = computed(() => selectedCandidateIds.value.length)

const canBulkPublish = computed(() =>
  selectedCandidates.value.some(canPublishCandidate),
)

const canBulkDelete = computed(() =>
  selectedCandidates.value.some(canDeleteCandidate),
)

function toggleSelectAll(checked: boolean) {
  if (checked) {
    selectedCandidateIds.value = selectableCandidates.value.map(c => c.id)
    lastSelectAnchorId.value = selectableCandidates.value.at(-1)?.id ?? null
  }
  else {
    clearCandidateSelection()
  }
}

/** Évite que le clic natif décoche la dernière case après un Shift+sélection. */
let suppressCheckClick = false

/**
 * Shift+mousedown : pose l’intervalle (inclusif).
 * Clic normal : v-model gère le cochage ; l’ancre est mémorisée au change.
 */
function onCandidateCheckMouseDown(c: CandidateRow, event: MouseEvent) {
  if (!event.shiftKey || !lastSelectAnchorId.value) return
  if (bulkBusy.value || busy.value) return

  event.preventDefault()
  suppressCheckClick = true

  const selectable = selectableCandidates.value
  const idx = selectable.findIndex(x => x.id === c.id)
  const anchorIdx = selectable.findIndex(x => x.id === lastSelectAnchorId.value)
  if (idx < 0 || anchorIdx < 0) return

  const from = Math.min(anchorIdx, idx)
  const to = Math.max(anchorIdx, idx)
  const rangeIds = selectable.slice(from, to + 1).map(x => x.id)
  selectedCandidateIds.value = [...new Set([...selectedCandidateIds.value, ...rangeIds])]
}

function onCandidateCheckClick(_c: CandidateRow, event: MouseEvent) {
  if (!suppressCheckClick && !event.shiftKey) return
  event.preventDefault()
  suppressCheckClick = false
}

function onCandidateCheckChange(c: CandidateRow) {
  if (bulkBusy.value || busy.value) return
  if (suppressCheckClick) return
  lastSelectAnchorId.value = c.id
}

function formatRunDate(iso: string | null | undefined): string {
  if (!iso) return ''
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return ''
  return d.toLocaleString('fr-FR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}

const cancelling = ref(false)

async function cancelRun() {
  if (!activeRun.value || cancelling.value) return
  const id = activeRun.value.id
  abortContinue.value = true
  autoResumeTriedFor = id
  cancelling.value = true
  errorMsg.value = null
  try {
    await $fetch(`/api/admin/imports/${id}/cancel`, {
      method: 'POST',
      credentials: 'include',
    })
    await refreshRuns()
    await refreshDetail()
    successMsg.value = 'Import annulé. Les chaînes cron s’arrêteront au prochain tick.'
  }
  catch {
    errorMsg.value = 'Impossible d’annuler l’import'
  }
  finally {
    cancelling.value = false
    busy.value = false
  }
}

const canCancelRun = computed(() => {
  const s = activeRun.value?.status
  return Boolean(s && RUN_LIVE.has(s))
})

async function publishApplied() {
  if (!activeRun.value) return
  busy.value = true
  errorMsg.value = null
  successMsg.value = null
  try {
    const res = await $fetch<{ published: number, alreadyPublished: number, missing: number }>(
      `/api/admin/imports/${activeRun.value.id}/publish`,
      { method: 'POST', credentials: 'include' },
    )
    await reloadCandidatesList(res.published)
    successMsg.value = `${res.published} publié(s), ${res.alreadyPublished} déjà public(s), ${res.missing} introuvable(s).`
  }
  catch {
    errorMsg.value = 'Échec de la publication des brouillons'
  }
  finally {
    busy.value = false
  }
}

async function publishCandidate(c: CandidateRow) {
  const eventId = c.appliedEventId || c.matchEventId
  if (!eventId) return
  publishingId.value = c.id
  errorMsg.value = null
  try {
    await $fetch(`/api/admin/events/${eventId}/publish`, { method: 'POST', credentials: 'include' })
    await reloadCandidatesList(1)
    successMsg.value = 'Candidat publié.'
  }
  catch {
    errorMsg.value = 'Publication impossible'
  }
  finally {
    publishingId.value = null
  }
}

async function deleteCandidate(c: CandidateRow) {
  const eventId = c.appliedEventId || c.matchEventId
  if (!eventId) return
  publishingId.value = c.id
  errorMsg.value = null
  try {
    await $fetch(`/api/admin/events/${eventId}`, { method: 'DELETE', credentials: 'include' })
    await reloadCandidatesList(1)
    successMsg.value = 'Événement supprimé.'
  }
  catch {
    errorMsg.value = 'Suppression impossible'
  }
  finally {
    publishingId.value = null
  }
}

async function bulkPublishSelected() {
  const targets = selectedCandidates.value.filter(canPublishCandidate)
  if (!targets.length) return
  bulkBusy.value = true
  errorMsg.value = null
  successMsg.value = null
  let ok = 0
  let fail = 0
  try {
    for (const c of targets) {
      const eventId = c.appliedEventId || c.matchEventId
      if (!eventId) continue
      try {
        await $fetch(`/api/admin/events/${eventId}/publish`, { method: 'POST', credentials: 'include' })
        ok++
      }
      catch {
        fail++
      }
    }
    await reloadCandidatesList(ok)
    successMsg.value = fail
      ? `${ok} publié(s), ${fail} échec(s).`
      : `${ok} publié(s).`
  }
  finally {
    bulkBusy.value = false
  }
}

async function bulkDeleteSelected() {
  const targets = selectedCandidates.value.filter(canDeleteCandidate)
  if (!targets.length) return
  bulkBusy.value = true
  errorMsg.value = null
  successMsg.value = null
  let ok = 0
  let fail = 0
  try {
    for (const c of targets) {
      const eventId = c.appliedEventId || c.matchEventId
      if (!eventId) continue
      try {
        await $fetch(`/api/admin/events/${eventId}`, { method: 'DELETE', credentials: 'include' })
        ok++
      }
      catch {
        fail++
      }
    }
    await reloadCandidatesList(ok)
    successMsg.value = fail
      ? `${ok} supprimé(s), ${fail} échec(s).`
      : `${ok} supprimé(s).`
  }
  finally {
    bulkBusy.value = false
  }
}

const nowTick = ref(Date.now())
let elapsedTimer: ReturnType<typeof setInterval> | null = null

function clearElapsedTimer() {
  if (elapsedTimer) {
    clearInterval(elapsedTimer)
    elapsedTimer = null
  }
}

watch(
  () => busy.value || runInProgress.value,
  (live) => {
    clearElapsedTimer()
    if (!live || !import.meta.client) return
    nowTick.value = Date.now()
    elapsedTimer = setInterval(() => {
      nowTick.value = Date.now()
    }, 250)
  },
  { immediate: true },
)

onBeforeUnmount(() => {
  clearElapsedTimer()
})

const progressPct = computed(() => {
  const run = activeRun.value
  if (!run) return 0
  // Pendant le démarrage optimiste / un run live, ne jamais coller à 100 %
  if (run.id === '__starting__' || busy.value && RUN_LIVE.has(run.status)) {
    if (typeof run.progress?.percent === 'number') {
      return Math.min(99, Math.max(0, Math.round(run.progress.percent)))
    }
    return 0
  }
  if (run.status === 'completed') return 100
  if (typeof run.progress?.percent === 'number') {
    return Math.min(100, Math.max(0, Math.round(run.progress.percent)))
  }
  // Repli si ancien run sans percent serveur
  const p = run.progress
  const stats = run.stats
  const units = p?.totalUnits || 1
  const cursor = Math.min(p?.cursor || 0, units)
  if (run.status === 'pending' || run.status === 'running') {
    return Math.round(55 * cursor / units)
  }
  if (run.status === 'scraped') {
    const scraped = stats?.scraped || 0
    const done = Math.min((stats?.ready || 0) + (stats?.duplicates || 0), scraped || 1)
    return scraped ? 55 + Math.round(25 * done / scraped) : 55
  }
  if (run.status === 'applying') {
    const toApply = Math.max((stats?.ready || 0) + (stats?.duplicates || 0), 1)
    const applied = (stats?.created || 0) + (stats?.updated || 0) + (stats?.skipped || 0)
    return 80 + Math.min(19, Math.round(19 * applied / toApply))
  }
  return 0
})

function formatElapsed(ms: number): string {
  const totalSec = Math.max(0, Math.floor(ms / 1000))
  const h = Math.floor(totalSec / 3600)
  const m = Math.floor((totalSec % 3600) / 60)
  const s = totalSec % 60
  if (h > 0) {
    return `${h}:${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`
  }
  return `${m}:${String(s).padStart(2, '0')}`
}

const runElapsedLabel = computed(() => {
  const run = activeRun.value
  if (!run) return ''
  const startIso = run.startedAt || run.createdAt
  if (!startIso) return ''
  const start = new Date(startIso).getTime()
  if (Number.isNaN(start)) return ''
  const end = run.finishedAt && RUN_FINISHED.has(run.status)
    ? new Date(run.finishedAt).getTime()
    : (busy.value || runInProgress.value ? nowTick.value : new Date(run.updatedAt || run.finishedAt || startIso).getTime())
  if (Number.isNaN(end)) return ''
  return formatElapsed(end - start)
})

const candidateTotalPages = computed(() => {
  const total = detailData.value?.candidates?.total ?? 0
  return Math.max(1, Math.ceil(total / 30))
})

const showResume = computed(() => {
  const run = activeRun.value
  if (!run || run.status === 'cancelled' || run.status === 'failed') return false
  if (RUN_LIVE.has(run.status)) return true
  if (writeIncomplete.value) return true
  // Ancien bug : « scrapés » comptés sans suivi pending → reprise pour resync DB
  if (run.status === 'completed') {
    const s = run.stats || {}
    const accounted = (s.ready || 0)
      + (s.duplicates || 0)
      + (s.created || 0)
      + (s.updated || 0)
      + (s.skipped || 0)
      + (s.errors || 0)
      + (s.pending || 0)
    if ((s.scraped || 0) > accounted) return true
  }
  return false
})

const lastRunHeading = computed(() => {
  const run = activeRun.value
  if (!run) return 'Dernier import'
  if (busy.value || runInProgress.value) return 'Import en cours'
  if (writeIncomplete.value) return 'Import à finaliser'
  if (run.status === 'cancelled') return 'Import annulé'
  if (run.status === 'failed') return 'Import en échec'
  const when = formatRunDate(run.finishedAt || run.updatedAt || run.createdAt)
  return when ? `Dernier import · ${when}` : 'Dernier import'
})

/** Reprend automatiquement un import interrompu / stats désynchronisées. */
let autoResumeTriedFor: string | null = null
watch(
  [showResume, () => activeRun.value?.id, busy],
  ([resume, id, isBusy]) => {
    if (!import.meta.client || !resume || !id || isBusy) return
    if (autoResumeTriedFor === id) return
    autoResumeTriedFor = id
    void resumeRun()
  },
  { immediate: true },
)
</script>

<template>
  <div class="container-page py-8 md:py-10">
    <div class="mb-8">
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
      <h1 class="mf-display mf-h2 mt-2 text-[#111111]">Imports multi-sources</h1>
      <p class="mt-3 max-w-2xl text-sm text-[#454545]">
        Synchronise AMI, Démosphère, manifs.fr, ManifRadar et Mobilizon XR.
        Filtrage militant et géocodage BAN sont toujours actifs.
      </p>
    </div>

    <div class="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.1fr)]">
      <!-- Config -->
      <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
        <h2 class="text-sm font-extrabold uppercase tracking-wide text-[#111111]">Nouvel import</h2>

        <fieldset class="mt-4">
          <legend class="text-xs font-bold uppercase tracking-wide text-[#636363]">Sources</legend>
          <div class="mt-3 space-y-2">
            <label
              v-for="src in IMPORT_SOURCES"
              :key="src.id"
              class="flex cursor-pointer gap-3 rounded-[4px] border border-[#DDDAD3] p-3 hover:bg-[#FFFCF4]"
            >
              <input
                type="checkbox"
                class="mt-1"
                :checked="selectedSources.includes(src.id)"
                @change="toggleSource(src.id)"
              >
              <span>
                <span class="block text-sm font-bold text-[#111111]">{{ src.label }}</span>
                <span class="mt-0.5 block text-xs text-[#636363]">{{ src.description }}</span>
              </span>
            </label>
          </div>
        </fieldset>

        <fieldset class="mt-5">
          <legend class="text-xs font-bold uppercase tracking-wide text-[#636363]">Statut</legend>
          <div class="mt-3 grid grid-cols-2 gap-2">
            <label
              v-for="m in IMPORT_MODES"
              :key="m.id"
              class="flex cursor-pointer items-center gap-3 rounded-[4px] border border-[#DDDAD3] p-3 hover:bg-[#FFFCF4]"
              :class="mode === m.id ? 'border-[#9C6EE8] bg-[#F7F2FC]' : ''"
            >
              <input v-model="mode" type="radio" :value="m.id" class="shrink-0">
              <span class="text-sm font-bold">{{ m.label }}</span>
            </label>
          </div>
        </fieldset>

        <p v-if="errorMsg" class="mt-4 text-sm text-[#AD291F]">{{ errorMsg }}</p>
        <p v-if="successMsg" class="mt-4 text-sm font-semibold text-[#206C4D]">{{ successMsg }}</p>

        <div class="mt-6 flex flex-wrap gap-3">
          <UiButton :disabled="busy || cancelling || !selectedSources.length" @click="startImport">
            {{ busy ? 'Import en cours…' : 'Lancer l’import' }}
          </UiButton>
        </div>

      </section>

      <!-- Import actif -->
      <section class="space-y-5">
        <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
          <h2 class="text-sm font-extrabold uppercase tracking-wide">{{ lastRunHeading }}</h2>
          <p v-if="!activeRun" class="mt-2 text-sm text-[#636363]">Aucun import pour l’instant.</p>

          <template v-if="activeRun">
            <div class="mt-4">
              <div class="mb-2 flex items-center justify-between gap-3 text-xs font-bold tabular-nums text-[#636363]">
                <span>{{ progressPct }}%</span>
                <span v-if="runElapsedLabel" class="text-[#454545]">{{ runElapsedLabel }}</span>
              </div>
              <div
                class="import-progress-track h-3 overflow-hidden rounded-full bg-[#F4F1EA]"
                role="progressbar"
                :aria-valuenow="progressPct"
                aria-valuemin="0"
                aria-valuemax="100"
              >
                <div
                  class="import-progress-bar h-full rounded-full transition-[width] duration-500 ease-out"
                  :class="runInProgress || busy ? 'import-progress-bar--live' : ''"
                  :style="{ width: `${Math.max(progressPct, runInProgress || busy ? 4 : 0)}%` }"
                />
              </div>
            </div>
            <p class="mt-2 text-sm text-[#454545]">
              {{ activeRun.progress?.message || '—' }}
            </p>
            <p
              v-if="writeIncomplete && !busy"
              class="mt-2 text-sm font-semibold text-[#805200]"
            >
              <template v-if="needsPrepare">
                {{ activeRun.stats?.pending }} événement(s) scrapés pas encore traités.
                Reprenez l’import pour les finaliser.
              </template>
              <template v-else>
                L’écriture n’est pas allée au bout.
                Utilisez « Reprendre » si la reprise auto n’a pas suffi.
              </template>
            </p>
            <p
              v-else-if="(activeRun.stats?.errors || 0) > 0 && !busy"
              class="mt-2 text-sm font-semibold text-[#AD291F]"
            >
              {{ activeRun.stats.errors }} erreur(s) — ces événements n’ont pas été créés.
            </p>

            <dl class="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Scrapés</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.scraped ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Candidats</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.created ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Doublons</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.duplicates ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Maj</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.updated ?? 0 }}</dd>
              </div>
              <div
                class="rounded-[4px] border p-3"
                :class="(activeRun.stats?.errors || 0) > 0
                  ? 'border-[#AD291F] bg-[#FDF2F0]'
                  : 'border-[#DDDAD3] bg-[#FFFCF4]'"
              >
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Erreurs</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.errors ?? 0 }}</dd>
              </div>
            </dl>

            <UiAlert
              v-if="activeRun.mode === 'published'"
              class="mt-3"
              color="info"
              variant="subtle"
              title="Publication auto"
            >
              Les nouveaux événements de cet import ont été publiés directement (pas de file de brouillons).
            </UiAlert>

            <div class="mt-4 flex flex-wrap gap-2">
              <UiButton
                v-if="canCancelRun"
                size="sm"
                variant="red"
                :disabled="cancelling"
                @click="cancelRun"
              >
                {{ cancelling ? 'Annulation…' : 'Arrêter / annuler' }}
              </UiButton>
              <UiButton
                v-if="showResume"
                size="sm"
                variant="outline"
                :disabled="busy || cancelling"
                @click="resumeRun"
              >
                Reprendre / finir l’écriture
              </UiButton>
              <UiButton
                v-if="showCandidates && (detailData?.candidates?.total || 0) > 0"
                size="sm"
                variant="outline"
                :disabled="busy || cancelling"
                @click="publishApplied"
              >
                Publier les nouveaux brouillons
              </UiButton>
            </div>
          </template>
        </div>

        <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
          <h2 class="text-sm font-extrabold uppercase tracking-wide">
            Candidats
          </h2>

          <div
            v-if="(runInProgress || busy) && !showCandidates"
            class="mt-6 flex flex-col items-center justify-center gap-4 py-8 text-center"
            role="status"
            aria-live="polite"
          >
            <div class="import-candidates-loader relative flex size-16 items-center justify-center">
              <span class="import-candidates-loader__ring absolute inset-0 rounded-full border-2 border-[#E8D9F8] border-t-[#9C6EE8]" />
              <img
                src="/brand/manif.logo.svg"
                alt=""
                width="40"
                height="40"
                class="import-candidates-loader__mark relative size-10 rounded-[10px]"
              >
            </div>
            <p class="max-w-sm text-sm text-[#636363]">
              La liste des nouveaux candidats s’affichera à la fin de l’import.
            </p>
          </div>
          <p
            v-else-if="!activeRun"
            class="mt-4 text-sm text-[#636363]"
          >
            Aucun import pour l’instant.
          </p>
          <p
            v-else-if="activeRun.status === 'cancelled' || activeRun.status === 'failed'"
            class="mt-4 text-sm text-[#636363]"
          >
            Import {{ activeRun.status === 'cancelled' ? 'annulé' : 'en échec' }} — pas de liste de candidats.
          </p>
          <template v-else-if="showCandidates">
            <p
              v-if="detailPending && !detailData?.candidates?.items?.length"
              class="mt-4 text-sm text-[#636363]"
            >
              Chargement…
            </p>
            <p
              v-else-if="!detailData?.candidates?.items?.length"
              class="mt-4 rounded-[4px] border border-dashed border-[#DDDAD3] bg-[#FFFCF4] px-4 py-8 text-center text-sm text-[#636363]"
            >
              <template v-if="(activeRun.stats?.created || 0) > 0">
                Aucun brouillon à publier.
                Les {{ activeRun.stats.created }} candidat{{ activeRun.stats.created > 1 ? 's' : '' }}
                de cet import {{ activeRun.mode === 'published' ? 'sont déjà publiés' : 'ne sont plus en brouillon' }}.
              </template>
              <template v-else>
                Aucun nouveau candidat pour cet import.
              </template>
            </p>
            <div
              v-if="detailData?.candidates?.items?.length"
              class="relative mt-4"
            >
              <div
                v-if="selectableCandidates.length"
                class="mb-2 flex items-center gap-3 border-b border-[#DDDAD3] pb-3"
              >
                <label class="flex cursor-pointer items-center gap-2 text-xs font-semibold text-[#636363]">
                  <input
                    type="checkbox"
                    class="size-4 accent-[#6735B6]"
                    :checked="allSelectableSelected"
                    :indeterminate.prop="selectedCount > 0 && !allSelectableSelected"
                    :disabled="bulkBusy || busy"
                    @change="toggleSelectAll(($event.target as HTMLInputElement).checked)"
                  >
                  Tout sélectionner
                </label>
                <span
                  v-if="selectedCount"
                  class="text-xs tabular-nums text-[#454545]"
                >
                  {{ selectedCount }} sélectionné{{ selectedCount > 1 ? 's' : '' }}
                </span>
              </div>

              <ul class="divide-y divide-[#DDDAD3]" :class="selectableCandidates.length ? 'pb-20' : ''">
                <li
                  v-for="c in detailData.candidates.items"
                  :key="c.id"
                  class="py-2.5"
                >
                  <div class="flex items-start gap-3">
                    <div class="flex w-6 shrink-0 justify-center pt-0.5">
                      <input
                        v-if="candidateHasEvent(c)"
                        v-model="selectedCandidateIds"
                        type="checkbox"
                        class="size-4 shrink-0 accent-[#6735B6]"
                        :value="c.id"
                        :disabled="bulkBusy || busy"
                        :aria-label="`Sélectionner ${c.title}`"
                        @mousedown="onCandidateCheckMouseDown(c, $event)"
                        @click="onCandidateCheckClick(c, $event)"
                        @change="onCandidateCheckChange(c)"
                      >
                    </div>

                    <div class="min-w-0 flex-1">
                      <NuxtLink
                        v-if="candidateAdminPath(c)"
                        :to="candidateAdminPath(c)!"
                        class="text-sm font-bold text-[#D1271C] hover:underline"
                      >
                        {{ c.title }}
                      </NuxtLink>
                      <p v-else class="text-sm font-bold text-[#111111]">{{ c.title }}</p>

                      <p
                        v-if="c.status === 'error' || candidateUnavailableHint(c)"
                        class="mt-1 text-xs text-[#805200]"
                      >
                        {{ c.errorMessage || candidateUnavailableHint(c) }}
                      </p>

                      <p
                        v-if="c.description"
                        class="mt-0.5 line-clamp-1 text-xs leading-snug text-[#454545]"
                      >
                        {{ excerpt(c.description) }}
                      </p>

                      <p class="mt-0.5 text-xs text-[#636363]">
                        {{ c.cityName }}
                        <template v-if="c.startAt"> · {{ c.startAt.slice(0, 16).replace('T', ' ') }}</template>
                        ·
                        <a
                          :href="c.sourceUrl"
                          target="_blank"
                          rel="noopener"
                          class="font-semibold text-[#6735B6] hover:underline"
                        >
                          {{ sourceLinkLabel(c.source) }}
                        </a>
                      </p>
                    </div>

                    <div
                      v-if="candidateHasEvent(c)"
                      class="flex shrink-0 flex-col gap-2"
                    >
                      <UiButton
                        v-if="canPublishCandidate(c)"
                        size="sm"
                        variant="red"
                        :disabled="publishingId === c.id || busy || bulkBusy"
                        @click="publishCandidate(c)"
                      >
                        {{ publishingId === c.id ? 'Publication…' : 'Publier' }}
                      </UiButton>
                      <UiButton
                        v-if="canDeleteCandidate(c)"
                        size="sm"
                        variant="outline"
                        :disabled="publishingId === c.id || busy || bulkBusy"
                        @click="deleteCandidate(c)"
                      >
                        {{ publishingId === c.id ? 'Suppression…' : 'Supprimer' }}
                      </UiButton>
                    </div>
                  </div>
                </li>
              </ul>

              <div
                v-if="(detailData?.candidates?.total || 0) > 30"
                class="mt-4 flex items-center justify-between gap-3"
                :class="selectableCandidates.length ? 'pb-20' : ''"
              >
                <UiButton
                  size="sm"
                  variant="outline"
                  :disabled="candidatesPage <= 1"
                  @click="candidatesPage--"
                >
                  Précédent
                </UiButton>
                <span class="text-xs font-semibold text-[#636363]">
                  p. {{ candidatesPage }}/{{ candidateTotalPages }}
                </span>
                <UiButton
                  size="sm"
                  variant="outline"
                  :disabled="candidatesPage >= candidateTotalPages"
                  @click="candidatesPage++"
                >
                  Suivant
                </UiButton>
              </div>

              <div
                v-if="selectableCandidates.length"
                class="sticky bottom-3 z-10 mt-4 rounded-[8px] border border-[#DDDAD3] bg-white/95 p-3 shadow-soft backdrop-blur"
              >
                <div class="flex flex-wrap items-center justify-between gap-3">
                  <p class="text-xs font-semibold text-[#636363]">
                    <template v-if="selectedCount">
                      {{ selectedCount }} sélectionné{{ selectedCount > 1 ? 's' : '' }}
                    </template>
                    <template v-else>
                      Sélectionnez des candidats
                    </template>
                  </p>
                  <div class="flex flex-wrap gap-2">
                    <UiButton
                      size="sm"
                      variant="red"
                      :disabled="!canBulkPublish || bulkBusy || busy"
                      @click="bulkPublishSelected"
                    >
                      {{ bulkBusy ? '…' : 'Publier' }}
                    </UiButton>
                    <UiButton
                      size="sm"
                      variant="outline"
                      :disabled="!canBulkDelete || bulkBusy || busy"
                      @click="bulkDeleteSelected"
                    >
                      Supprimer
                    </UiButton>
                  </div>
                </div>
              </div>
            </div>
          </template>
        </div>
      </section>
    </div>
  </div>
</template>

<style scoped>
.import-progress-bar {
  background: linear-gradient(90deg, #7b45c4 0%, #9c6ee8 45%, #b892f0 100%);
  background-size: 200% 100%;
  box-shadow: 0 0 12px rgb(156 110 232 / 35%);
}

.import-progress-bar--live {
  animation: import-progress-flow 1.4s linear infinite;
}

.import-progress-bar--live::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(
    105deg,
    transparent 30%,
    rgb(255 255 255 / 45%) 50%,
    transparent 70%
  );
  background-size: 200% 100%;
  animation: import-progress-shine 1.1s ease-in-out infinite;
}

.import-progress-track .import-progress-bar {
  position: relative;
  overflow: hidden;
}

.import-candidates-loader__ring {
  animation: import-loader-spin 0.9s linear infinite;
}

.import-candidates-loader__mark {
  animation: import-loader-pulse 1.4s ease-in-out infinite;
}

@keyframes import-progress-flow {
  0% { background-position: 0% 50%; }
  100% { background-position: 200% 50%; }
}

@keyframes import-progress-shine {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

@keyframes import-loader-spin {
  to { transform: rotate(360deg); }
}

@keyframes import-loader-pulse {
  0%, 100% { transform: scale(1); opacity: 1; }
  50% { transform: scale(0.92); opacity: 0.85; }
}

@media (prefers-reduced-motion: reduce) {
  .import-progress-bar--live,
  .import-progress-bar--live::after,
  .import-candidates-loader__ring,
  .import-candidates-loader__mark {
    animation: none;
  }
}
</style>
