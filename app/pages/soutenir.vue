<script setup lang="ts">
import { SEO } from '#shared/content/seo'
import { resolveKofiConfig } from '#shared/utils/kofi'

const config = useRuntimeConfig()
const siteUrl = computed(() => String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, ''))

const kofi = computed(() => resolveKofiConfig({
  username: String(config.public.kofiUsername || ''),
  url: String(config.public.kofiUrl || ''),
}))
const kofiConfigured = computed(() => Boolean(kofi.value))

const beneficiaryName = computed(() =>
  (config.public.legalEditorName as string)?.trim()
  || 'le créateur indépendant de Manif\'',
)

useSeoMeta({
  title: SEO.soutenir.title,
  description: SEO.soutenir.description,
  ogTitle: SEO.soutenir.title,
  ogDescription: SEO.soutenir.description,
  ogUrl: () => `${siteUrl.value}/soutenir`,
  ogImage: '/brand/og-default.svg',
  twitterCard: 'summary_large_image',
})

useHead({
  link: [{ rel: 'canonical', href: `${siteUrl.value}/soutenir` }],
})

const reasons = [
  {
    title: 'Hébergement & services',
    text: 'Serveurs, base de données, e-mails et outils cartographiques nécessaires au fonctionnement quotidien.',
  },
  {
    title: 'Maintenance',
    text: 'Corrections, sécurité, mises à jour et suivi de la qualité des informations publiées.',
  },
  {
    title: 'Développement',
    text: 'Nouvelles fonctionnalités utiles à l’agenda, à la carte et à l’expérience citoyenne.',
  },
  {
    title: 'Gratuité',
    text: 'Conserver un service public sans compte obligatoire et sans publicité ciblée.',
  },
]

const pledges = [
  {
    title: 'Indépendance',
    text: 'Les contributions financières ne donnent aucun contrôle sur les manifestations référencées.',
  },
  {
    title: 'Gratuité',
    text: 'Toutes les fonctionnalités publiques restent gratuites, que vous contribuiez ou non.',
  },
  {
    title: 'Neutralité',
    text: 'Une contribution finance la plateforme — pas un mouvement, un parti, un syndicat ou une revendication.',
  },
]
</script>

