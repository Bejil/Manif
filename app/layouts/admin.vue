<script setup lang="ts">
const open = ref(false)
const route = useRoute()

const links = [
  { to: '/admin', label: 'Tableau de bord', exact: true },
  { to: '/admin/evenements', label: 'Événements' },
  { to: '/admin/imports', label: 'Imports' },
  { to: '/admin/propositions', label: 'Propositions' },
  { to: '/admin/signalements', label: 'Signalements' },
]

function isActive(link: { to: string, exact?: boolean }) {
  if (link.exact) return route.path === link.to
  return route.path === link.to || route.path.startsWith(`${link.to}/`)
}

watch(open, (v) => {
  if (import.meta.client) document.body.style.overflow = v ? 'hidden' : ''
})
</script>

<template>
  <div class="flex min-h-screen flex-col bg-[#FFFCF4] text-[#111111]">
    <header class="sticky top-0 z-40 border-b border-[#DDDAD3] bg-[#FFFCF4]/95 backdrop-blur-md">
      <div class="container-page flex h-[4.25rem] items-center justify-between gap-3">
        <NuxtLink to="/admin" class="shrink-0" @click="open = false">
          <span class="flex items-center gap-2">
            <BrandLogo size="md" />
            <span class="mf-display text-sm tracking-wide text-[#D1271C]">Admin</span>
          </span>
        </NuxtLink>

        <nav class="hidden items-center gap-1 md:flex" aria-label="Navigation admin">
          <NuxtLink
            v-for="link in links"
            :key="link.to"
            :to="link.to"
            class="rounded-[4px] px-3 py-2 text-sm font-bold transition"
            :class="isActive(link)
              ? 'bg-[#111111] text-[#FFFCF4]'
              : 'text-[#111111] hover:bg-[#F4F1EA]'"
          >
            {{ link.label }}
          </NuxtLink>
          <NuxtLink to="/" class="ml-2">
            <UiButton size="sm" variant="outline">Site public</UiButton>
          </NuxtLink>
        </nav>

        <button
          type="button"
          class="inline-flex items-center justify-center rounded-[4px] p-2 text-[#111111] md:hidden"
          :aria-expanded="open"
          aria-controls="admin-menu-mobile"
          @click="open = !open"
        >
          <span class="sr-only">{{ open ? 'Fermer le menu' : 'Ouvrir le menu' }}</span>
          <svg v-if="!open" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
          <svg v-else class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
        </button>
      </div>

      <div v-if="open" id="admin-menu-mobile" class="border-t border-[#DDDAD3] bg-[#FFFCF4] md:hidden">
        <nav class="container-page flex flex-col gap-1 py-3" aria-label="Navigation admin mobile">
          <NuxtLink
            v-for="link in links"
            :key="link.to"
            :to="link.to"
            class="rounded-[4px] px-3 py-3 text-base font-bold hover:bg-[#F4F1EA]"
            @click="open = false"
          >
            {{ link.label }}
          </NuxtLink>
          <NuxtLink to="/" class="mt-2" @click="open = false">
            <UiButton block variant="outline">Site public</UiButton>
          </NuxtLink>
        </nav>
      </div>
    </header>

    <main id="contenu-principal" class="container-page flex-1 py-8 md:py-10">
      <slot />
    </main>

    <AppFooter />
  </div>
</template>
