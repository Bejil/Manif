<script setup lang="ts">
import {
  IMPORT_SOURCES,
  IMPORT_MODES,
  importSourceShortLabel,
} from '#shared/constants/import-sources'
import type { ImportModeId, ImportSourceId } from '#shared/constants/import-sources'
import type { ImportCandidateRecord, ImportRunRecord } from '#shared/types/import'
import type { PublicationStatus } from '#shared/constants/statuses'
import { readImportChanges, type ImportFieldChange } from '#shared/utils/import-diff'

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

const { data: runsData, refresh: refreshRuns } = await useFetch<{ items: ImportRunRecord[] }>(
  '/api/admin/imports',
  { headers: cookieHeaders, credentials: 'include' },
)

const activeRun = computed(() =>
  runsData.value?.items?.find(r => r.id === activeRunId.value)
  || runsData.value?.items?.[0]
  || null,
)

const candidatesPage = ref(1)
/** Liste affichée : créations ou mises à jour. */
const candidatesKind = ref<'new' | 'updated'>('new')

const candidatesQuery = computed(() => ({
  page: candidatesPage.value,
  pageSize: 30,
  kind: candidatesKind.value,
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

/** Vrai seulement pendant scrape / préparation / écriture — pas un « completed » désynchronisé. */
const runInProgress = computed(() => {
  const s = activeRun.value?.status
  return Boolean(s && RUN_LIVE.has(s))
})

/** Terminé côté statut, mais stats suggèrent une écriture incomplète. */
const writeIncomplete = computed(() =>
  activeRun.value?.status === 'completed' && needsWrite.value,
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

watch(activeRunId, () => {
  candidatesPage.value = 1
  candidatesKind.value = 'new'
})

watch(candidatesKind, () => {
  candidatesPage.value = 1
})

function showCreatedList() {
  if (!showCandidates.value) return
  candidatesKind.value = 'new'
}

function showUpdatedList() {
  if (!showCandidates.value) return
  if (!(activeRun.value?.stats?.updated)) return
  candidatesKind.value = 'updated'
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

function candidateChanges(c: CandidateRow): ImportFieldChange[] {
  return readImportChanges(c.payload)
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
  if (!selectedSources.value.length) {
    errorMsg.value = 'Sélectionnez au moins une source.'
    return
  }
  abortContinue.value = false
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
    activeRunId.value = step.run.id
    autoResumeTriedFor = step.run.id
    await refreshRuns()
    if (!step.done && !abortContinue.value) await loopContinue(step.run.id)
    await refreshDetail()
  }
  catch (e: unknown) {
    if (!abortContinue.value) {
      errorMsg.value = e && typeof e === 'object' && 'data' in e
        ? String((e as { data?: { statusMessage?: string } }).data?.statusMessage || 'Échec du lancement')
        : 'Échec du lancement'
    }
  }
  finally {
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

function canPublishCandidate(c: CandidateRow): boolean {
  const eventId = c.appliedEventId || c.matchEventId
  if (!eventId) return false
  return c.publicationStatus === 'draft' || c.publicationStatus === 'unpublished'
}

function canUnpublishCandidate(c: CandidateRow): boolean {
  const eventId = c.appliedEventId || c.matchEventId
  if (!eventId) return false
  return c.publicationStatus === 'published'
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
    successMsg.value = `${res.published} publié(s), ${res.alreadyPublished} déjà public(s), ${res.missing} introuvable(s).`
    await refreshDetail()
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
    await refreshDetail()
  }
  catch {
    errorMsg.value = 'Publication impossible'
  }
  finally {
    publishingId.value = null
  }
}

async function unpublishCandidate(c: CandidateRow) {
  const eventId = c.appliedEventId || c.matchEventId
  if (!eventId) return
  publishingId.value = c.id
  errorMsg.value = null
  try {
    await $fetch(`/api/admin/events/${eventId}/unpublish`, { method: 'POST', credentials: 'include' })
    await refreshDetail()
  }
  catch {
    errorMsg.value = 'Dépublication impossible'
  }
  finally {
    publishingId.value = null
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
  const s = activeRun.value?.status
  if (!s || s === 'cancelled' || s === 'failed') return false
  if (RUN_LIVE.has(s)) return true
  return writeIncomplete.value
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
          <div class="mt-3 space-y-2">
            <label
              v-for="m in IMPORT_MODES"
              :key="m.id"
              class="flex cursor-pointer gap-3 rounded-[4px] border border-[#DDDAD3] p-3 hover:bg-[#FFFCF4]"
              :class="mode === m.id ? 'border-[#9C6EE8] bg-[#F7F2FC]' : ''"
            >
              <input v-model="mode" type="radio" :value="m.id" class="mt-1">
              <span class="block text-sm font-bold">{{ m.label }}</span>
            </label>
          </div>
        </fieldset>

        <p v-if="errorMsg" class="mt-4 text-sm text-[#AD291F]">{{ errorMsg }}</p>
        <p v-if="successMsg" class="mt-4 text-sm font-semibold text-[#206C4D]">{{ successMsg }}</p>

        <div class="mt-6 flex flex-wrap gap-3">
          <UiButton :disabled="busy || cancelling || !selectedSources.length" @click="startImport">
            {{ busy ? 'Import en cours…' : 'Lancer l’import' }}
          </UiButton>
          <UiButton
            v-if="canCancelRun"
            variant="outline"
            :disabled="cancelling"
            @click="cancelRun"
          >
            {{ cancelling ? 'Annulation…' : 'Arrêter l’import' }}
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
              L’écriture n’est pas allée au bout (compteurs désynchronisés).
              Utilisez « Reprendre / finir l’écriture » si la reprise auto n’a pas suffi.
            </p>

            <dl class="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Scrapés</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.scraped ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Prêts</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.ready ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] p-3">
                <dt class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">Doublons</dt>
                <dd class="mt-1 text-lg font-extrabold tabular-nums text-[#111111]">{{ activeRun.stats?.duplicates ?? 0 }}</dd>
              </div>
              <div>
                <dt class="sr-only">Créés</dt>
                <dd>
                  <button
                    type="button"
                    class="group flex w-full flex-col rounded-[4px] border px-3 py-3 text-left transition disabled:cursor-default"
                    :class="showCandidates && candidatesKind === 'new'
                      ? 'border-[#111111] bg-[#111111] text-[#FFFCF4]'
                      : showCandidates
                        ? 'border-[#DDDAD3] bg-white hover:border-[#111111]'
                        : 'border-[#DDDAD3] bg-[#FFFCF4]'"
                    :disabled="!showCandidates"
                    @click="showCreatedList"
                  >
                    <span
                      class="text-[10px] font-bold uppercase tracking-wide"
                      :class="showCandidates && candidatesKind === 'new' ? 'text-[#9C6EE8]' : 'text-[#636363]'"
                    >
                      Créés
                    </span>
                    <span class="mt-1 text-lg font-extrabold tabular-nums">{{ activeRun.stats?.created ?? 0 }}</span>
                    <span
                      v-if="showCandidates"
                      class="mt-2 text-[10px] font-bold uppercase tracking-wide"
                      :class="candidatesKind === 'new' ? 'text-[#FFFCF4]/70' : 'text-[#6735B6] group-hover:underline'"
                    >
                      {{ candidatesKind === 'new' ? 'Liste active' : 'Afficher' }}
                    </span>
                  </button>
                </dd>
              </div>
              <div>
                <dt class="sr-only">MAJ</dt>
                <dd>
                  <button
                    type="button"
                    class="group flex w-full flex-col rounded-[4px] border px-3 py-3 text-left transition disabled:cursor-default disabled:opacity-50"
                    :class="showCandidates && (activeRun.stats?.updated || 0) > 0 && candidatesKind === 'updated'
                      ? 'border-[#6735B6] bg-[#6735B6] text-[#FFFCF4]'
                      : showCandidates && (activeRun.stats?.updated || 0) > 0
                        ? 'border-[#DDDAD3] bg-white hover:border-[#6735B6]'
                        : 'border-[#DDDAD3] bg-[#FFFCF4]'"
                    :disabled="!showCandidates || !(activeRun.stats?.updated)"
                    @click="showUpdatedList"
                  >
                    <span
                      class="text-[10px] font-bold uppercase tracking-wide"
                      :class="candidatesKind === 'updated' && showCandidates ? 'text-[#E8D9F8]' : 'text-[#636363]'"
                    >
                      MAJ
                    </span>
                    <span class="mt-1 text-lg font-extrabold tabular-nums">{{ activeRun.stats?.updated ?? 0 }}</span>
                    <span
                      v-if="showCandidates && (activeRun.stats?.updated || 0) > 0"
                      class="mt-2 text-[10px] font-bold uppercase tracking-wide"
                      :class="candidatesKind === 'updated' ? 'text-[#FFFCF4]/70' : 'text-[#6735B6] group-hover:underline'"
                    >
                      {{ candidatesKind === 'updated' ? 'Liste active' : 'Afficher' }}
                    </span>
                  </button>
                </dd>
              </div>
            </dl>

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
                v-if="showCandidates && (activeRun.stats?.created || 0) > 0"
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
            <template v-if="!showCandidates">Candidats</template>
            <template v-else-if="candidatesKind === 'updated'">Mises à jour</template>
            <template v-else>Nouveaux candidats</template>
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
              Les mises à jour d’événements déjà connus sont appliquées automatiquement.
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
            <p v-if="detailPending" class="mt-4 text-sm text-[#636363]">Chargement…</p>
            <p
              v-else-if="!detailData?.candidates?.items?.length"
              class="mt-4 text-sm text-[#636363]"
            >
              <template v-if="candidatesKind === 'updated'">
                Aucune mise à jour pour cet import.
              </template>
              <template v-else>
                Aucun nouvel événement.
                <span v-if="(activeRun.stats?.updated || 0) > 0">
                  {{ activeRun.stats.updated }} mise(s) à jour — cliquez sur le bloc MAJ pour les voir.
                </span>
              </template>
            </p>
            <ul v-else class="mt-4 divide-y divide-[#DDDAD3]">
              <li
                v-for="c in detailData.candidates.items"
                :key="c.id"
                class="py-4"
              >
                <!-- Liste MAJ : uniquement les champs modifiés -->
                <template v-if="candidatesKind === 'updated'">
                  <div class="flex flex-wrap items-start justify-between gap-3">
                    <div class="min-w-0 flex-1">
                      <NuxtLink
                        v-if="candidateAdminPath(c)"
                        :to="candidateAdminPath(c)!"
                        class="text-sm font-bold text-[#111111] hover:text-[#6735B6] hover:underline"
                      >
                        {{ c.title }}
                      </NuxtLink>
                      <p v-else class="text-sm font-bold text-[#111111]">{{ c.title }}</p>
                      <p class="mt-1 text-xs text-[#636363]">
                        {{ c.cityName }}
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

                      <ul
                        v-if="candidateChanges(c).length"
                        class="mt-3 space-y-2"
                      >
                        <li
                          v-for="change in candidateChanges(c)"
                          :key="change.field"
                          class="rounded-[4px] border border-[#E8D9F8] bg-[#F7F2FC] px-3 py-2"
                        >
                          <p class="text-[10px] font-bold uppercase tracking-wide text-[#4D257D]">
                            {{ change.label }}
                          </p>
                          <p class="mt-1 text-xs leading-relaxed text-[#636363] line-through decoration-[#AD291F]/50">
                            {{ change.field === 'description' ? excerpt(change.before, 120) : change.before }}
                          </p>
                          <p class="mt-0.5 text-sm font-semibold leading-relaxed text-[#111111]">
                            {{ change.field === 'description' ? excerpt(change.after, 160) : change.after }}
                          </p>
                        </li>
                      </ul>
                      <p
                        v-else
                        class="mt-3 text-xs text-[#805200]"
                      >
                        Aucun détail de diff enregistré (import antérieur à cette fonctionnalité).
                        <NuxtLink
                          v-if="candidateAdminPath(c)"
                          :to="candidateAdminPath(c)!"
                          class="font-semibold text-[#6735B6] hover:underline"
                        >
                          Ouvrir la fiche
                        </NuxtLink>
                      </p>
                    </div>
                    <NuxtLink
                      v-if="candidateAdminPath(c)"
                      :to="candidateAdminPath(c)!"
                      class="shrink-0"
                    >
                      <UiButton size="sm" variant="outline" type="button">Voir la fiche</UiButton>
                    </NuxtLink>
                  </div>
                </template>

                <!-- Liste créations -->
                <template v-else>
                  <div class="flex flex-wrap items-start justify-between gap-3">
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
                        v-if="candidateUnavailableHint(c)"
                        class="mt-1 text-xs text-[#805200]"
                      >
                        {{ candidateUnavailableHint(c) }}
                      </p>
                      <p
                        v-if="c.description"
                        class="mt-2 text-sm leading-snug text-[#454545]"
                      >
                        {{ excerpt(c.description) }}
                      </p>
                      <p class="mt-2 text-xs text-[#636363]">
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
                    <div class="flex shrink-0 flex-col gap-2">
                      <UiButton
                        v-if="canPublishCandidate(c)"
                        size="sm"
                        variant="red"
                        :disabled="publishingId === c.id || busy"
                        @click="publishCandidate(c)"
                      >
                        {{ publishingId === c.id ? 'Publication…' : 'Publier' }}
                      </UiButton>
                      <UiButton
                        v-if="canUnpublishCandidate(c)"
                        size="sm"
                        variant="outline"
                        :disabled="publishingId === c.id || busy"
                        @click="unpublishCandidate(c)"
                      >
                        {{ publishingId === c.id ? 'Dépublication…' : 'Dépublier' }}
                      </UiButton>
                    </div>
                  </div>
                </template>
              </li>
            </ul>

            <div
              v-if="(detailData?.candidates?.total || 0) > 30"
              class="mt-4 flex items-center justify-between gap-3"
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
