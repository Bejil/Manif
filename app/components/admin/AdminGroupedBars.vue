<script setup lang="ts">
export type AdminGroupedItem = {
  id: string
  label: string
  supports: number
  participations: number
  href?: string
}

const props = withDefaults(defineProps<{
  items: AdminGroupedItem[]
  emptyLabel?: string
}>(), {
  emptyLabel: 'Aucune donnée',
})

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}

const max = computed(() =>
  Math.max(1, ...props.items.flatMap(i => [i.supports, i.participations])),
)

function widthPct(value: number) {
  return `${Math.max(value > 0 ? 4 : 0, (value / max.value) * 100)}%`
}
</script>

<template>
  <p v-if="!items.length" class="text-sm text-[#636363]">{{ emptyLabel }}</p>
  <div v-else>
    <ul class="mb-3 flex flex-wrap gap-x-4 gap-y-1 text-xs text-[#636363]">
      <li class="inline-flex items-center gap-1.5">
        <span class="size-2 rounded-[2px] bg-[#4D257D]" aria-hidden="true" />
        Soutiens
      </li>
      <li class="inline-flex items-center gap-1.5">
        <span class="size-2 rounded-[2px] bg-[#97251B]" aria-hidden="true" />
        Participations
      </li>
    </ul>
    <ul class="space-y-4" role="list">
      <li v-for="(item, index) in items" :key="item.id" class="min-w-0">
        <div class="mb-1.5 flex items-baseline gap-2 text-sm">
          <span class="w-4 shrink-0 text-xs font-bold tabular-nums text-[#636363]">{{ index + 1 }}</span>
          <NuxtLink
            v-if="item.href"
            :to="item.href"
            class="truncate font-bold text-[#111111] hover:text-[#D1271C]"
          >
            {{ item.label }}
          </NuxtLink>
          <p v-else class="truncate font-bold text-[#111111]">{{ item.label }}</p>
        </div>
        <div class="space-y-1.5 pl-6">
          <div class="flex items-center gap-2">
            <div class="h-2 min-w-0 flex-1 overflow-hidden rounded-[2px] bg-[#F0EDE6]">
              <div
                class="h-full rounded-[2px] bg-[#4D257D] transition-[width] duration-500 ease-out motion-reduce:transition-none"
                :style="{ width: widthPct(item.supports) }"
              />
            </div>
            <span class="w-10 shrink-0 text-right text-xs font-bold tabular-nums text-[#4D257D]">
              {{ fmt(item.supports) }}
            </span>
          </div>
          <div class="flex items-center gap-2">
            <div class="h-2 min-w-0 flex-1 overflow-hidden rounded-[2px] bg-[#F0EDE6]">
              <div
                class="h-full rounded-[2px] bg-[#97251B] transition-[width] duration-500 ease-out motion-reduce:transition-none"
                :style="{ width: widthPct(item.participations) }"
                :aria-label="`Participations : ${fmt(item.participations)}`"
              />
            </div>
            <span class="w-10 shrink-0 text-right text-xs font-bold tabular-nums text-[#97251B]">
              {{ fmt(item.participations) }}
            </span>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
