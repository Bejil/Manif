<script setup lang="ts">
import { EVENT_CATEGORIES } from '#shared/constants/categories'

import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.proposer.title,
  description: SEO.proposer.description,
  ogTitle: SEO.proposer.title,
  ogDescription: SEO.proposer.description,
})

const route = useRoute()
const editToken = computed(() => {
  const t = route.query.edit
  return typeof t === 'string' && t.length >= 20 ? t : ''
})
const isEditMode = computed(() => Boolean(editToken.value))

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
const editDone = ref(false)
const error = ref<string | null>(null)
const loadError = ref<string | null>(null)
const loadingEdit = ref(false)
const adminMessage = ref<string | null>(null)
const emailMasked = ref('')
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

async function loadForEdit() {
  if (!editToken.value) return
  loadingEdit.value = true
  loadError.value = null
  try {
    const data = await $fetch<{
      title: string
      description: string
      category: string
      cityName: string
      locationName: string
      locationRevealHoursBefore: number | null
      dateToConfirm: boolean
      date: string
      startTime: string
      endTime: string
      organizerName: string
      sourceUrl: string
      practicalInfo: string
      proposerEmailMasked: string
      adminMessage: string | null
    }>('/api/submissions/edit', {
      query: { token: editToken.value },
    })
    form.title = data.title
    form.description = data.description
    form.category = data.category
    form.cityName = data.cityName
    form.locationName = data.locationName
    form.locationRevealHoursBefore = data.locationRevealHoursBefore
      ? String(data.locationRevealHoursBefore)
      : ''
    form.dateToConfirm = data.dateToConfirm
    form.date = data.date
    form.startTime = data.startTime
    form.endTime = data.endTime
    form.organizerName = data.organizerName
    form.sourceUrl = data.sourceUrl
    form.practicalInfo = data.practicalInfo
    emailMasked.value = data.proposerEmailMasked
    adminMessage.value = data.adminMessage
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    loadError.value = err?.data?.statusMessage || 'Lien de modification invalide ou expiré.'
  }
  finally {
    loadingEdit.value = false
  }
}

watch(editToken, (t) => {
  if (t) loadForEdit()
}, { immediate: true })

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
    if (isEditMode.value) {
      const res = await $fetch<{
        ok: boolean
        similarEvents?: typeof similar.value
      }>('/api/submissions/edit', {
        method: 'PATCH',
        body: {
          editToken: editToken.value,
          title: form.title,
          description: form.description,
          category: form.category,
          cityName: form.cityName,
          locationName: form.locationName,
          locationRevealHoursBefore: form.locationRevealHoursBefore,
          dateToConfirm: form.dateToConfirm,
          date: form.date,
          startTime: form.startTime,
          endTime: form.endTime,
          organizerName: form.organizerName,
          sourceUrl: form.sourceUrl,
          practicalInfo: form.practicalInfo,
          turnstileToken: turnstileToken.value || undefined,
        },
      })
      similar.value = res.similarEvents || similar.value
      editDone.value = true
    }
    else {
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
        <template v-if="isEditMode">Mettre à jour<br>votre proposition</template>
        <template v-else>Proposer une<br>manifestation</template>
      </h1>
      <p class="mt-4 max-w-xl text-[#FFFCF4]/75">
        <template v-if="isEditMode">
          Corrigez les points demandés par la modération, puis renvoyez pour validation.
          Aucun nouveau compte : votre e-mail reste le même.
        </template>
        <template v-else>
          Ajoutez un rassemblement pacifique et licite à l’agenda. Aucun compte :
          votre e-mail sert uniquement à la vérification. Chaque proposition est examinée avant publication.
        </template>
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
      <div
        v-if="editDone"
        class="rounded-[8px] border border-[#9C6EE8] bg-[#F0E8FC] p-6"
      >
        <h2 class="mf-display text-2xl text-[#111111]">Proposition renvoyée</h2>
        <p class="mt-3 text-sm text-[#252525]">
          Vos modifications ont été enregistrées. La proposition est de nouveau en file de modération.
        </p>
      </div>

      <div
        v-else-if="done"
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

      <p v-else-if="loadError" class="rounded-[8px] border border-[#AD291F]/40 bg-[#FDEDEB] p-5 text-sm text-[#AD291F]" role="alert">
        {{ loadError }}
      </p>

      <p v-else-if="loadingEdit" class="text-sm text-[#454545]">
        Chargement de votre proposition…
      </p>

      <form v-else class="space-y-5" @submit.prevent="onSubmit">
        <div
          v-if="isEditMode && adminMessage"
          class="rounded-[4px] border border-[#805200]/30 bg-[#FFF8E8] p-4 text-sm text-[#805200]"
        >
          <p class="font-bold">Demande de la modération</p>
          <p class="mt-2 whitespace-pre-wrap">{{ adminMessage }}</p>
        </div>

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
          v-if="!isEditMode"
          id="email"
          v-model="form.proposerEmail"
          label="Votre e-mail"
          type="email"
          required
          autocomplete="email"
          hint="Privé, jamais publié. Uniquement pour confirmer la proposition."
        />
        <p v-else class="rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA] px-3 py-2.5 text-sm text-[#454545]">
          E-mail associé : <span class="font-semibold text-[#111111]">{{ emailMasked }}</span>
        </p>

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
          <template v-if="isEditMode">
            {{ submitting ? 'Envoi en cours…' : 'Renvoyer pour validation' }}
          </template>
          <template v-else>
            {{ submitting ? 'Envoi en cours…' : 'Envoyer pour vérification' }}
          </template>
        </UiButton>
        <p class="text-center text-xs text-[#454545]">
          En envoyant, vous confirmez que le rassemblement est pacifique et licite.
        </p>
      </form>
      </div>
    </div>
  </div>
</template>
