<script setup lang="ts">
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

type SubmissionDetail = {
  id: string
  title: string
  description: string
  category: string
  cityName: string
  locationName: string
  locationRevealHoursBefore: number | null
  startAt: string | null
  endAt: string | null
  organizerName: string | null
  sourceUrl: string | null
  practicalInfo: string | null
  proposerEmailMasked: string
  proposerEmail?: string
  verificationStatus: string
  moderationStatus: string
  rejectionReason: string | null
  createdAt: string
  mapLatitude: number | null
  mapLongitude: number | null
  mapPrecision: 'place' | 'city' | 'none'
  mapLabel?: string
  history?: Array<{
    id: string
    action: string
    label: string
    detail: string | null
    actorId: string
    createdAt: string
  }>
}

const { data: item, error, pending, refresh } = await useFetch<SubmissionDetail>(
  () => `/api/admin/submissions/${id.value}`,
  { headers: cookieHeaders, credentials: 'include' },
)

const { formatDate, formatTimeRange, categoryLabel } = useEventFormat()
const timezone = 'Europe/Paris'

useSeoMeta({
  title: () => item.value ? `Proposition — ${item.value.title}` : 'Proposition — Admin',
  robots: 'noindex',
})

const message = ref<string | null>(null)
const actionError = ref<string | null>(null)
const busy = ref(false)
const rejectReason = ref('')
const changesMessage = ref('')
const showReject = ref(false)
const showChanges = ref(false)

const canModerate = computed(() =>
  item.value?.moderationStatus === 'pending_moderation'
  || item.value?.moderationStatus === 'changes_requested',
)

const statusLabel = computed(() => {
  switch (item.value?.moderationStatus) {
    case 'pending_moderation': return 'À modérer'
    case 'changes_requested': return 'Modifications demandées'
    case 'awaiting_verification': return 'En attente d’e-mail'
    case 'approved': return 'Approuvée'
    case 'rejected': return 'Refusée'
    default: return item.value?.moderationStatus || '—'
  }
})

async function approve() {
  if (!item.value || !confirm(`Publier « ${item.value.title} » ?`)) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/submissions/${item.value.id}/approve`, { method: 'POST' })
    message.value = 'Proposition publiée.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Publication impossible.'
  }
  finally {
    busy.value = false
  }
}

async function reject() {
  if (!item.value) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/submissions/${item.value.id}/reject`, {
      method: 'POST',
      body: { reason: rejectReason.value || 'Refus manuel' },
    })
    message.value = 'Proposition refusée.'
    showReject.value = false
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Refus impossible.'
  }
  finally {
    busy.value = false
  }
}

async function requestChanges() {
  if (!item.value) return
  busy.value = true
  actionError.value = null
  try {
    const res = await $fetch<{ emailMocked?: boolean }>(
      `/api/admin/submissions/${item.value.id}/request-changes`,
      { method: 'POST', body: { message: changesMessage.value } },
    )
    message.value = res.emailMocked
      ? 'Demande enregistrée (e-mail mocké en console).'
      : 'Demande de modifications envoyée au proposant.'
    showChanges.value = false
    changesMessage.value = ''
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Envoi impossible.'
  }
  finally {
    busy.value = false
  }
}

