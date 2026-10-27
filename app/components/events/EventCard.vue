<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import type { DisplayEventStatus } from '#shared/constants/statuses'
import { DATE_PENDING_LABEL } from '#shared/utils/event-time'

const props = withDefaults(defineProps<{
  event: EventPublic
  selected?: boolean
  /** Lien titre + CTA (défaut : fiche publique) */
  to?: string
  /** Libellé du CTA (défaut : Plus de détails) */
  actionLabel?: string
  /** Affiche le CTA comme UiButton (admin) */
  actionAsButton?: boolean
}>(), {
  selected: false,
  actionLabel: 'Plus de détails\u00a0>',
  actionAsButton: false,
})

defineEmits<{ select: [] }>()
const { formatDate, categoryLabel } = useEventFormat()
const { isSupported, isParticipating } = useMyEngagements()

const href = computed(() => props.to ?? `/manifestations/${props.event.slug}`)
const iSupport = computed(() => isSupported(props.event.id))
const iParticipate = computed(() => isParticipating(props.event.id))

/** Bordure gauche : signature par statut (hors sélection) */
const shell: Record<DisplayEventStatus, string> = {
  ongoing: 'border-l-[#D1271C]',
  upcoming: 'border-l-[#9C6EE8]',
  past: 'border-l-[#636363] opacity-90',
  cancelled: 'border-l-[#AD291F]',
  postponed: 'border-l-[#805200]',
}

const dateClass: Record<DisplayEventStatus, string> = {
  ongoing: 'text-[#97251B]',
  upcoming: 'text-[#4D257D]',
  past: 'text-[#454545]',
  cancelled: 'text-[#AD291F] line-through',
  postponed: 'text-[#805200]',
}

const titleClass: Record<DisplayEventStatus, string> = {
  ongoing: 'text-[#111111]',
  upcoming: 'text-[#111111]',
  past: 'text-[#454545]',
  cancelled: 'text-[#636363] line-through',
  postponed: 'text-[#111111]',
}

const dateLabel = computed(() => {
  if (!props.event.startAt) return DATE_PENDING_LABEL
  return formatDate(props.event.startAt, props.event.timezone)
})
</script>

<template>
  <article
    class="group relative border-l-[5px] p-5 transition duration-200 ease-out motion-reduce:transform-none"
    :class="[
      'rounded-[8px] border border-[#DDDAD3] border-l-[5px]',
      selected
        ? 'z-[1] -translate-y-1 border-l-[#9C6EE8] bg-[#111111] text-[#FFFCF4]'
        : ['bg-white', shell[event.displayStatus], 'hover:-translate-y-0.5 hover:shadow-lift'],
    ]"
    :aria-current="selected ? 'true' : undefined"
  >
    <div
      role="button"
      tabindex="0"
      class="w-full cursor-pointer text-left"
      @click="$emit('select')"
      @keydown.enter.prevent="$emit('select')"
      @keydown.space.prevent="$emit('select')"
    >
      <div class="flex flex-wrap items-center gap-2">
        <StatusBadge :status="event.displayStatus" />
        <span
          v-if="iSupport"
          class="chip inline-flex items-center gap-1"
          :class="selected ? 'bg-[#9C6EE8] text-[#111111]' : 'bg-[#F0E8FC] text-[#4D257D]'"
        >
          <BrandIcon name="support" :size="12" />
          Je soutiens
        </span>
        <span
          v-if="iParticipate"
          class="chip inline-flex items-center gap-1"
          :class="selected ? 'bg-[#D1271C] text-[#FFFCF4]' : 'bg-[#FDEDEB] text-[#97251B]'"
        >
          <BrandIcon name="participate" :size="12" />
          Je participe
        </span>
        <span
          v-if="!event.startAt"
          class="chip bg-[#805200] text-[#FFFCF4]"
        >
          Date à venir
        </span>
        <span
          class="text-xs font-semibold uppercase tracking-wide"
          :class="selected ? 'text-[#FFFCF4]/55' : 'text-[#636363]'"
        >
          {{ categoryLabel(event.category) }}
        </span>
      </div>

      <p
        class="mt-3 text-sm font-bold"
        :class="selected ? 'text-[#9C6EE8]' : dateClass[event.displayStatus]"
      >
        {{ dateLabel }} · {{ event.cityName }}
      </p>

      <h3
        class="mt-1.5 text-lg font-extrabold leading-snug"
        :class="selected ? 'text-[#FFFCF4]' : [titleClass[event.displayStatus], 'group-hover:text-[#6735B6]']"
      >
        <NuxtLink
          :to="href"
          class="hover:underline"
          :class="selected ? 'decoration-[#9C6EE8]' : ''"
          @click.stop
        >
          {{ event.title }}
        </NuxtLink>
      </h3>

      <p
        class="mt-1 text-sm"
        :class="selected ? 'text-[#FFFCF4]/70' : 'text-[#454545]'"
      >
        <template v-if="event.locationRevealed">
          {{ event.locationName }}
          <span
            v-if="event.latitude == null || event.longitude == null"
            class="ml-1"
            :class="selected ? 'text-[#FFFCF4]/55' : 'text-[#805200]'"
          >· Position carte à venir</span>
        </template>
        <span
          v-else
          :class="selected ? 'text-[#FFFCF4]/70' : 'text-[#454545]'"
        >
          {{ event.cityName }}
          <span
            class="font-semibold"
            :class="selected ? 'text-[#9C6EE8]' : 'text-[#805200]'"
          >
            · lieu précis à venir
          </span>
        </span>
      </p>

      <div class="mt-4 flex flex-wrap items-end justify-between gap-3">
        <div class="flex flex-wrap gap-2 text-xs font-bold">
          <span
            class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1.5"
            :class="selected
              ? 'border border-white/25 text-[#FFFCF4]'
              : 'border border-[#DDDAD3] text-[#4D257D]'"
          >
            <BrandIcon name="support" :size="14" />
            {{ event.counts.supports }} soutien{{ event.counts.supports > 1 ? 's' : '' }}
          </span>
          <span
            class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1.5"
            :class="selected
              ? 'border border-white/25 text-[#FFFCF4]'
              : 'border border-[#DDDAD3] text-[#97251B]'"
          >
            <BrandIcon name="participate" :size="14" />
            {{ event.counts.participations }} déclarée{{ event.counts.participations > 1 ? 's' : '' }}
          </span>
        </div>
        <NuxtLink
          v-if="actionAsButton"
          :to="href"
          class="ml-auto shrink-0"
          @click.stop
        >
          <UiButton size="sm" type="button">{{ actionLabel }}</UiButton>
        </NuxtLink>
        <NuxtLink
          v-else
          :to="href"
          class="ml-auto shrink-0 text-xs font-bold underline-offset-2 hover:underline"
          :class="selected ? 'text-[#9C6EE8]' : 'text-[#6735B6]'"
          @click.stop
        >
          {{ actionLabel }}
        </NuxtLink>
      </div>
    </div>
  </article>
</template>
