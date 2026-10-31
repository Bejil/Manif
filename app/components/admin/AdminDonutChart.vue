<script setup lang="ts">
export type AdminDonutSlice = {
  id: string
  label: string
  value: number
  color: string
}

const props = withDefaults(defineProps<{
  items: AdminDonutSlice[]
  emptyLabel?: string
  size?: number
}>(), {
  emptyLabel: 'Aucune donnée',
  size: 168,
})

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}

const total = computed(() => props.items.reduce((s, i) => s + Math.max(0, i.value), 0))

const slices = computed(() => {
  const sum = total.value
  if (!sum) return []
  const r = 42
  const c = 50
  const circumference = 2 * Math.PI * r
  let offset = 0
  return props.items
    .filter(i => i.value > 0)
    .map((item) => {
      const pct = item.value / sum
      const length = pct * circumference
      const slice = {
        ...item,
        pct,
        dash: `${length} ${circumference - length}`,
        offset: -offset,
      }
      offset += length
      return slice
    })
})

const viewBox = '0 0 100 100'
</script>

<template>
  <p v-if="!total" class="text-sm text-[#636363]">{{ emptyLabel }}</p>
  <div v-else class="flex flex-col items-center gap-5 sm:flex-row sm:items-start">
    <div class="relative shrink-0" :style="{ width: `${size}px`, height: `${size}px` }">
      <svg
        :viewBox="viewBox"
        class="size-full -rotate-90"
        role="img"
        :aria-label="`Répartition sur ${fmt(total)}`"
      >
        <circle cx="50" cy="50" r="42" fill="none" stroke="#F0EDE6" stroke-width="12" />
        <circle
          v-for="slice in slices"
          :key="slice.id"
          cx="50"
          cy="50"
          r="42"
          fill="none"
          :stroke="slice.color"
          stroke-width="12"
          :stroke-dasharray="slice.dash"
          :stroke-dashoffset="slice.offset"
          stroke-linecap="butt"
        />
      </svg>
      <div class="pointer-events-none absolute inset-0 flex flex-col items-center justify-center text-center">
        <p class="mf-count text-2xl leading-none text-[#111111]">{{ fmt(total) }}</p>
        <p class="mt-1 text-[10px] font-bold uppercase tracking-wide text-[#636363]">Total</p>
      </div>
    </div>
    <ul class="min-w-0 flex-1 space-y-2 text-sm">
      <li
        v-for="slice in slices"
        :key="slice.id"
        class="flex items-center justify-between gap-3"
      >
        <span class="inline-flex min-w-0 items-center gap-2">
          <span
            class="size-2.5 shrink-0 rounded-[2px]"
            :style="{ backgroundColor: slice.color }"
            aria-hidden="true"
          />
          <span class="truncate text-[#454545]">{{ slice.label }}</span>
        </span>
        <span class="shrink-0 tabular-nums text-[#111111]">
          <span class="font-bold">{{ fmt(slice.value) }}</span>
          <span class="ml-1 text-xs text-[#636363]">{{ Math.round(slice.pct * 100) }}%</span>
        </span>
      </li>
    </ul>
  </div>
</template>
