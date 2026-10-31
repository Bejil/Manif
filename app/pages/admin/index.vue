<script setup lang="ts">
definePageMeta({ layout: 'admin' })
useSeoMeta({ title: "Admin — Manif'", robots: 'noindex' })

const cookieHeaders = import.meta.server
  ? useRequestHeaders(['cookie'])
  : undefined

const { data: me, refresh: refreshMe } = await useFetch<{ authenticated: boolean, email?: string }>(
  '/api/admin/me',
  { headers: cookieHeaders, credentials: 'include' },
)

const email = ref('')
const password = ref('')
const loginError = ref<string | null>(null)

async function login() {
  loginError.value = null
  try {
    await $fetch('/api/admin/login', {
      method: 'POST',
      body: { email: email.value, password: password.value },
    })
    await refreshMe()
    await refreshDash()
    await navigateTo('/admin')
  }
  catch {
    loginError.value = 'Connexion impossible'
  }
}

type HighlightEvent = {
  id: string
  title: string
  cityName: string
  views: number
  supports: number
  participations: number
}

type NamedCount = {
  key: string
  label: string
  count: number
}

type Dashboard = {
  pendingSubmissions: number
  publishedEvents: number
  openReports: number
  activeAlerts: number
  pendingAlerts: number
  countingAnomalies: string[]
  submissions: {
    total: number
    pending_moderation: number
    changes_requested: number
    awaiting_verification: number
    approved: number
    rejected: number
  }
  events: {
    total: number
    published: number
    unpublished: number
    draft: number
    dateToConfirm: number
    byStatus: {
      upcoming: number
      ongoing: number
      past: number
      cancelled: number
      postponed: number
    }
    views: number
    supports: number
    participations: number
    avgViews: number
  }
  highlights: {
    topViews: HighlightEvent[]
    topSupports: HighlightEvent[]
    topParticipations: HighlightEvent[]
    topCities: NamedCount[]
    topCategories: NamedCount[]
  }
}

const { data: dash, refresh: refreshDash } = await useFetch<Dashboard>('/api/admin/dashboard', {
  headers: cookieHeaders,
  credentials: 'include',
  immediate: me.value?.authenticated === true,
  watch: false,
})

watch(() => me.value?.authenticated, (ok) => {
  if (ok) void refreshDash()
})

const heroStats = computed(() => [
  {
    to: '/admin/propositions?statut=pending_moderation',
    value: dash.value?.pendingSubmissions,
    label: 'Propositions en attente',
    accent: 'border-l-[#9C6EE8]',
  },
  {
    to: '/admin/evenements?publication=published',
    value: dash.value?.publishedEvents,
    label: 'Manifestations publiées',
    accent: 'border-l-[#D1271C]',
  },
  {
    to: '/admin/signalements',
    value: dash.value?.openReports,
    label: 'Signalements ouverts',
    accent: 'border-l-[#805200]',
  },
  {
    to: '/admin/alertes',
    value: dash.value?.activeAlerts,
    label: 'Alertes e-mail actives',
    accent: 'border-l-[#206C4D]',
  },
])

const submissionRows = computed(() => {
  const s = dash.value?.submissions
  return [
    { label: 'À modérer', value: s?.pending_moderation, to: '/admin/propositions?statut=pending_moderation' },
    { label: 'Modifs demandées', value: s?.changes_requested, to: '/admin/propositions?statut=changes_requested' },
    { label: 'Attente e-mail', value: s?.awaiting_verification, to: '/admin/propositions?statut=awaiting_verification' },
    { label: 'Approuvées', value: s?.approved, to: '/admin/propositions?statut=approved' },
    { label: 'Rejetées', value: s?.rejected, to: '/admin/propositions?statut=rejected' },
  ]
})

const eventStatusRows = computed(() => {
  const b = dash.value?.events?.byStatus
  return [
    { label: 'À venir', value: b?.upcoming },
    { label: 'En cours', value: b?.ongoing },
    { label: 'Terminées', value: b?.past },
    { label: 'Annulées', value: b?.cancelled },
    { label: 'Reportées', value: b?.postponed },
  ]
})

