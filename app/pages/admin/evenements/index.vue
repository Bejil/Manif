<script setup lang="ts">
import type { EventPublic } from '#shared/types/event'

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

const route = useRoute()

function queryFlag(v: unknown) {
  return v === '1' || v === 'true'
}

const page = ref(1)
const pageSize = 30
const q = ref(typeof route.query.q === 'string' ? route.query.q : '')
const category = ref(typeof route.query.category === 'string' ? route.query.category : '')
const statuses = ref<string[]>(
  typeof route.query.statuses === 'string' && route.query.statuses.trim()
    ? route.query.statuses.split(',').map(s => s.trim()).filter(Boolean)
    : ['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'],
)
const publication = ref(
  typeof route.query.publication === 'string' ? route.query.publication : '',
)
const withoutCoords = ref(queryFlag(route.query.withoutCoords))

const listQuery = computed(() => ({
  page: page.value,
  pageSize,
  q: q.value.trim() || undefined,
  category: category.value || undefined,
  publication: publication.value || undefined,
  withoutCoords: withoutCoords.value ? '1' : undefined,
  statuses: statuses.value.length ? statuses.value.join(',') : undefined,
}))

const { data, refresh, error, pending } = await useFetch<{
  items: EventPublic[]
  total: number
  page: number
  pageSize: number
}>('/api/admin/events', {
  headers: cookieHeaders,
  credentials: 'include',
  query: listQuery,
  watch: [listQuery],
})

watch([q, category, statuses, publication, withoutCoords], () => {
  page.value = 1
})

/** Reflète les filtres dans l’URL (liens tableau de bord, partage). */
watch(
  [publication, withoutCoords, q, category, statuses],
  () => {
    if (!import.meta.client) return
    const next: Record<string, string> = {}
    if (q.value.trim()) next.q = q.value.trim()
    if (category.value) next.category = category.value
    if (publication.value) next.publication = publication.value
    if (withoutCoords.value) next.withoutCoords = '1'
    if (statuses.value.length) next.statuses = statuses.value.join(',')
    void navigateTo({ path: '/admin/evenements', query: next }, { replace: true })
  },
)

const totalPages = computed(() => {
  const total = data.value?.total ?? 0
  const size = data.value?.pageSize ?? pageSize
  return Math.max(1, Math.ceil(total / size) || 1)
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
          <span v-if="data">
            {{ data.total }} événement{{ data.total > 1 ? 's' : '' }}
            <template v-if="data.total > pageSize">
              · page {{ data.page }}/{{ totalPages }}
            </template>
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
    <p v-else-if="pending && !data" class="mb-4 text-sm text-[#454545]">Chargement…</p>

    <EventFilters
      v-model:q="q"
      v-model:category="category"
      v-model:statuses="statuses"
      v-model:publication="publication"
      id-prefix="admin-events"
      show-publication
    />

    <label class="mt-3 flex cursor-pointer items-center gap-2 text-sm font-semibold text-[#454545]">
      <input
        v-model="withoutCoords"
        type="checkbox"
        class="size-4 accent-[#6735B6]"
      >
      Sans coordonnées uniquement
    </label>

    <p
      v-if="!pending && !error && data && !data.items.length"
      class="mt-6 text-sm text-[#454545]"
    >
      Aucun événement pour ces filtres.
    </p>

    <div class="mt-6 space-y-3">
      <EventCard
        v-for="e in data?.items || []"
        :key="e.id"
        :event="e"
        :to="`/admin/evenements/${e.id}`"
        action-label="Modifier"
        action-as-button
        @select="goEdit(e.id)"
      />
    </div>

    <div
      v-if="(data?.total || 0) > pageSize"
      class="mt-6 flex items-center justify-between gap-3"
    >
      <UiButton
        size="sm"
        variant="outline"
        :disabled="page <= 1 || pending"
        @click="page--"
      >
        Précédent
      </UiButton>
      <span class="text-xs font-semibold text-[#636363]">
        p. {{ page }}/{{ totalPages }}
      </span>
      <UiButton
        size="sm"
        variant="outline"
        :disabled="page >= totalPages || pending"
        @click="page++"
      >
        Suivant
      </UiButton>
    </div>
  </div>
</template>
