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
    loginError.value = 'Connexion impossible — en local : mot de passe « dev-admin-change-me »'
  }
}

async function logout() {
  await $fetch('/api/admin/logout', { method: 'POST' })
  await navigateTo('/admin')
  reloadNuxtApp()
}

const { data: dash, refresh: refreshDash } = await useFetch('/api/admin/dashboard', {
  headers: cookieHeaders,
  credentials: 'include',
  immediate: me.value?.authenticated === true,
  watch: false,
})

watch(() => me.value?.authenticated, (ok) => {
  if (ok) void refreshDash()
})
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
        <p class="text-xs text-[#636363]">
          En développement : mot de passe <code class="font-semibold">dev-admin-change-me</code>.
        </p>
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
        <div class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#9C6EE8] bg-white p-4">
          <p class="mf-count text-[#111111]">{{ dash?.pendingSubmissions ?? '—' }}</p>
          <p class="mt-1 text-sm font-semibold text-[#454545]">Propositions en attente</p>
        </div>
        <div class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#D1271C] bg-white p-4">
          <p class="mf-count text-[#111111]">{{ dash?.publishedEvents ?? '—' }}</p>
          <p class="mt-1 text-sm font-semibold text-[#454545]">Manifestations publiées</p>
        </div>
        <div class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#805200] bg-white p-4">
          <p class="mf-count text-[#111111]">{{ dash?.openReports ?? '—' }}</p>
          <p class="mt-1 text-sm font-semibold text-[#454545]">Signalements ouverts</p>
        </div>
        <div class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#636363] bg-white p-4">
          <p class="mf-count text-[#111111]">{{ dash?.eventsWithoutCoords ?? '—' }}</p>
          <p class="mt-1 text-sm font-semibold text-[#454545]">Sans coordonnées</p>
        </div>
      </div>

      <div
        v-if="dash?.countingAnomalies?.length"
        class="mt-6 rounded-[8px] border border-[#805200]/30 bg-[#FFF8E8] p-4 text-sm text-[#805200]"
      >
        <p class="font-bold">Anomalies de comptage</p>
        <ul class="mt-2 list-disc pl-5">
          <li v-for="(a, i) in dash.countingAnomalies" :key="i">{{ a }}</li>
        </ul>
      </div>

      <div class="mt-10 flex flex-wrap gap-3">
        <NuxtLink to="/admin/propositions">
          <UiButton variant="red">Modérer les propositions</UiButton>
        </NuxtLink>
        <NuxtLink to="/admin/evenements">
          <UiButton>Gérer les événements</UiButton>
        </NuxtLink>
        <NuxtLink to="/admin/signalements">
          <UiButton variant="outline">Voir les signalements</UiButton>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>
