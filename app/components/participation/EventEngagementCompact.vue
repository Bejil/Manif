<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import type { EngagementAction, EngagementState } from '#shared/types/engagement'
import {
  canDeclareParticipation,
  participationButtonLabel,
} from '#shared/utils/event-time'
import { isFlagEnabled } from '#shared/utils/flags'

const props = defineProps<{ event: EventPublic }>()

const config = useRuntimeConfig()
const { getOrCreateToken, getLocalState, setLocalState } = useParticipationToken(props.event.id)

const collectionEnabled = computed(() =>
  isFlagEnabled(config.public.engagementsEnabled),
)

const counts = reactive({
  supports: props.event.counts.supports,
  participations: props.event.counts.participations,
})
const state = reactive<EngagementState>(getLocalState())
const loading = ref(false)
const message = ref<string | null>(null)
const error = ref<string | null>(null)
const turnstileToken = ref('')
const turnstileRef = ref<{ reset: () => void } | null>(null)

const consentKey = 'manif:participation-consent-v1'
const consented = ref(false)

onMounted(() => {
  if (import.meta.client) consented.value = localStorage.getItem(consentKey) === '1'
})

function acceptConsent() {
  consented.value = true
  if (import.meta.client) localStorage.setItem(consentKey, '1')
}

watch(() => props.event.id, () => {
  Object.assign(state, getLocalState())
  counts.supports = props.event.counts.supports
  counts.participations = props.event.counts.participations
  message.value = null
  error.value = null
})

watch(() => props.event.counts, (c) => {
  counts.supports = c.supports
  counts.participations = c.participations
}, { deep: true })

const timeInput = computed(() => ({
  startAt: props.event.startAt,
  endAt: props.event.endAt,
  endIsEstimated: props.event.endIsEstimated,
  timezone: props.event.timezone,
  statusOverride: props.event.eventStatusOverride,
}))

const participationOpen = computed(() => canDeclareParticipation(timeInput.value))
const participateLabel = computed(() => participationButtonLabel(timeInput.value) || 'Participer')

async function run(action: EngagementAction) {
  error.value = null
  message.value = null
  if (!collectionEnabled.value) {
    error.value = 'Collecte désactivée'
    return
  }
  if (!consented.value && !action.startsWith('withdraw')) {
    error.value = 'Acceptez d’abord le traitement des données.'
    return
  }
  loading.value = true
  try {
    const token = getOrCreateToken()
    if (action.startsWith('withdraw')) {
      const field = action === 'withdraw_support' ? 'support' : 'participate'
      const res = await $fetch<{
        counts: { supports: number, participations: number }
        state: EngagementState
      }>(`/api/events/${props.event.id}/participation`, {
        method: 'DELETE',
        body: { field, eventScopedToken: token },
      })
      Object.assign(counts, res.counts)
      Object.assign(state, res.state)
      setLocalState(res.state)
      message.value = action === 'withdraw_support' ? 'Soutien retiré' : 'Participation retirée'
    }
    else {
      const res = await $fetch<{
        counts: { supports: number, participations: number }
        state: EngagementState
      }>(`/api/events/${props.event.id}/participation`, {
        method: 'PUT',
        body: { action, eventScopedToken: token, turnstileToken: turnstileToken.value || undefined },
      })
      Object.assign(counts, res.counts)
      Object.assign(state, res.state)
      setLocalState(res.state)
      message.value = action === 'support' ? 'Soutien enregistré' : 'Participation déclarée'
      useAlertPrompt().maybePrompt({ cityName: props.event.cityName })
      // Token Turnstile à usage unique — nouveau challenge pour le prochain engagement
      turnstileRef.value?.reset()
    }
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string }, statusMessage?: string }
    error.value = err?.data?.statusMessage || err?.statusMessage || 'Une erreur est survenue.'
  }
  finally {
    loading.value = false
  }
}

function toggleSupport() {
  if (loading.value || !collectionEnabled.value) return
  run(state.supported ? 'withdraw_support' : 'support')
}

function toggleParticipate() {
  if (loading.value || !collectionEnabled.value) return
  if (!participationOpen.value && !state.participating) {
    error.value = 'Participation fermée'
    return
  }
  if (!participationOpen.value) return
  run(state.participating ? 'withdraw_participate' : 'participate')
}
</script>

<template>
  <div class="space-y-3">
    <div
      v-if="!collectionEnabled"
      class="rounded-[4px] bg-[#F4F1EA] px-3 py-2 text-xs text-[#805200]"
    >
      Collecte temporairement désactivée.
    </div>

    <template v-else>
      <div
        v-if="!consented"
        class="rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] p-3 text-xs text-[#454545]"
      >
        <p class="font-bold text-[#111111]">Sans compte — jeton local, annulable.</p>
        <label class="mt-2 flex cursor-pointer items-start gap-2">
          <input
            type="checkbox"
            class="mt-0.5 accent-[#6735B6]"
            :checked="false"
            @change="(e) => (e.target as HTMLInputElement).checked && acceptConsent()"
          >
          <span>
            J’accepte l’enregistrement.
            <NuxtLink to="/confidentialite" class="text-[#6735B6] underline" @click.stop>Confidentialité</NuxtLink>
          </span>
        </label>
      </div>

      <template v-else>
        <TurnstileWidget ref="turnstileRef" v-model="turnstileToken" action="engage" />
        <div class="grid grid-cols-2 gap-2">
          <button
            type="button"
            class="rounded-[4px] border px-2 py-2.5 text-center transition hover:brightness-95 disabled:opacity-60"
            :class="state.supported
              ? 'border-[#6735B6] bg-[#F0E8FC] ring-2 ring-inset ring-[#6735B6]'
              : 'border-[#DDDAD3] bg-[#F0E8FC]'"
            :disabled="loading"
            :aria-pressed="state.supported"
            @click="toggleSupport"
          >
            <BrandIcon name="support" :size="18" class="mx-auto text-[#4D257D]" />
            <p class="mt-1 text-sm font-extrabold tabular-nums text-[#4D257D]">
              {{ counts.supports.toLocaleString('fr-FR') }}
            </p>
            <p class="text-[10px] font-bold uppercase tracking-wide text-[#4D257D]">
              {{ state.supported ? 'Soutenu' : 'Soutenir' }}
            </p>
          </button>
          <button
            type="button"
            class="rounded-[4px] border px-2 py-2.5 text-center transition hover:brightness-95 disabled:opacity-60"
            :class="[
              state.participating
                ? 'border-[#D1271C] bg-[#FDEDEB] ring-2 ring-inset ring-[#D1271C]'
                : 'border-[#DDDAD3] bg-[#FDEDEB]',
              !participationOpen && !state.participating ? 'opacity-70' : '',
            ]"
            :disabled="loading || (!participationOpen && !state.participating)"
            :aria-pressed="state.participating"
            @click="toggleParticipate"
          >
            <BrandIcon name="participate" :size="18" class="mx-auto text-[#97251B]" />
            <p class="mt-1 text-sm font-extrabold tabular-nums text-[#97251B]">
              {{ counts.participations.toLocaleString('fr-FR') }}
            </p>
            <p class="text-[10px] font-bold uppercase tracking-wide text-[#97251B]">
              {{ state.participating ? 'Participé' : participateLabel }}
            </p>
          </button>
        </div>
      </template>
    </template>

    <p v-if="message" class="text-xs font-semibold text-[#206C4D]" role="status">{{ message }}</p>
    <p v-if="error" class="text-xs text-[#AD291F]" role="alert">{{ error }}</p>
  </div>
</template>
