<script setup lang="ts">
definePageMeta({ layout: 'admin' })
useSeoMeta({ title: "Stats — Admin Manif'", robots: 'noindex' })

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me } = await useFetch('/api/admin/me', {
  headers: cookieHeaders,
  credentials: 'include',
})
if (!me.value?.authenticated) await navigateTo('/admin')

type StatEventRow = {
  id: string
  title: string
  cityName: string
  categoryLabel: string
  views: number
  supports: number
  participations: number
  engagement: number
}

type NamedCount = {
  key: string
  label: string
  count: number
  views: number
  supports: number
  participations: number
}

type StatsPayload = {
  totals: {
    published: number
    views: number
    supports: number
    participations: number
    engagement: number
    withViews: number
    withSupports: number
    withParticipations: number
    avgViews: number
    avgSupports: number
    avgParticipations: number
  }
  topViews: StatEventRow[]
  topSupports: StatEventRow[]
  topParticipations: StatEventRow[]
  topEngagement: StatEventRow[]
  byCity: NamedCount[]
  byCategory: NamedCount[]
}

const { data: stats, pending, error, refresh } = await useFetch<StatsPayload>('/api/admin/stats', {
  headers: cookieHeaders,
  credentials: 'include',
  query: { limit: 12 },
})

const DONUT_COLORS = [
  '#D1271C', '#4D257D', '#6735B6', '#9C6EE8', '#97251B',
  '#805200', '#206C4D', '#454545', '#111111', '#636363',
]

function fmt(n: number | undefined | null) {
  if (n == null) return '—'
  return n.toLocaleString('fr-FR')
}

const summaryCards = computed(() => {
  const t = stats.value?.totals
  return [
    { label: 'Vues', value: t?.views, hint: `moy. ${fmt(t?.avgViews)} / fiche`, accent: 'border-l-[#454545]' },
    { label: 'Soutiens', value: t?.supports, hint: `${fmt(t?.withSupports)} fiches`, accent: 'border-l-[#4D257D]' },
    { label: 'Participations', value: t?.participations, hint: `${fmt(t?.withParticipations)} fiches`, accent: 'border-l-[#97251B]' },
    { label: 'Publiées', value: t?.published, hint: `${fmt(t?.engagement)} eng. total`, accent: 'border-l-[#D1271C]' },
  ]
})

const audienceDonut = computed(() => {
  const t = stats.value?.totals
  if (!t) return []
  return [
    { id: 'views', label: 'Vues', value: t.views, color: '#454545' },
    { id: 'supports', label: 'Soutiens', value: t.supports, color: '#4D257D' },
    { id: 'participations', label: 'Participations', value: t.participations, color: '#97251B' },
  ]
})

const categoryDonut = computed(() =>
  (stats.value?.byCategory ?? []).map((c, i) => ({
    id: c.key,
    label: c.label,
    value: c.count,
    color: DONUT_COLORS[i % DONUT_COLORS.length]!,
  })),
)

const topViewsColumns = computed(() =>
  (stats.value?.topViews ?? []).slice(0, 8).map(r => ({
    id: r.id,
    label: r.title,
    value: r.views,
    href: `/admin/evenements/${r.id}`,
  })),
)

const cityColumns = computed(() =>
  (stats.value?.byCity ?? []).slice(0, 8).map(c => ({
    id: c.key,
    label: c.label,
    value: c.count,
  })),
)

const topSupportsBars = computed(() =>
  (stats.value?.topSupports ?? []).map(r => ({
    id: r.id,
    label: r.title,
    sublabel: r.cityName,
    value: r.supports,
    href: `/admin/evenements/${r.id}`,
  })),
)

const topParticipationsBars = computed(() =>
  (stats.value?.topParticipations ?? []).map(r => ({
    id: r.id,
    label: r.title,
    sublabel: r.cityName,
    value: r.participations,
    href: `/admin/evenements/${r.id}`,
  })),
)

const groupedEngagement = computed(() =>
  (stats.value?.topEngagement ?? []).slice(0, 8).map(r => ({
    id: r.id,
    label: r.title,
    supports: r.supports,
    participations: r.participations,
    href: `/admin/evenements/${r.id}`,
  })),
)
</script>

<template>
  <div>
    <div class="mb-6 flex flex-wrap items-end justify-between gap-4">
      <div>
        <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
        <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Statistiques</h1>
      </div>
      <UiButton size="sm" variant="ghost" :disabled="pending" @click="refresh()">
        Actualiser
      </UiButton>
    </div>

    <p v-if="error" class="rounded-[8px] border border-[#AD291F]/30 bg-[#FDEDEB] p-4 text-sm text-[#AD291F]">
      Impossible de charger les statistiques.
    </p>

    <template v-else>
      <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
        <div
          v-for="card in summaryCards"
          :key="card.label"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] bg-white px-4 py-3"
          :class="card.accent"
        >
          <p class="mf-count text-[#111111]">{{ fmt(card.value) }}</p>
          <p class="mt-0.5 text-sm font-semibold text-[#454545]">{{ card.label }}</p>
          <p class="mt-0.5 text-xs text-[#636363]">{{ card.hint }}</p>
        </div>
      </div>

      <div class="mt-6 grid gap-6 lg:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Audience (camembert)
          </h2>
          <div class="mt-4">
            <AdminDonutChart :items="audienceDonut" />
          </div>
        </section>

        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Thèmes (camembert)
          </h2>
          <div class="mt-4">
            <AdminDonutChart :items="categoryDonut" />
          </div>
        </section>
      </div>

      <div class="mt-6 grid gap-6 lg:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Top vues (histogramme)
          </h2>
          <p class="mt-1 text-xs text-[#636363]">Fiches les plus consultées</p>
          <div class="mt-4">
            <AdminVBarChart :items="topViewsColumns" bar-class="bg-[#454545]" :height="180" />
          </div>
        </section>

        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Villes (histogramme)
          </h2>
          <p class="mt-1 text-xs text-[#636363]">Nombre de fiches publiées</p>
          <div class="mt-4">
            <AdminVBarChart :items="cityColumns" bar-class="bg-[#111111]" :height="180" />
          </div>
        </section>
      </div>

      <section class="mt-6 rounded-[8px] border border-[#DDDAD3] bg-white p-5">
        <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
          Engagement comparé (barres groupées)
        </h2>
        <p class="mt-1 text-xs text-[#636363]">Soutiens vs participations — top fiches</p>
        <div class="mt-4">
          <AdminGroupedBars :items="groupedEngagement" />
        </div>
      </section>

      <div class="mt-6 grid gap-6 xl:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Plus soutenues (barres)
          </h2>
          <div class="mt-4">
            <AdminHBarChart :items="topSupportsBars" bar-class="bg-[#4D257D]" />
          </div>
        </section>

        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
            Plus participées (barres)
          </h2>
          <div class="mt-4">
            <AdminHBarChart :items="topParticipationsBars" bar-class="bg-[#97251B]" />
          </div>
        </section>
      </div>

      <section class="mt-6 rounded-[8px] border border-[#DDDAD3] bg-white p-5">
        <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
          Mix global (barre empilée)
        </h2>
        <div class="mt-4">
          <AdminMixBars
            :views="stats?.totals?.views ?? 0"
            :supports="stats?.totals?.supports ?? 0"
            :participations="stats?.totals?.participations ?? 0"
          />
        </div>
      </section>
    </template>
  </div>
</template>
