<script setup lang="ts">
import { DateTime } from 'luxon'
import type { EventMapPoint, EventPublic } from '#shared/types/event'
import { SEO } from '#shared/content/seo'
import { excerptText } from '#shared/utils/text'

useSiteSeo({
  title: SEO.manifestations.title,
  description: SEO.manifestations.description,
  path: '/manifestations',
})

const { data: citiesData } = await useFetch<{
  items: Array<{ name: string, slug: string }>
}>('/api/cities', {
  query: { limit: 10, upcoming: '1' },
  lazy: true,
  default: () => ({ items: [] }),
})
const topCities = computed(() => citiesData.value?.items ?? [])

type ViewMode = 'list' | 'calendar' | 'map'

const q = ref('')
const category = ref('')
const statuses = ref<string[]>(['upcoming', 'ongoing'])
const selectedId = ref<string | null>(null)
const previewId = ref<string | null>(null)
const viewMode = ref<ViewMode>('list')
const { supportedIds, participatingIds, engagedIds } = useMyEngagements()
const page = ref(1)
const pageSize = 20
const debouncedQ = refDebounced(q, 300)
const calendarMonth = ref(DateTime.now().setZone('Europe/Paris').toFormat('yyyy-MM'))

const filterParams = computed(() => ({
  q: debouncedQ.value || undefined,
  category: category.value || undefined,
  statuses: statuses.value.join(',') || undefined,
}))

const listParams = computed(() => ({
  ...filterParams.value,
  page: page.value,
  pageSize,
}))

const calendarRange = computed(() => {
  const start = DateTime.fromISO(`${calendarMonth.value}-01`, { zone: 'Europe/Paris' }).startOf('month')
  const end = start.endOf('month')
  return {
    dateFrom: start.toUTC().toISO() || undefined,
    dateTo: end.toUTC().toISO() || undefined,
  }
})

const calendarParams = computed(() => ({
  ...filterParams.value,
  ...calendarRange.value,
  page: 1,
  pageSize: 200,
}))

watch(filterParams, () => {
  page.value = 1
  selectedId.value = null
})

const { data, pending, error, refresh } = await useFetch<{
  items: EventPublic[]
  total: number
  page: number
  pageSize: number
}>('/api/events', {
  query: listParams,
  watch: [listParams],
  transform: (res) => ({
    ...res,
    items: (res.items ?? []).map(slimEventForList),
  }),
})

const {
  data: calendarData,
  pending: calendarPending,
  error: calendarError,
  refresh: refreshCalendar,
} = await useFetch<{
  items: EventPublic[]
  total: number
}>('/api/events', {
  query: calendarParams,
  watch: [calendarParams],
  lazy: true,
  immediate: false,
  transform: (res) => ({
    total: res.total ?? 0,
    items: (res.items ?? []).map(slimEventForList),
  }),
})

watch(viewMode, (mode) => {
  if (mode === 'calendar') refreshCalendar()
})

const { data: mapData, pending: mapPending } = await useFetch<{ points: EventMapPoint[] }>('/api/events/map', {
  query: filterParams,
  watch: [filterParams],
  server: false,
  lazy: true,
  default: () => ({ points: [] }),
  transform: (res) => ({
    points: (res.points ?? []).map(p => ({
      id: p.id,
      slug: p.slug,
      title: p.title,
      cityName: p.cityName,
      latitude: p.latitude,
      longitude: p.longitude,
      displayStatus: p.displayStatus,
      startAt: p.startAt,
      category: p.category,
    })),
  }),
})

const totalPages = computed(() => {
  const total = data.value?.total ?? 0
  return Math.max(1, Math.ceil(total / pageSize))
})

const resultCount = computed(() => {
  if (viewMode.value === 'calendar') return calendarData.value?.total ?? null
  return data.value?.total ?? null
})

const agendaEvents = computed(() =>
  (calendarData.value?.items ?? []).map(e => ({
    id: e.id,
    slug: e.slug,
    title: e.title,
    cityName: e.cityName,
    startAt: e.startAt,
    displayStatus: e.displayStatus,
    timezone: e.timezone,
  })),
)

function slimEventForList(event: EventPublic): EventPublic {
  return {
    ...event,
    description: excerptText(event.description || '', 160),
    imageUrls: [],
    videoUrls: [],
    sourceUrl: null,
    organizerName: null,
  }
}

const pendingScrollId = ref<string | null>(null)

function scrollListToEvent(id: string) {
  const el = document.getElementById(`event-${id}`)
  const list = document.getElementById('agenda-list')
  if (el) {
    el.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
  }
  else if (list) {
    list.scrollTop = 0
    list.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
  }
}

function goToPage(next: number) {
  const max = totalPages.value
  page.value = Math.min(max, Math.max(1, next))
  nextTick(() => {
    const list = document.getElementById('agenda-list')
    if (list) {
      list.scrollTop = 0
      list.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }
  })
}

