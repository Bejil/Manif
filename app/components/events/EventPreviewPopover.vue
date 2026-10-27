<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'

const props = defineProps<{
  eventId: string | null
}>()

const emit = defineEmits<{
  close: []
}>()

const { formatDate, formatTimeRange, categoryLabel } = useEventFormat()

const { data: event, pending, error, refresh } = await useFetch<EventPublic>(
  () => (props.eventId ? `/api/events/${props.eventId}` : null),
  { watch: [() => props.eventId] },
)

const excerpt = computed(() => {
  const raw = event.value?.description?.replace(/\s+/g, ' ').trim() || ''
  if (raw.length <= 180) return raw
  return `${raw.slice(0, 180).trim()}…`
})

function onKeydown(e: KeyboardEvent) {
  if (e.key === 'Escape') emit('close')
}

onMounted(() => {
  if (import.meta.client) window.addEventListener('keydown', onKeydown)
})
onBeforeUnmount(() => {
  if (import.meta.client) window.removeEventListener('keydown', onKeydown)
})
</script>

<template>
  <div
    v-if="eventId"
    class="pointer-events-auto w-full max-w-md overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-lift"
    role="dialog"
    aria-modal="false"
    :aria-label="event?.title || 'Aperçu de la manifestation'"
  >
    <div class="flex items-start justify-between gap-3 border-b border-[#DDDAD3] bg-[#111111] px-4 py-3 text-[#FFFCF4]">
      <div class="min-w-0">
        <p class="text-[10px] font-bold uppercase tracking-[0.14em] text-[#9C6EE8]">Aperçu</p>
        <p v-if="pending" class="mt-1 text-sm text-[#FFFCF4]/70">Chargement…</p>
        <h3 v-else-if="event" class="mt-1 truncate text-base font-bold leading-snug">
          {{ event.title }}
        </h3>
        <p v-else class="mt-1 text-sm text-[#FFFCF4]/70">Manifestation introuvable</p>
      </div>
      <button
        type="button"
        class="shrink-0 rounded-[4px] px-2 py-1 text-lg leading-none text-[#FFFCF4]/80 hover:bg-white/10 hover:text-white"
        aria-label="Fermer"
        @click="emit('close')"
      >
        ×
      </button>
    </div>

    <div class="max-h-[min(70vh,28rem)] space-y-4 overflow-y-auto p-4">
      <p v-if="error" class="text-sm text-[#AD291F]">
        Impossible de charger la fiche.
        <button type="button" class="underline" @click="refresh()">Réessayer</button>
      </p>

      <template v-else-if="event">
        <div class="flex flex-wrap items-center gap-2">
          <StatusBadge :status="event.displayStatus" />
          <span class="text-xs font-semibold text-[#636363]">
            {{ categoryLabel(event.category) }}
          </span>
        </div>

        <dl class="space-y-1.5 text-sm text-[#454545]">
          <div class="flex gap-2">
            <dt class="shrink-0 font-bold text-[#111111]">Quand</dt>
            <dd>
              {{ formatDate(event.startAt, event.timezone) }}
              <span v-if="event.startAt" class="text-[#636363]">
                · {{ formatTimeRange(event.startAt, event.endAt, event.endIsEstimated, event.timezone) }}
              </span>
            </dd>
          </div>
          <div class="flex gap-2">
            <dt class="shrink-0 font-bold text-[#111111]">Où</dt>
            <dd>
              {{ event.cityName }}
              <template v-if="event.locationRevealed && event.locationName">
                · {{ event.locationName }}
              </template>
            </dd>
          </div>
        </dl>

        <p v-if="excerpt" class="text-sm leading-relaxed text-[#454545]">
          {{ excerpt }}
        </p>

        <EventEngagementCompact :key="event.id" :event="event" />

        <NuxtLink
          :to="`/manifestations/${event.slug}`"
          class="inline-flex w-full items-center justify-center rounded-[4px] bg-[#111111] px-4 py-2.5 text-sm font-bold text-[#FFFCF4] transition hover:bg-[#252525]"
        >
          Voir la fiche complète
        </NuxtLink>
      </template>
    </div>
  </div>
</template>
