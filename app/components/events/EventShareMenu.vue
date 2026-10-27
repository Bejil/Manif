<script setup lang="ts">
const props = withDefaults(defineProps<{
  title: string
  cityName: string
  url: string
  /** Classes additionnelles sur le bouton déclencheur (ex. hero sombre) */
  buttonClass?: string
  /** Masque le bouton déclencheur (contrôle externe) */
  hideTrigger?: boolean
}>(), {
  hideTrigger: false,
})

const open = ref(false)

defineExpose({
  openMenu: () => { open.value = true },
})
const feedback = ref<string | null>(null)
const canNativeShare = ref(false)
const { share, copyLink, openSocial, shareInstagram, supportsNativeShare } = useShare()

const payload = computed(() => ({
  title: props.title,
  text: `${props.title} — ${props.cityName} · Voir sur Manif'`,
  url: props.url,
}))

onMounted(() => {
  canNativeShare.value = supportsNativeShare()
})

function showFeedback(message: string) {
  feedback.value = message
  window.setTimeout(() => {
    if (feedback.value === message) feedback.value = null
  }, 3500)
}

async function onNative() {
  const res = await share(payload.value)
  if (res.method === 'clipboard') showFeedback('Lien copié dans le presse-papiers')
  if (res.method === 'native') open.value = false
}

async function onCopy() {
  const res = await copyLink(payload.value.url)
  showFeedback(res.method === 'clipboard' ? 'Lien copié dans le presse-papiers' : 'Impossible de copier le lien')
}

function onFacebook() {
  openSocial('facebook', payload.value)
}

function onTwitter() {
  openSocial('twitter', payload.value)
}

function onTelegram() {
  openSocial('telegram', payload.value)
}

async function onInstagram() {
  const res = await shareInstagram(payload.value)
  if (res.method === 'instagram') {
    showFeedback('Lien copié — collez-le dans une story, un message ou une publication Instagram')
  }
  else {
    showFeedback('Impossible de copier le lien')
  }
}
</script>

<template>
  <div>
    <UiButton
      v-if="!hideTrigger"
      variant="outline"
      type="button"
      :class="buttonClass"
      @click="open = true"
    >
      <BrandIcon name="share" :size="16" />
      Partager
    </UiButton>

    <p v-if="feedback && !open && !hideTrigger" class="mt-3 text-sm font-semibold text-[#4D257D]" role="status">
      {{ feedback }}
    </p>

    <UiModal :open="open" title="Partager cette manifestation" @close="open = false">
      <p class="text-sm text-[#454545]">
        Faites circuler la fiche Manif' sur vos réseaux.
      </p>

      <ul class="mt-4 divide-y divide-[#DDDAD3] border border-[#DDDAD3] rounded-[4px]">
        <li>
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onFacebook"
          >
            <span>Facebook</span>
            <span class="text-xs font-semibold text-[#636363]">Ouvrir</span>
          </button>
        </li>
        <li>
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onTwitter"
          >
            <span>X / Twitter</span>
            <span class="text-xs font-semibold text-[#636363]">Ouvrir</span>
          </button>
        </li>
        <li>
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onInstagram"
          >
            <span>Instagram</span>
            <span class="text-xs font-semibold text-[#636363]">Copier le lien</span>
          </button>
        </li>
        <li>
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onTelegram"
          >
            <span>Telegram</span>
            <span class="text-xs font-semibold text-[#636363]">Ouvrir</span>
          </button>
        </li>
        <li>
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onCopy"
          >
            <span>Copier le lien</span>
            <span class="text-xs font-semibold text-[#636363]">Presse-papiers</span>
          </button>
        </li>
        <li v-if="canNativeShare">
          <button
            type="button"
            class="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-bold text-[#111111] transition hover:bg-[#FFFCF4]"
            @click="onNative"
          >
            <span>Autres applications</span>
            <span class="text-xs font-semibold text-[#636363]">Partage système</span>
          </button>
        </li>
      </ul>

      <p class="mt-3 text-xs leading-relaxed text-[#636363]">
        Instagram ne permet pas d’ouvrir un partage de lien depuis le navigateur :
        le lien est copié pour que vous puissiez le coller dans l’appli.
      </p>

      <p v-if="feedback" class="mt-3 text-sm font-semibold text-[#4D257D]" role="status">
        {{ feedback }}
      </p>
    </UiModal>
  </div>
</template>
