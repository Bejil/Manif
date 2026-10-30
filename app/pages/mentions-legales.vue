<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSiteSeo({
  title: SEO.mentions.title,
  description: SEO.mentions.description,
  path: '/mentions-legales',
})
const config = useRuntimeConfig()

const editorName = computed(() =>
  (config.public.legalEditorName as string) || "Manif'",
)
const editorAddress = computed(() =>
  (config.public.legalEditorAddress as string)
  || 'France — adresse postale disponible sur demande à contact@manif.info',
)
const hostName = computed(() =>
  (config.public.legalHostName as string) || 'Supabase + hébergeur applicatif',
)
const hostAddress = computed(() =>
  (config.public.legalHostAddress as string) || 'Voir configuration du projet',
)
const hostPhone = computed(() => (config.public.legalHostPhone as string) || '')
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Légal</p>
      <h1 class="mf-display mf-h2 mt-3">Mentions légales</h1>
    </PageHero>

    <div class="container-page py-10">
    <div class="prose-manif">
    <h2>Éditeur</h2>
    <p>{{ editorName }}</p>
    <p>{{ editorAddress }}</p>
    <p>
      Contact :
      <a :href="`mailto:${config.public.contactEmail}`">{{ config.public.contactEmail }}</a>
    </p>
    <p>Directeur de la publication : {{ editorName }}</p>

    <h2>Hébergeur</h2>
    <p>{{ hostName }}</p>
    <p>{{ hostAddress }}</p>
    <p v-if="hostPhone">{{ hostPhone }}</p>

    <h2>Objet du service</h2>
    <p>
      Manif' est une plateforme d'information et de comptage participatif des manifestations
      pacifiques et licites en France. Manif' n'est pas organisatrice des événements listés
      et n'endosse pas les revendications affichées.
    </p>

    <h2>Contributions volontaires</h2>
    <p>
      Les contributions financières éventuelles passent par une plateforme externe (Ko-fi).
      Elles sont destinées au porteur indépendant du projet (personne physique), et non à une
      association d’intérêt général. Elles n’ouvrent pas droit à un avantage fiscal présenté
      par Manif'. Voir
      <NuxtLink to="/soutenir">Soutenir Manif'</NuxtLink>.
    </p>

    <h2>Propriété intellectuelle</h2>
    <p>
      Les éléments graphiques et le code de Manif' sont protégés. Les contenus d'événements
      restent sous la responsabilité de leurs auteurs / sources.
    </p>
    </div>
    </div>
  </div>
</template>
