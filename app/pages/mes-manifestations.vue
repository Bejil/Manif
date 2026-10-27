<script setup lang="ts">
import { DateTime } from 'luxon'
import type { EventPublic } from '#shared/types/event'
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.mesManifestations.title,
  description: SEO.mesManifestations.description,
  ogTitle: SEO.mesManifestations.title,
  ogDescription: SEO.mesManifestations.description,
  robots: 'noindex',
})

type EngagementFilter = 'all' | 'supported' | 'participating'
type SortKey = 'date-asc' | 'date-desc' | 'title'
type ViewMode = 'list' | 'calendar'

const {
  entries,
  supportedIds,
  participatingIds,
  engagedIds,
  refresh,
} = useMyEngagements()

const q = ref('')
const category = ref('')
const statuses = ref<string[]>(['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'])
const engagementFilter = ref<EngagementFilter>('all')
const sortKey = ref<SortKey>('date-asc')
const viewMode = ref<ViewMode>('list')
const page = ref(1)
const pageSize = 20
const debouncedQ = refDebounced(q, 300)
const selectedId = ref<string | null>(null)
const previewId = ref<string | null>(null)
const calendarMonth = ref(DateTime.now().setZone('Europe/Paris').toFormat('yyyy-MM'))

const filteredLocalIds = computed(() => {
  if (engagementFilter.value === 'supported') return supportedIds.value
  if (engagementFilter.value === 'participating') return participatingIds.value
  return engagedIds.value
})

const listParams = computed(() => {
  if (!filteredLocalIds.value.length) return null
  return {
    q: debouncedQ.value || undefined,
    category: category.value || undefined,
    statuses: statuses.value.join(',') || undefined,
    ids: filteredLocalIds.value.join(','),
    page: 1,
    pageSize: 200,
  }
})

