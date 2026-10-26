<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.contact.title,
  description: SEO.contact.description,
  ogTitle: SEO.contact.title,
  ogDescription: SEO.contact.description,
})
const config = useRuntimeConfig()
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Contact</p>
      <h1 class="mf-display mf-h2 mt-3">Contact</h1>
      <p class="mt-4 max-w-2xl text-[#FFFCF4]/75">
        Une question, une demande relative à vos données, ou un signalement qui ne passe pas par une fiche ?
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
        <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-5 shadow-soft">
          <p class="text-sm font-bold text-[#111111]">Écrire à l’équipe</p>
          <a
            :href="`mailto:${config.public.contactEmail}`"
            class="mt-2 inline-block text-lg font-bold text-[#6735B6] hover:underline"
          >
            {{ config.public.contactEmail }}
          </a>
          <p class="mt-3 text-sm text-[#454545]">
            Nous lisons les messages avec attention. Les délais de réponse peuvent varier selon le volume.
          </p>
        </div>

        <p class="mt-8 text-sm text-[#454545]">
          Pour signaler une erreur sur une fiche, utilisez le bouton « Signaler » sur la page de la manifestation.
        </p>
      </div>
    </div>
  </div>
</template>
