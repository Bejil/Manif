<script setup lang="ts">
import { ALERT_RADIUS_OPTIONS, type AlertRadiusKm } from '#shared/constants/alerts'

const props = withDefaults(defineProps<{
  /** Préremplissage lieu (ex. ville de l’événement engagé) */
  initialLocationLabel?: string
  compact?: boolean
  idPrefix?: string
}>(), {
  initialLocationLabel: '',
  compact: false,
  idPrefix: 'alert',
})

const emit = defineEmits<{
  success: [{ needsConfirmation: boolean }]
}>()

const email = ref('')
const locationQuery = ref(props.initialLocationLabel || '')
const selected = ref<{
  label: string
  latitude: number
  longitude: number
} | null>(null)
const radiusKm = ref<string>('25')
const turnstileToken = ref('')
const turnstileRef = ref<{ reset: () => void } | null>(null)

const busy = ref(false)
const errorMsg = ref<string | null>(null)
/** Après envoi : le formulaire cède la place à un message. */
const done = ref<'pending' | 'active' | null>(null)
const submittedEmail = ref('')
const submittedLocation = ref('')

const suggestions = ref<Array<{
  label: string
  cityName: string
  postalCode: string | null
  latitude: number
  longitude: number
}>>([])
const suggestOpen = ref(false)
const suggestPending = ref(false)
let suggestTimer: ReturnType<typeof setTimeout> | null = null

async function resolveInitialLocation(label: string) {
  if (!label.trim() || selected.value) return
  locationQuery.value = label
  try {
    const res = await $fetch<{ items: typeof suggestions.value }>('/api/geo/suggest', {
      query: { q: label.trim() },
    })
    const first = res.items?.[0]
    if (first) pickSuggestion(first)
  }
  catch {
    /* l’utilisateur choisira manuellement */
  }
}

watch(() => props.initialLocationLabel, (label) => {
  if (!label || selected.value) return
  void resolveInitialLocation(label)
}, { immediate: true })

const radiusOptions = ALERT_RADIUS_OPTIONS.map(o => ({
  value: String(o.value),
  label: o.label,
}))

function onLocationInput(value: string) {
  locationQuery.value = value
  selected.value = null
  if (suggestTimer) clearTimeout(suggestTimer)
  if (value.trim().length < 2) {
    suggestions.value = []
    suggestOpen.value = false
    return
  }
  suggestTimer = setTimeout(() => void fetchSuggest(value.trim()), 280)
}

async function fetchSuggest(q: string) {
  suggestPending.value = true
  try {
    const res = await $fetch<{ items: typeof suggestions.value }>('/api/geo/suggest', {
      query: { q },
    })
    suggestions.value = res.items || []
    suggestOpen.value = suggestions.value.length > 0
  }
  catch {
    suggestions.value = []
    suggestOpen.value = false
  }
  finally {
    suggestPending.value = false
  }
}

function pickSuggestion(item: (typeof suggestions.value)[number]) {
  selected.value = {
    label: item.label,
    latitude: item.latitude,
    longitude: item.longitude,
  }
  locationQuery.value = item.label
  suggestions.value = []
  suggestOpen.value = false
}

function onLocationBlur() {
  window.setTimeout(() => {
    suggestOpen.value = false
  }, 180)
}

function resetForm() {
  done.value = null
  submittedEmail.value = ''
  submittedLocation.value = ''
  errorMsg.value = null
}

async function submit() {
  errorMsg.value = null
  if (!email.value.trim() || !selected.value) {
    errorMsg.value = selected.value
      ? 'Indiquez une adresse e-mail.'
      : 'Choisissez un lieu dans la liste de suggestions.'
    return
  }
  busy.value = true
  try {
    const mail = email.value.trim()
    const place = selected.value.label
    const res = await $fetch<{
      ok: boolean
      needsConfirmation: boolean
      mocked?: boolean
    }>('/api/alerts', {
      method: 'POST',
      body: {
        email: mail,
        locationLabel: place,
        latitude: selected.value.latitude,
        longitude: selected.value.longitude,
        radiusKm: Number(radiusKm.value) as AlertRadiusKm,
        turnstileToken: turnstileToken.value || undefined,
      },
    })
    submittedEmail.value = mail
    submittedLocation.value = place
    done.value = res.needsConfirmation ? 'pending' : 'active'
    emit('success', { needsConfirmation: res.needsConfirmation })
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string }, statusMessage?: string }
    errorMsg.value = err?.data?.statusMessage || err?.statusMessage || 'Inscription impossible.'
  }
  finally {
    busy.value = false
    turnstileRef.value?.reset()
  }
}

onBeforeUnmount(() => {
  if (suggestTimer) clearTimeout(suggestTimer)
})
</script>

