<script setup lang="ts">
const props = defineProps<{
  views: number
  supports: number
  participations: number
}>()

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}

const total = computed(() => Math.max(1, props.views + props.supports + props.participations))

const parts = computed(() => [
  { key: 'views', label: 'Vues', value: props.views, class: 'bg-[#454545]' },
  { key: 'supports', label: 'Soutiens', value: props.supports, class: 'bg-[#4D257D]' },
  { key: 'participations', label: 'Participations', value: props.participations, class: 'bg-[#97251B]' },
])
</script>

<template>
  <div>
    <div
      class="flex h-4 overflow-hidden rounded-[4px] bg-[#F0EDE6]"
      role="img"
      :aria-label="`Répartition : ${fmt(views)} vues, ${fmt(supports)} soutiens, ${fmt(participations)} participations`"
    >
      <div
        v-for="part in parts"
        :key="part.key"
        class="h-full transition-[width] duration-500 ease-out motion-reduce:transition-none"
        :class="part.class"
        :style="{ width: `${(part.value / total) * 100}%` }"
        :title="`${part.label} : ${fmt(part.value)}`"
      />
    </div>
    <ul class="mt-3 flex flex-wrap gap-x-5 gap-y-2 text-sm">
      <li v-for="part in parts" :key="part.key" class="inline-flex items-center gap-2">
        <span class="size-2.5 shrink-0 rounded-[2px]" :class="part.class" aria-hidden="true" />
        <span class="text-[#636363]">{{ part.label }}</span>
        <span class="font-bold tabular-nums text-[#111111]">{{ fmt(part.value) }}</span>
      </li>
    </ul>
  </div>
</template>
