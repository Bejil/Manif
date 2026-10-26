<script setup lang="ts">
withDefaults(defineProps<{
  name: 'voices' | 'map' | 'support' | 'participate' | 'calendar' | 'share' | 'guide'
  size?: number
  class?: string
}>(), {
  size: 24,
})
</script>

<template>
  <svg
    :width="size"
    :height="size"
    class="inline-block shrink-0"
    :class="$props.class"
    aria-hidden="true"
  >
    <use :href="`/brand/manif.icons.svg#mf-${name}`" />
  </svg>
</template>
