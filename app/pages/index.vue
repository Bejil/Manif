<script setup lang="ts">
import type { EventMapPoint } from '#shared/types/event'
import { FAQ_ITEMS, SEO } from '#shared/content/seo'
import { useShare } from '../composables/useShare'

useSeoMeta({
  title: SEO.home.title,
  description: SEO.home.description,
  ogTitle: SEO.home.title,
  ogDescription: SEO.home.description,
  ogImage: '/brand/og-default.svg',
})

const homeFilter = { statuses: 'upcoming,ongoing' }

const { data: countData } = await useFetch<{ total: number }>('/api/events', {
  query: { ...homeFilter, page: 1, pageSize: 1 },
  transform: res => ({ total: res.total ?? 0 }),
})

const { data: mapData, pending: mapPending } = await useFetch<{ points: EventMapPoint[] }>('/api/events/map', {
  query: homeFilter,
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

const eventTotal = computed(() => countData.value?.total ?? mapData.value?.points?.length ?? 0)

const previewId = ref<string | null>(null)
const selectedMapId = ref<string | null>(null)
const { supportedIds, participatingIds, engagedIds } = useMyEngagements()
const {
  suggestions,
  visible: suggestionsVisible,
  pending: suggestionsPending,
} = useHomeSuggestions()

function onMapSelect(id: string) {
  selectedMapId.value = id
  previewId.value = id
}

function closePreview() {
  previewId.value = null
}

const openFaq = ref<number | null>(0)

const { share } = useShare()
const shareMsg = ref<string | null>(null)

async function shareSite() {
  const config = useRuntimeConfig()
  const res = await share({
    title: "Manif'",
    text: 'Toutes les manifestations. Toutes les voix. — Agenda citoyen en France.',
    url: config.public.siteUrl,
  })
  if (res.method === 'clipboard') shareMsg.value = 'Lien copié'
  setTimeout(() => { shareMsg.value = null }, 2500)
}

const homeFaq = FAQ_ITEMS.slice(0, 5)

/** Photos Unsplash (licence libre) — 4:3, personnes réelles */
const engagementBlocks = [
  {
    title: 'Je soutiens',
    icon: 'support' as const,
    image: '/images/engagement/support.jpg',
    alt: 'Foule tenant des pancartes lors d’une manifestation',
    text: 'Affirmez votre soutien à un mouvement, même sans être sur place. Annulable à tout moment.',
  },
  {
    title: 'Je participe',
    icon: 'participate' as const,
    image: '/images/engagement/participate.jpg',
    alt: 'Cortège de manifestants dans une rue',
    text: 'Déclarez votre intention avant, ou votre présence pendant. Ce n’est pas un comptage officiel.',
  },
  {
    title: 'Je partage',
    icon: 'share' as const,
    image: '/images/engagement/share.jpg',
    alt: 'Personnes partageant des informations autour d’un écran',
    text: 'Diffusez une fiche, un lien, un créneau calendrier. L’information circule, pas vos données.',
  },
]
</script>

<template>
  <div>
    <!-- HERO AFFICHE : image plein cadre ; contenu dimensionne la hauteur -->
    <section class="relative overflow-hidden border-b border-[#DDDAD3] text-[#FFFCF4]">
      <img
        src="/images/hero-protest.jpg"
        alt=""
        width="1024"
        height="682"
        decoding="async"
        fetchpriority="high"
        class="absolute inset-0 size-full object-cover object-[78%_center]"
        aria-hidden="true"
      >
      <div
        class="pointer-events-none absolute inset-0"
        aria-hidden="true"
        style="background:
          linear-gradient(90deg, rgba(17,17,17,.88) 0%, rgba(17,17,17,.7) 45%, rgba(17,17,17,.28) 100%),
          linear-gradient(180deg, rgba(17,17,17,.35) 0%, transparent 40%, rgba(17,17,17,.4) 100%);"
      />
      <div class="container-page relative z-10 py-12 md:py-16 lg:py-20">
        <div class="animate-fade-up max-w-3xl">
          <p class="text-xs font-bold uppercase tracking-[0.2em] text-[#9C6EE8]">
            Agenda citoyen · France
          </p>
          <h1 class="mf-display mf-h1 mt-4 text-[#FFFCF4]">
            Toutes les<br>
            <HighlightedText tone="violet">manifestations</HighlightedText>.<br>
            Toutes les<br>
            <HighlightedText tone="red">voix</HighlightedText>.
          </h1>
          <p class="mt-6 max-w-lg text-base font-medium leading-relaxed text-[#FFFCF4]/85 sm:text-lg">
            Consultez la carte des manifestations en France, trouvez les informations pratiques
            et déclarez votre soutien ou votre participation, sans créer de compte.
          </p>

          <div class="mt-8 flex flex-wrap gap-3">
            <NuxtLink to="/manifestations">
              <UiButton size="lg" class="!bg-[#FFFCF4] !text-[#111111] hover:!bg-white">
                Explorer les manifestations
              </UiButton>
            </NuxtLink>
            <NuxtLink to="/proposer">
              <UiButton
                size="lg"
                variant="outline"
                class="!border-[#FFFCF4] !text-[#FFFCF4] hover:!bg-[#FFFCF4] hover:!text-[#111111]"
              >
                Proposer une manifestation
              </UiButton>
            </NuxtLink>
          </div>

          <ul class="mt-8 flex flex-wrap gap-x-6 gap-y-2 text-sm font-semibold text-[#FFFCF4]/7">
            <li class="inline-flex items-center gap-2">
              <BrandIcon name="voices" :size="16" /> Neutre
            </li>
            <li class="inline-flex items-center gap-2">
              <BrandIcon name="map" :size="16" /> Sans compte
            </li>
            <li class="inline-flex items-center gap-2">
              <BrandIcon name="share" :size="16" /> Gratuit
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- COMPTEUR + CARTE -->
    <section class="container-page py-10 md:py-14">
      <div class="overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-soft">
        <div class="flex flex-wrap items-end justify-between gap-4 border-b border-[#DDDAD3] px-5 py-5 md:px-6">
          <div>
            <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">En ce moment</p>
            <h2 class="mf-display mf-h2 mt-2 text-[#111111]">
              <span class="tabular-nums">{{ eventTotal }}</span>
              manifestation{{ eventTotal > 1 ? 's' : '' }}
            </h2>
            <p class="mt-2 max-w-xl text-sm text-[#454545]">
              À venir et en cours sur l’agenda. Ouvrez la carte interactive ou explorez la liste complète.
            </p>
          </div>
          <NuxtLink to="/manifestations">
            <UiButton variant="red">
              Voir l’agenda
            </UiButton>
          </NuxtLink>
        </div>

        <div class="relative h-[55vh] min-h-[320px] w-full lg:h-[65vh]">
          <ClientOnly>
            <div class="relative size-full">
              <EventsMap
                :points="mapData?.points || []"
                :selected-id="selectedMapId"
                :engaged-ids="engagedIds"
                :supported-ids="supportedIds"
                :participating-ids="participatingIds"
                @select="onMapSelect"
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
    </section>

    <!-- SUGGESTIONS PERSONNALISÉES -->
    <ClientOnly>
      <section
        v-if="suggestionsVisible || suggestionsPending"
        class="border-t border-[#DDDAD3] bg-[#FFFCF4]"
      >
        <div class="container-page py-10 md:py-14">
          <div class="flex flex-wrap items-end justify-between gap-4">
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#6735B6]">Pour vous</p>
              <h2 class="mf-display mf-h2 mt-2 text-[#111111]">
                Suggestions
              </h2>
              <p class="mt-2 max-w-xl text-sm text-[#454545]">
                Cinq manifestations à venir, proches de celles que vous soutenez ou auxquelles vous participez.
              </p>
            </div>
            <NuxtLink to="/mes-manifestations" class="text-sm font-bold text-[#6735B6] hover:underline">
              Mes manifestations
            </NuxtLink>
          </div>

          <p
            v-if="suggestionsPending && !suggestions.length"
            class="mt-8 text-sm text-[#454545]"
          >
            Chargement des suggestions…
          </p>

          <div
            v-else-if="suggestions.length"
            class="mt-8 flex gap-4 overflow-x-auto pb-2 lg:grid lg:grid-cols-5 lg:overflow-visible lg:pb-0"
          >
            <EventSuggestionCard
              v-for="e in suggestions"
              :key="e.id"
              :event="e"
              class="w-[16.5rem] shrink-0 lg:w-auto"
            />
          </div>
        </div>
      </section>
    </ClientOnly>

    <!-- SOUTENIR ≠ PARTICIPER -->
    <section class="border-y border-[#DDDAD3] bg-[#111111] text-[#FFFCF4]">
      <div class="container-page py-14 md:py-20">
        <div class="max-w-2xl">
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Engagement</p>
          <h2 class="mf-display mf-h2 mt-3">
            Soutenir n’est pas<br>
            forcément <HighlightedText tone="red">participer</HighlightedText>.
          </h2>
          <p class="mt-4 text-[#FFFCF4]/70">
            Deux actions indépendantes. Sans inscription. Sans rappel après l’événement.
            Vous gardez le contrôle.
          </p>
        </div>

        <div class="mt-12 grid gap-6 lg:grid-cols-3 lg:items-stretch">
          <article
            v-for="block in engagementBlocks"
            :key="block.title"
            class="flex h-full flex-col overflow-hidden border border-white/10 bg-[#252525]"
          >
            <div class="aspect-[4/3] shrink-0 overflow-hidden bg-[#111111]">
              <img
                :src="block.image"
                :alt="block.alt"
                width="1200"
                height="900"
                loading="lazy"
                decoding="async"
                class="size-full object-cover object-center"
              >
            </div>
            <div class="flex flex-1 flex-col p-5">
              <div class="flex items-center gap-2">
                <BrandIcon :name="block.icon" :size="22" />
                <h3 class="mf-display text-2xl">{{ block.title }}</h3>
              </div>
              <p class="mt-2 flex-1 text-sm leading-relaxed text-[#FFFCF4]/65">
                {{ block.text }}
              </p>
            </div>
          </article>
        </div>

        <p class="mt-10 max-w-2xl text-sm text-[#FFFCF4]/55">
          Les soutiens et participations reposent sur des déclarations volontaires.
          Ils ne mesurent pas la présence réelle des personnes sur place.
          <NuxtLink to="/comptage" class="font-semibold text-[#9C6EE8] underline">Méthodologie</NuxtLink>
        </p>
      </div>
    </section>

    <!-- CARTE / DÉCOUVRIR -->
    <section class="container-page grid items-center gap-10 py-14 md:grid-cols-2 md:py-20">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Découvrir</p>
        <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
          Une carte pensée<br>pour se retrouver
        </h2>
        <p class="mt-4 text-[#454545]">
          Marqueurs violet (à venir) et rouge (en cours), clusters et filtres conçus pour rester lisibles.
          La carte n’est pas un décor : c’est le cœur du parcours.
        </p>
        <NuxtLink to="/a-propos" class="mt-6 inline-block">
          <UiButton variant="outline">Pourquoi Manif' ?</UiButton>
        </NuxtLink>
      </div>
      <div class="aspect-[4/3] overflow-hidden rounded-[8px] bg-[#F4F1EA] shadow-lift">
        <img
          src="/images/home/discover.jpg"
          alt="Rue parisienne, orientation en ville"
          width="1200"
          height="900"
          loading="lazy"
          decoding="async"
          class="size-full object-cover object-center"
        >
      </div>
    </section>

    <!-- PROPOSER -->
    <section class="bg-[#F0E8FC]">
      <div class="container-page grid items-center gap-10 py-14 md:grid-cols-2 md:py-20">
        <div class="order-2 aspect-[4/3] overflow-hidden rounded-[8px] bg-[#E8D9F8] shadow-lift md:order-1">
          <img
            src="/images/home/propose.jpg"
            alt="Saisie d’une proposition sur un ordinateur"
            width="1200"
            height="900"
            loading="lazy"
            decoding="async"
            class="size-full object-cover object-center"
          >
        </div>
        <div class="order-1 md:order-2">
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#4D257D]">Proposer</p>
          <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
            Une manifestation<br>manque ?
          </h2>
          <p class="mt-4 text-[#454545]">
            Proposez-la en quelques minutes. Vérification e-mail, modération humaine,
            puis publication sur l’agenda et la carte.
          </p>
          <div class="mt-6 flex flex-wrap gap-3">
            <NuxtLink to="/proposer">
              <UiButton>Proposer une manifestation</UiButton>
            </NuxtLink>
            <NuxtLink to="/guide">
              <UiButton variant="ghost">Lire le guide</UiButton>
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- GUIDE -->
    <section class="container-page grid items-center gap-10 py-14 md:grid-cols-2 md:py-16">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Guide</p>
        <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
          Se préparer,<br>pas se mobiliser
        </h2>
        <p class="mt-4 text-[#454545]">
          Trajet, équipement, respect et numéros d’urgence.
          Des repères pratiques — pas un conseil juridique.
        </p>
        <NuxtLink to="/guide" class="mt-6 inline-block">
          <UiButton variant="violet">
            <BrandIcon name="guide" :size="18" />
            Ouvrir le guide
          </UiButton>
        </NuxtLink>
      </div>
      <div class="aspect-[4/3] overflow-hidden rounded-[8px] bg-[#F4F1EA] shadow-lift">
        <img
          src="/images/home/guide.jpg"
          alt="Public attentif lors d’une prise d’information"
          width="1200"
          height="900"
          loading="lazy"
          decoding="async"
          class="size-full object-cover object-center"
        >
      </div>
    </section>

    <!-- FAQ -->
    <section class="border-t border-[#DDDAD3] bg-[#F4F1EA]">
      <div class="container-page py-14 md:py-16">
        <div class="flex flex-wrap items-end justify-between gap-4">
          <div>
            <h2 class="mf-display mf-h2 text-[#111111]">Questions fréquentes</h2>
            <p class="mt-2 text-[#454545]">Les réponses utiles avant de consulter ou de proposer.</p>
          </div>
          <NuxtLink to="/faq" class="text-sm font-bold text-[#6735B6] hover:underline">
            Toute la FAQ
          </NuxtLink>
        </div>
        <div class="mt-8 divide-y divide-[#DDDAD3] overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-soft">
          <div v-for="(item, i) in homeFaq" :key="item.q">
            <button
              type="button"
              class="flex w-full items-start justify-between gap-4 px-5 py-4 text-left transition hover:bg-[#FFFCF4]"
              :aria-expanded="openFaq === i"
              @click="openFaq = openFaq === i ? null : i"
            >
              <span class="font-bold text-[#111111]">{{ item.q }}</span>
              <span class="shrink-0 text-lg text-[#636363]" aria-hidden="true">{{ openFaq === i ? '−' : '+' }}</span>
            </button>
            <div v-if="openFaq === i" class="space-y-3 px-5 pb-4 text-sm leading-relaxed text-[#454545]">
              <p v-for="(para, pi) in item.a.split('\n\n')" :key="pi">
                {{ para }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA FINAL -->
    <section class="bg-[#111111] text-[#FFFCF4]">
      <div class="container-page flex flex-col items-start gap-6 py-14 md:flex-row md:items-center md:justify-between">
        <div class="max-w-xl">
          <h2 class="mf-display mf-h3">
            Faites circuler<br>l’information
          </h2>
          <p class="mt-3 text-sm text-[#FFFCF4]/70">
            Partagez Manif' autour de vous. Plus l’agenda est complet, plus il est utile.
          </p>
        </div>
        <div class="flex flex-wrap gap-3">
          <UiButton variant="red" @click="shareSite">
            <BrandIcon name="share" :size="16" />
            Partager Manif'
          </UiButton>
          <NuxtLink to="/soutenir">
            <UiButton
              variant="outline"
              class="!border-[#FFFCF4]/40 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10"
            >
              Soutenir le projet
            </UiButton>
          </NuxtLink>
          <span v-if="shareMsg" class="self-center text-sm text-[#9C6EE8]">{{ shareMsg }}</span>
        </div>
      </div>
    </section>
  </div>
</template>