const highlightBlocks = computed(() => {
  const h = dash.value?.highlights
  if (!h) return []
  return [
    { title: 'Plus vues', metric: 'views' as const, rows: h.topViews },
    { title: 'Plus soutenues', metric: 'supports' as const, rows: h.topSupports },
    { title: 'Plus participées', metric: 'participations' as const, rows: h.topParticipations },
  ]
})

function fmt(n: number | undefined | null) {
  if (n == null) return '—'
  return n.toLocaleString('fr-FR')
}
</script>

<template>
  <div>
    <div v-if="!me?.authenticated" class="mx-auto max-w-md rounded-[8px] border border-[#DDDAD3] bg-white p-6 shadow-soft">
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
      <h1 class="mf-display mf-h3 mt-3 text-[#111111]">Administration</h1>
      <p class="mt-2 text-sm text-[#454545]">Accès réservé. Pas d’espace public de connexion.</p>
      <form class="mt-6 space-y-4" @submit.prevent="login">
        <UiInput id="admin-email" v-model="email" label="E-mail" type="email" required autocomplete="username" />
        <UiInput id="admin-password" v-model="password" label="Mot de passe" type="password" required autocomplete="current-password" />
        <p v-if="loginError" class="text-sm text-[#AD291F]">{{ loginError }}</p>
        <UiButton type="submit" variant="red" block>Se connecter</UiButton>
      </form>
    </div>

    <div v-else>
      <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
          <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Tableau de bord</h1>
        </div>
        <p class="text-sm text-[#636363]">{{ me.email }}</p>
      </div>

      <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
        <NuxtLink
          v-for="stat in heroStats"
          :key="stat.label"
          :to="stat.to"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] bg-white px-4 py-3 transition hover:border-[#111111] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#111111]"
          :class="stat.accent"
        >
          <p class="mf-count text-[#111111]">{{ fmt(stat.value) }}</p>
          <p class="mt-0.5 text-sm font-semibold text-[#454545]">{{ stat.label }}</p>
        </NuxtLink>
      </div>

      <NuxtLink
        to="/admin/imports"
        class="mt-5 flex flex-wrap items-center justify-between gap-3 rounded-[8px] border border-[#DDDAD3] bg-[#111111] px-5 py-4 text-[#FFFCF4] transition hover:bg-[#252525]"
      >
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Sources</p>
          <p class="mt-1 text-lg font-bold">Imports multi-sources</p>
        </div>
        <span class="text-sm font-bold text-[#9C6EE8]">Ouvrir →</span>
      </NuxtLink>

      <div
        v-if="dash?.countingAnomalies?.length"
        class="mt-4 rounded-[8px] border border-[#805200]/30 bg-[#FFF8E8] px-4 py-3 text-sm text-[#805200]"
      >
        <p class="font-bold">Anomalies de comptage</p>
        <ul class="mt-1 list-disc pl-5">
          <li v-for="(a, i) in dash.countingAnomalies" :key="i">{{ a }}</li>
        </ul>
      </div>

      <div class="mt-6 grid gap-4 lg:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <div class="flex items-baseline justify-between gap-3">
            <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Propositions</h2>
            <p class="text-sm text-[#636363]">{{ fmt(dash?.submissions?.total) }} au total</p>
          </div>
          <ul class="mt-3 divide-y divide-[#DDDAD3]">
            <li v-for="row in submissionRows" :key="row.label">
              <NuxtLink
                :to="row.to"
                class="flex items-center justify-between gap-3 py-2.5 text-sm transition hover:text-[#D1271C]"
              >
                <span class="font-semibold text-[#111111]">{{ row.label }}</span>
                <span class="tabular-nums text-[#454545]">{{ fmt(row.value) }}</span>
              </NuxtLink>
            </li>
          </ul>
        </section>

        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <div class="flex items-baseline justify-between gap-3">
            <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Manifestations</h2>
            <NuxtLink to="/admin/evenements" class="text-sm font-semibold text-[#454545] hover:text-[#D1271C]">
              {{ fmt(dash?.events?.total) }} au total
            </NuxtLink>
          </div>
          <dl class="mt-3 grid grid-cols-2 gap-x-4 gap-y-2 text-sm">
            <div>
              <dt class="text-[#636363]">Publiées</dt>
              <dd class="font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.published) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Dépubliées</dt>
              <dd class="font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.unpublished) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Brouillons</dt>
              <dd class="font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.draft) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Date à confirmer</dt>
              <dd class="font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.dateToConfirm) }}</dd>
            </div>
          </dl>
          <ul class="mt-4 divide-y divide-[#DDDAD3] border-t border-[#DDDAD3]">
            <li
              v-for="row in eventStatusRows"
              :key="row.label"
              class="flex items-center justify-between gap-3 py-2.5 text-sm"
            >
              <span class="font-semibold text-[#111111]">{{ row.label }}</span>
              <span class="tabular-nums text-[#454545]">{{ fmt(row.value) }}</span>
            </li>
          </ul>
        </section>
      </div>

      <section class="mt-4 rounded-[8px] border border-[#DDDAD3] bg-white p-5">
        <div class="flex flex-wrap items-baseline justify-between gap-3">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Audience</h2>
          <NuxtLink to="/admin/stats" class="text-sm font-semibold text-[#6735B6] hover:underline">
            Stats détaillées →
          </NuxtLink>
        </div>
        <dl class="mt-4 grid gap-4 sm:grid-cols-3">
          <div>
            <dt class="text-sm text-[#636363]">Vues</dt>
            <dd class="mt-1 text-2xl font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.views) }}</dd>
            <p class="mt-0.5 text-xs text-[#636363]">moy. {{ fmt(dash?.events?.avgViews) }} / fiche</p>
          </div>
          <div>
            <dt class="text-sm text-[#636363]">Soutiens</dt>
            <dd class="mt-1 text-2xl font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.supports) }}</dd>
          </div>
          <div>
            <dt class="text-sm text-[#636363]">Participations</dt>
            <dd class="mt-1 text-2xl font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.participations) }}</dd>
          </div>
        </dl>
        <div class="mt-4">
          <AdminMixBars
            :views="dash?.events?.views ?? 0"
            :supports="dash?.events?.supports ?? 0"
            :participations="dash?.events?.participations ?? 0"
          />
        </div>
      </section>

      <div class="mt-4 grid gap-4 lg:grid-cols-3">
        <section
          v-for="block in highlightBlocks"
          :key="block.title"
          class="rounded-[8px] border border-[#DDDAD3] bg-white p-4"
        >
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">{{ block.title }}</h2>
          <p v-if="!block.rows.length" class="mt-3 text-sm text-[#636363]">Pas encore de données.</p>
          <ol v-else class="mt-3 divide-y divide-[#DDDAD3]">
            <li
              v-for="(row, index) in block.rows"
              :key="row.id"
              class="flex items-start gap-2 py-2"
            >
              <span class="w-4 shrink-0 pt-0.5 text-xs font-bold tabular-nums text-[#636363]">{{ index + 1 }}</span>
              <div class="min-w-0 flex-1">
                <NuxtLink
                  :to="`/admin/evenements/${row.id}`"
                  class="block truncate text-sm font-bold text-[#111111] hover:text-[#D1271C]"
                >
                  {{ row.title }}
                </NuxtLink>
                <p class="truncate text-xs text-[#636363]">{{ row.cityName }}</p>
              </div>
              <span class="shrink-0 text-sm font-bold tabular-nums">{{ fmt(row[block.metric]) }}</span>
            </li>
          </ol>
        </section>
      </div>

      <div class="mt-4 grid gap-4 sm:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Top villes</h2>
          <ul class="mt-3 divide-y divide-[#DDDAD3]">
            <li
              v-for="city in dash?.highlights?.topCities ?? []"
              :key="city.key"
              class="flex justify-between gap-3 py-2 text-sm"
            >
              <span class="truncate font-semibold">{{ city.label }}</span>
              <span class="tabular-nums text-[#454545]">{{ fmt(city.count) }}</span>
            </li>
          </ul>
        </section>
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
          <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Top thèmes</h2>
          <ul class="mt-3 divide-y divide-[#DDDAD3]">
            <li
              v-for="cat in dash?.highlights?.topCategories ?? []"
              :key="cat.key"
              class="flex justify-between gap-3 py-2 text-sm"
            >
              <span class="truncate font-semibold">{{ cat.label }}</span>
              <span class="tabular-nums text-[#454545]">{{ fmt(cat.count) }}</span>
            </li>
          </ul>
        </section>
      </div>
    </div>
  </div>
</template>