function closePreview() {
  previewId.value = null
}

async function onSelect(id: string) {
  selectedId.value = id
  previewId.value = id

  // Carte / agenda : popover uniquement
  if (viewMode.value === 'calendar' || viewMode.value === 'map') return

  // Mode liste : popover + synchro scroll
  if (data.value?.items?.some(e => e.id === id)) {
    await nextTick()
    scrollListToEvent(id)
    return
  }

  try {
    const res = await $fetch<{ page: number }>('/api/events', {
      query: {
        ...filterParams.value,
        pageSize,
        focusId: id,
      },
    })
    pendingScrollId.value = id
    if (page.value === res.page) {
      pendingScrollId.value = null
      await nextTick()
      scrollListToEvent(id)
    }
    else {
      page.value = res.page
    }
  }
  catch {
    // sélection carte / popover seule
  }
}

watch(viewMode, () => {
  previewId.value = null
})

watch(
  [() => data.value?.items, pending],
  ([items, isPending]) => {
    const id = pendingScrollId.value
    if (!id || isPending) return
    if (!items?.some(e => e.id === id)) return
    pendingScrollId.value = null
    nextTick(() => scrollListToEvent(id))
  },
)

function refDebounced<T>(source: Ref<T>, ms: number) {
  const debounced = ref(source.value) as Ref<T>
  let t: ReturnType<typeof setTimeout> | undefined
  watch(source, (v) => {
    clearTimeout(t)
    t = setTimeout(() => { debounced.value = v }, ms)
  })
  return debounced
}

const viewOptions: Array<{ id: ViewMode, label: string }> = [
  { id: 'list', label: 'Liste' },
  { id: 'calendar', label: 'Agenda' },
  { id: 'map', label: 'Carte' },
]
</script>

