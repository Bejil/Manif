<script setup lang="ts">
export type AdminVBarItem = {
  id: string
  label: string
  value: number
  href?: string
}

const props = withDefaults(defineProps<{
  items: AdminVBarItem[]
  barClass?: string
  emptyLabel?: string
  height?: number
}>(), {
  barClass: 'bg-[#111111]',
  emptyLabel: 'Aucune donnée',
  height: 160,
})

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}

const max = computed(() => Math.max(1, ...props.items.map(i => i.value)))

function heightPct(value: number) {
  return `${Math.max(value > 0 ? 6 : 0, (value / max.value) * 100)}%`
}

function shortLabel(label: string) {
  return label.length > 14 ? `${label.slice(0, 13)}…` : label
}
</script>

<template>
  <p v-if="!items.length" class="text-sm text-[#636363]">{{ emptyLabel }}</p>
  <div v-else>
    <div
      class="flex items-end gap-2 border-b border-[#DDDAD3] pb-1"
      :style="{ height: `${height}px` }"
      role="img"
      :aria-label="`Histogramme de ${items.length} valeurs`"
    >
      <div
        v-for="item in items"
        :key="item.id"
        class="flex h-full min-w-0 flex-1 flex-col items-center justify-end gap-1"
      >
        <span class="text-[10px] font-bold tabular-nums text-[#454545]">{{ fmt(item.value) }}</span>
        <div class="flex w-full flex-1 items-end justify-center">
          <NuxtLink
            v-if="item.href"
            :to="item.href"
            class="mx-auto block w-full max-w-[2.25rem] rounded-t-[3px] transition-[height] duration-500 ease-out hover:opacity-80 motion-reduce:transition-none"
            :class="barClass"
            :style="{ height: heightPct(item.value) }"
            :title="`${item.label} : ${fmt(item.value)}`"
            :aria-label="`${item.label} : ${fmt(item.value)}`"
          />
          <div
            v-else
            class="mx-auto w-full max-w-[2.25rem] rounded-t-[3px] transition-[height] duration-500 ease-out motion-reduce:transition-none"
            :class="barClass"
            :style="{ height: heightPct(item.value) }"
            :title="`${item.label} : ${fmt(item.value)}`"
          />
        </div>
      </div>
    </div>
    <div class="mt-2 flex gap-2">
      <div
        v-for="item in items"
        :key="`${item.id}-label`"
        class="min-w-0 flex-1 text-center text-[10px] leading-tight text-[#636363]"
        :title="item.label"
      >
        {{ shortLabel(item.label) }}
      </div>
    </div>
  </div>
</template>
