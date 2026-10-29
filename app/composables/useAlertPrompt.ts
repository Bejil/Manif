const STORAGE_KEY = 'manif:alert-prompt-v1'

/** Nombre de soutiens / participations entre deux affichages de la modal. */
const ENGAGEMENTS_BETWEEN_PROMPTS = 5

type PromptStore = {
  /** Total d’engagements réussis (soutien ou participation) sur ce navigateur. */
  engagementCount: number
  /** Prochain engagementCount auquel on peut réafficher (1 = dès le premier). */
  nextPromptAt: number
}

function defaultStore(): PromptStore {
  return { engagementCount: 0, nextPromptAt: 1 }
}

function readStore(): PromptStore {
  if (!import.meta.client) return defaultStore()
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (!raw) return defaultStore()
    // Legacy : dismiss définitif ou cooldown temps → repartir sur le prochain engagement
    if (raw === '1') {
      const migrated = { engagementCount: 0, nextPromptAt: 1 }
      writeStore(migrated)
      return migrated
    }
    const parsed = JSON.parse(raw) as Partial<PromptStore> & { quietUntil?: number }
    if (typeof parsed.quietUntil === 'number' && typeof parsed.engagementCount !== 'number') {
      const migrated = defaultStore()
      writeStore(migrated)
      return migrated
    }
    if (
      typeof parsed.engagementCount === 'number'
      && typeof parsed.nextPromptAt === 'number'
    ) {
      return {
        engagementCount: parsed.engagementCount,
        nextPromptAt: parsed.nextPromptAt,
      }
    }
  }
  catch { /* ignore */ }
  return defaultStore()
}

function writeStore(store: PromptStore) {
  if (!import.meta.client) return
  localStorage.setItem(STORAGE_KEY, JSON.stringify(store))
}

/**
 * Modal d’alerte après soutien / participation.
 * Affichée au 1er engagement, puis tous les 5 engagements suivants (après fermeture ou inscription).
 */
export function useAlertPrompt() {
  const open = useState('alert-prompt-open', () => false)
  const locationHint = useState<string>('alert-prompt-city', () => '')

  function scheduleNext() {
    const store = readStore()
    store.nextPromptAt = store.engagementCount + ENGAGEMENTS_BETWEEN_PROMPTS
    writeStore(store)
  }

  function dismiss() {
    open.value = false
    scheduleNext()
  }

  function markSubscribed() {
    open.value = false
    scheduleNext()
  }

  function maybePrompt(opts?: { cityName?: string | null }) {
    if (!import.meta.client) return
    const store = readStore()
    store.engagementCount += 1
    writeStore(store)

    if (store.engagementCount < store.nextPromptAt) return

    if (opts?.cityName) locationHint.value = opts.cityName.trim()
    open.value = true
  }

  function close() {
    open.value = false
  }

  return {
    open,
    locationHint,
    maybePrompt,
    dismiss,
    markSubscribed,
    close,
  }
}