<template>
  <div class="container-page scroll-mt-24 py-10 md:py-14">
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Agenda</p>
        <h1 class="mf-display mf-h2 mt-2 text-[#111111]">
          Manifestations
        </h1>
        <p class="mt-3 max-w-xl text-sm text-[#454545] sm:text-base">
          Liste, grille mensuelle ou carte. Filtrez, sélectionnez, ouvrez la fiche.
        </p>
      </div>
      <p v-if="resultCount != null" class="chip bg-[#111111] text-[#FFFCF4]">
        {{ resultCount }} résultat{{ resultCount > 1 ? 's' : '' }}
        <span v-if="viewMode === 'list' && data && data.total > pageSize" class="opacity-70">
          · p. {{ page }}/{{ totalPages }}
        </span>
      </p>
    </div>

    <EventFilters
      v-model:q="q"
      v-model:category="category"
      v-model:statuses="statuses"
    />

    <div
      v-if="topCities.length"
      class="mt-4 flex flex-wrap items-center gap-2 text-sm"
    >
      <span class="text-xs font-bold uppercase tracking-wide text-[#636363]">Villes</span>
      <NuxtLink
        v-for="c in topCities"
        :key="c.slug"
        :to="`/manifestations/ville/${c.slug}`"
        class="rounded-[4px] border border-[#DDDAD3] bg-white px-2.5 py-1 text-xs font-bold text-[#111111] hover:border-[#9C6EE8] hover:text-[#6735B6]"
      >
        {{ c.name }}
      </NuxtLink>
    </div>

    <div class="mt-4 flex gap-2" role="tablist" aria-label="Mode d’affichage">
      <button
        v-for="opt in viewOptions"
        :key="opt.id"
        type="button"
        role="tab"
        class="flex-1 rounded-[4px] px-3 py-2.5 text-sm font-bold sm:flex-none sm:px-4"
        :class="viewMode === opt.id ? 'bg-[#111111] text-[#FFFCF4]' : 'border border-[#DDDAD3] bg-white text-[#111111]'"
        :aria-selected="viewMode === opt.id"
        @click="viewMode = opt.id"
      >
        {{ opt.label }}
      </button>
    </div>

    <!-- Liste (+ carte desktop) -->
    <div
      v-if="viewMode === 'list'"
      id="carte-section"
      class="mt-5 grid scroll-mt-24 gap-5 lg:grid-cols-2 lg:gap-6"
    >
      <div
        id="agenda-list"
        class="-mx-2 max-h-[70vh] space-y-2 overflow-y-auto px-2 pb-3 pt-2"
      >
        <p v-if="pending" class="text-sm text-[#454545]">Chargement de l’agenda…</p>
        <p v-else-if="error" class="text-sm text-[#AD291F]">
          Impossible de charger les manifestations.
          <button type="button" class="underline" @click="refresh()">Réessayer</button>
        </p>
        <EmptyState
          v-else-if="!data?.items?.length"
          title="Aucune manifestation pour ces filtres"
          description="Élargissez votre recherche ou proposez un événement manquant."
        >
          <NuxtLink to="/proposer">
            <UiButton size="sm">Proposer une manifestation</UiButton>
          </NuxtLink>
        </EmptyState>
        <div
          v-for="event in data?.items"
          :id="`event-${event.id}`"
          :key="event.id"
        >
          <EventCard
            :event="event"
            :selected="selectedId === event.id"
            @select="onSelect(event.id)"
          />
        </div>

        <nav
          v-if="data && data.total > pageSize"
          class="flex flex-wrap items-center justify-between gap-3 border-t border-[#DDDAD3] pt-4"
          aria-label="Pagination de l’agenda"
        >
          <UiButton
            size="sm"
            variant="outline"
            :disabled="page <= 1 || pending"
            @click="goToPage(page - 1)"
          >
            Précédent
          </UiButton>
          <p class="text-sm font-semibold text-[#454545]">
            Page {{ page }} sur {{ totalPages }}
          </p>
          <UiButton
            size="sm"
            variant="outline"
            :disabled="page >= totalPages || pending"
            @click="goToPage(page + 1)"
          >
            Suivant
          </UiButton>
        </nav>
      </div>

      <div class="relative hidden h-[55vh] min-h-[320px] w-full md:block lg:h-[70vh]">
        <ClientOnly>
          <div class="relative size-full">
            <EventsMap
              :points="mapData?.points || []"
              :selected-id="selectedId"
              :engaged-ids="engagedIds"
              :supported-ids="supportedIds"
              :participating-ids="participatingIds"
              @select="onSelect"
            />
            <div
              v-if="mapPending && !(mapData?.points?.length)"
              class="absolute inset-0 z-10 flex items-center justify-center bg-[#F4F1EA]/80 text-sm text-[#454545]"
            >
              Chargement de la carte…
            </div>
            <div
              v-if="previewId"
              class="pointer-events-none absolute inset-x-3 bottom-3 z-20 flex justify-center md:inset-x-auto md:bottom-4 md:left-4 md:justify-start"
            >
              <EventPreviewPopover :event-id="previewId" @close="closePreview" />
            </div>
          </div>
          <template #fallback>
            <div class="map-shell flex items-center justify-center text-sm text-[#454545]">
              Chargement de la carte…
            </div>
          </template>
        </ClientOnly>
      </div>
    </div>

    <!-- Grille agenda mensuelle -->
    <div v-else-if="viewMode === 'calendar'" class="relative mt-5">
      <p v-if="calendarError" class="mb-3 text-sm text-[#AD291F]">
        Impossible de charger le mois.
        <button type="button" class="underline" @click="refreshCalendar()">Réessayer</button>
      </p>
      <EventsAgendaGrid
        v-model:month="calendarMonth"
        :events="agendaEvents"
        :pending="calendarPending"
        :selected-id="selectedId"
        @select="onSelect"
      />
      <div
        v-if="previewId"
        class="pointer-events-none fixed inset-x-3 bottom-3 z-40 flex justify-center md:absolute md:inset-x-auto md:bottom-4 md:right-4 md:justify-end"
      >
        <EventPreviewPopover :event-id="previewId" @close="closePreview" />
      </div>
      <p
        v-if="calendarData && calendarData.total > 200"
        class="mt-3 text-xs text-[#805200]"
      >
        Plus de 200 événements ce mois pour ces filtres — seuls les 200 premiers sont affichés.
      </p>
    </div>

    <!-- Carte seule -->
    <div
      v-else
      class="relative mt-5 h-[60vh] min-h-[360px] w-full lg:h-[70vh]"
    >
      <ClientOnly>
        <div class="relative size-full">
          <EventsMap
            :points="mapData?.points || []"
            :selected-id="selectedId"
            :engaged-ids="engagedIds"
            :supported-ids="supportedIds"
            :participating-ids="participatingIds"
            @select="onSelect"
          />
          <div
            v-if="mapPending && !(mapData?.points?.length)"
            class="absolute inset-0 z-10 flex items-center justify-center bg-[#F4F1EA]/80 text-sm text-[#454545]"
          >
            Chargement de la carte…
          </div>
          <div
            v-if="previewId"
            class="pointer-events-none absolute inset-x-3 bottom-3 z-20 flex justify-center md:inset-x-auto md:bottom-4 md:left-4 md:justify-start"
          >
            <EventPreviewPopover :event-id="previewId" @close="closePreview" />
          </div>
        </div>
        <template #fallback>
          <div class="map-shell flex size-full items-center justify-center text-sm text-[#454545]">
            Chargement de la carte…
          </div>
        </template>
      </ClientOnly>
    </div>
  </div>
</template>
