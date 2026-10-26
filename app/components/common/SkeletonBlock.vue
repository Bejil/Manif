<script setup lang="ts">
withDefaults(defineProps<{ lines?: number }>(), { lines: 3 })
</script>

<template>
  <div class="animate-pulse space-y-3" aria-hidden="true">
    <div
      v-for="n in lines"
      :key="n"
      class="h-4 rounded bg-surface-muted"
      :class="n === 1 ? 'w-3/4' : n === lines ? 'w-1/2' : 'w-full'"
    />
  </div>
</template>
