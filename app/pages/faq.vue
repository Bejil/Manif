<script setup lang="ts">
import { FAQ_ITEMS, SEO } from '#shared/content/seo'

const open = ref<number | null>(0)

useSiteSeo({
  title: SEO.faq.title,
  description: SEO.faq.description,
  path: '/faq',
  jsonLd: {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: FAQ_ITEMS.map(item => ({
      '@type': 'Question',
      name: item.q,
      acceptedAnswer: {
        '@type': 'Answer',
        text: item.a.replace(/\n\n/g, ' '),
      },
    })),
  },
})
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">FAQ</p>
      <h1 class="mf-display mf-h2 mt-3">Questions fréquentes</h1>
      <p class="mt-4 max-w-2xl text-[#FFFCF4]/75">
        Trouver une manifestation, proposer un événement, comptage citoyen,
        confidentialité et signalement : les réponses pour utiliser Manif' sereinement.
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
        <div class="divide-y divide-[#DDDAD3] overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-soft">
          <div v-for="(item, i) in FAQ_ITEMS" :key="item.q">
            <button
              type="button"
              class="flex w-full items-start justify-between gap-4 px-5 py-4 text-left transition hover:bg-[#FFFCF4]"
              :aria-expanded="open === i"
              @click="open = open === i ? null : i"
            >
              <span class="font-bold text-[#111111]">{{ item.q }}</span>
              <span class="shrink-0 text-lg text-[#636363]" aria-hidden="true">{{ open === i ? '−' : '+' }}</span>
            </button>
            <div v-if="open === i" class="space-y-3 px-5 pb-4 text-sm leading-relaxed text-[#454545]">
              <p v-for="(para, pi) in item.a.split('\n\n')" :key="pi">
                {{ para }}
              </p>
            </div>
          </div>
        </div>

        <p class="mt-8 text-sm text-[#454545]">
          Une autre question ?
          <NuxtLink to="/contact" class="font-semibold text-[#6735B6] underline">Contactez-nous</NuxtLink>.
        </p>
      </div>
    </div>
  </div>
</template>
