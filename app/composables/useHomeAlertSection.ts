const STORAGE_KEY = 'manif:alert-section-hidden-v1'

/**
 * Masque le bloc #alertes après confirmation e-mail (pas dès l’inscription).
 * Bandeau temporaire en haut de page.
 */
export function useHomeAlertSection() {
  const hidden = useState('home-alert-section-hidden', () => {
    if (import.meta.client) return localStorage.getItem(STORAGE_KEY) === '1'
    return false
  })
  const banner = useState<{ text: string, tone: 'ok' | 'err' } | null>(
    'home-alert-banner',
    () => null,
  )
  let bannerTimer: ReturnType<typeof setTimeout> | null = null

  function syncFromStorage() {
    if (!import.meta.client) return
    hidden.value = localStorage.getItem(STORAGE_KEY) === '1'
  }

  function hideSection() {
    hidden.value = true
    if (import.meta.client) localStorage.setItem(STORAGE_KEY, '1')
  }

  function showSection() {
    hidden.value = false
    if (import.meta.client) localStorage.removeItem(STORAGE_KEY)
  }

  function showBanner(text: string, tone: 'ok' | 'err' = 'ok', ms = 6000) {
    banner.value = { text, tone }
    if (bannerTimer) clearTimeout(bannerTimer)
    bannerTimer = setTimeout(() => {
      banner.value = null
      bannerTimer = null
    }, ms)
  }

  function dismissBanner() {
    banner.value = null
    if (bannerTimer) {
      clearTimeout(bannerTimer)
      bannerTimer = null
    }
  }

  return {
    hidden,
    banner,
    syncFromStorage,
    hideSection,
    showSection,
    showBanner,
    dismissBanner,
  }
}
