<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { REPORT_REASONS } from '#shared/constants/statuses'

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

type ReportDetail = {
  id: string
  eventId: string
  reason: string
  details: string
  status: string
  createdAt: string
  resolvedAt: string | null
  adminNote: string | null
  event: {
    id: string
    slug: string
    title: string
    cityName: string
    publicationStatus: string
    displayStatus: string
    startAt: string | null
  } | null
  eventPublic: EventPublic | null
}

const { data: item, error, pending, refresh } = await useFetch<ReportDetail>(
  () => `/api/admin/reports/${id.value}`,
  { headers: cookieHeaders, credentials: 'include' },
)

useSeoMeta({
  title: () => item.value?.event?.title
    ? `Signalement — ${item.value.event.title}`
    : 'Signalement — Admin',
  robots: 'noindex',
})

const { formatDate, formatTimeRange, categoryLabel } = useEventFormat()

const message = ref<string | null>(null)
const actionError = ref<string | null>(null)
const busy = ref(false)
const adminNote = ref('')

watch(item, (v) => {
  if (v) adminNote.value = v.adminNote || ''
}, { immediate: true })

function reasonLabel(rid: string) {
  return REPORT_REASONS.find(r => r.id === rid)?.label || rid
}

function statusLabel(s: string) {
  const map: Record<string, string> = {
    open: 'Ouvert',
    in_progress: 'En cours',
    resolved: 'Résolu',
    dismissed: 'Rejeté',
  }
  return map[s] || s
}

async function setStatus(status: 'resolved' | 'dismissed' | 'in_progress' | 'open') {
  if (!item.value) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/reports/${item.value.id}`, {
      method: 'PATCH',
      body: { status, adminNote: adminNote.value || undefined },
    })
    message.value = status === 'resolved'
      ? 'Signalement marqué résolu.'
      : status === 'dismissed'
        ? 'Signalement rejeté.'
        : 'Statut mis à jour.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Mise à jour impossible.'
  }
  finally {
    busy.value = false
  }
}

async function unpublishEvent() {
  if (!item.value?.event) return
  if (!confirm('Dépublier cet événement ?')) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/events/${item.value.event.id}/unpublish`, { method: 'POST' })
    message.value = 'Événement dépublié.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Dépublication impossible.'
  }
  finally {
    busy.value = false
  }
}

async function cancelEvent() {
  if (!item.value?.event) return
  if (!confirm('Annuler cet événement (statut forcé) ?')) return
  busy.value = true
  actionError.value = null
  try {
    await $fetch(`/api/admin/events/${item.value.event.id}/cancel`, { method: 'POST' })
    message.value = 'Événement annulé.'
    await refresh()
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Annulation impossible.'
  }
  finally {
    busy.value = false
  }
}

async function deleteEvent() {
  if (!item.value?.event) return
  if (!confirm(`Supprimer définitivement « ${item.value.event.title} » ?`)) return
  busy.value = true
  actionError.value = null
  try {
    // Résoudre le signalement avant la suppression (CASCADE côté DB)
    await $fetch(`/api/admin/reports/${item.value.id}`, {
      method: 'PATCH',
      body: { status: 'resolved', adminNote: adminNote.value || 'Événement supprimé suite au signalement.' },
    })
    await $fetch(`/api/admin/events/${item.value.event.id}`, { method: 'DELETE' })
    await navigateTo('/admin/signalements')
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    actionError.value = err?.data?.statusMessage || 'Suppression impossible.'
  }
  finally {
    busy.value = false
  }
}
</script>

