<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { citySeo } from '#shared/content/seo'
import { breadcrumbJsonLd } from '#shared/utils/seo-schema'

const route = useRoute()
const config = useRuntimeConfig()
const slug = computed(() => String(route.params.slug || ''))

const page = ref(1)
const sort = ref<'date' | 'category'>('date')
const draftQ = ref('')
const draftCategory = ref('')
const appliedQ = ref('')
const appliedCategory = ref('')

const { data: citiesData } = await useFetch<{
  items: Array<{ name: string, slug: string }>
}>('/api/cities', {
  query: { limit: 10, upcoming: '1' },
  lazy: true,
  default: () => ({ items: [] }),
})
const popularCities = computed(() =>
  (citiesData.value?.items ?? []).filter(c => c.slug !== slug.value),
)

const listQuery = computed(() => ({
  page: page.value,
  pageSize: 20,
  statuses: 'upcoming,ongoing',
  sort: sort.value,
  q: appliedQ.value || undefined,
  category: appliedCategory.value || undefined,
}))

const { data, error, pending } = await useFetch<{
  city: { name: string, slug: string, total: number, upcoming: number }
  items: EventPublic[]
  total: number
  page: number
  pageSize: number
}>(() => `/api/cities/${slug.value}`, {
  query: listQuery,
  watch: [slug, listQuery],
})

if (error.value || !data.value?.city) {
  throw createError({ statusCode: 404, statusMessage: 'Ville introuvable' })
}

const city = computed(() => data.value!.city)
const items = computed(() => data.value?.items ?? [])
const total = computed(() => data.value?.total ?? 0)
const pageSize = computed(() => data.value?.pageSize ?? 20)
const totalPages = computed(() => Math.max(1, Math.ceil(total.value / pageSize.value)))

const seo = computed(() => citySeo(city.value.name, city.value.upcoming))
const siteUrl = computed(() => String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, ''))

useSiteSeo({
  title: () => seo.value.title,
  description: () => seo.value.description,
  path: () => `/manifestations/ville/${city.value.slug}`,
  jsonLd: () => breadcrumbJsonLd(siteUrl.value, [
    { name: 'Accueil', path: '/' },
    { name: 'Manifestations', path: '/manifestations' },
    { name: city.value.name, path: `/manifestations/ville/${city.value.slug}` },
  ]),
})

const selectedId = ref<string | null>(null)

function applySearch() {
  appliedQ.value = draftQ.value.trim()
  appliedCategory.value = draftCategory.value
  page.value = 1
  selectedId.value = null
}

watch(slug, () => {
  page.value = 1
  selectedId.value = null
})

watch(sort, () => {
  page.value = 1
})
</script>

<template>
  <div class="container-page py-8 md:py-10">
    <nav class="text-xs font-semibold text-[#636363]" aria-label="Fil d’Ariane">
      <ol class="flex flex-wrap items-center gap-1.5">
        <li><NuxtLink to="/" class="hover:text-[#6735B6]">Accueil</NuxtLink></li>
        <li aria-hidden="true">/</li>
        <li><NuxtLink to="/manifestations" class="hover:text-[#6735B6]">Manifestations</NuxtLink></li>
        <li aria-hidden="true">/</li>
        <li class="text-[#111111]">{{ city.name }}</li>
      </ol>
    </nav>

    <header class="mt-5 max-w-3xl">
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Agenda local</p>
      <h1 class="mf-display mf-h2 mt-2 text-[#111111]">
        {{ total }} Manifestation{{ total > 1 ? 's' : '' }} à {{ city.name }}
      </h1>
      <p class="mt-3 text-base leading-relaxed text-[#454545]">
        Retrouvez les rassemblements à venir ou en cours à {{ city.name }} :
        dates, lieux et infos pratiques, avec comptage citoyen.
        Manif’ reste neutre — publier une fiche n’équivaut pas à un soutien éditorial.
      </p>
    </header>

    <div class="mt-6">
      <EventFilters
        v-model:q="draftQ"
        v-model:category="draftCategory"
        :popular-cities="popularCities"
        id-prefix="city-events"
        manual-submit
        @search="applySearch"
      />
    </div>

    <div class="mt-6 flex flex-wrap items-center justify-between gap-3">
      <div class="flex flex-wrap gap-3">
        <NuxtLink to="/manifestations">
          <UiButton size="sm" variant="outline">Tout l’agenda</UiButton>
        </NuxtLink>
        <NuxtLink to="/proposer">
          <UiButton size="sm" variant="outline">Proposer une manif à {{ city.name }}</UiButton>
        </NuxtLink>
      </div>
      <label class="flex shrink-0 items-center gap-2 text-sm">
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

    <div v-if="pending && !items.length" class="mt-10 text-sm text-[#636363]">
      Chargement…
    </div>

    <EmptyState
      v-else-if="!items.length"
      class="mt-10"
      title="Aucune manifestation à venir"
      description="Proposez un événement ou consultez l’agenda national."
    />

    <template v-else>
      <ul class="mt-8 space-y-2">
        <li v-for="ev in items" :key="ev.id">
          <EventCard
            :event="ev"
            :selected="selectedId === ev.id"
            @select="selectedId = ev.id"
          />
        </li>
      </ul>

      <div
        v-if="totalPages > 1"
        class="mt-8 flex items-center justify-between gap-3"
      >
        <UiButton
          size="sm"
          variant="outline"
          :disabled="page <= 1"
          @click="page = Math.max(1, page - 1)"
        >
          Précédent
        </UiButton>
        <p class="text-xs font-semibold text-[#636363]">
          Page {{ page }} / {{ totalPages }}
        </p>
        <UiButton
          size="sm"
          variant="outline"
          :disabled="page >= totalPages"
          @click="page = Math.min(totalPages, page + 1)"
        >
          Suivant
        </UiButton>
      </div>
    </template>
  </div>
</template>
