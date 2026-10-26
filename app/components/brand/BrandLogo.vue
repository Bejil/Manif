<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'mark' | 'horizontal'
  onDark?: boolean
  size?: 'sm' | 'md' | 'lg'
}>(), {
  variant: 'horizontal',
  onDark: false,
  size: 'md',
})

const markSize = { sm: 'h-8 w-8', md: 'h-10 w-10', lg: 'h-12 w-12' }
const wordSize = { sm: 'text-xl', md: 'text-2xl', lg: 'text-3xl' }
</script>

<template>
  <span class="inline-flex items-center gap-2.5" aria-label="Manif'">
    <img
      src="/brand/manif.logo.svg"
      alt=""
      :class="markSize[size]"
      width="40"
      height="40"
      decoding="async"
    >
    <span
      v-if="variant === 'horizontal'"
      class="font-display"
      :class="[wordSize[size], onDark ? 'text-[#FFFCF4]' : 'text-ink']"
    >MANIF'</span>
  </span>
</template>
