<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.guide.title,
  description: SEO.guide.description,
  ogTitle: SEO.guide.title,
  ogDescription: SEO.guide.description,
})

const sections = [
  {
    id: 'avant',
    icon: 'calendar' as const,
    title: 'Avant de partir',
    lead: 'Quelques minutes de préparation changent une journée.',
    items: [
      'Vérifiez l’horaire et le lieu sur la fiche Manif\', et si possible auprès de l’organisateur.',
      'Consultez la météo et adaptez votre équipement.',
      'Anticipez le trajet : transports, stationnement, accessibilité.',
      'Prévenez éventuellement un proche de votre participation et de l’heure de retour prévue.',
    ],
  },
  {
    id: 'sac',
    icon: 'guide' as const,
    title: 'Dans votre sac',
    lead: 'Léger, utile, adapté à la durée.',
    items: [
      'Eau en quantité suffisante',
      'Encas',
      'Téléphone chargé et, si possible, batterie externe',
      'Protection adaptée à la météo',
      'Médicaments personnels nécessaires',
    ],
  },
  {
    id: 'habiller',
    icon: 'participate' as const,
    title: 'S’habiller pour marcher',
    lead: 'Confort d’abord.',
    items: [
      'Chaussures adaptées à une longue marche',
      'Vêtements selon la saison et l’effort',
      'Protection pluie ou soleil',
    ],
  },
  {
    id: 'respect',
    icon: 'voices' as const,
    title: 'Respecter les autres',
    lead: 'Le collectif commence par l’attention.',
    items: [
      'Respect des personnes et de leur dignité',
      'Respect des biens',
      'Attention aux enfants et personnes vulnérables',
      'Non-violence',
      'Respect des consignes de sécurité sur place',
    ],
  },
  {
    id: 'droits',
    icon: 'share' as const,
    title: 'Droits et obligations',
    lead: 'Informations générales — pas un conseil juridique.',
    items: [
      'Le droit de manifestation est encadré par le droit français.',
      'Violences, dégradations et certaines entraves sont interdites.',
      'Consultez service-public.fr et Légifrance pour les textes à jour.',
    ],
  },
  {
    id: 'urgence',
    icon: 'map' as const,
    title: 'En cas de problème',
    lead: 'Priorité à votre sécurité.',
    items: [
      'Éloignez-vous d’une situation dangereuse.',
      'Contactez les secours si nécessaire.',
      '15 SAMU · 17 police/gendarmerie · 18 pompiers · 112 Europe · 114 sourds/malentendants',
    ],
  },
]
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Guide</p>
      <h1 class="mf-display mf-h2 mt-3 max-w-3xl text-[#FFFCF4]">
        Guide du<br>
        <HighlightedText tone="violet">manifestant</HighlightedText>
      </h1>
      <p class="mt-4 max-w-xl text-[#FFFCF4]/75">
        Des repères concrets pour préparer votre journée. Informational,
        pas un avis juridique personnalisé.
      </p>
    </PageHero>

    <div class="container-page space-y-6 py-12 md:py-16">
      <article
        v-for="(section, index) in sections"
        :id="section.id"
        :key="section.id"
        class="grid items-start gap-6 rounded-[8px] border border-[#DDDAD3] bg-white p-6 shadow-soft md:grid-cols-[auto_1fr] md:gap-8 md:p-8"
        :class="index % 2 === 1 ? 'md:bg-[#F0E8FC]/50' : ''"
      >
        <div class="flex h-14 w-14 items-center justify-center rounded-[4px] bg-[#111111] text-[#FFFCF4]">
          <BrandIcon :name="section.icon" :size="28" />
        </div>
        <div>
          <h2 class="mf-display text-2xl text-[#111111] md:text-3xl">
            {{ section.title }}
          </h2>
          <p class="mt-1 text-sm text-[#454545]">{{ section.lead }}</p>
          <ul class="mt-4 space-y-2 text-[#111111]">
            <li
              v-for="item in section.items"
              :key="item"
              class="flex gap-3 text-sm leading-relaxed"
            >
              <span class="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-[#D1271C]" aria-hidden="true" />
              <span>{{ item }}</span>
            </li>
          </ul>
          <p v-if="section.id === 'droits'" class="mt-4 text-sm text-[#454545]">
            Sources :
            <a href="https://www.service-public.fr" class="font-semibold text-[#6735B6] underline" rel="noopener noreferrer" target="_blank">service-public.fr</a>
            ·
            <a href="https://www.legifrance.gouv.fr" class="font-semibold text-[#6735B6] underline" rel="noopener noreferrer" target="_blank">Légifrance</a>
            · Relecture éditoriale : octobre 2026
          </p>
        </div>
      </article>
    </div>

    <section class="border-t border-[#DDDAD3] bg-[#111111] text-[#FFFCF4]">
      <div class="container-page flex flex-col items-start gap-5 py-12 md:flex-row md:items-center md:justify-between">
        <div>
          <h2 class="mf-display text-2xl md:text-3xl">Prêt·e à consulter l’agenda ?</h2>
          <p class="mt-1 text-sm text-[#FFFCF4]/65">Trouvez une manifestation près de chez vous.</p>
        </div>
        <div class="flex flex-wrap gap-3">
          <NuxtLink to="/">
            <UiButton variant="red">Voir les manifestations</UiButton>
          </NuxtLink>
          <NuxtLink to="/faq">
            <UiButton
              variant="outline"
              class="!border-[#FFFCF4]/40 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10"
            >
              FAQ
            </UiButton>
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>
