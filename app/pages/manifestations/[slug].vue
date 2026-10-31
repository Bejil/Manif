<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { REPORT_REASONS } from '#shared/constants/statuses'
import { createCitySlug } from '#shared/utils/city-slug'
import { breadcrumbJsonLd, eventJsonLd } from '#shared/utils/seo-schema'

const route = useRoute()
const config = useRuntimeConfig()
const slug = computed(() => route.params.slug as string)

const { data: event, error } = await useFetch<EventPublic>(() => `/api/events/${slug.value}`)

if (error.value || !event.value) {
  throw createError({ statusCode: 404, statusMessage: 'Manifestation introuvable' })
}

const { formatDate, formatTimeRange, categoryLabel } = useEventFormat()

const siteUrl = computed(() =>
  String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, ''),
)

const eventShareUrl = computed(
  () => `${siteUrl.value}/manifestations/${event.value!.slug}`,
)

const cityPath = computed(
  () => `/manifestations/ville/${createCitySlug(event.value!.cityName)}`,
)

const ogImage = computed(() => {
  const first = event.value?.imageUrls?.[0]
  if (first) return first
  return `/api/og/event/${event.value!.slug}`
})

useSiteSeo({
  title: () => `${event.value!.title} — ${event.value!.cityName} | Manif'`,
  description: () => {
    const e = event.value!
    const date = formatDate(e.startAt, e.timezone)
    const excerpt = e.description.replace(/\s+/g, ' ').trim().slice(0, 110)
    return `${e.cityName} · ${date}. ${excerpt}${excerpt.length >= 110 ? '…' : ''}`
  },
  path: () => `/manifestations/${event.value!.slug}`,
  ogImage: () => ogImage.value,
  jsonLd: () => [
    eventJsonLd(siteUrl.value, event.value!),
    breadcrumbJsonLd(siteUrl.value, [
      { name: 'Accueil', path: '/' },
      { name: 'Manifestations', path: '/manifestations' },
      { name: event.value!.cityName, path: cityPath.value },
      { name: event.value!.title, path: `/manifestations/${event.value!.slug}` },
    ]),
  ],
})

const reportOpen = ref(false)
const reportReason = ref('')
const reportDetails = ref('')
const reportOk = ref(false)
const reportError = ref<string | null>(null)
const reportTurnstile = ref('')
const reportTurnstileRef = ref<{ reset: () => void } | null>(null)

const reportReasonOptions = [
  { value: '', label: 'Choisir un motif' },
  ...REPORT_REASONS.map(r => ({ value: r.id, label: r.label })),
]

const mapPoint = computed(() => {
  const e = event.value
  if (!e || e.mapLatitude == null || e.mapLongitude == null || e.mapPrecision === 'none') {
    return null
  }
  return {
    latitude: e.mapLatitude,
    longitude: e.mapLongitude,
    label: e.locationRevealed ? e.locationName : e.cityName,
    zoom: e.mapPrecision === 'city' ? 11 : 14,
    cityOnly: e.mapPrecision === 'city',
  }
})

onMounted(() => {
  if (!import.meta.client || !event.value) return
  const key = `manif:viewed:${event.value.id}`
  try {
    if (sessionStorage.getItem(key)) return
    sessionStorage.setItem(key, '1')
  }
  catch {
    /* private mode */
  }
  void $fetch(`/api/events/${event.value.id}/views`, { method: 'POST' }).catch(() => {})
})

async function submitReport() {
  reportError.value = null
  if (!reportReason.value) {
    reportError.value = 'Choisissez un motif'
    return
  }
  try {
    await $fetch(`/api/events/${event.value!.id}/reports`, {
      method: 'POST',
      body: {
        reason: reportReason.value,
        details: reportDetails.value,
        turnstileToken: reportTurnstile.value || undefined,
      },
    })
    reportOk.value = true
    reportOpen.value = false
    reportReason.value = ''
    reportDetails.value = ''
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    reportError.value = err?.data?.statusMessage || 'Envoi impossible'
    reportTurnstileRef.value?.reset()
  }
}
</script>

