<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import type { DisplayEventStatus } from '#shared/constants/statuses'
import { createCitySlug } from '#shared/utils/city-slug'
import { DATE_PENDING_LABEL } from '#shared/utils/event-time'
import { excerptText } from '#shared/utils/text'

const props = withDefaults(defineProps<{
  event: EventPublic
  selected?: boolean
  /** Lien titre + CTA (défaut : fiche publique) */
  to?: string
  /** Libellé du CTA (défaut : Plus de détails) */
  actionLabel?: string
  /** Affiche le CTA comme UiButton (admin) */
  actionAsButton?: boolean
  /** Masque le CTA (slot actions ou pas de CTA) */
  hideAction?: boolean
  /** Pas de zone cliquable globale (boutons externes) */
  staticCard?: boolean
}>(), {
  selected: false,
  actionLabel: 'Plus de détails\u00a0>',
  actionAsButton: false,
  hideAction: false,
  staticCard: false,
})

defineEmits<{ select: [] }>()
const slots = useSlots()
const { formatDate, categoryLabel } = useEventFormat()
const { isSupported, isParticipating } = useMyEngagements()

const href = computed(() => props.to ?? `/manifestations/${props.event.slug}`)
const iSupport = computed(() => isSupported(props.event.id))
const iParticipate = computed(() => isParticipating(props.event.id))
const hasActionsSlot = computed(() => Boolean(slots.actions))

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

const descriptionPreview = computed(() => excerptText(props.event.description || '', 90))
const cityPath = computed(() => `/manifestations/ville/${createCitySlug(props.event.cityName)}`)
</script>

<template>
  <article
    class="group relative border-l-[5px] px-3.5 py-2.5 transition duration-200 ease-out motion-reduce:transform-none"
    :class="[
      'rounded-[8px] border border-[#DDDAD3] border-l-[5px]',
      selected
        ? 'z-[1] -translate-y-0.5 border-l-[#9C6EE8] bg-[#111111] text-[#FFFCF4]'
        : ['bg-white', shell[event.displayStatus], 'hover:-translate-y-0.5 hover:shadow-lift'],
    ]"
    :aria-current="selected ? 'true' : undefined"
  >
    <div
      class="flex items-start gap-3"
      :class="staticCard ? '' : 'cursor-pointer'"
      :role="staticCard ? undefined : 'button'"
      :tabindex="staticCard ? undefined : 0"
      @click="!staticCard && $emit('select')"
      @keydown.enter.prevent="!staticCard && $emit('select')"
      @keydown.space.prevent="!staticCard && $emit('select')"
    >
      <div class="min-w-0 flex-1 text-left">
        <div class="flex flex-wrap items-center gap-x-2 gap-y-1">
          <StatusBadge :status="event.displayStatus" />
          <span
            v-if="iSupport"
            class="chip inline-flex items-center gap-1"
            :class="selected ? 'bg-[#9C6EE8] text-[#111111]' : 'bg-[#F0E8FC] text-[#4D257D]'"
          >
            <BrandIcon name="support" :size="11" />
            Je soutiens
          </span>
          <span
            v-if="iParticipate"
            class="chip inline-flex items-center gap-1"
            :class="selected ? 'bg-[#D1271C] text-[#FFFCF4]' : 'bg-[#FDEDEB] text-[#97251B]'"
          >
            <BrandIcon name="participate" :size="11" />
            Je participe
          </span>
          <span
            v-if="!event.startAt"
            class="chip bg-[#805200] text-[#FFFCF4]"
          >
            Date à venir
          </span>
          <span
            class="text-[11px] font-semibold uppercase tracking-wide"
            :class="selected ? 'text-[#FFFCF4]/55' : 'text-[#636363]'"
          >
            {{ categoryLabel(event.category) }}
          </span>
        </div>

        <p
          class="mt-1 text-xs font-bold"
          :class="selected ? 'text-[#9C6EE8]' : dateClass[event.displayStatus]"
        >
          {{ dateLabel }} ·
          <NuxtLink
            :to="cityPath"
            class="hover:underline"
            :class="selected ? 'text-[#9C6EE8]' : ''"
            @click.stop
          >{{ event.cityName }}</NuxtLink>
          <template v-if="event.locationRevealed">
            <span
              v-if="event.locationName"
              :class="selected ? 'text-[#FFFCF4]/55' : 'text-[#636363]'"
            > · {{ event.locationName }}</span>
            <span
              v-if="event.latitude == null || event.longitude == null"
              :class="selected ? 'text-[#FFFCF4]/55' : 'text-[#805200]'"
            > · Position carte à venir</span>
          </template>
          <span
            v-else
            class="font-semibold"
            :class="selected ? 'text-[#9C6EE8]' : 'text-[#805200]'"
          >
            · lieu précis à venir
          </span>
        </p>

        <h3
          class="mt-0.5 text-base font-extrabold leading-snug"
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
          v-if="descriptionPreview"
          class="mt-0.5 line-clamp-1 text-xs leading-snug"
          :class="selected ? 'text-[#FFFCF4]/65' : 'text-[#636363]'"
        >
          {{ descriptionPreview }}
        </p>

        <div class="mt-1.5 flex flex-wrap items-center justify-between gap-2">
          <div class="flex flex-wrap gap-1.5 text-[11px] font-bold">
            <span
              class="inline-flex items-center gap-1 rounded-full px-2 py-0.5"
              :class="selected
                ? 'border border-white/25 text-[#FFFCF4]'
                : 'border border-[#DDDAD3] text-[#4D257D]'"
            >
              <BrandIcon name="support" :size="12" />
              {{ event.counts.supports }}
            </span>
            <span
              class="inline-flex items-center gap-1 rounded-full px-2 py-0.5"
              :class="selected
                ? 'border border-white/25 text-[#FFFCF4]'
                : 'border border-[#DDDAD3] text-[#97251B]'"
            >
              <BrandIcon name="participate" :size="12" />
              {{ event.counts.participations }}
            </span>
            <span
              v-if="event.publicationStatus === 'draft'"
              class="inline-flex items-center rounded-full px-2 py-0.5"
              :class="selected ? 'border border-white/25 text-[#FFFCF4]' : 'border border-[#DDDAD3] text-[#805200]'"
            >
              Brouillon
            </span>
            <span
              v-else-if="event.publicationStatus === 'unpublished'"
              class="inline-flex items-center rounded-full px-2 py-0.5"
              :class="selected ? 'border border-white/25 text-[#FFFCF4]' : 'border border-[#DDDAD3] text-[#636363]'"
            >
              Dépublié
            </span>
          </div>
          <template v-if="!hideAction && !hasActionsSlot">
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
          </template>
        </div>
      </div>

      <div
        v-if="hasActionsSlot"
        class="flex shrink-0 flex-col gap-1.5"
        @click.stop
        @keydown.stop
      >
        <slot name="actions" />
      </div>
    </div>
  </article>
</template>