<template>
  <div>
    <nav class="mb-6 text-sm text-[#636363]">
      <NuxtLink to="/admin/signalements" class="font-semibold text-[#6735B6] hover:underline">
        ← Signalements
      </NuxtLink>
    </nav>

    <p v-if="pending" class="text-sm text-[#454545]">Chargement…</p>
    <p v-else-if="error" class="text-sm text-[#AD291F]" role="alert">
      Signalement introuvable.
      <NuxtLink to="/admin/signalements" class="underline">Retour</NuxtLink>
    </p>

    <template v-else-if="item">
      <p v-if="message" class="mb-4 text-sm font-semibold text-[#206C4D]">{{ message }}</p>
      <p v-if="actionError" class="mb-4 text-sm text-[#AD291F]" role="alert">{{ actionError }}</p>

      <div class="mb-6">
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Signalement</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">
          {{ item.event?.title || 'Événement introuvable' }}
        </h1>
        <p class="mt-2 text-sm text-[#454545]">
          {{ reasonLabel(item.reason) }} · {{ statusLabel(item.status) }}
          · {{ new Date(item.createdAt).toLocaleString('fr-FR') }}
        </p>
      </div>

      <div class="grid items-start gap-6 lg:grid-cols-[minmax(0,1fr)_18rem]">
        <div class="space-y-6">
          <section class="surface-card space-y-3 p-5">
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Motif</p>
            <p class="font-extrabold text-[#111111]">{{ reasonLabel(item.reason) }}</p>
            <p v-if="item.details" class="whitespace-pre-wrap text-sm text-[#454545]">{{ item.details }}</p>
            <p v-else class="text-sm text-[#636363]">Aucune précision fournie.</p>
          </section>

          <section v-if="item.eventPublic" class="space-y-4">
            <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Événement signalé</p>
            <div class="surface-card grid gap-4 p-5 sm:grid-cols-2">
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Date</p>
                <p class="mt-1 font-semibold text-[#111111]">
                  {{ formatDate(item.eventPublic.startAt, item.eventPublic.timezone) }}
                </p>
              </div>
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Horaire</p>
                <p class="mt-1 font-semibold text-[#111111]">
                  {{ formatTimeRange(
                    item.eventPublic.startAt,
                    item.eventPublic.endAt,
                    item.eventPublic.endIsEstimated,
                    item.eventPublic.timezone,
                  ) }}
                </p>
              </div>
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Lieu</p>
                <p class="mt-1 font-semibold text-[#111111]">
                  {{ item.eventPublic.locationName }}, {{ item.eventPublic.cityName }}
                </p>
              </div>
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Catégorie</p>
                <p class="mt-1 font-semibold text-[#111111]">
                  {{ categoryLabel(item.eventPublic.category) }}
                </p>
              </div>
              <div>
                <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Publication</p>
                <p class="mt-1 font-semibold text-[#111111]">
                  {{ item.eventPublic.publicationStatus }} · {{ item.eventPublic.displayStatus }}
                </p>
              </div>
            </div>
            <div class="prose-manif whitespace-pre-wrap">{{ item.eventPublic.description }}</div>
            <EventCard
              v-if="item.eventPublic"
              :event="item.eventPublic"
              :to="`/admin/evenements/${item.eventPublic.id}`"
              action-label="Modifier"
              action-as-button
            />
          </section>

          <p v-else class="rounded-[4px] border border-[#AD291F]/30 bg-[#FDEDEB] p-4 text-sm text-[#AD291F]">
            L’événement lié a été supprimé ou est introuvable.
          </p>
        </div>

        <aside class="lg:sticky lg:top-24">
          <div class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
            <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Actions</p>

            <UiTextarea
              id="admin-note"
              v-model="adminNote"
              class="mt-4"
              label="Note interne"
              :rows="3"
              hint="Conservée avec le statut du signalement."
            />

            <div class="mt-4 flex flex-col gap-2">
              <UiButton
                v-if="item.status === 'open' || item.status === 'in_progress'"
                block
                size="sm"
                :disabled="busy"
                @click="setStatus('resolved')"
              >
                Marquer résolu
              </UiButton>
              <UiButton
                v-if="item.status === 'open'"
                block
                size="sm"
                variant="outline"
                :disabled="busy"
                @click="setStatus('in_progress')"
              >
                Prendre en charge
              </UiButton>
              <UiButton
                v-if="item.status !== 'dismissed'"
                block
                size="sm"
                variant="ghost"
                :disabled="busy"
                @click="setStatus('dismissed')"
              >
                Rejeter le signalement
              </UiButton>
              <UiButton
                v-if="item.status !== 'open'"
                block
                size="sm"
                variant="ghost"
                :disabled="busy"
                @click="setStatus('open')"
              >
                Rouvrir
              </UiButton>
            </div>

            <div v-if="item.event" class="mt-5 space-y-2 border-t border-[#DDDAD3] pt-4">
              <p class="text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Événement</p>
              <NuxtLink :to="`/admin/evenements/${item.event.id}`">
                <UiButton block size="sm" variant="outline">Modifier l’événement</UiButton>
              </NuxtLink>
              <NuxtLink :to="`/manifestations/${item.event.slug}`" target="_blank">
                <UiButton block size="sm" variant="ghost">Voir la fiche publique</UiButton>
              </NuxtLink>
              <UiButton
                block
                size="sm"
                variant="ghost"
                :disabled="busy || item.event.publicationStatus !== 'published'"
                @click="unpublishEvent"
              >
                Dépublier
              </UiButton>
              <UiButton
                block
                size="sm"
                variant="outline"
                :disabled="busy"
                @click="cancelEvent"
              >
                Annuler l’événement
              </UiButton>
              <UiButton
                block
                size="sm"
                variant="danger"
                :disabled="busy"
                @click="deleteEvent"
              >
                Supprimer l’événement
              </UiButton>
            </div>
          </div>
        </aside>
      </div>
    </template>
  </div>
</template>