async function reopen() {
  if (!item.value) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/submissions/${item.value.id}/reopen`, { method: 'POST' })
    message.value = 'Remise en file de modération.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Action impossible.'
  }
  finally {
    busy.value = false
  }
}

const revealLabel = computed(() => {
  const h = item.value?.locationRevealHoursBefore
  if (h == null || h <= 0) return 'Immédiatement à la publication'
  if (h < 24) return `${h} h avant le début`
  if (h % 24 === 0) return `${h / 24} jour${h / 24 > 1 ? 's' : ''} avant le début`
  return `${h} h avant le début`
})
</script>

<template>
  <div>
    <nav class="mb-6 text-sm text-[#636363]">
      <NuxtLink to="/admin/propositions" class="font-semibold text-[#6735B6] hover:underline">
        ← Propositions
      </NuxtLink>
    </nav>

    <p v-if="pending" class="text-sm text-[#454545]">Chargement…</p>
    <p v-else-if="error" class="text-sm text-[#AD291F]" role="alert">
      Proposition introuvable.
      <NuxtLink to="/admin/propositions" class="underline">Retour</NuxtLink>
    </p>

    <template v-else-if="item">
      <p v-if="message" class="mb-4 text-sm font-semibold text-[#206C4D]">{{ message }}</p>
      <p v-if="actionError" class="mb-4 text-sm text-[#AD291F]" role="alert">{{ actionError }}</p>

      <div class="mb-6 flex flex-wrap items-start justify-between gap-4">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Proposition</p>
          <h1 class="mf-display mf-h3 mt-2 max-w-3xl text-[#111111]">{{ item.title }}</h1>
          <p class="mt-2 text-sm text-[#454545]">
            {{ statusLabel }} · {{ categoryLabel(item.category as never) }} · {{ item.cityName }}
          </p>
        </div>
      </div>

      <div class="grid items-start gap-6 lg:grid-cols-[minmax(0,1fr)_18rem]">
        <article class="space-y-6">
          <div class="surface-card grid gap-4 p-5 sm:grid-cols-2">
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Date</p>
              <p class="mt-1 font-semibold text-[#111111]">
                {{ formatDate(item.startAt, timezone) }}
              </p>
            </div>
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Horaire</p>
              <p class="mt-1 font-semibold text-[#111111]">
                {{ formatTimeRange(item.startAt, item.endAt, !item.endAt, timezone) }}
              </p>
            </div>
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Lieu</p>
              <p class="mt-1 font-semibold text-[#111111]">
                {{ item.locationName }}, {{ item.cityName }}
              </p>
            </div>
            <div>
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Révélation du lieu</p>
              <p class="mt-1 font-semibold text-[#111111]">{{ revealLabel }}</p>
            </div>
            <div v-if="item.organizerName">
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Organisateur</p>
              <p class="mt-1 font-semibold text-[#111111]">{{ item.organizerName }}</p>
            </div>
            <div v-if="item.sourceUrl">
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Source</p>
              <a
                :href="item.sourceUrl"
                class="mt-1 inline-block break-all text-sm font-semibold text-[#6735B6] hover:underline"
                rel="noopener noreferrer"
                target="_blank"
              >{{ item.sourceUrl }}</a>
            </div>
          </div>

          <div>
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Description</p>
            <div class="prose-manif mt-3 whitespace-pre-wrap">{{ item.description }}</div>
          </div>

          <div v-if="item.practicalInfo">
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Infos pratiques</p>
            <p class="mt-3 whitespace-pre-wrap text-sm text-[#454545]">{{ item.practicalInfo }}</p>
          </div>

          <div v-if="item.mapLatitude != null && item.mapLongitude != null">
            <p class="mb-3 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
              {{ item.mapPrecision === 'city' ? 'Ville sur la carte' : 'Lieu sur la carte' }}
            </p>
            <ClientOnly>
              <EventLocationMap
                :latitude="item.mapLatitude"
                :longitude="item.mapLongitude"
                :label="item.mapLabel || item.locationName"
                :zoom="item.mapPrecision === 'city' ? 11 : 14"
              />
              <template #fallback>
                <div class="map-shell flex min-h-[280px] items-center justify-center text-sm text-[#454545] md:min-h-[360px]">
                  Chargement de la carte…
                </div>
              </template>
            </ClientOnly>
            <p v-if="item.mapLabel" class="mt-2 text-xs text-[#636363]">{{ item.mapLabel }}</p>
          </div>
          <p v-else class="text-sm text-[#805200]">
            Position carte indisponible pour cette adresse.
          </p>

          <AdminHistoryFeed
            class="mt-6"
            title="Historique de modération"
            :items="item.history || []"
          />
        </article>

        <aside class="lg:sticky lg:top-24">
          <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
            <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Modération</p>
            <p class="mt-3 text-sm text-[#454545]">
              Statut : <span class="font-semibold text-[#111111]">{{ statusLabel }}</span>
            </p>
            <p class="mt-2 text-sm text-[#454545]">
              Proposant :
              <a
                v-if="item.proposerEmail"
                :href="`mailto:${item.proposerEmail}`"
                class="font-semibold text-[#6735B6] hover:underline"
              >{{ item.proposerEmail }}</a>
              <span v-else class="font-semibold text-[#111111]">{{ item.proposerEmailMasked }}</span>
            </p>
            <p class="mt-1 text-xs text-[#636363]">
              Reçue le {{ new Date(item.createdAt).toLocaleString('fr-FR') }}
            </p>

            <div v-if="canModerate" class="mt-5 flex flex-col gap-2">
              <UiButton block variant="red" :disabled="busy" @click="approve">
                Accepter &amp; publier
              </UiButton>
              <UiButton
                block
                variant="outline"
                :disabled="busy"
                @click="showChanges = !showChanges; showReject = false"
              >
                Demander des modifications
              </UiButton>
              <UiButton
                block
                variant="danger"
                :disabled="busy"
                @click="showReject = !showReject; showChanges = false"
              >
                Refuser
              </UiButton>
              <UiButton
                v-if="item.moderationStatus === 'changes_requested'"
                block
                variant="ghost"
                :disabled="busy"
                @click="reopen"
              >
                Remettre en modération
              </UiButton>
            </div>
            <p v-else class="mt-5 text-sm text-[#636363]">
              Aucune action de modération disponible pour ce statut.
            </p>

            <div v-if="showChanges" class="mt-4 space-y-3 border-t border-[#DDDAD3] pt-4">
              <UiTextarea
                id="changes-msg"
                v-model="changesMessage"
                label="Message au proposant"
                :rows="5"
                hint="Expliquez ce qu’il faut corriger ou préciser."
              />
              <UiButton
                block
                size="sm"
                :disabled="busy || changesMessage.trim().length < 10"
                @click="requestChanges"
              >
                Envoyer la demande
              </UiButton>
            </div>

            <div v-if="showReject" class="mt-4 space-y-3 border-t border-[#DDDAD3] pt-4">
              <UiTextarea
                id="reject-reason"
                v-model="rejectReason"
                label="Motif du refus (optionnel)"
                :rows="3"
              />
              <UiButton block size="sm" variant="danger" :disabled="busy" @click="reject">
                Confirmer le refus
              </UiButton>
            </div>
          </div>
        </aside>
      </div>
    </template>
  </div>
</template>
