<script setup lang="ts">
const props = withDefaults(defineProps<{
  modelValue?: string
  /** Action Turnstile (1–32 chars) — validée côté serveur */
  action?: string
}>(), {
  action: undefined,
})

const emit = defineEmits<{ 'update:modelValue': [value: string] }>()

const config = useRuntimeConfig()
const siteKey = computed(() => (config.public.turnstileSiteKey as string) || '')
const container = ref<HTMLElement | null>(null)
const widgetId = ref<string | null>(null)
const loadError = ref<string | null>(null)
const bypass = computed(() => !siteKey.value)

function reset() {
  emit('update:modelValue', '')
  // @ts-expect-error turnstile global
  if (widgetId.value != null && window.turnstile?.reset) {
    // @ts-expect-error turnstile global
    window.turnstile.reset(widgetId.value)
  }
}

defineExpose({ reset })

function renderWidget() {
  // @ts-expect-error turnstile global
  if (!window.turnstile || !container.value) return
  if (widgetId.value != null) return

  // @ts-expect-error turnstile global
  widgetId.value = window.turnstile.render(container.value, {
    sitekey: siteKey.value,
    ...(props.action ? { action: props.action } : {}),
    callback: (token: string) => emit('update:modelValue', token),
    'expired-callback': () => emit('update:modelValue', ''),
    'error-callback': () => {
      emit('update:modelValue', '')
      loadError.value = 'Vérification antibot indisponible. Réessayez.'
    },
    theme: 'light',
  })
}

function loadScript() {
  return new Promise<void>((resolve, reject) => {
    // @ts-expect-error turnstile global
    if (window.turnstile) {
      resolve()
      return
    }
    const existing = document.querySelector('script[data-turnstile]') as HTMLScriptElement | null
    if (existing) {
      // Script déjà présent : load peut déjà être passé — poller turnstile
      // @ts-expect-error turnstile global
      if (window.turnstile) {
        resolve()
        return
      }
      const onLoad = () => {
        cleanup()
        resolve()
      }
      const onError = () => {
        cleanup()
        reject(new Error('Turnstile indisponible'))
      }
      const cleanup = () => {
        existing.removeEventListener('load', onLoad)
        existing.removeEventListener('error', onError)
        clearInterval(poll)
      }
      existing.addEventListener('load', onLoad)
      existing.addEventListener('error', onError)
      const poll = setInterval(() => {
        // @ts-expect-error turnstile global
        if (window.turnstile) {
          cleanup()
          resolve()
        }
      }, 50)
      setTimeout(() => {
        // @ts-expect-error turnstile global
        if (!window.turnstile) {
          cleanup()
          reject(new Error('Turnstile indisponible'))
        }
      }, 10_000)
      return
    }
    const s = document.createElement('script')
    s.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'
    s.async = true
    s.defer = true
    s.dataset.turnstile = '1'
    s.onload = () => resolve()
    s.onerror = () => reject(new Error('Turnstile indisponible'))
    document.head.appendChild(s)
  })
}

onMounted(async () => {
  if (bypass.value) {
    emit('update:modelValue', 'dev-bypass')
    return
  }
  try {
    // Après onload de api.js?render=explicit, turnstile.render est prêt.
    // Ne pas appeler turnstile.ready() si le script a async/defer (erreur Cloudflare).
    await loadScript()
    renderWidget()
  }
  catch {
    loadError.value = 'Impossible de charger Cloudflare Turnstile.'
  }
})

onBeforeUnmount(() => {
  // @ts-expect-error turnstile global
  if (widgetId.value != null && window.turnstile?.remove) {
    // @ts-expect-error turnstile global
    window.turnstile.remove(widgetId.value)
  }
  widgetId.value = null
})
</script>

<template>
  <div>
    <div
      v-if="bypass"
      class="rounded-[4px] border border-dashed border-[#DDDAD3] bg-[#F4F1EA] px-3 py-2 text-xs text-[#636363]"
    >
      Antibot désactivé (pas de clé Turnstile) — mode développement.
    </div>
    <template v-else>
      <div ref="container" />
      <p v-if="loadError" class="mt-2 text-xs text-[#AD291F]">{{ loadError }}</p>
    </template>
  </div>
</template>
