<script setup lang="ts">
const config = useRuntimeConfig()
const year = new Date().getFullYear()
</script>

<template>
  <footer class="mt-auto bg-[#111111] text-[#FFFCF4]">
    <div class="container-page grid gap-10 py-14 md:grid-cols-3">
      <div>
        <BrandLogo on-dark size="md" />
        <p class="mt-4 max-w-xs text-sm text-[#FFFCF4]/70">
          Toutes les manifestations. Toutes les voix.
        </p>
        <p class="mt-3 text-xs text-[#FFFCF4]/45">
          Neutre · Gratuit · Sans compte public
        </p>
      </div>
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.14em] text-[#9C6EE8]">Découvrir</p>
        <ul class="mt-4 space-y-2.5 text-sm font-medium">
          <li><NuxtLink to="/#agenda" class="hover:text-[#9C6EE8]">Manifestations</NuxtLink></li>
          <li><NuxtLink to="/proposer" class="hover:text-[#9C6EE8]">Proposer</NuxtLink></li>
          <li><NuxtLink to="/guide" class="hover:text-[#9C6EE8]">Guide</NuxtLink></li>
          <li><NuxtLink to="/faq" class="hover:text-[#9C6EE8]">FAQ</NuxtLink></li>
          <li><NuxtLink to="/comptage" class="hover:text-[#9C6EE8]">Méthodologie</NuxtLink></li>
          <li><NuxtLink to="/soutenir" class="hover:text-[#9C6EE8]">Soutenir Manif'</NuxtLink></li>
        </ul>
      </div>
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.14em] text-[#9C6EE8]">Légal</p>
        <ul class="mt-4 space-y-2.5 text-sm font-medium">
          <li><NuxtLink to="/confidentialite" class="hover:text-[#9C6EE8]">Confidentialité</NuxtLink></li>
          <li><NuxtLink to="/mentions-legales" class="hover:text-[#9C6EE8]">Mentions légales</NuxtLink></li>
          <li><NuxtLink to="/contact" class="hover:text-[#9C6EE8]">Contact</NuxtLink></li>
          <li><NuxtLink to="/a-propos" class="hover:text-[#9C6EE8]">À propos</NuxtLink></li>
        </ul>
        <p v-if="config.public.contactEmail" class="mt-5 text-xs text-[#FFFCF4]/45">
          {{ config.public.contactEmail }}
        </p>
      </div>
    </div>
    <div class="border-t border-white/10">
      <div class="container-page flex flex-col gap-2 py-4 text-xs text-[#FFFCF4]/40 sm:flex-row sm:justify-between">
        <p>© {{ year }} Manif' — information et comptage citoyen.</p>
        <p>Aucune publicité ciblée.</p>
      </div>
    </div>
  </footer>
</template>
