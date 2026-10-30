<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { citySeo } from '#shared/content/seo'
import { breadcrumbJsonLd } from '#shared/utils/seo-schema'

const route = useRoute()
const config = useRuntimeConfig()
const slug = computed(() => String(route.params.slug || ''))

const page = ref(1)

const { data, error, pending } = await useFetch<{
  city: { name: string, slug: string, total: number, upcoming: number }
  items: EventPublic[]
  total: number
  page: number
  pageSize: number
}>(() => `/api/cities/${slug.value}`, {
  query: computed(() => ({
    page: page.value,
    pageSize: 20,
    statuses: 'upcoming,ongoing,past,cancelled,postponed',
  })),
  watch: [slug, page],
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

const upcomingItems = computed(() =>
  items.value.filter(e => e.displayStatus === 'upcoming' || e.displayStatus === 'ongoing'),
)
const otherItems = computed(() =>
  items.value.filter(e => e.displayStatus !== 'upcoming' && e.displayStatus !== 'ongoing'),
)

const selectedId = ref<string | null>(null)

watch(slug, () => {
  page.value = 1
  selectedId.value = null
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
        Manifestations à {{ city.name }}
      </h1>
      <p class="mt-3 text-base leading-relaxed text-[#454545]">
        Retrouvez les rassemblements publiés à {{ city.name }} :
        dates, lieux et infos pratiques, avec carte et comptage citoyen.
        Manif’ reste neutre — publier une fiche n’équivaut pas à un soutien éditorial.
      </p>
      <p class="mt-2 text-sm font-semibold text-[#636363]">
        <template v-if="city.upcoming > 0">
          {{ city.upcoming }} à venir ou en cours
          <span class="font-medium text-[#636363]">· {{ city.total }} au total</span>
        </template>
        <template v-else>
          {{ city.total }} manifestation{{ city.total > 1 ? 's' : '' }} référencée{{ city.total > 1 ? 's' : '' }}
        </template>
      </p>
    </header>

    <div class="mt-8 flex flex-wrap gap-3">
      <NuxtLink to="/manifestations">
        <UiButton size="sm" variant="outline">Tout l’agenda</UiButton>
      </NuxtLink>
      <NuxtLink to="/proposer">
        <UiButton size="sm" variant="outline">Proposer une manif à {{ city.name }}</UiButton>
      </NuxtLink>
    </div>

    <div v-if="pending && !items.length" class="mt-10 text-sm text-[#636363]">
      Chargement…
    </div>

    <EmptyState
      v-else-if="!items.length"
      class="mt-10"
      title="Aucune manifestation listée"
      description="Proposez un événement ou consultez l’agenda national."
    />

    <template v-else>
      <section v-if="upcomingItems.length" class="mt-10">
        <h2 class="text-sm font-extrabold uppercase tracking-wide text-[#111111]">
          À venir et en cours
        </h2>
        <ul class="mt-3 space-y-2">
          <li v-for="ev in upcomingItems" :key="ev.id">
            <EventCard
              :event="ev"
              :selected="selectedId === ev.id"
              @select="selectedId = ev.id"
            />
          </li>
        </ul>
      </section>

      <section v-if="otherItems.length" class="mt-10">
        <h2 class="text-sm font-extrabold uppercase tracking-wide text-[#111111]">
          Passées, reportées ou annulées
        </h2>
        <ul class="mt-3 space-y-2">
          <li v-for="ev in otherItems" :key="ev.id">
            <EventCard
              :event="ev"
              :selected="selectedId === ev.id"
              @select="selectedId = ev.id"
            />
          </li>
        </ul>
      </section>

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
