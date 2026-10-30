<script setup lang="ts">
import { organizationJsonLd, websiteJsonLd } from '#shared/utils/seo-schema'

const config = useRuntimeConfig()
const { toast: alertToast, dismissToast } = useHomeAlertSection()

const siteUrl = computed(() =>
  String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, ''),
)

useHead(() => ({
  script: [
    {
      type: 'application/ld+json',
      children: JSON.stringify(organizationJsonLd(siteUrl.value)),
    },
    {
      type: 'application/ld+json',
      children: JSON.stringify(websiteJsonLd(siteUrl.value)),
    },
  ],
}))
</script>

<template>
  <div class="flex min-h-screen flex-col">
    <AppHeader />
    <main id="contenu-principal" class="flex-1">
      <slot />
    </main>
    <AppFooter />

    <Teleport to="body">
      <div
        v-if="alertToast"
        class="pointer-events-none fixed bottom-4 right-4 z-[90] flex justify-end sm:bottom-6 sm:right-6"
        role="status"
        aria-live="polite"
      >
        <div
          class="pointer-events-auto flex w-[min(100vw-2rem,22rem)] gap-3 rounded-[8px] border px-4 py-3 shadow-lift"
          :class="alertToast.tone === 'ok'
            ? 'border-[#C6E8D8] bg-[#E7F6EF] text-[#206C4D]'
            : 'border-[#E8B4AE] bg-[#FDF2F0] text-[#AD291F]'"
        >
          <span
            class="mt-0.5 flex size-8 shrink-0 items-center justify-center rounded-full"
            :class="alertToast.tone === 'ok' ? 'bg-[#206C4D] text-white' : 'bg-[#AD291F] text-white'"
            aria-hidden="true"
          >
            <svg
              v-if="alertToast.tone === 'ok'"
              class="size-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7" />
            </svg>
            <svg
              v-else
              class="size-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </span>
          <div class="min-w-0 flex-1">
            <p class="text-sm font-extrabold leading-snug">
              {{ alertToast.title }}
            </p>
            <p class="mt-0.5 text-sm leading-snug opacity-90">
              {{ alertToast.description }}
            </p>
          </div>
          <button
            type="button"
            class="shrink-0 self-start rounded-[4px] px-1 text-lg leading-none opacity-60 hover:opacity-100"
            aria-label="Fermer"
            @click="dismissToast"
          >
            ×
          </button>
        </div>
      </div>
    </Teleport>

    <ClientOnly>
      <KofiOverlayWidget />
      <AlertSignupModal />
    </ClientOnly>
  </div>
</template>
