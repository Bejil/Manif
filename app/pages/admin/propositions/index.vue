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
}

const { data, refresh, pending } = await useFetch<{
  pending: SubmissionRow[]
  items: SubmissionRow[]
  changesRequested: SubmissionRow[]
}>('/api/admin/submissions', {
  headers: cookieHeaders,
  credentials: 'include',
})

const toModerate = computed(() => data.value?.pending ?? [])
const changesRequested = computed(() => data.value?.changesRequested ?? [])
const awaitingEmail = computed(() =>
  (data.value?.items ?? []).filter(s => s.moderationStatus === 'awaiting_verification'),
)
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

    <section class="mb-10">
      <h2 class="text-sm font-bold uppercase tracking-[0.12em] text-[#636363]">
        À modérer
        <span class="text-[#111111]">({{ toModerate.length }})</span>
      </h2>

      <EmptyState
        v-if="!toModerate.length"
        class="mt-4"
        title="Aucune proposition à modérer"
        description="Elles apparaissent ici après confirmation e-mail du proposant."
      />

      <ul v-else class="mt-4 space-y-3">
        <li
          v-for="item in toModerate"
          :key="item.id"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#9C6EE8] bg-white p-5"
        >
          <div class="flex flex-wrap items-start justify-between gap-3">
            <div class="min-w-0 flex-1">
              <h3 class="font-extrabold text-[#111111]">{{ item.title }}</h3>
              <p class="mt-1 text-xs font-semibold text-[#636363]">
                {{ item.cityName }} · {{ item.startAt || 'Date à venir' }} · {{ item.category }}
                · proposant {{ item.proposerEmailMasked }}
              </p>
              <p class="mt-2 line-clamp-2 text-sm text-[#454545]">{{ item.description }}</p>
            </div>
            <NuxtLink :to="`/admin/propositions/${item.id}`">
              <UiButton size="sm">Examiner</UiButton>
            </NuxtLink>
          </div>
        </li>
      </ul>
    </section>

    <section class="mb-10">
      <h2 class="text-sm font-bold uppercase tracking-[0.12em] text-[#636363]">
        Modifications demandées
        <span class="text-[#111111]">({{ changesRequested.length }})</span>
      </h2>

      <EmptyState
        v-if="!changesRequested.length"
        class="mt-4"
        title="Aucune demande de modification en cours"
      />

      <ul v-else class="mt-4 space-y-3">
        <li
          v-for="item in changesRequested"
          :key="item.id"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#805200] bg-white p-5"
        >
          <div class="flex flex-wrap items-start justify-between gap-3">
            <div class="min-w-0 flex-1">
              <h3 class="font-extrabold text-[#111111]">{{ item.title }}</h3>
              <p class="mt-1 text-xs font-semibold text-[#636363]">
                {{ item.cityName }} · proposant {{ item.proposerEmailMasked }}
              </p>
              <p v-if="item.rejectionReason" class="mt-2 text-sm text-[#805200]">
                « {{ item.rejectionReason }} »
              </p>
            </div>
            <NuxtLink :to="`/admin/propositions/${item.id}`">
              <UiButton size="sm" variant="outline">Revoir</UiButton>
            </NuxtLink>
          </div>
        </li>
      </ul>
    </section>

    <section>
      <h2 class="text-sm font-bold uppercase tracking-[0.12em] text-[#636363]">
        En attente de confirmation e-mail
        <span class="text-[#111111]">({{ awaitingEmail.length }})</span>
      </h2>
      <p class="mt-2 text-sm text-[#454545]">
        Le proposant n’a pas encore cliqué le lien (valable 24 h).
      </p>

      <EmptyState
        v-if="!awaitingEmail.length"
        class="mt-4"
        title="Aucune proposition en attente d’e-mail"
      />

      <ul v-else class="mt-4 space-y-3">
        <li
          v-for="item in awaitingEmail"
          :key="item.id"
          class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#636363] bg-white p-5"
        >
          <div class="flex flex-wrap items-start justify-between gap-3">
            <div class="min-w-0 flex-1">
              <h3 class="font-extrabold text-[#111111]">{{ item.title }}</h3>
              <p class="mt-1 text-xs font-semibold text-[#636363]">
                {{ item.cityName }} · {{ item.startAt || 'Date à venir' }} · {{ item.category }}
                · proposant {{ item.proposerEmailMasked }}
              </p>
            </div>
            <NuxtLink :to="`/admin/propositions/${item.id}`">
              <UiButton size="sm" variant="ghost">Voir</UiButton>
            </NuxtLink>
          </div>
        </li>
      </ul>
    </section>
  </div>
</template>
