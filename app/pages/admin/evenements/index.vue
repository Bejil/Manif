<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'
import { matchesSearch } from '#shared/utils/search'

definePageMeta({ layout: 'admin' })
useSeoMeta({ title: 'Événements — Admin', robots: 'noindex' })

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me } = await useFetch('/api/admin/me', {
  headers: cookieHeaders,
  credentials: 'include',
})
if (!me.value?.authenticated) await navigateTo('/admin')

const { data, refresh, error, pending } = await useFetch<{ items: EventPublic[] }>(
  '/api/admin/events',
  {
    headers: cookieHeaders,
    credentials: 'include',
  },
)

const q = ref('')
const category = ref('')
const statuses = ref<string[]>(['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'])
const publication = ref('')

const filtered = computed(() => {
  let items = data.value?.items ?? []
  if (q.value.trim()) {
    const needle = q.value
    items = items.filter(e =>
      matchesSearch(e.title, needle)
      || matchesSearch(e.cityName, needle)
      || matchesSearch(e.description, needle)
      || matchesSearch(e.locationName, needle)
      || matchesSearch(e.slug, needle)
      || (e.postalCode ? matchesSearch(e.postalCode, needle) : false),
    )
  }
  if (category.value) {
    items = items.filter(e => e.category === category.value)
  }
  if (statuses.value.length) {
    items = items.filter(e => statuses.value.includes(e.displayStatus))
  }
  if (publication.value) {
    items = items.filter(e => e.publicationStatus === publication.value)
  }
  return items
})

function goEdit(eventId: string) {
  return navigateTo(`/admin/evenements/${eventId}`)
}
</script>

<template>
  <div>
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Manifestations</h1>
        <p class="mt-2 text-sm text-[#454545]">
          <span v-if="data?.items">
            {{ filtered.length }} / {{ data.items.length }} affichée{{ filtered.length > 1 ? 's' : '' }}
          </span>
        </p>
      </div>
      <UiButton size="sm" variant="outline" :disabled="pending" @click="refresh()">
        Actualiser
      </UiButton>
    </div>

    <p v-if="error" class="mb-4 text-sm text-[#AD291F]" role="alert">
      Impossible de charger les événements.
      <button type="button" class="underline" @click="refresh()">Réessayer</button>
    </p>
    <p v-else-if="pending" class="mb-4 text-sm text-[#454545]">Chargement…</p>

    <EventFilters
      v-model:q="q"
      v-model:category="category"
      v-model:statuses="statuses"
      v-model:publication="publication"
      id-prefix="admin-events"
      show-publication
    />

    <p
      v-if="!pending && !error && data && !filtered.length"
      class="mt-6 text-sm text-[#454545]"
    >
      Aucun événement pour ces filtres.
    </p>

    <div class="mt-6 space-y-3">
      <EventCard
        v-for="e in filtered"
        :key="e.id"
        :event="e"
        :to="`/admin/evenements/${e.id}`"
        action-label="Modifier"
        action-as-button
        @select="goEdit(e.id)"
      />
    </div>
  </div>
</template>
