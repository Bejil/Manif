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

const listQuery = computed(() => ({
  page: page.value,
  pageSize,
  q: q.value.trim() || undefined,
  category: category.value || undefined,
  publication: publication.value || undefined,
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

watch([q, category, statuses, publication], () => {
  page.value = 1
})

watch(
  [publication, q, category, statuses],
  () => {
    if (!import.meta.client) return
    const next: Record<string, string> = {}
    if (q.value.trim()) next.q = q.value.trim()
    if (category.value) next.category = category.value
    if (publication.value) next.publication = publication.value
    if (statuses.value.length) next.statuses = statuses.value.join(',')
    void navigateTo({ path: '/admin/evenements', query: next }, { replace: true })
  },
)

const totalPages = computed(() => {
  const total = data.value?.total ?? 0
  const size = data.value?.pageSize ?? pageSize
  return Math.max(1, Math.ceil(total / size) || 1)
})

const selectedIds = ref<string[]>([])
const lastSelectAnchorId = ref<string | null>(null)
const bulkBusy = ref(false)
const actionId = ref<string | null>(null)
const errorMsg = ref<string | null>(null)
const successMsg = ref<string | null>(null)
let suppressCheckClick = false

function clearSelection() {
  selectedIds.value = []
  lastSelectAnchorId.value = null
}

watch([page, q, category, statuses, publication], () => {
  clearSelection()
})

const pageItems = computed(() => data.value?.items || [])

const selectedEvents = computed(() =>
  pageItems.value.filter(e => selectedIds.value.includes(e.id)),
)

const allSelected = computed(() =>
  pageItems.value.length > 0
  && pageItems.value.every(e => selectedIds.value.includes(e.id)),
)

const selectedCount = computed(() => selectedIds.value.length)

const canBulkPublish = computed(() =>
  selectedEvents.value.some(e => e.publicationStatus !== 'published'),
)

const canBulkUnpublish = computed(() =>
  selectedEvents.value.some(e => e.publicationStatus === 'published'),
)

const canBulkDelete = computed(() => selectedEvents.value.length > 0)

function toggleSelectAll(checked: boolean) {
  if (checked) {
    selectedIds.value = pageItems.value.map(e => e.id)
    lastSelectAnchorId.value = pageItems.value.at(-1)?.id ?? null
  }
  else {
    clearSelection()
  }
}

function onCheckMouseDown(e: EventPublic, event: MouseEvent) {
  if (!event.shiftKey || !lastSelectAnchorId.value) return
  if (bulkBusy.value || pending.value) return

  event.preventDefault()
  suppressCheckClick = true

  const items = pageItems.value
  const idx = items.findIndex(x => x.id === e.id)
  const anchorIdx = items.findIndex(x => x.id === lastSelectAnchorId.value)
  if (idx < 0 || anchorIdx < 0) return

  const from = Math.min(anchorIdx, idx)
  const to = Math.max(anchorIdx, idx)
  const rangeIds = items.slice(from, to + 1).map(x => x.id)
  selectedIds.value = [...new Set([...selectedIds.value, ...rangeIds])]
}

function onCheckClick(_e: EventPublic, event: MouseEvent) {
  if (!suppressCheckClick && !event.shiftKey) return
  event.preventDefault()
  suppressCheckClick = false
}

function onCheckChange(e: EventPublic) {
  if (bulkBusy.value || pending.value) return
  if (suppressCheckClick) return
  lastSelectAnchorId.value = e.id
}

function canPublish(e: EventPublic) {
  return e.publicationStatus !== 'published'
}

function canUnpublish(e: EventPublic) {
  return e.publicationStatus === 'published'
}

/** Recharge la liste selon les filtres actifs (ex. brouillons après publication). */
async function reloadList(message?: string) {
  clearSelection()
  if (message) successMsg.value = message
  await refresh()
  // Page devenue vide (ex. derniers brouillons publiés / page hors bornes)
  if (data.value && !data.value.items.length && page.value > 1) {
    page.value = 1
  }
}

async function publishEvent(e: EventPublic) {
  actionId.value = e.id
  errorMsg.value = null
  successMsg.value = null
  try {
    await $fetch(`/api/admin/events/${e.id}/publish`, { method: 'POST', credentials: 'include' })
    await reloadList('Événement publié.')
  }
  catch {
    errorMsg.value = 'Publication impossible'
  }
  finally {
    actionId.value = null
  }
}

async function unpublishEvent(e: EventPublic) {
  actionId.value = e.id
  errorMsg.value = null
  successMsg.value = null
  try {
    await $fetch(`/api/admin/events/${e.id}/unpublish`, { method: 'POST', credentials: 'include' })
    await reloadList('Événement dépublié.')
  }
  catch {
    errorMsg.value = 'Dépublication impossible'
  }
  finally {
    actionId.value = null
  }
}

async function deleteEvent(e: EventPublic) {
  actionId.value = e.id
  errorMsg.value = null
  successMsg.value = null
  try {
    await $fetch(`/api/admin/events/${e.id}`, { method: 'DELETE', credentials: 'include' })
    await reloadList('Événement supprimé.')
  }
  catch {
    errorMsg.value = 'Suppression impossible'
  }
  finally {
    actionId.value = null
  }
}

async function bulkPublishSelected() {
  const targets = selectedEvents.value.filter(canPublish)
  if (!targets.length) return
  bulkBusy.value = true
  errorMsg.value = null
  successMsg.value = null
  let ok = 0
  let fail = 0
  try {
    for (const e of targets) {
      try {
        await $fetch(`/api/admin/events/${e.id}/publish`, { method: 'POST', credentials: 'include' })
        ok++
      }
      catch {
        fail++
      }
    }
    await reloadList(fail ? `${ok} publié(s), ${fail} échec(s).` : `${ok} publié(s).`)
  }
  finally {
    bulkBusy.value = false
  }
}

async function bulkUnpublishSelected() {
  const targets = selectedEvents.value.filter(canUnpublish)
  if (!targets.length) return
  bulkBusy.value = true
  errorMsg.value = null
  successMsg.value = null
  let ok = 0
  let fail = 0
  try {
    for (const e of targets) {
      try {
        await $fetch(`/api/admin/events/${e.id}/unpublish`, { method: 'POST', credentials: 'include' })
        ok++
      }
      catch {
        fail++
      }
    }
    await reloadList(fail ? `${ok} dépublié(s), ${fail} échec(s).` : `${ok} dépublié(s).`)
  }
  finally {
    bulkBusy.value = false
  }
}

async function bulkDeleteSelected() {
  const targets = [...selectedEvents.value]
  if (!targets.length) return
  bulkBusy.value = true
  errorMsg.value = null
  successMsg.value = null
  let ok = 0
  let fail = 0
  try {
    for (const e of targets) {
      try {
        await $fetch(`/api/admin/events/${e.id}`, { method: 'DELETE', credentials: 'include' })
        ok++
      }
      catch {
        fail++
      }
    }
    await reloadList(fail ? `${ok} supprimé(s), ${fail} échec(s).` : `${ok} supprimé(s).`)
  }
  finally {
    bulkBusy.value = false
  }
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
      <UiButton size="sm" variant="outline" :disabled="pending || bulkBusy" @click="refresh()">
        Actualiser
      </UiButton>
    </div>

    <p v-if="error" class="mb-4 text-sm text-[#AD291F]" role="alert">
      Impossible de charger les événements.
      <button type="button" class="underline" @click="refresh()">Réessayer</button>
    </p>
    <p v-else-if="pending && !data" class="mb-4 text-sm text-[#454545]">Chargement…</p>
    <p v-if="errorMsg" class="mb-4 text-sm text-[#AD291F]">{{ errorMsg }}</p>
    <p v-if="successMsg" class="mb-4 text-sm font-semibold text-[#206C4D]">{{ successMsg }}</p>

    <EventFilters
      v-model:q="q"
      v-model:category="category"
      v-model:statuses="statuses"
      v-model:publication="publication"
      id-prefix="admin-events"
      show-publication
    />

    <p
      v-if="!pending && !error && data && !data.items.length"
      class="mt-6 text-sm text-[#454545]"
    >
      Aucun événement pour ces filtres.
    </p>

    <div
      v-if="pageItems.length"
      class="relative mt-6"
    >
      <div class="mb-3 flex items-center gap-3 border-b border-[#DDDAD3] pb-3">
        <label class="flex cursor-pointer items-center gap-2 text-xs font-semibold text-[#636363]">
          <input
            type="checkbox"
            class="size-4 accent-[#6735B6]"
            :checked="allSelected"
            :indeterminate.prop="selectedCount > 0 && !allSelected"
            :disabled="bulkBusy || pending"
            @change="toggleSelectAll(($event.target as HTMLInputElement).checked)"
          >
          Tout sélectionner
        </label>
        <span
          v-if="selectedCount"
          class="text-xs tabular-nums text-[#454545]"
        >
          {{ selectedCount }} sélectionné{{ selectedCount > 1 ? 's' : '' }}
        </span>
      </div>

      <ul class="space-y-3 pb-20">
        <li
          v-for="e in pageItems"
          :key="e.id"
          class="flex items-start gap-3"
        >
          <div class="flex w-6 shrink-0 justify-center pt-6">
            <input
              v-model="selectedIds"
              type="checkbox"
              class="size-4 shrink-0 accent-[#6735B6]"
              :value="e.id"
              :disabled="bulkBusy || pending"
              :aria-label="`Sélectionner ${e.title}`"
              @mousedown="onCheckMouseDown(e, $event)"
              @click="onCheckClick(e, $event)"
              @change="onCheckChange(e)"
            >
          </div>

          <div class="min-w-0 flex-1">
            <EventCard
              :event="e"
              :to="`/admin/evenements/${e.id}`"
              static-card
              hide-action
            >
              <template #actions>
                <UiButton
                  v-if="canPublish(e)"
                  size="sm"
                  variant="red"
                  :disabled="actionId === e.id || bulkBusy || pending"
                  @click="publishEvent(e)"
                >
                  {{ actionId === e.id ? '…' : 'Publier' }}
                </UiButton>
                <UiButton
                  v-if="canUnpublish(e)"
                  size="sm"
                  variant="outline"
                  :disabled="actionId === e.id || bulkBusy || pending"
                  @click="unpublishEvent(e)"
                >
                  {{ actionId === e.id ? '…' : 'Dépublier' }}
                </UiButton>
                <NuxtLink :to="`/admin/evenements/${e.id}`">
                  <UiButton size="sm" variant="outline" type="button" class="w-full">
                    Modifier
                  </UiButton>
                </NuxtLink>
                <UiButton
                  size="sm"
                  variant="outline"
                  :disabled="actionId === e.id || bulkBusy || pending"
                  @click="deleteEvent(e)"
                >
                  {{ actionId === e.id ? '…' : 'Supprimer' }}
                </UiButton>
              </template>
            </EventCard>
          </div>
        </li>
      </ul>

      <div
        v-if="(data?.total || 0) > pageSize"
        class="mt-6 flex items-center justify-between gap-3 pb-20"
      >
        <UiButton
          size="sm"
          variant="outline"
          :disabled="page <= 1 || pending || bulkBusy"
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
          :disabled="page >= totalPages || pending || bulkBusy"
          @click="page++"
        >
          Suivant
        </UiButton>
      </div>

      <div
        class="sticky bottom-3 z-10 mt-4 rounded-[8px] border border-[#DDDAD3] bg-white/95 p-3 shadow-soft backdrop-blur"
      >
        <div class="flex flex-wrap items-center justify-between gap-3">
          <p class="text-xs font-semibold text-[#636363]">
            <template v-if="selectedCount">
              {{ selectedCount }} sélectionné{{ selectedCount > 1 ? 's' : '' }}
            </template>
            <template v-else>
              Sélectionnez des manifestations
            </template>
          </p>
          <div class="flex flex-wrap gap-2">
            <UiButton
              size="sm"
              variant="red"
              :disabled="!canBulkPublish || bulkBusy || pending"
              @click="bulkPublishSelected"
            >
              Publier
            </UiButton>
            <UiButton
              size="sm"
              variant="outline"
              :disabled="!canBulkUnpublish || bulkBusy || pending"
              @click="bulkUnpublishSelected"
            >
              Dépublier
            </UiButton>
            <UiButton
              size="sm"
              variant="outline"
              :disabled="!canBulkDelete || bulkBusy || pending"
              @click="bulkDeleteSelected"
            >
              Supprimer
            </UiButton>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
