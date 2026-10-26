<script setup lang="ts">
const props = withDefaults(defineProps<{
  name:
    | 'manifestation'
    | 'soutien'
    | 'participation'
    | 'carte'
    | 'calendrier'
    | 'partage'
    | 'expression'
    | 'info'
    | 'guide'
    | 'securite'
    | 'transparence'
    | 'communaute'
  size?: number
  class?: string
}>(), {
  size: 28,
})

const src = computed(() => `/icons/manif/${props.name}.svg`)
</script>

<template>
  <img
    :src="src"
    alt=""
    :width="size"
    :height="size"
    decoding="async"
    class="inline-block shrink-0"
    :class="props.class"
    aria-hidden="true"
  >
</template>
