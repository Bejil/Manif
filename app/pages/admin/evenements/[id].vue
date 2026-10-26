<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { EVENT_CATEGORIES } from '#shared/constants/categories'
import { matchesSearch } from '#shared/utils/search'

definePageMeta({ layout: 'admin' })

const route = useRoute()
const id = computed(() => route.params.id as string)

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me } = await useFetch('/api/admin/me', {
  headers: cookieHeaders,
  credentials: 'include',
})
if (!me.value?.authenticated) await navigateTo('/admin')

type EventAdminDetail = EventPublic & {
  history?: Array<{
    id: string
    action: string
    label: string
    detail: string | null
    actorId: string
    createdAt: string
  }>
}

const { data: event, error, refresh, pending } = await useFetch<EventAdminDetail>(
  () => `/api/admin/events/${id.value}`,
  { headers: cookieHeaders, credentials: 'include' },
)

const { data: allEvents } = await useFetch<{ items: EventPublic[] }>(
  '/api/admin/events',
  { headers: cookieHeaders, credentials: 'include' },
)

useSeoMeta({
  title: () => event.value ? `Modifier — ${event.value.title}` : 'Modifier — Admin',
  robots: 'noindex',
})

const message = ref<string | null>(null)
const saveError = ref<string | null>(null)
const saving = ref(false)
const deleting = ref(false)
const actionBusy = ref(false)
const merging = ref(false)
const geocoding = ref(false)
const geocodeHint = ref<string | null>(null)

const form = reactive({
  title: '',
  description: '',
  category: 'autre',
  cityName: '',
  postalCode: '',
  timezone: 'Europe/Paris',
  locationName: '',
  latitude: '' as string,
  longitude: '' as string,
  locationRevealAt: '' as string,
  startAt: '' as string,
  endAt: '' as string,
  endIsEstimated: true,
  organizerName: '',
  sourceUrl: '',
  publicationStatus: 'published' as 'draft' | 'published' | 'unpublished',
  eventStatusOverride: '' as '' | 'cancelled' | 'postponed',
})

