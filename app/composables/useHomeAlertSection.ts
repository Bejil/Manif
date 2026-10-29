const STORAGE_KEY = 'manif:alert-section-hidden-v1'

/**
 * Masque le bloc #alertes sur l’accueil une fois l’alerte engagée
 * (inscription envoyée ou confirmée). Réaffiche après désinscription.
 */
export function useHomeAlertSection() {
  const hidden = useState('home-alert-section-hidden', () => {
    if (import.meta.client) return localStorage.getItem(STORAGE_KEY) === '1'
    return false
  })
  const toast = useState<{ text: string, tone: 'ok' | 'err' } | null>(
    'home-alert-toast',
    () => null,
  )
  let toastTimer: ReturnType<typeof setTimeout> | null = null

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

  function showToast(text: string, tone: 'ok' | 'err' = 'ok', ms = 5500) {
    toast.value = { text, tone }
    if (toastTimer) clearTimeout(toastTimer)
    toastTimer = setTimeout(() => {
      toast.value = null
      toastTimer = null
    }, ms)
  }

  function dismissToast() {
    toast.value = null
    if (toastTimer) {
      clearTimeout(toastTimer)
      toastTimer = null
    }
  }

  return {
    hidden,
    toast,
    syncFromStorage,
    hideSection,
    showSection,
    showToast,
    dismissToast,
  }
}
