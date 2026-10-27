<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import {
  canDeclareParticipation,
  participationButtonLabel,
} from '#shared/utils/event-time'

const props = withDefaults(defineProps<{
  event: EventPublic
  shareUrl: string
  /** Sélecteur CSS du bloc soutien/participation */
  targetSelector?: string
}>(), {
  targetSelector: '#event-engagement-panel',
})

const showBar = ref(true)
const shareMenu = ref<{ openMenu: () => void } | null>(null)
const { getLocalState } = useParticipationToken(props.event.id)
const state = reactive(getLocalState())

const timeInput = computed(() => ({
  startAt: props.event.startAt,
  endAt: props.event.endAt,
  endIsEstimated: props.event.endIsEstimated,
  timezone: props.event.timezone,
  statusOverride: props.event.eventStatusOverride,
}))

const participationOpen = computed(() => canDeclareParticipation(timeInput.value))
const participateLabel = computed(() =>
  participationButtonLabel(timeInput.value) || 'Je participe',
)

let observer: IntersectionObserver | null = null

function refreshLocalState() {
  Object.assign(state, getLocalState())
}

function scrollToPanel() {
  if (!import.meta.client) return
  const el = document.querySelector(props.targetSelector)
  el?.scrollIntoView({ behavior: 'smooth', block: 'start' })
}

function onShare() {
  shareMenu.value?.openMenu()
}

function observePanel() {
  if (!import.meta.client) return
  const target = document.querySelector(props.targetSelector)
  if (!target) return

  observer?.disconnect()
  observer = new IntersectionObserver(
    ([entry]) => {
      showBar.value = !(entry?.isIntersecting && (entry.intersectionRatio ?? 0) >= 0.12)
      if (!showBar.value) refreshLocalState()
    },
    {
      root: null,
      threshold: [0, 0.12, 0.3],
      rootMargin: '0px 0px -10% 0px',
    },
  )
  observer.observe(target)
}

function onEngagementChanged(e: Event) {
  const detail = (e as CustomEvent<{ eventId?: string }>).detail
  if (detail?.eventId && detail.eventId !== props.event.id) return
  refreshLocalState()
}

onMounted(() => {
  if (!import.meta.client) return
  refreshLocalState()
  observePanel()
  window.addEventListener('focus', refreshLocalState)
  window.addEventListener('manif:engagement-changed', onEngagementChanged)
  // Panneau parfois monté après le premier paint (ClientOnly / layout)
  window.setTimeout(observePanel, 400)
})

onBeforeUnmount(() => {
  if (!import.meta.client) return
  window.removeEventListener('focus', refreshLocalState)
  window.removeEventListener('manif:engagement-changed', onEngagementChanged)
  observer?.disconnect()
  observer = null
})

watch(() => props.event.id, () => {
  refreshLocalState()
  nextTick(observePanel)
})
</script>

<template>
  <ClientOnly>
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="translate-y-4 opacity-0"
        enter-to-class="translate-y-0 opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="translate-y-0 opacity-100"
        leave-to-class="translate-y-4 opacity-0"
      >
        <div
          v-show="showBar"
          class="fixed bottom-[max(1rem,env(safe-area-inset-bottom))] right-3 z-[9000] flex flex-col items-end gap-2.5 lg:hidden"
          role="toolbar"
          aria-label="Actions rapides"
        >
          <button
            type="button"
            class="flex size-12 items-center justify-center rounded-full border border-[#111111] bg-white text-[#111111] shadow-lift transition hover:bg-[#F4F1EA] active:scale-95"
            aria-label="Partager"
            @click="onShare"
          >
            <BrandIcon name="share" :size="20" />
          </button>

          <button
            type="button"
            class="flex size-12 items-center justify-center rounded-full border shadow-lift transition active:scale-95"
            :class="state.supported
              ? 'border-[#6735B6] bg-[#F0E8FC] text-[#4D257D] ring-2 ring-[#6735B6]'
              : 'border-[#6735B6]/35 bg-[#F0E8FC] text-[#4D257D] hover:brightness-95'"
            :aria-label="state.supported ? 'Soutien enregistré — voir le panneau' : 'Je soutiens'"
            :aria-pressed="state.supported"
            @click="scrollToPanel"
          >
            <BrandIcon name="support" :size="20" />
          </button>

          <button
            type="button"
            class="flex size-12 items-center justify-center rounded-full border shadow-lift transition active:scale-95 disabled:opacity-55"
            :class="state.participating
              ? 'border-[#D1271C] bg-[#FDEDEB] text-[#97251B] ring-2 ring-[#D1271C]'
              : 'border-[#D1271C]/35 bg-[#FDEDEB] text-[#97251B] hover:brightness-95'"
            :aria-label="state.participating ? 'Participation enregistrée — voir le panneau' : participateLabel"
            :aria-pressed="state.participating"
            :disabled="!participationOpen && !state.participating"
            @click="scrollToPanel"
          >
            <BrandIcon name="participate" :size="20" />
          </button>
        </div>
      </Transition>

      <EventShareMenu
        ref="shareMenu"
        hide-trigger
        :title="event.title"
        :city-name="event.cityName"
        :url="shareUrl"
      />
    </Teleport>
  </ClientOnly>
</template>
