<script setup lang="ts">
/**
 * Illustrations locales issues d’unDraw (https://undraw.co),
 * recolorées en violet Manif' (#9C6EE8). Licence unDraw : usage libre.
 */
const props = withDefaults(defineProps<{
  name:
    | 'hero-poster'
    | 'hero-gathering'
    | 'discover-map'
    | 'support'
    | 'participate'
    | 'share'
    | 'propose'
    | 'guide-prep'
    | 'empty-events'
    | 'error'
  alt?: string
  class?: string
}>(), {
  alt: '',
})

const src = computed(() => `/illustrations/${props.name}.svg`)
</script>

<template>
  <img
    :src="src"
    :alt="alt"
    decoding="async"
    loading="lazy"
    class="h-auto w-full"
    :class="props.class"
  >
</template>
