<script setup lang="ts">
withDefaults(defineProps<{
  /** Padding vertical réduit (fiches événement) */
  compact?: boolean
}>(), {
  compact: false,
})
</script>

<template>
  <section class="relative overflow-hidden border-b border-[#DDDAD3] text-[#FFFCF4]">
    <img
      src="/images/hero-crowd.png"
      alt=""
      width="1200"
      height="800"
      decoding="async"
      fetchpriority="low"
      class="absolute inset-0 size-full object-cover object-[center_40%]"
      aria-hidden="true"
    >
    <div
      class="pointer-events-none absolute inset-0"
      aria-hidden="true"
      style="background:
        linear-gradient(90deg, rgba(17,17,17,.9) 0%, rgba(17,17,17,.72) 48%, rgba(17,17,17,.45) 100%),
        linear-gradient(180deg, rgba(17,17,17,.4) 0%, transparent 42%, rgba(17,17,17,.55) 100%);"
    />
    <div
      class="container-page relative z-10"
      :class="compact ? 'py-8 md:py-12' : 'py-12 md:py-16'"
    >
      <slot />
    </div>
  </section>
</template>
