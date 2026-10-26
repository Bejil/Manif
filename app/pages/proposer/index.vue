<script setup lang="ts">
import { EVENT_CATEGORIES } from '#shared/constants/categories'

import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.proposer.title,
  description: SEO.proposer.description,
  ogTitle: SEO.proposer.title,
  ogDescription: SEO.proposer.description,
})

const form = reactive({
  title: '',
  description: '',
  category: 'autre',
  cityName: '',
  locationName: '',
  /** '' = immédiat ; sinon heures avant le début */
  locationRevealHoursBefore: '' as string,
  dateToConfirm: false,
  date: '',
  startTime: '',
  endTime: '',
  organizerName: '',
  sourceUrl: '',
  practicalInfo: '',
  proposerEmail: '',
})

const revealOptions = [
  { value: '', label: 'Immédiatement à la publication' },
  { value: '6', label: '6 heures avant le début' },
  { value: '12', label: '12 heures avant le début' },
  { value: '24', label: '24 heures avant le début' },
  { value: '48', label: '48 heures avant le début' },
  { value: '72', label: '72 heures avant le début' },
  { value: '168', label: '7 jours avant le début' },
]

const similar = ref<Array<{ slug: string, title: string, cityName: string, startAt: string }>>([])
const submitting = ref(false)
const done = ref(false)
const error = ref<string | null>(null)
const devLink = ref<string | null>(null)
const turnstileToken = ref('')
const turnstileRef = ref<{ reset: () => void } | null>(null)

watch(() => form.dateToConfirm, (tba) => {
  if (tba) {
    form.date = ''
    form.startTime = ''
    form.endTime = ''
    form.locationRevealHoursBefore = ''
    similar.value = []
  }
})

async function checkSimilar() {
  if (form.dateToConfirm || form.title.length < 5 || !form.cityName || !form.date) {
    similar.value = []
    return
  }
  try {
    const res = await $fetch<{ items: typeof similar.value }>('/api/submissions/similar', {
      query: {
        title: form.title,
        cityName: form.cityName,
        date: form.date,
      },
    })
    similar.value = res.items
  }
  catch {
    similar.value = []
  }
}

