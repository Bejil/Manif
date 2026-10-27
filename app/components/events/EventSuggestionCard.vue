<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { DATE_PENDING_LABEL } from '#shared/utils/event-time'
import { excerptText } from '#shared/utils/text'

const props = defineProps<{
  event: EventPublic
}>()

const { formatDate, categoryLabel } = useEventFormat()

const href = computed(() => `/manifestations/${props.event.slug}`)
const dateLabel = computed(() => {
  if (!props.event.startAt) return DATE_PENDING_LABEL
  return formatDate(props.event.startAt, props.event.timezone)
})
const descriptionPreview = computed(() => excerptText(props.event.description || '', 100))
</script>

<template>
  <article
    class="flex h-full min-w-[14rem] flex-col rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#9C6EE8] bg-white p-4 transition duration-200 hover:-translate-y-0.5 hover:shadow-lift motion-reduce:transform-none"
  >
    <p class="text-[10px] font-bold uppercase tracking-[0.14em] text-[#636363]">
      {{ categoryLabel(event.category) }}
    </p>
    <p class="mt-2 text-xs font-bold text-[#4D257D]">
      {{ dateLabel }} · {{ event.cityName }}
    </p>
    <h3 class="mt-1.5 text-base font-extrabold leading-snug text-[#111111]">
      <NuxtLink :to="href" class="hover:text-[#6735B6] hover:underline">
        {{ event.title }}
      </NuxtLink>
    </h3>
    <p
      v-if="descriptionPreview"
      class="mt-2 line-clamp-3 flex-1 text-sm leading-relaxed text-[#636363]"
    >
      {{ descriptionPreview }}
    </p>
    <NuxtLink
      :to="href"
      class="mt-3 text-xs font-bold text-[#6735B6] underline-offset-2 hover:underline"
    >
      Voir la fiche&nbsp;>
    </NuxtLink>
  </article>
</template>