<template>
  <div
    v-if="done === 'pending'"
    class="rounded-[4px] border border-[#E8D9F8] bg-[#F7F2FC] px-4 py-5"
    role="status"
  >
    <p class="text-xs font-bold uppercase tracking-[0.14em] text-[#4D257D]">
      Confirmation requise
    </p>
    <p class="mt-2 text-base font-bold text-[#111111]">
      Vérifiez votre boîte mail
    </p>
    <p class="mt-2 text-sm leading-relaxed text-[#454545]">
      Un e-mail vient d’être envoyé
      <template v-if="submittedEmail">
        à <strong class="text-[#111111]">{{ submittedEmail }}</strong>
      </template>
      .
      Cliquez sur le lien pour activer l’alerte
      <template v-if="submittedLocation">
        autour de <strong class="text-[#111111]">{{ submittedLocation }}</strong>
      </template>
      .
    </p>
    <p class="mt-3 text-xs text-[#636363]">
      Pensez à regarder les spams si vous ne le voyez pas.
    </p>
    <button
      type="button"
      class="mt-4 text-sm font-bold text-[#6735B6] hover:underline"
      @click="resetForm"
    >
      Utiliser une autre adresse
    </button>
  </div>

  <div
    v-else-if="done === 'active'"
    class="rounded-[4px] border border-[#C6E8D8] bg-[#E7F6EF] px-4 py-5"
    role="status"
  >
    <p class="text-xs font-bold uppercase tracking-[0.14em] text-[#206C4D]">
      Alerte active
    </p>
    <p class="mt-2 text-base font-bold text-[#111111]">
      C’est enregistré
    </p>
    <p class="mt-2 text-sm leading-relaxed text-[#454545]">
      Votre zone a été mise à jour
      <template v-if="submittedLocation">
        (<strong class="text-[#111111]">{{ submittedLocation }}</strong>)
      </template>
      . Vous recevrez un e-mail dès qu’une nouvelle manifestation y sera publiée.
    </p>
    <button
      type="button"
      class="mt-4 text-sm font-bold text-[#206C4D] hover:underline"
      @click="resetForm"
    >
      Modifier l’alerte
    </button>
  </div>

  <form
    v-else
    class="space-y-4"
    @submit.prevent="submit"
  >
    <UiInput
      :id="`${idPrefix}-email`"
      v-model="email"
      label="E-mail"
      type="email"
      required
      autocomplete="email"
      placeholder="vous@exemple.fr"
    />

    <div class="grid grid-cols-1 gap-4 sm:grid-cols-[minmax(0,1fr)_7.5rem] sm:items-start">
      <div class="relative min-w-0 space-y-1.5">
        <label
          :for="`${idPrefix}-location`"
          class="block text-sm font-bold text-[#111111]"
        >
          Lieu
          <span class="text-[#AD291F]" aria-hidden="true">*</span>
        </label>
        <input
          :id="`${idPrefix}-location`"
          :value="locationQuery"
          type="text"
          required
          autocomplete="off"
          placeholder="Ville ou code postal"
          class="min-h-[48px] w-full rounded-[4px] border-2 border-[#DDDAD3] bg-white px-3.5 py-2.5 text-[#111111] placeholder:text-[#636363] focus:border-[#6735B6] focus:outline-none focus:ring-2 focus:ring-[#9C6EE8]/35"
          @input="onLocationInput(($event.target as HTMLInputElement).value)"
          @focus="suggestOpen = suggestions.length > 0"
          @blur="onLocationBlur"
        >
        <p
          v-if="suggestPending"
          class="text-xs text-[#636363]"
        >
          Recherche…
        </p>
        <ul
          v-if="suggestOpen && suggestions.length"
          class="absolute z-20 mt-1 max-h-48 w-full overflow-auto rounded-[4px] border border-[#DDDAD3] bg-white py-1 shadow-soft"
          role="listbox"
        >
          <li
            v-for="item in suggestions"
            :key="`${item.label}-${item.latitude}`"
          >
            <button
              type="button"
              class="w-full px-3 py-2 text-left text-sm text-[#111111] hover:bg-[#F7F2FC]"
              @mousedown.prevent="pickSuggestion(item)"
            >
              {{ item.label }}
            </button>
          </li>
        </ul>
        <p
          v-if="selected"
          class="text-xs text-[#206C4D]"
        >
          Zone : {{ selected.label }}
        </p>
      </div>

      <UiSelect
        :id="`${idPrefix}-radius`"
        v-model="radiusKm"
        label="Rayon"
        required
        :options="radiusOptions"
      />
    </div>

    <TurnstileWidget
      ref="turnstileRef"
      v-model="turnstileToken"
      action="alert"
    />

    <p
      v-if="errorMsg"
      class="text-sm text-[#AD291F]"
      role="alert"
    >
      {{ errorMsg }}
    </p>

    <UiButton
      type="submit"
      :disabled="busy"
      :variant="compact ? 'violet' : 'red'"
      class="w-full sm:w-auto"
    >
      {{ busy ? 'Envoi…' : 'Activer l’alerte' }}
    </UiButton>

    <p class="text-[11px] leading-snug text-[#636363]">
      Double confirmation par e-mail. Désinscription en un clic.
      Une seule alerte par adresse — une nouvelle inscription met à jour le lieu et le rayon.
    </p>
  </form>
</template>
