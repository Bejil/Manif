import type { EngagementState } from '#shared/types/engagement'

export interface MyEngagementEntry extends EngagementState {
  eventId: string
}

const INDEX_KEY = 'manif:engagement-index'
const CHANGE_EVENT = 'manif:engagements-changed'

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

/** État partagé (évite N listeners si beaucoup de cartes). */
const sharedEntries = shallowRef<MyEngagementEntry[]>([])
let subscriberCount = 0

function parseState(raw: string | null): EngagementState | null {
  if (!raw) return null
  try {
    const parsed = JSON.parse(raw) as Record<string, unknown>
    if ('intended' in parsed || 'attended' in parsed) {
      return {
        supported: false,
        participating: Boolean(parsed.intended || parsed.attended),
        participationKind: parsed.intended ? 'planned' : parsed.attended ? 'during' : null,
      }
    }
    return {
      supported: Boolean(parsed.supported),
      participating: Boolean(parsed.participating),
      participationKind: (parsed.participationKind as EngagementState['participationKind']) ?? null,
    }
  }
  catch {
    return null
  }
}

function readIndex(): string[] {
  if (!import.meta.client) return []
  try {
    const raw = localStorage.getItem(INDEX_KEY)
    if (!raw) return []
    const parsed = JSON.parse(raw) as unknown
    if (!Array.isArray(parsed)) return []
    return parsed.filter((id): id is string => typeof id === 'string' && UUID_RE.test(id))
  }
  catch {
    return []
  }
}

function writeIndex(ids: string[]) {
  if (!import.meta.client) return
  localStorage.setItem(INDEX_KEY, JSON.stringify([...new Set(ids)]))
}

/** Scanne le localStorage (migration) + index. */
export function scanMyEngagements(): MyEngagementEntry[] {
  if (!import.meta.client) return []
  const byId = new Map<string, MyEngagementEntry>()

  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i)
    if (!key) continue
    const match = key.match(/^manif:(?:engagement|participation):([0-9a-f-]{36}):state$/i)
    if (!match?.[1]) continue
    const eventId = match[1]
    const state = parseState(localStorage.getItem(key))
    if (!state || (!state.supported && !state.participating)) continue
    byId.set(eventId, { eventId, ...state })
  }

  for (const id of readIndex()) {
    if (byId.has(id)) continue
    const state = parseState(localStorage.getItem(`manif:engagement:${id}:state`))
      || parseState(localStorage.getItem(`manif:participation:${id}:state`))
    if (!state || (!state.supported && !state.participating)) continue
    byId.set(id, { eventId: id, ...state })
  }

  const items = [...byId.values()]
  writeIndex(items.map(e => e.eventId))
  return items
}

function refreshShared() {
  sharedEntries.value = scanMyEngagements()
}

export function rememberEngagement(eventId: string, state: EngagementState) {
  if (!import.meta.client || !UUID_RE.test(eventId)) return
  const ids = new Set(readIndex())
  if (state.supported || state.participating) ids.add(eventId)
  else ids.delete(eventId)
  writeIndex([...ids])
  refreshShared()
  window.dispatchEvent(new CustomEvent(CHANGE_EVENT))
}

/** État réactif des engagements locaux (soutien / participation). */
export function useMyEngagements() {
  const byId = computed(() => {
    const map = new Map<string, MyEngagementEntry>()
    for (const e of sharedEntries.value) map.set(e.eventId, e)
    return map
  })

  const supportedIds = computed(() =>
    sharedEntries.value.filter(e => e.supported).map(e => e.eventId),
  )
  const participatingIds = computed(() =>
    sharedEntries.value.filter(e => e.participating).map(e => e.eventId),
  )
  const engagedIds = computed(() => sharedEntries.value.map(e => e.eventId))

  function get(eventId: string): MyEngagementEntry | null {
    return byId.value.get(eventId) ?? null
  }

  function isSupported(eventId: string) {
    return Boolean(byId.value.get(eventId)?.supported)
  }

  function isParticipating(eventId: string) {
    return Boolean(byId.value.get(eventId)?.participating)
  }

  function isEngaged(eventId: string) {
    const e = byId.value.get(eventId)
    return Boolean(e && (e.supported || e.participating))
  }

  function refresh() {
    refreshShared()
  }

  onMounted(() => {
    if (subscriberCount === 0) {
      refreshShared()
      window.addEventListener(CHANGE_EVENT, refreshShared)
      window.addEventListener('storage', refreshShared)
    }
    subscriberCount++
  })

  onBeforeUnmount(() => {
    subscriberCount = Math.max(0, subscriberCount - 1)
    if (subscriberCount === 0 && import.meta.client) {
      window.removeEventListener(CHANGE_EVENT, refreshShared)
      window.removeEventListener('storage', refreshShared)
    }
  })

  return {
    entries: sharedEntries,
    byId,
    supportedIds,
    participatingIds,
    engagedIds,
    refresh,
    get,
    isSupported,
    isParticipating,
    isEngaged,
  }
}
