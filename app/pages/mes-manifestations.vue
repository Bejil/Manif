<script setup lang="ts">
import { DateTime } from 'luxon'
import type { EventPublic } from '#shared/types/event'
import type { SubmissionModerationStatus } from '#shared/types/submission'
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.mesManifestations.title,
  description: SEO.mesManifestations.description,
  ogTitle: SEO.mesManifestations.title,
  ogDescription: SEO.mesManifestations.description,
  robots: 'noindex',
})

type EngagementFilter = 'all' | 'supported' | 'participating' | 'proposed'
type ViewMode = 'list' | 'calendar'

type MyProposalRow = {
  id: string
  title: string
  cityName: string
  category: string
  startAt: string | null
  moderationStatus: SubmissionModerationStatus
  verificationStatus: string
  rejectionReason: string | null
  event: {
    id: string
    slug: string
    title: string
    cityName: string
    category: string
    startAt: string | null
    displayStatus: string
    counts: { views: number, supports: number, participations: number }
  } | null
}

const {
  entries,
  supportedIds,
  participatingIds,
  engagedIds,
  refresh,
} = useMyEngagements()

const {
  proposals,
  proposalIds,
  hasProposals,
  refresh: refreshProposals,
} = useMyProposals()

/** Brouillon UI — appliqué seulement via « Rechercher ». */
const draftQ = ref('')
const draftCategory = ref('')
const appliedQ = ref('')
const appliedCategory = ref('')
const engagementFilter = ref<EngagementFilter>('all')
const sort = ref<'date' | 'category'>('date')
const viewMode = ref<ViewMode>('list')
const page = ref(1)
const pageSize = 20
const selectedId = ref<string | null>(null)
const previewId = ref<string | null>(null)
const calendarMonth = ref(DateTime.now().setZone('Europe/Paris').toFormat('yyyy-MM'))

const hasLocalData = computed(() => engagedIds.value.length > 0 || hasProposals.value)

const filteredLocalIds = computed(() => {
  if (engagementFilter.value === 'supported') return supportedIds.value
  if (engagementFilter.value === 'participating') return participatingIds.value
  if (engagementFilter.value === 'proposed') return []
  return engagedIds.value
})

const showEngagements = computed(() =>
  engagementFilter.value === 'all'
  || engagementFilter.value === 'supported'
  || engagementFilter.value === 'participating',
)

const showProposals = computed(() =>
  engagementFilter.value === 'all' || engagementFilter.value === 'proposed',
)

const listParams = computed(() => {
  if (!showEngagements.value || !filteredLocalIds.value.length) return null
  return {
    q: appliedQ.value || undefined,
    category: appliedCategory.value || undefined,
    statuses: 'upcoming,ongoing,past,cancelled,postponed',
    sort: sort.value,
    ids: filteredLocalIds.value.join(','),
    page: 1,
    pageSize: 200,
  }
})

function applySearch() {
  appliedQ.value = draftQ.value.trim()
  appliedCategory.value = draftCategory.value
  page.value = 1
  selectedId.value = null
}

watch([engagementFilter, sort], () => {
  page.value = 1
  selectedId.value = null
})

watch(viewMode, () => {
  previewId.value = null
})

const { data, pending, error, refresh: refreshList } = await useFetch<{
  items: EventPublic[]
  total: number
}>(() => (listParams.value ? '/api/events' : null), {
  query: listParams,
  watch: [listParams],
  server: false,
  lazy: true,
  default: () => ({ items: [], total: 0 }),
  transform: (res) => ({
    total: res.total ?? 0,
    items: res.items ?? [],
  }),
})

const proposalsData = ref<{ items: MyProposalRow[] }>({ items: [] })
const proposalsPending = ref(false)
const proposalsError = ref(false)