function toLocalInput(iso: string | null | undefined): string {
  if (!iso) return ''
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return ''
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`
}

function fromLocalInput(local: string): string | null {
  if (!local.trim()) return null
  const d = new Date(local)
  if (Number.isNaN(d.getTime())) return null
  return d.toISOString()
}

function fillForm(e: EventPublic) {
  form.title = e.title
  form.description = e.description
  form.category = e.category
  form.cityName = e.cityName
  form.postalCode = e.postalCode || ''
  form.timezone = e.timezone || 'Europe/Paris'
  form.locationName = e.locationName
  form.latitude = e.latitude != null ? String(e.latitude) : ''
  form.longitude = e.longitude != null ? String(e.longitude) : ''
  form.locationRevealAt = toLocalInput(e.locationRevealAt)
  form.startAt = toLocalInput(e.startAt)
  form.endAt = toLocalInput(e.endAt)
  form.endIsEstimated = e.endIsEstimated
  form.organizerName = e.organizerName || ''
  form.sourceUrl = e.sourceUrl || ''
  form.publicationStatus = e.publicationStatus
  form.eventStatusOverride = e.eventStatusOverride || ''
}

watch(event, (e) => {
  if (e) fillForm(e)
}, { immediate: true })

/** La révélation du lieu ne peut pas être après le début. */
function clampRevealToStart() {
  if (!form.locationRevealAt || !form.startAt) return
  if (form.locationRevealAt > form.startAt) {
    form.locationRevealAt = form.startAt
  }
}

watch(() => form.startAt, () => {
  clampRevealToStart()
})

watch(() => form.locationRevealAt, () => {
  clampRevealToStart()
})

async function geocodeAddress() {
  if (!form.cityName.trim()) {
    saveError.value = 'Indiquez une ville avant de géocoder.'
    return
  }
  geocoding.value = true
  saveError.value = null
  geocodeHint.value = null
  try {
    const result = await $fetch<{
      latitude: number
      longitude: number
      cityName: string
      postalCode: string | null
      label: string
      timezone: string
    }>('/api/admin/geocode', {
      method: 'POST',
      body: {
        cityName: form.cityName,
        locationName: form.locationName || undefined,
        postalCode: form.postalCode || undefined,
      },
    })
    form.latitude = String(result.latitude)
    form.longitude = String(result.longitude)
    if (result.postalCode && !form.postalCode) form.postalCode = result.postalCode
    if (result.timezone) form.timezone = result.timezone
    geocodeHint.value = `Position trouvée : ${result.label}`
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Géocodage impossible.'
  }
  finally {
    geocoding.value = false
  }
}

async function saveEdit() {
  if (!event.value) return
  saveError.value = null
  message.value = null
  clampRevealToStart()
  saving.value = true
  try {
    await $fetch(`/api/admin/events/${event.value.id}`, {
      method: 'PATCH',
      body: {
        title: form.title,
        description: form.description,
        category: form.category,
        cityName: form.cityName,
        postalCode: form.postalCode === '' ? null : form.postalCode,
        timezone: form.timezone,
        locationName: form.locationName,
        latitude: form.latitude === '' ? null : Number(form.latitude),
        longitude: form.longitude === '' ? null : Number(form.longitude),
        locationRevealAt: fromLocalInput(form.locationRevealAt),
        startAt: fromLocalInput(form.startAt),
        endAt: fromLocalInput(form.endAt),
        endIsEstimated: form.endIsEstimated,
        organizerName: form.organizerName === '' ? null : form.organizerName,
        sourceUrl: form.sourceUrl === '' ? null : form.sourceUrl,
        publicationStatus: form.publicationStatus,
        eventStatusOverride: form.eventStatusOverride || null,
      },
    })
    message.value = 'Événement enregistré.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Enregistrement impossible.'
  }
  finally {
    saving.value = false
  }
}

async function unpublish() {
  if (!event.value) return
  actionBusy.value = true
  saveError.value = null
  try {
    await $fetch(`/api/admin/events/${event.value.id}/unpublish`, { method: 'POST' })
    message.value = 'Événement dépublié.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Dépublication impossible.'
  }
  finally {
    actionBusy.value = false
  }
}

async function cancelEvent() {
  if (!event.value) return
  actionBusy.value = true
  saveError.value = null
  try {
    await $fetch(`/api/admin/events/${event.value.id}/cancel`, { method: 'POST' })
    message.value = 'Événement annulé.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Annulation impossible.'
  }
  finally {
    actionBusy.value = false
  }
}

async function removeEvent() {
  if (!event.value) return
  if (!confirm(`Supprimer définitivement « ${event.value.title} » ? Cette action est irréversible.`)) {
    return
  }
  deleting.value = true
  saveError.value = null
  try {
    await $fetch(`/api/admin/events/${event.value.id}`, { method: 'DELETE' })
    await navigateTo('/admin/evenements')
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Suppression impossible.'
  }
  finally {
    deleting.value = false
  }
}

const mergeQuery = ref('')
const mergeTargetId = ref<string | null>(null)
const mergeOpen = ref(false)
const mergeHighlight = ref(0)

const mergeCandidates = computed(() => {
  const items = (allEvents.value?.items ?? []).filter(e => e.id !== id.value)
  const needle = mergeQuery.value.trim()
  if (!needle) return items.slice(0, 8)
  return items
    .filter(e =>
      matchesSearch(e.title, needle)
      || e.id.toLowerCase().includes(needle.toLowerCase())
      || matchesSearch(e.slug, needle)
      || matchesSearch(e.cityName, needle),
    )
    .slice(0, 12)
})

const selectedMergeTarget = computed(() => {
  if (!mergeTargetId.value) return null
  return (allEvents.value?.items ?? []).find(e => e.id === mergeTargetId.value) ?? null
})

watch(mergeCandidates, (list) => {
  mergeHighlight.value = list.length ? 0 : -1
})

function onMergeInput(value: string) {
  mergeQuery.value = value
  mergeTargetId.value = null
  mergeOpen.value = true
}

function selectMergeTarget(e: EventPublic) {
  mergeTargetId.value = e.id
  mergeQuery.value = `${e.title} · ${e.cityName}`
  mergeOpen.value = false
}

function onMergeKeydown(ev: KeyboardEvent) {
  if (!mergeOpen.value && (ev.key === 'ArrowDown' || ev.key === 'ArrowUp')) {
    mergeOpen.value = true
    return
  }
  if (!mergeOpen.value) return
  const list = mergeCandidates.value
  if (ev.key === 'ArrowDown') {
    ev.preventDefault()
    if (!list.length) return
    mergeHighlight.value = (mergeHighlight.value + 1) % list.length
  }
  else if (ev.key === 'ArrowUp') {
    ev.preventDefault()
    if (!list.length) return
    mergeHighlight.value = (mergeHighlight.value - 1 + list.length) % list.length
  }
  else if (ev.key === 'Enter') {
    const pick = list[mergeHighlight.value]
    if (pick) {
      ev.preventDefault()
      selectMergeTarget(pick)
    }
  }
  else if (ev.key === 'Escape') {
    mergeOpen.value = false
  }
}

function resolveMergeTargetId(): string | null {
  if (mergeTargetId.value) return mergeTargetId.value
  const needle = mergeQuery.value.trim()
  if (!needle) return null
  const items = (allEvents.value?.items ?? []).filter(e => e.id !== id.value)
  const byId = items.find(e => e.id === needle)
  if (byId) return byId.id
  const byTitle = items.filter(e => matchesSearch(e.title, needle))
  if (byTitle.length === 1) return byTitle[0]!.id
  return null
}

async function mergeIntoTarget() {
  if (!event.value) return
  const targetId = resolveMergeTargetId()
  if (!targetId) {
    saveError.value = 'Choisissez une cible dans la liste (titre ou UUID).'
    return
  }
  if (!confirm(`Fusionner cet événement dans la cible sélectionnée ? La source sera dépubliée.`)) {
    return
  }
  merging.value = true
  saveError.value = null
  try {
    await $fetch(`/api/admin/events/${event.value.id}/merge`, {
      method: 'POST',
      body: { targetId },
    })
    message.value = 'Fusion effectuée (cet événement a été dépublié).'
    mergeQuery.value = ''
    mergeTargetId.value = null
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    saveError.value = err?.data?.statusMessage || 'Fusion impossible.'
  }
  finally {
    merging.value = false
  }
}
</script>

<template>
  <div>
    <nav class="mb-6 text-sm text-[#636363]">
      <NuxtLink to="/admin/evenements" class="font-semibold text-[#6735B6] hover:underline">
        ← Événements
      </NuxtLink>
    </nav>

    <p v-if="pending" class="text-sm text-[#454545]">Chargement…</p>
    <p v-else-if="error" class="text-sm text-[#AD291F]" role="alert">
      Événement introuvable.
      <NuxtLink to="/admin/evenements" class="underline">Retour à la liste</NuxtLink>
    </p>

    <template v-else-if="event">
      <div class="mb-6 flex flex-wrap items-start justify-between gap-4">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Modifier</p>
          <h1 class="mf-display mf-h3 mt-2 text-[#111111]">{{ event.title }}</h1>
          <p class="mt-2 text-sm text-[#454545]">
            {{ event.slug }} · {{ event.displayStatus }} · {{ event.publicationStatus }}
          </p>
        </div>
        <NuxtLink :to="`/manifestations/${event.slug}`" target="_blank">
          <UiButton size="sm" variant="outline">Voir la fiche</UiButton>
        </NuxtLink>
      </div>

      <p v-if="message" class="mb-4 text-sm font-semibold text-[#206C4D]">{{ message }}</p>
      <p v-if="saveError" class="mb-4 text-sm text-[#AD291F]" role="alert">{{ saveError }}</p>

      <div class="grid items-start gap-6 lg:grid-cols-[minmax(0,1fr)_18rem]">
        <form class="surface-card space-y-5 p-5 md:p-6" @submit.prevent="saveEdit">
          <div class="grid gap-4 sm:grid-cols-2">
            <UiInput id="edit-title" v-model="form.title" label="Titre" class="sm:col-span-2" required />
            <UiTextarea
              id="edit-description"
              v-model="form.description"
              label="Description"
              :rows="8"
              class="sm:col-span-2"
              required
            />
            <UiSelect
              id="edit-category"
              v-model="form.category"
              label="Catégorie"
              :options="EVENT_CATEGORIES.map(c => ({ value: c.id, label: c.label }))"
            />
            <UiSelect
              id="edit-publication"
              v-model="form.publicationStatus"
              label="Publication"
              :options="[
                { value: 'published', label: 'Publié' },
                { value: 'draft', label: 'Brouillon' },
                { value: 'unpublished', label: 'Dépublié' },
              ]"
            />
            <UiSelect
              id="edit-override"
              v-model="form.eventStatusOverride"
              label="Statut forcé"
              :options="[
                { value: '', label: 'Aucun (calcul auto)' },
                { value: 'cancelled', label: 'Annulé' },
                { value: 'postponed', label: 'Reporté' },
              ]"
            />
            <UiInput id="edit-timezone" v-model="form.timezone" label="Fuseau (IANA)" hint="ex. Europe/Paris" />
            <UiInput id="edit-city" v-model="form.cityName" label="Ville" required />
            <UiInput id="edit-postal" v-model="form.postalCode" label="Code postal" />
            <UiInput id="edit-loc" v-model="form.locationName" label="Lieu" class="sm:col-span-2" required />
            <div class="sm:col-span-2 space-y-2">
              <div class="grid grid-cols-1 items-end gap-3 sm:grid-cols-[minmax(0,1fr)_minmax(0,1fr)_auto]">
                <UiInput
                  id="edit-lat"
                  v-model="form.latitude"
                  label="Latitude"
                />
                <UiInput
                  id="edit-lng"
                  v-model="form.longitude"
                  label="Longitude"
                />
                <div class="flex flex-col">
                  <span class="mb-1.5 hidden text-sm font-bold sm:block" aria-hidden="true">&nbsp;</span>
                  <UiButton
                    type="button"
                    variant="outline"
                    class="min-h-[48px] whitespace-nowrap"
                    :disabled="geocoding || !form.cityName.trim()"
                    @click="geocodeAddress"
                  >
                    {{ geocoding ? 'Géocodage…' : 'Géocoder l’adresse' }}
                  </UiButton>
                </div>
              </div>
              <p v-if="geocodeHint" class="text-xs font-semibold text-[#206C4D]">
                {{ geocodeHint }}
              </p>
              <p class="text-xs text-[#454545]">
                Vide = pas sur la carte. Géocodage via le lieu, le code postal et la ville (API Adresse data.gouv.fr).
              </p>
            </div>
            <UiInput
              id="edit-start"
              v-model="form.startAt"
              label="Début"
              type="datetime-local"
              hint="Vide = date à venir"
            />
            <UiInput
              id="edit-end"
              v-model="form.endAt"
              label="Fin"
              type="datetime-local"
              :min="form.startAt || undefined"
            />
            <label class="flex cursor-pointer items-center gap-2 text-sm sm:col-span-2">
              <input v-model="form.endIsEstimated" type="checkbox" class="accent-[#6735B6]">
              Fin estimée
            </label>
            <div class="sm:col-span-2 space-y-2">
              <div class="grid grid-cols-1 items-end gap-3 sm:grid-cols-[minmax(0,1fr)_auto]">
                <UiInput
                  id="edit-reveal"
                  v-model="form.locationRevealAt"
                  label="Révéler le lieu à partir de"
                  type="datetime-local"
                  :max="form.startAt || undefined"
                />
                <div class="flex flex-col">
                  <span class="mb-1.5 hidden text-sm font-bold sm:block" aria-hidden="true">&nbsp;</span>
                  <UiButton
                    type="button"
                    variant="outline"
                    class="min-h-[48px] whitespace-nowrap"
                    :disabled="!form.locationRevealAt"
                    @click="form.locationRevealAt = ''"
                  >
                    Toujours public
                  </UiButton>
                </div>
              </div>
              <p class="text-xs text-[#454545]">
                Vide ou « Toujours public » = visible immédiatement.
                <template v-if="form.startAt"> Au plus tard au début de l’événement.</template>
              </p>
            </div>
            <UiInput id="edit-organizer" v-model="form.organizerName" label="Organisateur" />
            <UiInput id="edit-source" v-model="form.sourceUrl" label="URL source" type="url" />
          </div>

          <div class="flex flex-wrap gap-3 border-t border-[#DDDAD3] pt-5">
            <UiButton type="submit" :disabled="saving">
              {{ saving ? 'Enregistrement…' : 'Enregistrer' }}
            </UiButton>
            <NuxtLink to="/admin/evenements">
              <UiButton type="button" variant="ghost">Retour à la liste</UiButton>
            </NuxtLink>
          </div>
        </form>

        <aside class="space-y-4 lg:sticky lg:top-24">
          <AdminHistoryFeed
            title="Historique"
            :items="event.history || []"
          />
          <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
            <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Actions</p>

            <div class="mt-4 flex flex-col gap-2">
              <UiButton
                size="sm"
                variant="outline"
                block
                :disabled="actionBusy"
                @click="cancelEvent"
              >
                Annuler l’événement
              </UiButton>
              <UiButton
                size="sm"
                variant="ghost"
                block
                :disabled="actionBusy"
                @click="unpublish"
              >
                Dépublier
              </UiButton>
              <UiButton
                size="sm"
                variant="danger"
                block
                :disabled="deleting"
                @click="removeEvent"
              >
                {{ deleting ? 'Suppression…' : 'Supprimer' }}
              </UiButton>
            </div>

            <div class="mt-5 border-t border-[#DDDAD3] pt-4">
              <p class="text-sm font-extrabold text-[#111111]">Fusionner</p>
              <p class="mt-1 text-xs text-[#636363]">
                Engagements reportés ; cet événement est dépublié.
              </p>

              <div class="relative mt-3">
                <label for="merge-target" class="block text-xs font-bold text-[#111111]">
                  Cible (titre ou UUID)
                </label>
                <input
                  id="merge-target"
                  :value="mergeQuery"
                  type="text"
                  role="combobox"
                  autocomplete="off"
                  aria-autocomplete="list"
                  :aria-expanded="mergeOpen"
                  aria-controls="merge-suggestions"
                  placeholder="Titre ou UUID…"
                  class="mt-1.5 min-h-[44px] w-full rounded-[4px] border-2 border-[#DDDAD3] bg-white px-3 py-2 text-sm text-[#111111] placeholder:text-[#636363] focus:border-[#6735B6] focus:outline-none focus:ring-2 focus:ring-[#9C6EE8]/35"
                  @input="onMergeInput(($event.target as HTMLInputElement).value)"
                  @focus="mergeOpen = true"
                  @keydown="onMergeKeydown"
                  @blur="mergeOpen = false"
                >
                <ul
                  v-if="mergeOpen && mergeCandidates.length"
                  id="merge-suggestions"
                  role="listbox"
                  class="absolute z-20 mt-1 max-h-56 w-full overflow-auto rounded-[4px] border border-[#DDDAD3] bg-white py-1 shadow-soft"
                >
                  <li
                    v-for="(c, i) in mergeCandidates"
                    :key="c.id"
                    role="option"
                    :aria-selected="mergeHighlight === i"
                    class="cursor-pointer px-3 py-2 text-sm"
                    :class="mergeHighlight === i ? 'bg-[#F4F1EA]' : 'hover:bg-[#FFFCF4]'"
                    @mousedown.prevent="selectMergeTarget(c)"
                    @mouseenter="mergeHighlight = i"
                  >
                    <span class="font-semibold text-[#111111]">{{ c.title }}</span>
                    <span class="mt-0.5 block text-[11px] text-[#636363]">
                      {{ c.cityName }} · {{ c.id.slice(0, 8) }}…
                    </span>
                  </li>
                </ul>
                <p v-if="selectedMergeTarget" class="mt-2 text-xs font-semibold text-[#206C4D]">
                  {{ selectedMergeTarget.title }}
                </p>
              </div>

              <UiButton
                class="mt-3"
                size="sm"
                variant="secondary"
                block
                :disabled="merging || (!mergeTargetId && !mergeQuery.trim())"
                @click="mergeIntoTarget"
              >
                {{ merging ? 'Fusion…' : 'Fusionner' }}
              </UiButton>
            </div>
          </div>
        </aside>
      </div>
    </template>
  </div>
</template>
