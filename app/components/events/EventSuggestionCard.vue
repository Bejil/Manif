<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { DATE_PENDING_LABEL } from '#shared/utils/event-time'

const props = defineProps<{
  event: EventPublic
}>()

const { formatDate, categoryLabel } = useEventFormat()

const href = computed(() => `/manifestations/${props.event.slug}`)
const dateLabel = computed(() => {
  if (!props.event.startAt) return DATE_PENDING_LABEL
  return formatDate(props.event.startAt, props.event.timezone)
})
</script>

<template>
  <article
    class="flex h-full min-w-[14rem] flex-col rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#9C6EE8] bg-white px-3.5 py-2.5 transition duration-200 hover:-translate-y-0.5 hover:shadow-lift motion-reduce:transform-none"
  >
    <p class="text-[10px] font-bold uppercase tracking-[0.14em] text-[#636363]">
      {{ categoryLabel(event.category) }}
    </p>
    <p class="mt-1 text-xs font-bold text-[#4D257D]">
      {{ dateLabel }} · {{ event.cityName }}
    </p>
    <h3 class="mt-0.5 text-sm font-extrabold leading-snug text-[#111111]">
      <NuxtLink :to="href" class="hover:text-[#6735B6] hover:underline">
        {{ event.title }}
      </NuxtLink>
    </h3>
    <NuxtLink
      :to="href"
      class="mt-1.5 text-xs font-bold text-[#6735B6] underline-offset-2 hover:underline"
    >
      Voir la fiche&nbsp;>
    </NuxtLink>
  </article>
</template>
