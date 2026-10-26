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
  isFlagEnabled(
    config.public.engagementsEnabled
    ?? config.public.participationEnabled,
  ),
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

const timeInput = computed(() => ({
  startAt: props.event.startAt,
  endAt: props.event.endAt,
  endIsEstimated: props.event.endIsEstimated,
  timezone: props.event.timezone,
  statusOverride: props.event.eventStatusOverride,
}))

const participationOpen = computed(() => canDeclareParticipation(timeInput.value))
const participateLabel = computed(() => participationButtonLabel(timeInput.value))

const supportHint = computed(() =>
  state.supported ? 'Soutien enregistré — cliquer pour annuler' : 'Je soutiens le mouvement',
)

const participateHint = computed(() => {
  if (!participationOpen.value) {
    return state.participating
      ? 'Participation déclarée (fermeture)'
      : 'Participation fermée'
  }
  if (state.participating) return 'Participation déclarée — cliquer pour annuler'
  return participateLabel.value || 'Je vais participer'
})

watch(() => props.event.counts, (c) => {
  counts.supports = c.supports
  counts.participations = c.participations
}, { deep: true })

async function run(action: EngagementAction) {
  error.value = null
  message.value = null
  if (!collectionEnabled.value) {
    error.value = 'La collecte est désactivée.'
    return
  }
  if (!consented.value && !action.startsWith('withdraw')) {
    error.value = 'Veuillez d\'abord accepter l\'information sur le traitement des données.'
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
        body: { field, eventScopedToken: token, turnstileToken: turnstileToken.value || undefined },
      })
      Object.assign(counts, res.counts)
      Object.assign(state, res.state)
      setLocalState(res.state)
      message.value = action === 'withdraw_support' ? 'Soutien retiré.' : 'Participation retirée.'
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
      message.value = action === 'support' ? 'Soutien enregistré.' : 'Participation déclarée.'
    }
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string }, statusMessage?: string }
    error.value = err?.data?.statusMessage || err?.statusMessage || 'Une erreur est survenue.'
  }
  finally {
    loading.value = false
    // Token single-use — reset pour la prochaine action
    turnstileRef.value?.reset()
  }
}

function toggleSupport() {
  if (loading.value || !collectionEnabled.value) return
  run(state.supported ? 'withdraw_support' : 'support')
}

function toggleParticipate() {
  if (loading.value || !collectionEnabled.value) return
  if (!participationOpen.value) {
    if (!state.participating) {
      error.value = props.event.eventStatusOverride === 'cancelled'
        ? 'Manifestation annulée — participation fermée.'
        : 'Manifestation terminée — participation fermée.'
      message.value = null
    }
    return
  }
  run(state.participating ? 'withdraw_participate' : 'participate')
}
</script>

<template>
  <section class="overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-soft">
    <div class="border-b border-[#DDDAD3] bg-[#111111] px-5 py-4 text-[#FFFCF4]">
      <h2 class="font-display text-2xl tracking-wide">Soutenir ou participer</h2>
      <p class="mt-1 text-sm text-[#FFFCF4]/70">
        Deux actions indépendantes, sans compte. Cliquez sur un compteur pour basculer.
      </p>
    </div>

    <div class="grid grid-cols-2">
      <button
        type="button"
        class="border-r border-[#DDDAD3] bg-[#F0E8FC] px-4 py-5 text-center transition hover:brightness-95 focus-visible:z-10 disabled:cursor-not-allowed disabled:opacity-60"
        :class="state.supported ? 'ring-2 ring-inset ring-[#6735B6]' : ''"
        :disabled="loading || !collectionEnabled"
        :aria-pressed="state.supported"
        :aria-label="supportHint"
        @click="toggleSupport"
      >
        <BrandIcon name="support" :size="22" class="mx-auto mb-2 text-[#4D257D]" />
        <p class="mf-count text-[#4D257D]">{{ counts.supports.toLocaleString('fr-FR') }}</p>
        <p class="mt-1 text-[11px] font-bold uppercase tracking-wide text-[#4D257D]">Soutiens</p>
        <p class="mt-2 text-[11px] font-semibold leading-snug text-[#4D257D]/80">
          {{ supportHint }}
        </p>
      </button>

      <button
        type="button"
        class="bg-[#FDEDEB] px-4 py-5 text-center transition hover:brightness-95 focus-visible:z-10 disabled:cursor-not-allowed disabled:opacity-60"
        :class="[
          state.participating ? 'ring-2 ring-inset ring-[#D1271C]' : '',
          !participationOpen && !state.participating ? 'opacity-70' : '',
        ]"
        :disabled="loading || !collectionEnabled || (!participationOpen && !state.participating)"
        :aria-pressed="state.participating"
        :aria-label="participateHint"
        @click="toggleParticipate"
      >
        <BrandIcon name="participate" :size="22" class="mx-auto mb-2 text-[#97251B]" />
        <p class="mf-count text-[#97251B]">{{ counts.participations.toLocaleString('fr-FR') }}</p>
        <p class="mt-1 text-[11px] font-bold uppercase tracking-wide text-[#97251B]">Participations déclarées</p>
        <p class="mt-2 text-[11px] font-semibold leading-snug text-[#97251B]/80">
          {{ participateHint }}
        </p>
      </button>
    </div>

    <div class="space-y-4 p-5">
      <p class="text-xs leading-relaxed text-[#454545]">
        Déclarations volontaires — pas un comptage officiel des personnes présentes.
        <NuxtLink to="/comptage" class="font-semibold text-[#6735B6] underline">Méthodologie</NuxtLink>
      </p>

      <div
        v-if="!collectionEnabled"
        class="rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] p-3 text-sm text-[#805200]"
      >
        Collecte temporairement désactivée.
      </div>

      <div v-else class="flex flex-col gap-3">
        <div
          v-if="!consented"
          class="rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] p-4 text-sm"
        >
          <p class="font-bold text-[#111111]">En toute transparence</p>
          <ul class="mt-2 list-disc space-y-1 pl-4 text-xs text-[#454545]">
            <li>Jeton local pour cet événement — pas de compte.</li>
            <li>Peut révéler une opinion (donnée sensible).</li>
            <li>Ce n’est pas un anonymat juridique complet.</li>
            <li>Chaque action est annulable séparément.</li>
          </ul>
          <label class="mt-3 flex cursor-pointer items-start gap-2 text-sm">
            <input
              type="checkbox"
              class="mt-1 accent-[#6735B6]"
              :checked="false"
              @change="(e) => (e.target as HTMLInputElement).checked && acceptConsent()"
            >
            <span>
              J’ai lu ces informations et j’accepte l’enregistrement.
              <NuxtLink to="/confidentialite" class="text-[#6735B6] underline" @click.stop>Confidentialité</NuxtLink>.
            </span>
          </label>
        </div>

        <template v-else>
          <TurnstileWidget ref="turnstileRef" v-model="turnstileToken" action="engage" />
          <p
            v-if="state.participating && !participationOpen"
            class="rounded-[4px] bg-[#FDEDEB] px-3 py-2.5 text-sm text-[#97251B]"
          >
            Votre participation déclarée reste comptabilisée. Déclaration fermée.
          </p>
        </template>
      </div>

      <p v-if="message" class="text-sm font-semibold text-[#206C4D]" role="status">{{ message }}</p>
      <p v-if="error" class="text-sm text-[#AD291F]" role="alert">{{ error }}</p>
    </div>
  </section>
</template>
