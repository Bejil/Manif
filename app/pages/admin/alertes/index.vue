<script setup lang="ts">
import type { AlertStatus } from '#shared/constants/alerts'

definePageMeta({ layout: 'admin' })
useSeoMeta({ title: 'Alertes e-mail — Admin', robots: 'noindex' })

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me } = await useFetch('/api/admin/me', {
  headers: cookieHeaders,
  credentials: 'include',
})
if (!me.value?.authenticated) {
  await navigateTo('/admin')
}

type AlertRow = {
  id: string
  email: string
  locationLabel: string
  latitude: number
  longitude: number
  radiusKm: number
  status: AlertStatus
  confirmedAt: string | null
  unsubscribedAt: string | null
  lastNotifiedAt: string | null
  createdAt: string
  updatedAt: string
}

const filter = ref<'active' | 'pending' | 'unsubscribed' | 'all'>('active')

const query = computed(() => ({ status: filter.value }))

const { data, refresh, pending } = await useFetch<{
  items: AlertRow[]
  counts: Record<AlertStatus, number>
}>('/api/admin/alerts', {
  headers: cookieHeaders,
  credentials: 'include',
  query,
  watch: [query],
})

const items = computed(() => data.value?.items ?? [])
const counts = computed(() => data.value?.counts ?? {
  pending: 0,
  active: 0,
  unsubscribed: 0,
})

function statusLabel(s: AlertStatus) {
  const map: Record<AlertStatus, string> = {
    pending: 'En attente',
    active: 'Active',
    unsubscribed: 'Désinscrit',
  }
  return map[s] || s
}

function statusClass(s: AlertStatus) {
  if (s === 'active') return 'border-l-[#206C4D]'
  if (s === 'pending') return 'border-l-[#805200]'
  return 'border-l-[#636363]'
}

function fmtDate(iso: string | null | undefined) {
  if (!iso) return '—'
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return '—'
  return d.toLocaleString('fr-FR', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}

const filters: Array<{ id: typeof filter.value, label: string }> = [
  { id: 'active', label: 'Actives' },
  { id: 'pending', label: 'En attente' },
  { id: 'unsubscribed', label: 'Désinscrits' },
  { id: 'all', label: 'Toutes' },
]

const deletingId = ref<string | null>(null)
const actionError = ref<string | null>(null)

async function deleteAlert(a: AlertRow) {
  if (deletingId.value) return
  if (!confirm(`Supprimer définitivement l’alerte de ${a.email} (${a.locationLabel}) ?`)) {
    return
  }
  deletingId.value = a.id
  actionError.value = null
  try {
    await $fetch(`/api/admin/alerts/${a.id}`, {
      method: 'DELETE',
      credentials: 'include',
    })
    await refresh()
  }
  catch {
    actionError.value = 'Suppression impossible.'
  }
  finally {
    deletingId.value = null
  }
}
</script>

<template>
  <div>
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Alertes e-mail</h1>
        <p class="mt-2 text-sm text-[#454545]">
          {{ counts.active }} active{{ counts.active > 1 ? 's' : '' }}
          · {{ counts.pending }} en attente
          · {{ counts.unsubscribed }} désinscrit{{ counts.unsubscribed > 1 ? 's' : '' }}
        </p>
      </div>
      <div class="flex flex-wrap gap-2">
        <UiButton
          v-for="f in filters"
          :key="f.id"
          size="sm"
          :variant="filter === f.id ? 'primary' : 'outline'"
          @click="filter = f.id"
        >
          {{ f.label }}
          <template v-if="f.id !== 'all'">
            ({{ counts[f.id] }})
          </template>
        </UiButton>
        <UiButton size="sm" variant="ghost" :disabled="pending" @click="refresh()">
          Actualiser
        </UiButton>
      </div>
    </div>

    <p
      v-if="pending && !items.length"
      class="mt-8 text-sm text-[#636363]"
    >
      Chargement…
    </p>

    <p
      v-if="actionError"
      class="mb-4 text-sm text-[#AD291F]"
      role="alert"
    >
      {{ actionError }}
    </p>

    <EmptyState
      v-if="!pending && !items.length"
      class="mt-8"
      title="Aucune alerte"
      :description="filter === 'active'
        ? 'Aucune alerte active pour le moment.'
        : undefined"
    />

    <ul v-if="items.length" class="space-y-3">
      <li
        v-for="a in items"
        :key="a.id"
        class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] bg-white p-5"
        :class="statusClass(a.status)"
      >
        <div class="flex flex-wrap items-start justify-between gap-3">
          <div class="min-w-0 flex-1">
            <p class="font-extrabold text-[#111111]">
              {{ a.email }}
              <span class="font-semibold text-[#636363]">· {{ statusLabel(a.status) }}</span>
            </p>
            <p class="mt-1 text-sm text-[#111111]">
              {{ a.locationLabel }}
              <span class="text-[#636363]">· {{ a.radiusKm }}&nbsp;km</span>
            </p>
            <p class="mt-2 text-xs text-[#636363]">
              Créée {{ fmtDate(a.createdAt) }}
              <template v-if="a.confirmedAt"> · Confirmée {{ fmtDate(a.confirmedAt) }}</template>
              <template v-if="a.lastNotifiedAt"> · Dernier envoi {{ fmtDate(a.lastNotifiedAt) }}</template>
              <template v-if="a.unsubscribedAt"> · Désinscrit {{ fmtDate(a.unsubscribedAt) }}</template>
            </p>
          </div>
          <div class="flex shrink-0 flex-col items-end gap-2">
            <p class="text-[10px] font-bold uppercase tracking-wide text-[#636363]">
              {{ a.latitude.toFixed(4) }}, {{ a.longitude.toFixed(4) }}
            </p>
            <UiButton
              size="sm"
              variant="outline"
              :disabled="deletingId === a.id"
              @click="deleteAlert(a)"
            >
              {{ deletingId === a.id ? 'Suppression…' : 'Supprimer' }}
            </UiButton>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