<template>
  <div v-if="event">
    <PageHero compact>
      <nav class="mb-6 text-sm text-[#FFFCF4]/60" aria-label="Fil d’Ariane">
        <NuxtLink to="/" class="font-medium hover:text-[#9C6EE8]">Accueil</NuxtLink>
        <span aria-hidden="true"> / </span>
        <NuxtLink to="/manifestations" class="font-medium hover:text-[#9C6EE8]">Agenda</NuxtLink>
        <span aria-hidden="true"> / </span>
        <NuxtLink :to="cityPath" class="font-medium hover:text-[#9C6EE8]">{{ event.cityName }}</NuxtLink>
      </nav>

      <div class="flex flex-wrap items-center gap-2">
        <StatusBadge :status="event.displayStatus" />
        <span
          v-if="!event.startAt"
          class="chip bg-[#805200] text-[#FFFCF4]"
        >Date à venir</span>
        <span class="chip bg-white/10 text-[#FFFCF4]/80">{{ categoryLabel(event.category) }}</span>
      </div>

      <p class="mt-5 inline-block">
        <HighlightedText :tone="event.startAt ? 'red' : 'violet'">
          {{ formatDate(event.startAt, event.timezone) }}
        </HighlightedText>
      </p>

      <h1 class="mf-display mf-h2 mt-4 max-w-4xl text-[#FFFCF4]">
        {{ event.title }}
      </h1>

      <p class="mt-4 flex flex-wrap items-center gap-x-5 gap-y-2 text-[#FFFCF4]/75">
        <span class="inline-flex items-center gap-1.5">
          <BrandIcon name="map" :size="16" />
          <template v-if="event.locationRevealed">
            {{ event.locationName }}, {{ event.cityName }}
          </template>
          <template v-else>
            Localisation à venir · {{ event.cityName }}
          </template>
        </span>
        <span class="inline-flex items-center gap-1.5">
          <BrandIcon name="calendar" :size="16" />
          {{ formatTimeRange(event.startAt, event.endAt, event.endIsEstimated, event.timezone) }}
        </span>
      </p>
      <p
        v-if="!event.locationRevealed"
        class="mt-3 max-w-2xl text-sm text-[#FFFCF4]/65"
      >
        Le lieu précis sera communiqué avant le début de la manifestation.
        La ville reste affichée pour vous situer.
      </p>
      <p
        v-else-if="event.latitude == null || event.longitude == null"
        class="mt-3 max-w-2xl text-sm text-[#FFFCF4]/65"
      >
        Lieu indiqué — position sur la carte à venir.
      </p>

      <EventActionsBar
        class="mt-8"
        dark
        :event-id="event.id"
        :title="event.title"
        :city-name="event.cityName"
        :share-url="eventShareUrl"
        :show-calendar="Boolean(event.startAt)"
        @report="reportOpen = true"
      />
    </PageHero>

    <div class="container-page grid gap-8 py-8 lg:grid-cols-[1fr_22rem] lg:gap-10">
      <article>
        <div class="surface-card grid gap-4 p-5 sm:grid-cols-2">
          <div>
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Horaire</p>
            <p class="mt-1 font-semibold text-[#111111]">
              {{ formatTimeRange(event.startAt, event.endAt, event.endIsEstimated, event.timezone) }}
            </p>
          </div>
          <div>
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Ville</p>
            <p class="mt-1 font-semibold text-[#111111]">
              <NuxtLink :to="cityPath" class="hover:text-[#6735B6] hover:underline">
                {{ event.cityName }}
              </NuxtLink>
            </p>
          </div>
          <div v-if="event.organizerName">
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Organisateur</p>
            <p class="mt-1 font-semibold text-[#111111]">{{ event.organizerName }}</p>
          </div>
          <div v-if="event.sourceUrl" class="sm:col-span-2">
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Source</p>
            <a
              :href="event.sourceUrl"
              class="mt-1 inline-block break-all text-sm font-semibold text-[#6735B6] hover:underline"
              rel="noopener noreferrer"
              target="_blank"
            >{{ event.sourceUrl }}</a>
          </div>
        </div>

        <EventMediaGallery
          :image-urls="event.imageUrls || []"
          :video-urls="event.videoUrls || []"
          :title="event.title"
        />

        <div class="prose-manif mt-8 whitespace-pre-wrap">
          {{ event.description }}
        </div>

        <div v-if="mapPoint" class="mt-8">
          <p class="mb-3 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
            {{ mapPoint.cityOnly ? 'Ville sur la carte' : 'Lieu sur la carte' }}
          </p>
          <ClientOnly>
            <EventLocationMap
              :latitude="mapPoint.latitude"
              :longitude="mapPoint.longitude"
              :label="mapPoint.label"
              :zoom="mapPoint.zoom"
            />
            <template #fallback>
              <div class="map-shell flex min-h-[280px] items-center justify-center text-sm text-[#454545] md:min-h-[340px]">
                Chargement de la carte…
              </div>
            </template>
          </ClientOnly>
          <p v-if="mapPoint.cityOnly" class="mt-2 text-sm text-[#454545]">
            Le point de rendez-vous précis sera indiqué avant le début — la carte est centrée sur {{ event.cityName }}.
          </p>
        </div>

        <EventActionsBar
          class="mt-8"
          :event-id="event.id"
          :title="event.title"
          :city-name="event.cityName"
          :share-url="eventShareUrl"
          :show-calendar="Boolean(event.startAt)"
          @report="reportOpen = true"
        />
        <p v-if="reportOk" class="mt-3 text-sm font-semibold text-[#206C4D]" role="status">Signalement envoyé. Merci.</p>
      </article>

      <aside
        id="event-engagement-panel"
        class="scroll-mt-24 space-y-4 lg:sticky lg:top-24 lg:self-start"
      >
        <ParticipationPanel :event="event" />
      </aside>
    </div>

    <UiModal :open="reportOpen" title="Signaler une erreur" @close="reportOpen = false">
      <form class="space-y-4" @submit.prevent="submitReport">
        <UiSelect
          id="report-reason"
          v-model="reportReason"
          label="Motif"
          required
          :options="reportReasonOptions"
        />
        <UiTextarea
          id="report-details"
          v-model="reportDetails"
          label="Précisions (optionnel)"
          hint="Si renseignées, 10 caractères minimum."
          :rows="3"
        />
        <TurnstileWidget ref="reportTurnstileRef" v-model="reportTurnstile" action="report" />
        <p v-if="reportError" class="text-sm text-[#AD291F]">{{ reportError }}</p>
        <div class="flex justify-end gap-2">
          <UiButton type="button" variant="ghost" @click="reportOpen = false">Annuler</UiButton>
          <UiButton type="submit">Envoyer</UiButton>
        </div>
      </form>
    </UiModal>
  </div>
</template>
