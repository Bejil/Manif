/**
 * Ouvre le panneau flottant Ko-fi (overlay sticky) sans naviguer hors du site.
 * Clique le bouton injecté par overlay-widget.js dans l’iframe same-origin.
 */
export function openKofiOverlay(): boolean {
  if (!import.meta.client) return false

  const preferMobi = window.matchMedia('(max-width: 999px)').matches
  const iframeSelectors = preferMobi
    ? ['iframe.floatingchat-container-mobi', 'iframe.floatingchat-container']
    : ['iframe.floatingchat-container', 'iframe.floatingchat-container-mobi']

  for (const sel of iframeSelectors) {
    const iframe = document.querySelector(sel) as HTMLIFrameElement | null
    if (!iframe) continue
    try {
      const btn = iframe.contentDocument?.querySelector(
        '.floatingchat-donate-button',
      ) as HTMLElement | null
      if (!btn) continue
      // Déjà ouvert : ne pas basculer (éviter de fermer)
      if (btn.classList.contains('closed')) {
        btn.click()
      }
      return true
    }
    catch {
      // iframe pas encore prêt / cross-origin
    }
  }
  return false
}

/** Réessaie quelques fois si le widget sticky n’est pas encore monté. */
export function openKofiOverlayWhenReady(attempts = 12, delayMs = 120): void {
  if (!import.meta.client) return
  let left = attempts
  const tryOpen = () => {
    if (openKofiOverlay()) return
    if (--left <= 0) return
    window.setTimeout(tryOpen, delayMs)
  }
  tryOpen()
}

export function useKofiOverlay() {
  return {
    openKofiOverlay,
    openKofiOverlayWhenReady,
  }
}
