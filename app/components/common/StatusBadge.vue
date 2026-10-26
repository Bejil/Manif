<script setup lang="ts">
import type { DisplayEventStatus } from '#shared/constants/statuses'
import { DISPLAY_STATUS_LABELS } from '#shared/constants/statuses'

defineProps<{ status: DisplayEventStatus }>()

const styles: Record<DisplayEventStatus, string> = {
  upcoming: 'bg-[#9C6EE8] text-[#111111]',
  ongoing: 'bg-[#D1271C] text-[#FFFCF4]',
  past: 'bg-[#636363] text-[#FFFCF4]',
  cancelled: 'bg-[#AD291F] text-[#FFFCF4] ring-1 ring-[#111111]/20',
  postponed: 'bg-[#805200] text-[#FFFCF4]',
}
</script>

<template>
  <span class="chip font-bold tracking-wide" :class="styles[status]">
    {{ DISPLAY_STATUS_LABELS[status] }}
  </span>
</template>
