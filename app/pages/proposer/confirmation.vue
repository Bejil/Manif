<script setup lang="ts">
useSeoMeta({ title: "Confirmation — Manif'", robots: 'noindex' })

const route = useRoute()
const token = computed(() => {
  const q = route.query.token
  return typeof q === 'string' ? q : Array.isArray(q) ? (q[0] || '') : ''
})

const status = ref<'idle' | 'loading' | 'ok' | 'already' | 'error'>('idle')
const message = ref('')

async function verify() {
  if (!token.value) {
    status.value = 'error'
    message.value = 'Lien invalide — jeton manquant.'
    return
  }
  status.value = 'loading'
  try {
    const res = await $fetch<{ alreadyVerified: boolean, id?: string }>('/api/submissions/verify', {
      method: 'POST',
      body: { token: token.value },
    })
    if (res.id) {
      rememberMyProposal({
        submissionId: res.id,
        title: 'Ma proposition',
        cityName: '',
      })
    }
    status.value = res.alreadyVerified ? 'already' : 'ok'
  }
  catch (e: unknown) {
    status.value = 'error'
    const err = e as { data?: { statusMessage?: string } }
    message.value = err?.data?.statusMessage || 'Vérification impossible.'
  }
}

onMounted(() => {
  void verify()
})
</script>

<template>
  <div class="container-page py-16">
    <div class="mx-auto max-w-lg text-center">
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Proposer</p>
      <h1 class="mf-display mf-h3 mt-3 text-[#111111]">Confirmation de votre proposition</h1>
      <p v-if="status === 'loading' || status === 'idle'" class="mt-4 text-[#454545]">
        Vérification en cours…
      </p>
      <div v-else-if="status === 'ok'" class="mt-4 space-y-2">
        <p class="font-bold text-[#206C4D]">Adresse e-mail confirmée.</p>
        <p class="text-sm text-[#454545]">
          Merci. Votre proposition est en file de modération et n’est pas encore publiée.
          Suivez-la dans
          <NuxtLink to="/mes-manifestations" class="font-semibold text-[#6735B6] underline">Mes manifestations</NuxtLink>.
        </p>
      </div>
      <div v-else-if="status === 'already'" class="mt-4 space-y-2">
        <p class="font-bold text-[#111111]">Déjà confirmée</p>
        <p class="text-sm text-[#454545]">
          Cette proposition est déjà en attente d’examen —
          <NuxtLink to="/mes-manifestations" class="font-semibold text-[#6735B6] underline">Mes manifestations</NuxtLink>.
        </p>
      </div>
      <div v-else-if="status === 'error'" class="mt-4 space-y-3">
        <p class="text-[#AD291F]">{{ message }}</p>
        <p class="text-sm text-[#454545]">
          Si le lien a expiré, renvoyez une proposition depuis
          <NuxtLink to="/proposer" class="font-semibold text-[#6735B6] underline">Proposer</NuxtLink>.
        </p>
      </div>
      <NuxtLink to="/" class="mt-8 inline-block">
        <UiButton variant="outline">Retour à l’agenda</UiButton>
      </NuxtLink>
    </div>
  </div>
</template>
