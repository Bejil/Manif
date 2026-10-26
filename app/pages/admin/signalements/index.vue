<script setup lang="ts">
import { REPORT_REASONS } from '#shared/constants/statuses'

definePageMeta({ layout: 'admin' })
useSeoMeta({ title: 'Signalements — Admin', robots: 'noindex' })

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

type ReportRow = {
  id: string
  eventId: string
  reason: string
  details: string
  status: string
  createdAt: string
  event: {
    id: string
    slug: string
    title: string
    cityName: string
    publicationStatus: string
    displayStatus: string
    startAt: string | null
  } | null
}

const { data, refresh, pending } = await useFetch<{ items: ReportRow[] }>(
  '/api/admin/reports',
  { headers: cookieHeaders, credentials: 'include' },
)

const filter = ref<'open' | 'all'>('open')

const filtered = computed(() => {
  const items = data.value?.items ?? []
  if (filter.value === 'open') {
    return items.filter(r => r.status === 'open' || r.status === 'in_progress')
  }
  return items
})

function reasonLabel(id: string) {
  return REPORT_REASONS.find(r => r.id === id)?.label || id
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
</script>

<template>
  <div>
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Signalements</h1>
        <p class="mt-2 text-sm text-[#454545]">
          {{ filtered.length }} affichée{{ filtered.length > 1 ? 's' : '' }}
        </p>
      </div>
      <div class="flex flex-wrap gap-2">
        <UiButton
          size="sm"
          :variant="filter === 'open' ? 'primary' : 'outline'"
          @click="filter = 'open'"
        >
          Ouverts
        </UiButton>
        <UiButton
          size="sm"
          :variant="filter === 'all' ? 'primary' : 'outline'"
          @click="filter = 'all'"
        >
          Tous
        </UiButton>
        <UiButton size="sm" variant="ghost" :disabled="pending" @click="refresh()">
          Actualiser
        </UiButton>
      </div>
    </div>

    <EmptyState
      v-if="!filtered.length"
      class="mt-8"
      title="Aucun signalement"
      :description="filter === 'open' ? 'Aucun signalement ouvert pour le moment.' : undefined"
    />

    <ul v-else class="space-y-3">
      <li
        v-for="r in filtered"
        :key="r.id"
        class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#D1271C] bg-white p-5"
      >
        <div class="flex flex-wrap items-start justify-between gap-3">
          <div class="min-w-0 flex-1">
            <p class="font-extrabold text-[#111111]">
              {{ reasonLabel(r.reason) }}
              <span class="font-semibold text-[#636363]">· {{ statusLabel(r.status) }}</span>
            </p>
            <p class="mt-1 text-sm font-semibold text-[#111111]">
              {{ r.event?.title || 'Événement introuvable' }}
            </p>
            <p class="mt-1 text-xs font-semibold text-[#636363]">
              <template v-if="r.event">
                {{ r.event.cityName }} · {{ r.event.publicationStatus }} · {{ r.event.displayStatus }}
              </template>
              · {{ new Date(r.createdAt).toLocaleString('fr-FR') }}
            </p>
            <p v-if="r.details" class="mt-2 line-clamp-2 text-sm text-[#454545]">{{ r.details }}</p>
          </div>
          <div class="flex flex-wrap gap-2">
            <NuxtLink :to="`/admin/signalements/${r.id}`">
              <UiButton size="sm">Examiner</UiButton>
            </NuxtLink>
            <NuxtLink v-if="r.event" :to="`/admin/evenements/${r.event.id}`">
              <UiButton size="sm" variant="outline">Modifier</UiButton>
            </NuxtLink>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
