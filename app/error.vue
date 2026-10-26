<script setup lang="ts">
import type { NuxtError } from '#app'

defineProps<{ error: NuxtError }>()

useSeoMeta({ robots: 'noindex' })
</script>

<template>
  <div class="flex min-h-screen flex-col items-center justify-center bg-[#FFFCF4] px-4 text-center">
    <ManifIllustration
      name="error"
      alt=""
      class="mb-6 max-w-[240px]"
    />
    <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Manif'</p>
    <h1 class="mf-display mf-h3 mt-3 text-[#111111]">
      {{ error.statusCode === 404 ? 'Cette page n’existe pas' : 'Une erreur est survenue' }}
    </h1>
    <p class="mt-3 max-w-md text-[#454545]">
      {{ error.statusMessage || 'Réessayez dans un instant, ou revenez à l’agenda.' }}
    </p>
    <NuxtLink to="/" class="mt-8">
      <UiButton>Retour à l’agenda</UiButton>
    </NuxtLink>
  </div>
</template>
