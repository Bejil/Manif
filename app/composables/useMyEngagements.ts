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
let reconcileInFlight: Promise<void> | null = null

function normalizeEventId(id: string) {
  return id.trim().toLowerCase()
}

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

function mergeStates(
  a: EngagementState | null,
  b: EngagementState | null,
): EngagementState | null {
  if (!a && !b) return null
  const supported = Boolean(a?.supported || b?.supported)
  const participating = Boolean(a?.participating || b?.participating)
  if (!supported && !participating) return null
  return {
    supported,
    participating,
    participationKind: participating
      ? (a?.participationKind || b?.participationKind || null)
      : null,
  }
}

function isActive(state: EngagementState | null): state is EngagementState {
  return Boolean(state && (state.supported || state.participating))
}

function readIndex(): string[] {
  if (!import.meta.client) return []
  try {
    const raw = localStorage.getItem(INDEX_KEY)
    if (!raw) return []
    const parsed = JSON.parse(raw) as unknown
    if (!Array.isArray(parsed)) return []
    return [...new Set(
      parsed
        .filter((id): id is string => typeof id === 'string' && UUID_RE.test(id))
        .map(normalizeEventId),
    )]
  }
  catch {
    return []
  }
}

function writeIndex(ids: string[]) {
  if (!import.meta.client) return
  localStorage.setItem(
    INDEX_KEY,
    JSON.stringify([...new Set(ids.map(normalizeEventId))]),
  )
}

function stateKey(eventId: string, kind: 'engagement' | 'participation' = 'engagement') {
  return `manif:${kind}:${normalizeEventId(eventId)}:state`
}

function clearLocalEngagementState(eventId: string) {
  if (!import.meta.client || !UUID_RE.test(eventId)) return
  const id = normalizeEventId(eventId)
  localStorage.removeItem(stateKey(id, 'engagement'))
  localStorage.removeItem(stateKey(id, 'participation'))
}

/** Purge totale (événement disparu / dépublié). */
function forgetLocalEngagement(eventId: string) {
  if (!import.meta.client || !UUID_RE.test(eventId)) return
  const id = normalizeEventId(eventId)
  clearLocalEngagementState(id)
  localStorage.removeItem(`manif:engagement:${id}`)
  localStorage.removeItem(`manif:participation:${id}`)
}

/** Scanne le localStorage (migration) + index — 1 entrée par événement. */
export function scanMyEngagements(): MyEngagementEntry[] {
  if (!import.meta.client) return []
  const byId = new Map<string, EngagementState>()

  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i)
    if (!key) continue
    const match = key.match(/^manif:(?:engagement|participation):([0-9a-f-]{36}):state$/i)
    if (!match?.[1] || !UUID_RE.test(match[1])) continue
    const eventId = normalizeEventId(match[1])
    const merged = mergeStates(byId.get(eventId) ?? null, parseState(localStorage.getItem(key)))
    if (merged) byId.set(eventId, merged)
    else byId.delete(eventId)
  }

  for (const rawId of readIndex()) {
    const eventId = normalizeEventId(rawId)
    if (byId.has(eventId)) continue
    const state = mergeStates(
      parseState(localStorage.getItem(stateKey(eventId, 'engagement'))),
      parseState(localStorage.getItem(stateKey(eventId, 'participation'))),
    )
    if (state) byId.set(eventId, state)
  }

  const items: MyEngagementEntry[] = []
  for (const [eventId, state] of byId) {
    if (!isActive(state)) {
      clearLocalEngagementState(eventId)
      continue
    }
    // Canonicalise sur la clé engagement, retire la legacy
    localStorage.setItem(stateKey(eventId, 'engagement'), JSON.stringify(state))
    localStorage.removeItem(stateKey(eventId, 'participation'))
    items.push({ eventId, ...state })
  }

  writeIndex(items.map(e => e.eventId))
  return items
}

function refreshShared() {
  sharedEntries.value = scanMyEngagements()
}

export function rememberEngagement(eventId: string, state: EngagementState) {
  if (!import.meta.client || !UUID_RE.test(eventId)) return
  const id = normalizeEventId(eventId)
  const ids = new Set(readIndex())
  if (state.supported || state.participating) ids.add(id)
  else ids.delete(id)
  writeIndex([...ids])
  refreshShared()
  window.dispatchEvent(new CustomEvent(CHANGE_EVENT))
}

/**
 * Aligne le compteur local sur les événements encore publiés.
 * Retire les engagements orphelins (événements absents / dépubliés).
 */
export async function reconcileMyEngagements() {
  if (!import.meta.client) return
  if (reconcileInFlight) return reconcileInFlight

  reconcileInFlight = (async () => {
    refreshShared()
    const entries = sharedEntries.value
    if (!entries.length) return

    try {
      const res = await $fetch<{ items: Array<{ id: string }> }>('/api/events', {
        query: {
          ids: entries.map(e => e.eventId).join(','),
          statuses: 'upcoming,ongoing,past,cancelled,postponed',
          page: 1,
          pageSize: 100,
        },
      })
      const found = new Set((res.items ?? []).map(e => normalizeEventId(e.id)))
      let pruned = false
      for (const entry of entries) {
        if (found.has(normalizeEventId(entry.eventId))) continue
        forgetLocalEngagement(entry.eventId)
        pruned = true
      }
      if (pruned) refreshShared()
    }
    catch {
      // Garde le scan local si l’API est indisponible
    }
  })().finally(() => {
    reconcileInFlight = null
  })

  return reconcileInFlight
}

/** État réactif des engagements locaux (soutien / participation). */
export function useMyEngagements() {
  const byId = computed(() => {
    const map = new Map<string, MyEngagementEntry>()
    for (const e of sharedEntries.value) map.set(normalizeEventId(e.eventId), e)
    return map
  })

  const supportedIds = computed(() =>
    sharedEntries.value.filter(e => e.supported).map(e => e.eventId),
  )
  const participatingIds = computed(() =>
    sharedEntries.value.filter(e => e.participating).map(e => e.eventId),
  )
  const engagedIds = computed(() =>
    [...new Set(sharedEntries.value.map(e => normalizeEventId(e.eventId)))],
  )

  function get(eventId: string): MyEngagementEntry | null {
    return byId.value.get(normalizeEventId(eventId)) ?? null
  }

  function isSupported(eventId: string) {
    return Boolean(byId.value.get(normalizeEventId(eventId))?.supported)
  }

  function isParticipating(eventId: string) {
    return Boolean(byId.value.get(normalizeEventId(eventId))?.participating)
  }

  function isEngaged(eventId: string) {
    const e = byId.value.get(normalizeEventId(eventId))
    return Boolean(e && (e.supported || e.participating))
  }

  function refresh() {
    refreshShared()
  }

  onMounted(() => {
    if (subscriberCount === 0) {
      refreshShared()
      void reconcileMyEngagements()
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
    reconcile: reconcileMyEngagements,
    get,
    isSupported,
    isParticipating,
    isEngaged,
  }
}
