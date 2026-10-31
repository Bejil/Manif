<script setup lang="ts">
export type AdminHBarItem = {
  id: string
  label: string
  sublabel?: string
  value: number
  href?: string
}

const props = withDefaults(defineProps<{
  items: AdminHBarItem[]
  /** Couleur de la barre */
  barClass?: string
  emptyLabel?: string
}>(), {
  barClass: 'bg-[#111111]',
  emptyLabel: 'Aucune donnée',
})

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}

const max = computed(() => Math.max(1, ...props.items.map(i => i.value)))

function widthPct(value: number) {
  return `${Math.max(value > 0 ? 4 : 0, (value / max.value) * 100)}%`
}
</script>

<template>
  <p v-if="!items.length" class="text-sm text-[#636363]">{{ emptyLabel }}</p>
  <ul v-else class="space-y-3" role="list">
    <li v-for="(item, index) in items" :key="item.id" class="min-w-0">
      <div class="mb-1 flex items-baseline justify-between gap-3 text-sm">
        <div class="min-w-0 flex items-baseline gap-2">
          <span class="w-4 shrink-0 text-xs font-bold tabular-nums text-[#636363]">{{ index + 1 }}</span>
          <div class="min-w-0">
            <NuxtLink
              v-if="item.href"
              :to="item.href"
              class="block truncate font-bold text-[#111111] hover:text-[#D1271C]"
            >
              {{ item.label }}
            </NuxtLink>
            <p v-else class="truncate font-bold text-[#111111]">{{ item.label }}</p>
            <p v-if="item.sublabel" class="truncate text-xs text-[#636363]">{{ item.sublabel }}</p>
          </div>
        </div>
        <span class="shrink-0 font-bold tabular-nums text-[#111111]">{{ fmt(item.value) }}</span>
      </div>
      <div
        class="h-2 overflow-hidden rounded-[2px] bg-[#F0EDE6]"
        role="img"
        :aria-label="`${item.label} : ${fmt(item.value)}`"
      >
        <div
          class="h-full rounded-[2px] transition-[width] duration-500 ease-out motion-reduce:transition-none"
          :class="barClass"
          :style="{ width: widthPct(item.value) }"
        />
      </div>
    </li>
  </ul>
</template>
