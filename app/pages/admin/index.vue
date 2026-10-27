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

const email = ref('contact@manif.info')
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

async function logout() {
  await $fetch('/api/admin/logout', { method: 'POST' })
  await navigateTo('/admin')
  reloadNuxtApp()
}

type Dashboard = {
  pendingSubmissions: number
  publishedEvents: number
  openReports: number
  eventsWithoutCoords: number
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
    withoutCoords: number
    dateToConfirm: number
    byStatus: {
      upcoming: number
      ongoing: number
      past: number
      cancelled: number
      postponed: number
    }
    supports: number
    participations: number
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
    to: '/admin/evenements',
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
    to: '/admin/evenements',
    value: dash.value?.eventsWithoutCoords,
    label: 'Sans coordonnées',
    accent: 'border-l-[#636363]',
  },
])

const submissionRows = computed(() => {
  const s = dash.value?.submissions
  return [
    { label: 'À modérer', value: s?.pending_moderation, to: '/admin/propositions?statut=pending_moderation' },
    { label: 'Modifications demandées', value: s?.changes_requested, to: '/admin/propositions?statut=changes_requested' },
    { label: 'Attente e-mail', value: s?.awaiting_verification, to: '/admin/propositions?statut=awaiting_verification' },
    { label: 'Publiées', value: s?.approved, to: '/admin/propositions?statut=approved' },
    { label: 'Supprimées', value: s?.rejected, to: '/admin/propositions?statut=rejected' },
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
      <div class="mb-8 flex flex-wrap items-start justify-between gap-4">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Admin</p>
          <h1 class="mf-display mf-h3 mt-2 text-[#111111]">Tableau de bord</h1>
          <p class="mt-2 text-sm text-[#454545]">{{ me.email }}</p>
        </div>
        <UiButton variant="outline" size="sm" @click="logout">Déconnexion</UiButton>
      </div>

      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <NuxtLink
          v-for="stat in heroStats"
          :key="stat.label"
          :to="stat.to"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] bg-white p-4 transition hover:border-[#111111] hover:shadow-soft focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#111111]"
          :class="stat.accent"
        >
          <p class="mf-count text-[#111111]">{{ fmt(stat.value) }}</p>
          <p class="mt-1 text-sm font-semibold text-[#454545]">{{ stat.label }}</p>
        </NuxtLink>
      </div>

      <NuxtLink
        to="/admin/imports"
        class="mt-6 flex flex-wrap items-center justify-between gap-3 rounded-[8px] border border-[#DDDAD3] bg-[#111111] p-5 text-[#FFFCF4] transition hover:bg-[#252525]"
      >
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Sources</p>
          <p class="mf-display mt-1 text-2xl">Imports multi-sources</p>
          <p class="mt-1 text-sm text-[#FFFCF4]/65">
            AMI · Démosphère · manifs.fr · ManifRadar · Mobilizon XR
          </p>
        </div>
        <span class="text-sm font-bold text-[#9C6EE8]">Ouvrir →</span>
      </NuxtLink>

      <div
        v-if="dash?.countingAnomalies?.length"
        class="mt-6 rounded-[8px] border border-[#805200]/30 bg-[#FFF8E8] p-4 text-sm text-[#805200]"
      >
        <p class="font-bold">Anomalies de comptage</p>
        <ul class="mt-2 list-disc pl-5">
          <li v-for="(a, i) in dash.countingAnomalies" :key="i">{{ a }}</li>
        </ul>
      </div>

      <div class="mt-10 grid gap-6 lg:grid-cols-2">
        <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-5">
          <div class="flex items-baseline justify-between gap-3">
            <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Propositions</h2>
            <p class="text-sm text-[#636363]">{{ fmt(dash?.submissions?.total) }} au total</p>
          </div>
          <ul class="mt-4 divide-y divide-[#DDDAD3]">
            <li v-for="row in submissionRows" :key="row.label">
              <NuxtLink
                :to="row.to"
                class="flex items-center justify-between gap-3 py-3 text-sm transition hover:text-[#D1271C]"
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
          <dl class="mt-4 grid grid-cols-2 gap-x-4 gap-y-3 text-sm">
            <div>
              <dt class="text-[#636363]">Publiées</dt>
              <dd class="mt-0.5 font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.published) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Dépubliées</dt>
              <dd class="mt-0.5 font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.unpublished) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Brouillons</dt>
              <dd class="mt-0.5 font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.draft) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Date à confirmer</dt>
              <dd class="mt-0.5 font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.dateToConfirm) }}</dd>
            </div>
            <div>
              <dt class="text-[#636363]">Sans coordonnées</dt>
              <dd class="mt-0.5 font-bold tabular-nums text-[#111111]">{{ fmt(dash?.events?.withoutCoords) }}</dd>
            </div>
          </dl>
          <ul class="mt-5 divide-y divide-[#DDDAD3] border-t border-[#DDDAD3]">
            <li
              v-for="row in eventStatusRows"
              :key="row.label"
              class="flex items-center justify-between gap-3 py-3 text-sm"
            >
              <span class="font-semibold text-[#111111]">{{ row.label }}</span>
              <span class="tabular-nums text-[#454545]">{{ fmt(row.value) }}</span>
            </li>
          </ul>
        </section>
      </div>

      <section class="mt-6 rounded-[8px] border border-[#DDDAD3] bg-white p-5">
        <h2 class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">Engagement</h2>
        <dl class="mt-4 grid gap-4 sm:grid-cols-2">
          <div>
            <dt class="text-sm text-[#636363]">Soutiens (publiées)</dt>
            <dd class="mt-1 mf-display text-3xl tabular-nums text-[#111111]">
              {{ fmt(dash?.events?.supports) }}
            </dd>
          </div>
          <div>
            <dt class="text-sm text-[#636363]">Participations (publiées)</dt>
            <dd class="mt-1 mf-display text-3xl tabular-nums text-[#111111]">
              {{ fmt(dash?.events?.participations) }}
            </dd>
          </div>
        </dl>
      </section>
    </div>
  </div>
</template>
