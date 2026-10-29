<script setup lang="ts">
const { banner: alertBanner, dismissBanner } = useHomeAlertSection()
</script>

<template>
  <div class="flex min-h-screen flex-col">
    <div
      v-if="alertBanner"
      class="relative z-[60] px-4 py-3 text-center text-sm font-semibold leading-snug text-white"
      :class="alertBanner.tone === 'ok' ? 'bg-[#206C4D]' : 'bg-[#AD291F]'"
      role="status"
      aria-live="polite"
    >
      <div class="mx-auto flex max-w-3xl items-start justify-center gap-3">
        <p class="min-w-0 flex-1">
          {{ alertBanner.text }}
        </p>
        <button
          type="button"
          class="shrink-0 rounded-[4px] px-1 text-lg leading-none text-white/80 hover:text-white"
          aria-label="Fermer"
          @click="dismissBanner"
        >
          ×
        </button>
      </div>
    </div>
    <AppHeader />
    <main id="contenu-principal" class="flex-1">
      <slot />
    </main>
    <AppFooter />
    <ClientOnly>
      <KofiOverlayWidget />
      <AlertSignupModal />
    </ClientOnly>
  </div>
</template>
