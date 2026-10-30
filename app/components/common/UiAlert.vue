<script setup lang="ts">
withDefaults(defineProps<{
  /** info | success | warning | danger */
  color?: 'info' | 'success' | 'warning' | 'danger'
  /** subtle = fond pâle + bordure ; solid = fond plein */
  variant?: 'subtle' | 'solid'
  title?: string
}>(), {
  color: 'info',
  variant: 'subtle',
})

const shells: Record<string, Record<string, string>> = {
  info: {
    subtle: 'border-[#E8D9F8] bg-[#F7F2FC] text-[#4D257D]',
    solid: 'border-transparent bg-[#6735B6] text-white',
  },
  success: {
    subtle: 'border-[#C6E8D8] bg-[#E7F6EF] text-[#206C4D]',
    solid: 'border-transparent bg-[#206C4D] text-white',
  },
  warning: {
    subtle: 'border-[#E8D4A8] bg-[#FFF8E8] text-[#805200]',
    solid: 'border-transparent bg-[#805200] text-white',
  },
  danger: {
    subtle: 'border-[#E8B4AE] bg-[#FDF2F0] text-[#AD291F]',
    solid: 'border-transparent bg-[#AD291F] text-white',
  },
}
</script>

<template>
  <div
    class="flex gap-2.5 rounded-[4px] border px-3 py-2.5 text-sm leading-snug"
    :class="shells[color]?.[variant]"
    role="status"
  >
    <span class="mt-0.5 shrink-0" aria-hidden="true">
      <svg class="size-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
        />
      </svg>
    </span>
    <div class="min-w-0 flex-1">
      <p v-if="title" class="font-bold">
        {{ title }}
      </p>
      <div :class="title ? 'mt-0.5 opacity-90' : ''">
        <slot />
      </div>
    </div>
  </div>
</template>
