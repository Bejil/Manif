<script setup lang="ts">
withDefaults(defineProps<{
  tone?: 'violet' | 'red'
}>(), {
  tone: 'violet',
})
</script>

<template>
  <span
    class="mf-strip"
    :class="tone === 'red' ? 'mf-strip--red' : 'mf-strip--violet'"
  ><slot /></span>
</template>
