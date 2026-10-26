<script setup lang="ts">
const open = ref(false)

const links = [
  { to: '/#agenda', label: 'Manifestations' },
  { to: '/guide', label: 'Guide' },
  { to: '/faq', label: 'FAQ' },
  { to: '/comptage', label: 'Méthodologie' },
  { to: '/soutenir', label: 'Soutenir Manif\'' },
]

watch(open, (v) => {
  if (import.meta.client) document.body.style.overflow = v ? 'hidden' : ''
})
</script>

<template>
  <header class="sticky top-0 z-40 border-b border-[#DDDAD3] bg-[#FFFCF4]/95 backdrop-blur-md">
    <a
      href="#contenu-principal"
      class="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:bg-[#6735B6] focus:px-3 focus:py-2 focus:text-white"
    >
      Aller au contenu
    </a>
    <div class="container-page flex h-[4.25rem] items-center justify-between gap-3">
      <NuxtLink to="/" class="shrink-0" @click="open = false">
        <BrandLogo size="md" />
      </NuxtLink>

      <div class="hidden items-center gap-1.5 lg:flex">
        <nav class="flex flex-wrap items-center gap-0.5" aria-label="Navigation principale">
          <NuxtLink
            v-for="link in links"
            :key="link.to"
            :to="link.to"
            class="rounded-[4px] px-2.5 py-2 text-sm font-bold text-[#111111] transition hover:bg-[#F4F1EA]"
            active-class="!bg-[#111111] !text-[#FFFCF4]"
          >
            {{ link.label }}
          </NuxtLink>
        </nav>
        <NuxtLink to="/proposer" class="ml-1 shrink-0">
          <UiButton size="sm" variant="red">Proposer</UiButton>
        </NuxtLink>
      </div>

      <button
        type="button"
        class="inline-flex items-center justify-center rounded-[4px] p-2 text-[#111111] lg:hidden"
        :aria-expanded="open"
        aria-controls="menu-mobile"
        @click="open = !open"
      >
        <span class="sr-only">{{ open ? 'Fermer le menu' : 'Ouvrir le menu' }}</span>
        <svg v-if="!open" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
        <svg v-else class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
      </button>
    </div>

    <div v-if="open" id="menu-mobile" class="border-t border-[#DDDAD3] bg-[#FFFCF4] lg:hidden">
      <nav class="container-page flex flex-col gap-1 py-3" aria-label="Navigation mobile">
        <NuxtLink
          v-for="link in links"
          :key="link.to"
          :to="link.to"
          class="rounded-[4px] px-3 py-3 text-base font-bold hover:bg-[#F4F1EA]"
          @click="open = false"
        >
          {{ link.label }}
        </NuxtLink>
        <NuxtLink to="/proposer" class="mt-2" @click="open = false">
          <UiButton block variant="red">Proposer une manifestation</UiButton>
        </NuxtLink>
      </nav>
    </div>
  </header>
</template>
