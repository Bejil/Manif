const STORAGE_KEY = 'manif:alert-section-hidden-v1'

export type HomeAlertToast = {
  title: string
  description: string
  tone: 'ok' | 'err'
}

/**
 * Masque le bloc #alertes après confirmation e-mail (pas dès l’inscription).
 * Toast temporaire (titre + icône + description).
 */
export function useHomeAlertSection() {
  const hidden = useState('home-alert-section-hidden', () => {
    if (import.meta.client) return localStorage.getItem(STORAGE_KEY) === '1'
    return false
  })
  const toast = useState<HomeAlertToast | null>('home-alert-toast', () => null)
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

  function showToast(
    input: { title: string, description: string, tone?: 'ok' | 'err' },
    ms = 6500,
  ) {
    toast.value = {
      title: input.title,
      description: input.description,
      tone: input.tone || 'ok',
    }
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
