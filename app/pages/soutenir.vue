<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.soutenir.title,
  description: SEO.soutenir.description,
  ogTitle: SEO.soutenir.title,
  ogDescription: SEO.soutenir.description,
})
const config = useRuntimeConfig()
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Soutenir</p>
      <h1 class="mf-display mf-h2 mt-3">Soutenir Manif'</h1>
      <p class="mt-4 max-w-2xl text-lg text-[#FFFCF4]/75">
        Un outil citoyen gratuit, financé par la confiance — pas par la publicité ciblée.
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
        <div class="prose-manif">
          <p>
            Manif' reste entièrement gratuit pour consulter l’agenda, soutenir une cause ou déclarer
            une participation. Aucun avantage fonctionnel n’est accordé aux donateurs.
            Aucune manifestation n’est favorisée en raison d’un don.
          </p>
          <p>
            Un don volontaire aide à couvrir l’hébergement, la modération et l’amélioration continue du service.
          </p>
        </div>

        <div class="mt-8">
          <a
            v-if="config.public.donateUrl"
            :href="config.public.donateUrl"
            rel="noopener noreferrer"
            target="_blank"
          >
            <UiButton variant="violet">Faire un don</UiButton>
          </a>
          <p
            v-else
            class="rounded-[8px] border border-[#DDDAD3] bg-white p-4 text-sm text-[#454545]"
          >
            Le lien de don n’est pas encore configuré. En attendant, vous pouvez
            <NuxtLink to="/" class="font-semibold text-[#6735B6] hover:underline">partager Manif'</NuxtLink>
            autour de vous — c’est déjà un soutien utile.
          </p>
        </div>

        <div class="mt-10">
          <NuxtLink to="/">
            <UiButton variant="outline">Retour à l’agenda</UiButton>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>
