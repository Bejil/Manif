<script setup lang="ts">
import { resolveKofiConfig } from '#shared/utils/kofi'

declare global {
  interface Window {
    kofiWidgetOverlay?: {
      draw: (username: string, options: Record<string, string>) => void
    }
  }
}

const SCRIPT_ID = 'kofi-overlay-widget-script'
const SCRIPT_SRC = 'https://storage.ko-fi.com/cdn/scripts/overlay-widget.js'

const config = useRuntimeConfig()

const kofi = computed(() => resolveKofiConfig({
  username: String(config.public.kofiUsername || ''),
  url: String(config.public.kofiUrl || ''),
}))

function removeWidgetDom() {
  if (!import.meta.client) return
  document.querySelectorAll(
    '.floatingchat-container-wrap, .floatingchat-container-wrap-mobi, .floating-chat-kofi-popup-iframe, .floating-chat-kofi-popup-iframe-mobi',
  ).forEach(el => el.remove())
}

const KOFI_WIGGLE_STYLE_ID = 'manif-kofi-wiggle'
const KOFI_WIGGLE_CSS = `
@keyframes kofi-wiggle{
  0%{transform:rotate(0) scale(1)}
  60%{transform:rotate(0) scale(1)}
  75%{transform:rotate(0) scale(1.12)}
  80%{transform:rotate(0) scale(1.1)}
  84%{transform:rotate(-10deg) scale(1.1)}
  88%{transform:rotate(10deg) scale(1.1)}
  92%{transform:rotate(-10deg) scale(1.1)}
  96%{transform:rotate(10deg) scale(1.1)}
  100%{transform:rotate(0) scale(1)}
}
.kofiimg{animation:kofi-wiggle 3s infinite;}
`

/**
 * Ko-fi coupe le bouton : wrap max-width 180px + iframe ~195px trop étroit
 * pour un libellé long (« Supporter Manif' »).
 * L’overlay n’anime pas la tasse (contrairement à Widget_2) : on injecte
 * le même wiggle dans le document de l’iframe (about:blank same-origin).
 */
function fixFloatingButtonLayout() {
  const widthPx = 280
  document.querySelectorAll(
    '.floatingchat-container-wrap, .floatingchat-container-wrap-mobi',
  ).forEach((el) => {
    const wrap = el as HTMLElement
    wrap.style.setProperty('width', `${widthPx}px`, 'important')
    wrap.style.setProperty('max-width', 'none', 'important')
    wrap.style.setProperty('overflow', 'visible', 'important')
    const iframe = wrap.querySelector('iframe') as HTMLIFrameElement | null
    if (!iframe) return
    iframe.style.setProperty('width', `${widthPx}px`, 'important')
    iframe.style.setProperty('min-width', `${widthPx}px`, 'important')

    try {
      const doc = iframe.contentDocument
      if (!doc?.head || doc.getElementById(KOFI_WIGGLE_STYLE_ID)) return
      const style = doc.createElement('style')
      style.id = KOFI_WIGGLE_STYLE_ID
      style.textContent = KOFI_WIGGLE_CSS
      doc.head.appendChild(style)
    }
    catch {
      // iframe cross-origin : pas d’injection possible
    }
  })
}

function drawWidget(username: string) {
  window.kofiWidgetOverlay?.draw(username, {
    type: 'floating-chat',
    'floating-chat.donateButton.text': "Supporter Manif'",
    'floating-chat.donateButton.background-color': '#794bc4',
    'floating-chat.donateButton.text-color': '#fff',
  })
  requestAnimationFrame(() => {
    fixFloatingButtonLayout()
    window.setTimeout(fixFloatingButtonLayout, 100)
    window.setTimeout(fixFloatingButtonLayout, 500)
  })
}

onMounted(() => {
  if (!import.meta.client || !kofi.value) return

  const username = kofi.value.username
  const existing = document.getElementById(SCRIPT_ID) as HTMLScriptElement | null

  if (existing && window.kofiWidgetOverlay) {
    drawWidget(username)
    return
  }

  if (existing) {
    existing.addEventListener('load', () => drawWidget(username), { once: true })
    return
  }

  const script = document.createElement('script')
  script.id = SCRIPT_ID
  script.src = SCRIPT_SRC
  script.async = true
  script.onload = () => drawWidget(username)
  document.body.appendChild(script)
})

onBeforeUnmount(() => {
  removeWidgetDom()
})
</script>

<template>
  <!-- Widget injecté par le script officiel Ko-fi (overlay-widget.js) -->
</template>