async function refreshProposalsApi() {
  if (!showProposals.value || !proposalIds.value.length) {
    proposalsData.value = { items: [] }
    proposalsError.value = false
    return
  }
  proposalsPending.value = true
  proposalsError.value = false
  try {
    proposalsData.value = await $fetch<{ items: MyProposalRow[] }>('/api/submissions/mine', {
      method: 'POST',
      body: { ids: proposalIds.value },
    })
  }
  catch {
    proposalsError.value = true
  }
  finally {
    proposalsPending.value = false
  }
}

watch([proposalIds, showProposals], () => {
  void refreshProposalsApi()
})

onMounted(() => {
  refresh()
  refreshProposals()
  void refreshProposalsApi()
})

const sortedItems = computed(() => {
  const items = [...(data.value?.items ?? [])]
  const byId = new Map(entries.value.map(e => [e.eventId, e]))
  const allowed = new Set(filteredLocalIds.value)
  const filtered = items.filter(e => allowed.has(e.id))

  return filtered.map(e => ({
    event: e,
    mine: byId.get(e.id) || null,
  }))
})

const proposalRows = computed(() => {
  let rows = [...(proposalsData.value?.items ?? [])]
  const q = appliedQ.value.trim().toLowerCase()
  if (q) {
    rows = rows.filter(r =>
      r.title.toLowerCase().includes(q)
      || r.cityName.toLowerCase().includes(q)
      || (r.event?.title.toLowerCase().includes(q) ?? false)
      || (r.event?.cityName.toLowerCase().includes(q) ?? false),
    )
  }
  if (appliedCategory.value) {
    rows = rows.filter(r => r.category === appliedCategory.value || r.event?.category === appliedCategory.value)
  }
  return rows
})

const totalPages = computed(() =>
  Math.max(1, Math.ceil(sortedItems.value.length / pageSize)),
)

const pageItems = computed(() => {
  const start = (page.value - 1) * pageSize
  return sortedItems.value.slice(start, start + pageSize)
})

const headingLabel = computed(() => {
  if (!hasLocalData.value) return 'Mes manifestations'
  if (engagementFilter.value === 'proposed') {
    const n = proposalRows.value.length
    return `${n} Proposition${n > 1 ? 's' : ''}`
  }
  const n = sortedItems.value.length
  return `${n} Manifestation${n > 1 ? 's' : ''}`
})

const agendaEvents = computed(() => {
  const fromEngagements = sortedItems.value.map(({ event: e }) => ({
    id: e.id,
    slug: e.slug,
    title: e.title,
    cityName: e.cityName,
    startAt: e.startAt,
    displayStatus: e.displayStatus,
    timezone: e.timezone,
  }))
  if (!showProposals.value) return fromEngagements
  const engaged = new Set(fromEngagements.map(e => e.id))
  const fromProposals = proposalRows.value
    .filter(p => p.event && !engaged.has(p.event.id))
    .map(p => ({
      id: p.event!.id,
      slug: p.event!.slug,
      title: p.event!.title,
      cityName: p.event!.cityName,
      startAt: p.event!.startAt,
      displayStatus: p.event!.displayStatus as EventPublic['displayStatus'],
      timezone: 'Europe/Paris',
    }))
  return [...fromEngagements, ...fromProposals]
})

const viewOptions: Array<{ id: ViewMode, label: string }> = [
  { id: 'list', label: 'Liste' },
  { id: 'calendar', label: 'Agenda' },
]

const engagementOptions = computed(() => {
  const opts: Array<{ id: EngagementFilter, label: string }> = [
    { id: 'all', label: 'Tous' },
    { id: 'supported', label: 'Je soutiens' },
    { id: 'participating', label: 'Je participe' },
  ]
  if (hasProposals.value || engagementFilter.value === 'proposed') {
    opts.push({ id: 'proposed', label: 'Je propose' })
  }
  return opts
})

watch(totalPages, (max) => {
  if (page.value > max) page.value = max
})

function eventById(id: string) {
  return sortedItems.value.find(row => row.event.id === id)?.event
    ?? proposalRows.value.find(p => p.event?.id === id)?.event
    ?? null
}

