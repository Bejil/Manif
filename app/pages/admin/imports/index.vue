<script setup lang="ts">
import {
  IMPORT_SOURCES,
  IMPORT_MODES,
  IMPORT_RUN_STATUS_LABELS,
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

const candidatesQuery = computed(() => ({
  page: candidatesPage.value,
  pageSize: 30,
}))

const { data: detailData, refresh: refreshDetail, pending: detailPending } = await useFetch<{
  run: ImportRunRecord
  candidates: { items: CandidateRow[], total: number }
}>(() => (activeRun.value ? `/api/admin/imports/${activeRun.value.id}` : null), {
  headers: cookieHeaders,
  credentials: 'include',
  query: candidatesQuery,
  watch: [() => activeRun.value?.id, candidatesQuery],
})

watch(activeRunId, () => {
  candidatesPage.value = 1
})

function toggleSource(id: ImportSourceId) {
  if (selectedSources.value.includes(id)) {
    selectedSources.value = selectedSources.value.filter(s => s !== id)
  }
  else {
    selectedSources.value = [...selectedSources.value, id]
  }
}

function runStatusLabel(status: string) {
  return IMPORT_RUN_STATUS_LABELS[status] || status
}

function sourceLinkLabel(source: string) {
  return `Source ${importSourceShortLabel(source)}`
}

function excerpt(text: string, max = 160) {
  const clean = text.replace(/\s+/g, ' ').trim()
  if (clean.length <= max) return clean
  return `${clean.slice(0, max).trim()}…`
}

async function loopContinue(runId: string) {
  let guard = 0
  while (guard++ < 2000) {
    const step = await $fetch<{ run: ImportRunRecord, done: boolean, step: string }>(
      `/api/admin/imports/${runId}/continue`,
      { method: 'POST', credentials: 'include' },
    )
    activeRunId.value = step.run.id
    await refreshRuns()
    await refreshDetail()
    if (step.done) break
    await new Promise(r => setTimeout(r, 80))
  }
}

async function resumeRun() {
  if (!activeRun.value) return
  busy.value = true
  errorMsg.value = null
  try {
    await loopContinue(activeRun.value.id)
    await refreshDetail()
  }
  catch {
    errorMsg.value = 'Impossible de reprendre l’import'
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
    await refreshRuns()
    if (!step.done) await loopContinue(step.run.id)
    await refreshDetail()
  }
  catch (e: unknown) {
    errorMsg.value = e && typeof e === 'object' && 'data' in e
      ? String((e as { data?: { statusMessage?: string } }).data?.statusMessage || 'Échec du lancement')
      : 'Échec du lancement'
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

async function cancelRun() {
  if (!activeRun.value) return
  busy.value = true
  try {
    await $fetch(`/api/admin/imports/${activeRun.value.id}/cancel`, {
      method: 'POST',
      credentials: 'include',
    })
    await refreshRuns()
    await refreshDetail()
  }
  finally {
    busy.value = false
  }
}

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

const progressPct = computed(() => {
  const p = activeRun.value?.progress
  if (!p?.totalUnits) return 0
  return Math.min(100, Math.round((100 * (p.cursor || 0)) / p.totalUnits))
})

const candidateTotalPages = computed(() => {
  const total = detailData.value?.candidates?.total ?? 0
  return Math.max(1, Math.ceil(total / 30))
})

const showResume = computed(() => {
  const s = activeRun.value?.status
  return !!s && s !== 'completed' && s !== 'cancelled'
})

const lastRunHeading = computed(() => {
  const run = activeRun.value
  if (!run) return 'Dernier run'
  if (run.status !== 'completed') return 'Dernier run'
  const when = formatRunDate(run.finishedAt || run.updatedAt || run.createdAt)
  return when ? `Dernier run · ${when}` : 'Dernier run'
})
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
        <h2 class="text-sm font-extrabold uppercase tracking-wide text-[#111111]">Nouveau run</h2>

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
          <legend class="text-xs font-bold uppercase tracking-wide text-[#636363]">Mode d’écriture</legend>
          <div class="mt-3 space-y-2">
            <label
              v-for="m in IMPORT_MODES"
              :key="m.id"
              class="flex cursor-pointer gap-3 rounded-[4px] border border-[#DDDAD3] p-3 hover:bg-[#FFFCF4]"
              :class="mode === m.id ? 'border-[#9C6EE8] bg-[#F7F2FC]' : ''"
            >
              <input v-model="mode" type="radio" :value="m.id" class="mt-1">
              <span>
                <span class="block text-sm font-bold">{{ m.label }}</span>
                <span class="block text-xs text-[#636363]">{{ m.description }}</span>
              </span>
            </label>
          </div>
        </fieldset>

        <p v-if="errorMsg" class="mt-4 text-sm text-[#AD291F]">{{ errorMsg }}</p>
        <p v-if="successMsg" class="mt-4 text-sm font-semibold text-[#206C4D]">{{ successMsg }}</p>

        <div class="mt-6 flex flex-wrap gap-3">
          <UiButton :disabled="busy || !selectedSources.length" @click="startImport">
            {{ busy ? 'Import en cours…' : 'Lancer l’import' }}
          </UiButton>
          <UiButton
            v-if="activeRun && ['running', 'scraped', 'applying'].includes(activeRun.status)"
            variant="outline"
            :disabled="busy"
            @click="cancelRun"
          >
            Annuler
          </UiButton>
        </div>

        <p class="mt-4 text-xs text-[#636363]">
          Avant le premier run en base réelle, exécutez
          <code class="rounded bg-[#F4F1EA] px-1">supabase/apply_010_import_runs.sql</code>
          dans le SQL Editor Supabase.
        </p>
      </section>

      <!-- Run actif -->
      <section class="space-y-5">
        <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
          <div class="flex flex-wrap items-start justify-between gap-3">
            <div>
              <h2 class="text-sm font-extrabold uppercase tracking-wide">{{ lastRunHeading }}</h2>
              <p v-if="activeRun" class="mt-1 text-xs text-[#636363]">
                {{ activeRun.id.slice(0, 8) }}
                · {{ runStatusLabel(activeRun.status) }}
                · mode {{ activeRun.mode === 'draft' ? 'brouillon' : 'publié' }}
              </p>
              <p v-else class="mt-2 text-sm text-[#636363]">Aucun import pour l’instant.</p>
            </div>
            <div v-if="runsData?.items?.length" class="flex flex-wrap gap-1">
              <button
                v-for="r in runsData.items.slice(0, 6)"
                :key="r.id"
                type="button"
                class="rounded-[4px] px-2 py-1 text-xs font-bold"
                :class="activeRun?.id === r.id ? 'bg-[#111111] text-white' : 'bg-[#F4F1EA] text-[#111111]'"
                @click="activeRunId = r.id"
              >
                {{ runStatusLabel(r.status) }}
              </button>
            </div>
          </div>

          <template v-if="activeRun">
            <div class="mt-4 h-2 overflow-hidden rounded-full bg-[#F4F1EA]">
              <div class="h-full bg-[#9C6EE8] transition-all" :style="{ width: `${progressPct}%` }" />
            </div>
            <p class="mt-2 text-sm text-[#454545]">
              {{ activeRun.progress?.message || '—' }}
              <span v-if="activeRun.progress?.totalUnits" class="text-[#636363]">
                ({{ activeRun.progress.cursor }}/{{ activeRun.progress.totalUnits }})
              </span>
            </p>

            <dl class="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
              <div class="rounded-[4px] bg-[#F4F1EA] p-3">
                <dt class="text-[10px] font-bold uppercase text-[#636363]">Scrapés</dt>
                <dd class="text-lg font-extrabold">{{ activeRun.stats?.scraped ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] bg-[#F4F1EA] p-3">
                <dt class="text-[10px] font-bold uppercase text-[#636363]">Prêts</dt>
                <dd class="text-lg font-extrabold">{{ activeRun.stats?.ready ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] bg-[#F4F1EA] p-3">
                <dt class="text-[10px] font-bold uppercase text-[#636363]">Doublons</dt>
                <dd class="text-lg font-extrabold">{{ activeRun.stats?.duplicates ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] bg-[#F4F1EA] p-3">
                <dt class="text-[10px] font-bold uppercase text-[#636363]">Créés</dt>
                <dd class="text-lg font-extrabold">{{ activeRun.stats?.created ?? 0 }}</dd>
              </div>
              <div class="rounded-[4px] bg-[#F4F1EA] p-3">
                <dt class="text-[10px] font-bold uppercase text-[#636363]">MAJ</dt>
                <dd class="text-lg font-extrabold">{{ activeRun.stats?.updated ?? 0 }}</dd>
              </div>
            </dl>

            <div class="mt-4 flex flex-wrap gap-2">
              <UiButton
                v-if="showResume"
                size="sm"
                variant="outline"
                :disabled="busy"
                @click="resumeRun"
              >
                Reprendre / finir l’écriture
              </UiButton>
              <UiButton
                v-if="(activeRun.stats?.created || 0) + (activeRun.stats?.updated || 0) > 0"
                size="sm"
                variant="red"
                :disabled="busy"
                @click="publishApplied"
              >
                Publier les brouillons de ce run
              </UiButton>
            </div>
            <p
              v-if="activeRun.mode === 'draft'"
              class="mt-3 rounded-[4px] border border-[#805200]/30 bg-[#FFF8E8] px-3 py-2 text-xs text-[#805200]"
            >
              Mode brouillon : les événements ne sont pas visibles sur le site public tant qu’ils
              ne sont pas publiés.
            </p>
          </template>
        </div>

        <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
          <h2 class="text-sm font-extrabold uppercase tracking-wide">Candidats</h2>

          <p v-if="detailPending" class="mt-4 text-sm text-[#636363]">Chargement…</p>
          <p
            v-else-if="!detailData?.candidates?.items?.length"
            class="mt-4 text-sm text-[#636363]"
          >
            Aucun candidat.
          </p>
          <ul v-else class="mt-4 divide-y divide-[#DDDAD3]">
            <li
              v-for="c in detailData.candidates.items"
              :key="c.id"
              class="py-4"
            >
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
        </div>
      </section>
    </div>
  </div>
</template>
