<script setup lang="ts">
withDefaults(defineProps<{
  title: string
  description?: string
  illustration?: 'empty-events' | 'error'
}>(), {
  illustration: 'empty-events',
})
</script>

<template>
  <div class="flex flex-col items-center justify-center rounded-[8px] border border-dashed border-[#DDDAD3] bg-white px-6 py-12 text-center">
    <ManifIllustration
      :name="illustration"
      :alt="title"
      class="mb-5 max-w-[220px]"
    />
    <p class="mf-display text-xl text-[#111111]">{{ title }}</p>
    <p v-if="description" class="mt-2 max-w-md text-sm text-[#454545]">{{ description }}</p>
    <div v-if="$slots.default" class="mt-5">
      <slot />
    </div>
  </div>
</template>