function onSelect(id: string) {
  selectedId.value = id
  if (viewMode.value === 'calendar') {
    previewId.value = id
    return
  }
  const event = eventById(id)
  if (event && 'slug' in event) void navigateTo(`/manifestations/${event.slug}`)
}

function closePreview() {
  previewId.value = null
}

async function refreshAll() {
  refresh()
  refreshProposals()
  await Promise.all([refreshList(), refreshProposalsApi()])
}
</script>

<template>
  <div class="container-page py-10 md:py-14">
    <div class="mb-6">
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Sans compte</p>
      <h1 class="mf-display mf-h2 mt-2 text-[#111111]">
        {{ headingLabel }}
      </h1>
      <p class="mt-3 max-w-xl text-sm text-[#454545] sm:text-base">
        Soutiens, participations et propositions enregistrés sur cet appareil.
        Filtrez, triez, ou ouvrez votre agenda mensuel.
      </p>
    </div>

    <EmptyState
      v-if="!hasLocalData"
      title="Rien pour l’instant sur cet appareil"
      description="Soutenez, participez, ou proposez une manifestation — vos choix restent ici, sans compte."
    >
      <div class="flex flex-wrap gap-2">
        <NuxtLink to="/manifestations">
          <UiButton size="sm">Explorer</UiButton>
        </NuxtLink>
        <NuxtLink to="/proposer">
          <UiButton size="sm" variant="outline">Proposer</UiButton>
        </NuxtLink>
      </div>
    </EmptyState>

    <template v-else>
      <EventFilters
        v-model:q="draftQ"
        v-model:category="draftCategory"
        id-prefix="mes-manifs"
        manual-submit
        @search="applySearch"
      />

      <div class="mt-4 flex flex-wrap items-center justify-between gap-y-3 gap-x-4">
        <fieldset class="flex flex-wrap gap-2">
          <legend class="sr-only">Type d’engagement</legend>
          <button
            v-for="opt in engagementOptions"
            :key="opt.id"
            type="button"
            class="rounded-[4px] px-3 py-2 text-sm font-bold"
            :class="engagementFilter === opt.id
              ? 'bg-[#111111] text-[#FFFCF4]'
              : 'border border-[#DDDAD3] bg-white text-[#111111]'"
            @click="engagementFilter = opt.id"
          >
            {{ opt.label }}
            <span
              v-if="opt.id === 'proposed' && proposals.length"
              class="ml-1 tabular-nums opacity-70"
            >({{ proposals.length }})</span>
          </button>
        </fieldset>

        <div class="flex flex-wrap items-center gap-4">
          <label class="flex items-center gap-2 text-sm">
            <span class="font-bold text-[#636363]">Affichage</span>
            <select
              v-model="viewMode"
              class="min-h-[42px] rounded-[4px] border border-[#DDDAD3] bg-white px-2.5 py-2 text-sm font-semibold text-[#111111]"
            >
              <option
                v-for="opt in viewOptions"
                :key="opt.id"
                :value="opt.id"
              >
                {{ opt.label }}
              </option>
            </select>
          </label>
          <label
            v-if="showEngagements"
            class="flex items-center gap-2 text-sm"
          >
            <span class="font-bold text-[#636363]">Trier</span>
            <select
              v-model="sort"
              class="min-h-[42px] rounded-[4px] border border-[#DDDAD3] bg-white px-2.5 py-2 text-sm font-semibold text-[#111111]"
            >
              <option value="date">Date</option>
              <option value="category">Thème</option>
            </select>
          </label>
        </div>
      </div>

      <!-- Liste -->
      <div v-if="viewMode === 'list'" class="mt-6 space-y-6">
        <section v-if="showProposals && (hasProposals || engagementFilter === 'proposed')">
          <div class="mb-3 flex items-baseline justify-between gap-3">
            <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">
              Mes propositions
            </h2>
            <button
              type="button"
              class="text-xs font-semibold text-[#6735B6] underline-offset-2 hover:underline"
              @click="refreshProposalsApi()"
            >
              Actualiser
            </button>
          </div>
          <p v-if="proposalsPending" class="text-sm text-[#454545]">Chargement des propositions…</p>
          <p v-else-if="proposalsError" class="text-sm text-[#AD291F]">
            Impossible de charger vos propositions.
            <button type="button" class="underline" @click="refreshProposalsApi()">Réessayer</button>
          </p>
          <EmptyState
            v-else-if="!proposalRows.length"
            title="Aucune proposition ici"
            description="Proposez un événement pour le retrouver sur cet appareil, avec son statut et ses stats une fois publié."
          >
            <NuxtLink to="/proposer">
              <UiButton size="sm">Proposer une manifestation</UiButton>
            </NuxtLink>
          </EmptyState>
          <div v-else class="space-y-2">
            <MyProposalCard
              v-for="row in proposalRows"
              :key="row.id"
              :proposal="row"
            />
          </div>
        </section>

        <section v-if="showEngagements">
          <h2
            v-if="showProposals && hasProposals"
            class="mb-3 text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]"
          >
            Soutiens & participations
          </h2>
          <p v-if="pending" class="text-sm text-[#454545]">Chargement…</p>
          <p v-else-if="error" class="text-sm text-[#AD291F]">
            Impossible de charger vos manifestations.
            <button type="button" class="underline" @click="refreshAll()">Réessayer</button>
          </p>
          <EmptyState
            v-else-if="!pageItems.length && engagementFilter !== 'all'"
            title="Aucun résultat pour ces filtres"
            description="Élargissez la recherche ou changez le type d’engagement."
          />
          <EmptyState
            v-else-if="!pageItems.length && !hasProposals"
            title="Aucun engagement"
            description="Soutenez ou déclarez votre participation depuis une fiche."
          />
          <div v-else-if="pageItems.length" class="space-y-2">
            <EventCard
              v-for="row in pageItems"
              :key="row.event.id"
              :event="row.event"
              :selected="selectedId === row.event.id"
              @select="onSelect(row.event.id)"
            />

            <nav
              v-if="sortedItems.length > pageSize"
              class="mt-6 flex flex-wrap items-center justify-between gap-3 border-t border-[#DDDAD3] pt-4"
              aria-label="Pagination"
            >
              <UiButton
                size="sm"
                variant="outline"
                :disabled="page <= 1"
                @click="page--"
              >
                Précédent
              </UiButton>
              <p class="text-sm font-semibold text-[#454545]">
                Page {{ page }} sur {{ totalPages }}
              </p>
              <UiButton
                size="sm"
                variant="outline"
                :disabled="page >= totalPages"
                @click="page++"
              >
                Suivant
              </UiButton>
            </nav>
          </div>
        </section>
      </div>

      <!-- Agenda mensuel -->
      <div v-else class="relative mt-6">
        <p v-if="pending || proposalsPending" class="mb-3 text-sm text-[#454545]">Chargement de l’agenda…</p>
        <p v-else-if="error" class="mb-3 text-sm text-[#AD291F]">
          Impossible de charger l’agenda.
          <button type="button" class="underline" @click="refreshAll()">Réessayer</button>
        </p>
        <EventsAgendaGrid
          v-model:month="calendarMonth"
          :events="agendaEvents"
          :pending="pending || proposalsPending"
          :selected-id="selectedId"
          @select="onSelect"
        />
        <div
          v-if="previewId"
          class="pointer-events-none fixed inset-x-3 bottom-3 z-40 flex justify-center md:absolute md:inset-x-auto md:bottom-4 md:right-4 md:justify-end"
        >
          <EventPreviewPopover :event-id="previewId" @close="closePreview" />
        </div>
      </div>
    </template>
  </div>
</template>
