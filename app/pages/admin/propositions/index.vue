<script setup lang="ts">
definePageMeta({ layout: 'admin' })
useSeoMeta({ title: 'Propositions — Admin', robots: 'noindex' })

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

type SubmissionRow = {
  id: string
  title: string
  cityName: string
  startAt: string | null
  category: string
  proposerEmailMasked: string
  description: string
  moderationStatus: string
  verificationStatus: string
  rejectionReason: string | null
  updatedAt?: string
}

type TabId =
  | 'pending_moderation'
  | 'changes_requested'
  | 'awaiting_verification'
  | 'approved'
  | 'rejected'

const tabs: Array<{ id: TabId, label: string, accent: string }> = [
  { id: 'pending_moderation', label: 'À modérer', accent: 'border-l-[#9C6EE8]' },
  { id: 'changes_requested', label: 'Modifications', accent: 'border-l-[#805200]' },
  { id: 'awaiting_verification', label: 'Attente e-mail', accent: 'border-l-[#636363]' },
  { id: 'approved', label: 'Publiées', accent: 'border-l-[#206C4D]' },
  { id: 'rejected', label: 'Supprimées', accent: 'border-l-[#AD291F]' },
]

const route = useRoute()
const router = useRouter()

const activeTab = computed<TabId>({
  get() {
    const q = route.query.statut
    const id = typeof q === 'string' ? q : ''
    if (tabs.some(t => t.id === id)) return id as TabId
    return 'pending_moderation'
  },
  set(id) {
    router.replace({ query: { ...route.query, statut: id } })
  },
})

const { data, refresh, pending } = await useFetch<{ items: SubmissionRow[] }>(
  '/api/admin/submissions',
  {
    headers: cookieHeaders,
    credentials: 'include',
  },
)

const counts = computed(() => {
  const c: Record<TabId, number> = {
    pending_moderation: 0,
    changes_requested: 0,
    awaiting_verification: 0,
    approved: 0,
    rejected: 0,
  }
  for (const s of data.value?.items ?? []) {
    if (s.moderationStatus in c) {
      c[s.moderationStatus as TabId] += 1
    }
  }
  return c
})

const filtered = computed(() =>
  (data.value?.items ?? []).filter(s => s.moderationStatus === activeTab.value),
)

const emptyCopy = computed(() => {
  switch (activeTab.value) {
    case 'pending_moderation':
      return {
        title: 'Aucune proposition à modérer',
        description: 'Elles apparaissent ici après confirmation e-mail du proposant.',
      }
    case 'changes_requested':
      return { title: 'Aucune demande de modification en cours', description: '' }
    case 'awaiting_verification':
      return {
        title: 'Aucune proposition en attente d’e-mail',
        description: 'Le proposant n’a pas encore cliqué le lien (valable 24 h).',
      }
    case 'approved':
      return { title: 'Aucune proposition publiée', description: '' }
    case 'rejected':
      return {
        title: 'Aucune proposition refusée',
        description: 'Les propositions refusées restent consultables ici.',
      }
    default:
      return { title: 'Aucune proposition', description: '' }
  }
})

const activeAccent = computed(
  () => tabs.find(t => t.id === activeTab.value)?.accent || 'border-l-[#9C6EE8]',
)

function ctaLabel(status: string) {
  if (status === 'pending_moderation' || status === 'changes_requested') return 'Examiner'
  return 'Voir'
}
</script>

<template>
  <div>
    <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Propositions</h1>
      </div>
      <UiButton size="sm" variant="outline" :disabled="pending" @click="refresh()">
        Actualiser
      </UiButton>
    </div>

    <div
      class="flex gap-1 overflow-x-auto border-b border-[#DDDAD3] pb-px"
      role="tablist"
      aria-label="Filtrer par statut"
    >
      <button
        v-for="tab in tabs"
        :key="tab.id"
        type="button"
        role="tab"
        class="shrink-0 border-b-2 px-3 py-2.5 text-sm font-bold transition"
        :class="activeTab === tab.id
          ? 'border-[#111111] text-[#111111]'
          : 'border-transparent text-[#636363] hover:text-[#111111]'"
        :aria-selected="activeTab === tab.id"
        @click="activeTab = tab.id"
      >
        {{ tab.label }}
        <span
          class="ml-1.5 inline-flex min-w-[1.25rem] justify-center rounded-full px-1.5 text-xs font-bold"
          :class="activeTab === tab.id ? 'bg-[#111111] text-[#FFFCF4]' : 'bg-[#F4F1EA] text-[#636363]'"
        >
          {{ counts[tab.id] }}
        </span>
      </button>
    </div>

    <div class="mt-6" role="tabpanel">
      <EmptyState
        v-if="!filtered.length"
        :title="emptyCopy.title"
        :description="emptyCopy.description || undefined"
      />

      <ul v-else class="space-y-2">
        <li
          v-for="item in filtered"
          :key="item.id"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] bg-white px-3.5 py-2.5"
          :class="activeAccent"
        >
          <div class="flex flex-wrap items-center justify-between gap-2">
            <div class="min-w-0 flex-1">
              <h3 class="text-sm font-extrabold leading-snug text-[#111111]">{{ item.title }}</h3>
              <p class="mt-0.5 text-xs font-semibold text-[#636363]">
                {{ item.cityName }} · {{ item.startAt || 'Date à venir' }} · {{ item.category }}
                · proposant {{ item.proposerEmailMasked }}
              </p>
              <p
                v-if="item.rejectionReason && (activeTab === 'changes_requested' || activeTab === 'rejected')"
                class="mt-0.5 line-clamp-1 text-xs"
                :class="activeTab === 'rejected' ? 'text-[#AD291F]' : 'text-[#805200]'"
              >
                « {{ item.rejectionReason }} »
              </p>
              <p
                v-else-if="activeTab === 'pending_moderation' || activeTab === 'awaiting_verification'"
                class="mt-0.5 line-clamp-1 text-xs text-[#454545]"
              >
                {{ item.description }}
              </p>
            </div>
            <NuxtLink :to="`/admin/propositions/${item.id}`">
              <UiButton
                size="sm"
                :variant="activeTab === 'pending_moderation' ? undefined : 'outline'"
              >
                {{ ctaLabel(item.moderationStatus) }}
              </UiButton>
            </NuxtLink>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