watch([engagementFilter, debouncedQ, category, statuses], () => {
  page.value = 1
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

onMounted(() => {
  refresh()
})

const sortedItems = computed(() => {
  const items = [...(data.value?.items ?? [])]
  const byId = new Map(entries.value.map(e => [e.eventId, e]))
  const allowed = new Set(filteredLocalIds.value)
  const filtered = items.filter(e => allowed.has(e.id))

  filtered.sort((a, b) => {
    if (sortKey.value === 'title') {
      return a.title.localeCompare(b.title, 'fr', { sensitivity: 'base' })
    }
    const da = a.startAt || ''
    const db = b.startAt || ''
    if (sortKey.value === 'date-desc') return db.localeCompare(da)
    return da.localeCompare(db) || a.title.localeCompare(b.title, 'fr')
  })

  return filtered.map(e => ({
    event: e,
    mine: byId.get(e.id) || null,
  }))
})

const totalPages = computed(() =>
  Math.max(1, Math.ceil(sortedItems.value.length / pageSize)),
)

const pageItems = computed(() => {
  const start = (page.value - 1) * pageSize
  return sortedItems.value.slice(start, start + pageSize)
})

const agendaEvents = computed(() =>
  sortedItems.value.map(({ event: e }) => ({
    id: e.id,
    slug: e.slug,
    title: e.title,
    cityName: e.cityName,
    startAt: e.startAt,
    displayStatus: e.displayStatus,
    timezone: e.timezone,
  })),
)

watch(totalPages, (max) => {
  if (page.value > max) page.value = max
})

function onSelect(id: string) {
  selectedId.value = id
  previewId.value = id
}

function closePreview() {
  previewId.value = null
}

function refDebounced<T>(source: Ref<T>, ms: number) {
  const debounced = ref(source.value) as Ref<T>
  let t: ReturnType<typeof setTimeout> | undefined
  watch(source, (v) => {
    clearTimeout(t)
    t = setTimeout(() => { debounced.value = v }, ms)
  })
  return debounced
}
</script>

<template>
  <div class="container-page py-10 md:py-14">
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Sans compte</p>
        <h1 class="mf-display mf-h2 mt-2 text-[#111111]">Mes manifestations</h1>
        <p class="mt-3 max-w-xl text-sm text-[#454545] sm:text-base">
          Soutiens et participations enregistrés sur cet appareil.
          Filtrez, triez, ou ouvrez votre agenda mensuel.
        </p>
      </div>
      <div class="flex flex-wrap items-center gap-2">
        <p class="chip bg-[#111111] text-[#FFFCF4]">
          {{ sortedItems.length }} résultat{{ sortedItems.length > 1 ? 's' : '' }}
        </p>
        <UiButton
          v-if="engagedIds.length"
          size="sm"
          :variant="viewMode === 'calendar' ? 'red' : 'outline'"
          @click="viewMode = viewMode === 'calendar' ? 'list' : 'calendar'"
        >
          {{ viewMode === 'calendar' ? 'Voir la liste' : 'Mon agenda' }}
        </UiButton>
      </div>
    </div>

    <EmptyState
      v-if="!engagedIds.length"
      title="Aucun engagement pour l’instant"
      description="Soutenez ou déclarez votre participation depuis une fiche ou la carte — vos choix restent sur cet appareil."
    >
      <NuxtLink to="/manifestations">
        <UiButton size="sm">Explorer les manifestations</UiButton>
      </NuxtLink>
    </EmptyState>

    <template v-else>
      <EventFilters
        v-model:q="q"
        v-model:category="category"
        v-model:statuses="statuses"
      />

      <div class="mt-4 flex flex-wrap gap-3">
        <fieldset class="flex flex-wrap gap-2">
          <legend class="sr-only">Type d’engagement</legend>
          <button
            v-for="opt in [
              { id: 'all' as const, label: 'Tous' },
              { id: 'supported' as const, label: 'Je soutiens' },
              { id: 'participating' as const, label: 'Je participe' },
            ]"
            :key="opt.id"
            type="button"
            class="rounded-[4px] px-3 py-2 text-sm font-bold"
            :class="engagementFilter === opt.id
              ? 'bg-[#111111] text-[#FFFCF4]'
              : 'border border-[#DDDAD3] bg-white text-[#111111]'"
            @click="engagementFilter = opt.id"
          >
            {{ opt.label }}
          </button>
        </fieldset>

        <label
          v-if="viewMode === 'list'"
          class="ml-auto flex items-center gap-2 text-sm"
        >
          <span class="font-bold text-[#636363]">Trier</span>
          <select
            v-model="sortKey"
            class="rounded-[4px] border border-[#DDDAD3] bg-white px-2 py-2 text-sm font-semibold text-[#111111]"
          >
            <option value="date-asc">Date (croissant)</option>
            <option value="date-desc">Date (décroissant)</option>
            <option value="title">Titre</option>
          </select>
        </label>
      </div>

      <!-- Liste -->
      <div v-if="viewMode === 'list'" class="mt-6 space-y-3">
        <p v-if="pending" class="text-sm text-[#454545]">Chargement…</p>
        <p v-else-if="error" class="text-sm text-[#AD291F]">
          Impossible de charger vos manifestations.
          <button type="button" class="underline" @click="refreshList()">Réessayer</button>
        </p>
        <EmptyState
          v-else-if="!pageItems.length"
          title="Aucun résultat pour ces filtres"
          description="Élargissez les statuts ou le type d’engagement."
        />
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

      <!-- Agenda mensuel -->
      <div v-else class="relative mt-6">
        <p v-if="pending" class="mb-3 text-sm text-[#454545]">Chargement de l’agenda…</p>
        <p v-else-if="error" class="mb-3 text-sm text-[#AD291F]">
          Impossible de charger l’agenda.
          <button type="button" class="underline" @click="refreshList()">Réessayer</button>
        </p>
        <EventsAgendaGrid
          v-model:month="calendarMonth"
          :events="agendaEvents"
          :pending="pending"
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