<template>
  <div>
    <!-- HERO -->
    <section class="relative overflow-hidden border-b border-[#DDDAD3] text-[#FFFCF4]">
      <img
        src="/images/hero-protest.jpg"
        alt=""
        width="1024"
        height="682"
        decoding="async"
        fetchpriority="high"
        class="absolute inset-0 size-full object-cover object-[70%_center]"
        aria-hidden="true"
      >
      <div
        class="pointer-events-none absolute inset-0"
        aria-hidden="true"
        style="background:
          linear-gradient(90deg, rgba(17,17,17,.9) 0%, rgba(17,17,17,.72) 48%, rgba(17,17,17,.35) 100%),
          linear-gradient(180deg, rgba(17,17,17,.4) 0%, transparent 40%, rgba(17,17,17,.5) 100%);"
      />
      <div class="container-page relative z-10 py-14 md:py-20">
        <p class="text-xs font-bold uppercase tracking-[0.2em] text-[#9C6EE8]">
          Contribution volontaire
        </p>
        <h1 class="mf-display mf-h1 mt-4 max-w-4xl text-[#FFFCF4]">
          Manif' est gratuit.<br>
          Aidez-nous à le<br>
          <HighlightedText tone="violet">garder accessible</HighlightedText>.
        </h1>
        <p class="mt-6 max-w-2xl text-base font-medium leading-relaxed text-[#FFFCF4]/85 sm:text-lg">
          Manif' est un projet indépendant qui permet de découvrir les manifestations partout en France,
          de partager les informations et de rendre visibles les soutiens et les participations déclarées.
        </p>
        <div class="mt-8">
          <KofiDonateButton />
        </div>
        <p
          v-if="!kofiConfigured"
          class="mt-4 max-w-xl text-sm text-[#FFFCF4]/65"
        >
          Le lien de contribution n’est pas encore activé. Vous pouvez déjà
          <NuxtLink to="/" class="font-semibold text-[#9C6EE8] underline">partager Manif'</NuxtLink>
          autour de vous.
        </p>
      </div>
    </section>

    <!-- DISTINCTION -->
    <section class="border-b border-[#DDDAD3] bg-[#F4F1EA]">
      <div class="container-page flex flex-col gap-4 py-6 sm:flex-row sm:items-center sm:justify-between md:py-8">
        <p class="max-w-3xl text-sm leading-relaxed text-[#454545]">
          <strong class="text-[#111111]">À ne pas confondre :</strong>
          « Je soutiens » sur une fiche concerne un mouvement.
          « Soutenir Manif' » finance uniquement le fonctionnement de la plateforme.
          Ces deux actions sont indépendantes et ne partagent aucune donnée.
        </p>
        <KofiDonateButton />
      </div>
    </section>

    <!-- POURQUOI -->
    <section class="container-page py-14 md:py-20">
      <div class="max-w-2xl">
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Pourquoi contribuer ?</p>
        <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
          Faire vivre un outil<br>citoyen indépendant
        </h2>
        <p class="mt-4 text-[#454545]">
          Les contributions volontaires aident à financer le fonctionnement et le développement de Manif'.
          Elles participent notamment à :
        </p>
      </div>

      <div class="mt-10 grid gap-4 sm:grid-cols-2">
        <article
          v-for="item in reasons"
          :key="item.title"
          class="border border-[#DDDAD3] bg-white p-5 shadow-soft"
        >
          <h3 class="text-base font-extrabold text-[#111111]">{{ item.title }}</h3>
          <p class="mt-2 text-sm leading-relaxed text-[#454545]">{{ item.text }}</p>
        </article>
      </div>

      <p class="mt-8 max-w-2xl text-sm text-[#636363]">
        Manif' ne promet pas d’affecter chaque euro à une dépense isolée : les contributions
        soutiennent l’ensemble du projet (fonctionnement, maintenance et évolution).
      </p>
      <div class="mt-6">
        <KofiDonateButton />
      </div>
    </section>

    <!-- CONTRIBUTION LIBRE -->
    <section class="bg-[#111111] text-[#FFFCF4]">
      <div class="container-page grid items-center gap-10 py-14 md:grid-cols-2 md:py-20">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Contribution libre</p>
          <h2 class="mf-display mf-h2 mt-3">
            Aucun montant<br>imposé
          </h2>
          <p class="mt-4 text-[#FFFCF4]/75">
            Il n’y a aucun montant imposé. Chacun peut contribuer selon ses moyens et ses envies.
            Le montant se choisit sur Ko-fi.
          </p>
          <div class="mt-8">
            <KofiDonateButton />
          </div>
          <p
            v-if="kofiConfigured"
            class="mt-3 text-xs text-[#FFFCF4]/55"
          >
            Vous quittez Manif' pour la plateforme externe Ko-fi.
          </p>
          <p
            v-else
            class="mt-3 rounded-[4px] border border-white/15 bg-white/5 px-3 py-2 text-xs text-[#FFFCF4]/70"
          >
            Configuration requise :
            <code class="rounded bg-white/10 px-1">NUXT_PUBLIC_KOFI_USERNAME</code>
            — voir
            <code class="rounded bg-white/10 px-1">docs/KOFI.md</code>.
          </p>
        </div>
        <div class="aspect-[4/3] overflow-hidden rounded-[8px] bg-[#252525] shadow-lift">
          <img
            src="/images/home/propose.jpg"
            alt="Personne travaillant sur un ordinateur"
            width="1200"
            height="900"
            loading="lazy"
            decoding="async"
            class="size-full object-cover object-center opacity-90"
          >
        </div>
      </div>
    </section>

    <!-- TRANSPARENCE -->
    <section class="container-page py-14 md:py-20">
      <div class="max-w-2xl">
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Transparence</p>
        <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
          Trois engagements<br>clairs
        </h2>
      </div>
          <div class="mt-10 grid gap-6 lg:grid-cols-3">
        <article
          v-for="(p, i) in pledges"
          :key="p.title"
          class="flex flex-col border-t-4 bg-[#F4F1EA] p-6"
          :class="i === 0 ? 'border-t-[#9C6EE8]' : i === 1 ? 'border-t-[#D1271C]' : 'border-t-[#111111]'"
        >
          <h3 class="mf-display text-2xl text-[#111111]">{{ p.title }}</h3>
          <p class="mt-3 flex-1 text-sm leading-relaxed text-[#454545]">{{ p.text }}</p>
        </article>
      </div>
      <div class="mt-8">
        <KofiDonateButton />
      </div>
    </section>

    <!-- BÉNÉFICIAIRE -->
    <section class="border-y border-[#DDDAD3] bg-[#F0E8FC]">
      <div class="container-page py-14 md:py-16">
        <div class="max-w-3xl">
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#4D257D]">Bénéficiaire</p>
          <h2 class="mf-display mf-h2 mt-3 text-[#111111]">
            Qui reçoit les contributions ?
          </h2>
          <div class="prose-manif mt-6 text-[#454545]">
            <p>
              Les contributions via Ko-fi sont destinées à
              <strong>{{ beneficiaryName }}</strong>,
              personne physique portant le projet à titre indépendant —
              et non à une association reconnue d’intérêt général.
            </p>
            <p>
              Il ne s’agit pas de dons ouvrant droit à un avantage fiscal.
              Aucune déduction fiscale ne doit être attendue.
            </p>
            <p>
              Le paiement et les données nécessaires à son traitement (coordonnées bancaires,
              éventuellement e-mail) sont gérés directement par
              <strong>Ko-fi</strong> et ses prestataires. Manif' ne collecte aucune donnée bancaire,
              n’enregistre aucune contribution et n’associe aucun paiement à un soutien citoyen
              ou à une participation déclarée.
            </p>
          </div>
          <div class="mt-8">
            <KofiDonateButton />
          </div>
        </div>
      </div>
    </section>

    <!-- CTA FINAL -->
    <section class="bg-[#111111] text-[#FFFCF4]">
      <div class="container-page flex flex-col items-start gap-6 py-14 md:flex-row md:items-center md:justify-between">
        <div class="max-w-xl">
          <h2 class="mf-display mf-h3">
            Faire vivre<br>Manif' ensemble
          </h2>
          <p class="mt-3 text-sm text-[#FFFCF4]/70">
            Contribuer est facultatif. Partager l’agenda reste toujours utile.
          </p>
        </div>
        <div class="flex flex-wrap items-center gap-3">
          <KofiDonateButton />
          <NuxtLink to="/manifestations">
            <UiButton
              variant="outline"
              class="!border-[#FFFCF4]/40 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10"
            >
              Retour à l’agenda
            </UiButton>
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>