async function onSubmit() {
  error.value = null
  submitting.value = true
  try {
    const res = await $fetch<{
      id: string
      similarEvents: typeof similar.value
      emailMocked?: boolean
      devLink?: string
    }>('/api/submissions', {
      method: 'POST',
      body: { ...form, turnstileToken: turnstileToken.value || undefined },
    })
    similar.value = res.similarEvents || similar.value
    done.value = true
    if (res.devLink) devLink.value = res.devLink
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string, data?: unknown } }
    error.value = err?.data?.statusMessage || 'Envoi impossible. Vérifiez le formulaire.'
    turnstileRef.value?.reset()
  }
  finally {
    submitting.value = false
  }
}
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Proposer</p>
      <h1 class="mf-display mf-h2 mt-3 max-w-3xl text-[#FFFCF4]">
        Proposer une<br>manifestation
      </h1>
      <p class="mt-4 max-w-xl text-[#FFFCF4]/75">
        Ajoutez un rassemblement pacifique et licite à l’agenda. Aucun compte :
        votre e-mail sert uniquement à la vérification. Chaque proposition est examinée avant publication.
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
      <div
        v-if="done"
        class="rounded-[8px] border border-[#9C6EE8] bg-[#F0E8FC] p-6"
      >
        <h2 class="mf-display text-2xl text-[#111111]">Vérifiez votre e-mail</h2>
        <ul class="mt-3 list-disc space-y-2 pl-5 text-sm text-[#252525]">
          <li>Un message de confirmation vient de partir.</li>
          <li>Le lien est valable 24 heures.</li>
          <li>Après confirmation, votre proposition rejoindra la file de modération.</li>
        </ul>
        <p v-if="devLink" class="mt-4 break-all rounded-[4px] bg-white p-3 text-xs text-[#454545]">
          [DEV] Lien de vérification :
          <a :href="devLink" class="text-[#6735B6] underline">{{ devLink }}</a>
        </p>
      </div>

      <form v-else class="space-y-5" @submit.prevent="onSubmit">
        <UiInput
          id="title"
          v-model="form.title"
          label="Titre"
          required
          maxlength="160"
          hint="Court et lisible, ex. « Marche pour le climat — République »"
          @blur="checkSimilar"
        />
        <UiTextarea
          id="description"
          v-model="form.description"
          label="Description"
          required
          :rows="5"
          maxlength="5000"
          hint="Contexte, parcours éventuel, consignes utiles — sans données personnelles inutiles."
        />
        <UiSelect
          id="category"
          v-model="form.category"
          label="Catégorie"
          required
          :options="EVENT_CATEGORIES.map(c => ({ value: c.id, label: c.label }))"
        />
        <div class="grid gap-4 sm:grid-cols-2">
          <UiInput id="city" v-model="form.cityName" label="Ville" required @blur="checkSimilar" />
          <UiInput
            id="location"
            v-model="form.locationName"
            label="Lieu de rassemblement"
            required
            hint="Toujours renseigné pour la modération. Peut rester masqué au public jusqu’à une heure choisie."
          />
        </div>
        <label class="flex cursor-pointer items-start gap-2 rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] p-3 text-sm">
          <input v-model="form.dateToConfirm" type="checkbox" class="mt-0.5 accent-[#6735B6]">
          <span>
            <span class="font-bold text-[#111111]">Date à confirmer plus tard</span>
            <span class="mt-0.5 block text-xs text-[#454545]">
              La manifestation restera visible avec la mention « Date à venir ».
            </span>
          </span>
        </label>
        <div v-if="!form.dateToConfirm" class="grid gap-4 sm:grid-cols-3">
          <UiInput id="date" v-model="form.date" label="Date" type="date" required @blur="checkSimilar" />
          <UiInput id="start" v-model="form.startTime" label="Heure de début" type="time" required />
          <UiInput id="end" v-model="form.endTime" label="Heure de fin" type="time" hint="Facultatif — sinon fin estimée à +3 h" />
        </div>
        <UiSelect
          v-if="!form.dateToConfirm"
          id="location-reveal"
          v-model="form.locationRevealHoursBefore"
          label="Publication du lieu précis"
          :options="revealOptions"
        />
        <UiInput id="organizer" v-model="form.organizerName" label="Organisateur" hint="Facultatif" />
        <UiInput id="source" v-model="form.sourceUrl" label="URL source" type="url" hint="Facultatif" />
        <UiTextarea id="practical" v-model="form.practicalInfo" label="Informations pratiques" hint="Facultatif" />
        <UiInput
          id="email"
          v-model="form.proposerEmail"
          label="Votre e-mail"
          type="email"
          required
          autocomplete="email"
          hint="Privé, jamais publié. Uniquement pour confirmer la proposition."
        />

        <div v-if="similar.length" class="rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] p-4 text-sm">
          <p class="font-bold text-[#805200]">Des manifestations proches existent déjà</p>
          <p class="mt-1 text-[#454545]">Deux événements peuvent coexister. Vérifiez avant d’envoyer pour éviter un doublon inutile.</p>
          <ul class="mt-2 space-y-1">
            <li v-for="s in similar" :key="s.slug">
              <NuxtLink :to="`/manifestations/${s.slug}`" class="font-semibold text-[#6735B6] underline" target="_blank">
                {{ s.title }} — {{ s.cityName }}
              </NuxtLink>
            </li>
          </ul>
        </div>

        <TurnstileWidget ref="turnstileRef" v-model="turnstileToken" action="propose" />

        <p v-if="error" class="text-sm text-[#AD291F]" role="alert">{{ error }}</p>

        <UiButton type="submit" :disabled="submitting" block>
          {{ submitting ? 'Envoi en cours…' : 'Envoyer pour vérification' }}
        </UiButton>
        <p class="text-center text-xs text-[#454545]">
          En envoyant, vous confirmez que le rassemblement est pacifique et licite.
        </p>
      </form>
      </div>
    </div>
  </div>
</template>
