import type { EngagementState } from '#shared/types/engagement'

/**
 * Jeton pseudonyme scoped à un événement, stocké localement.
 * Pas d'identifiant global transversal entre manifestations.
 */
export function useParticipationToken(eventId: string) {
  const storageKey = `manif:engagement:${eventId}`
  /** Clé legacy pour migration douce des jetons déjà émis */
  const legacyKey = `manif:participation:${eventId}`

  function getOrCreateToken(): string {
    if (!import.meta.client) return ''
    const existing = localStorage.getItem(storageKey) || localStorage.getItem(legacyKey)
    if (existing && existing.length >= 16) {
      if (!localStorage.getItem(storageKey)) localStorage.setItem(storageKey, existing)
      return existing
    }
    const bytes = new Uint8Array(24)
    crypto.getRandomValues(bytes)
    const token = Array.from(bytes, b => b.toString(16).padStart(2, '0')).join('')
    localStorage.setItem(storageKey, token)
    return token
  }

  function getLocalState(): EngagementState {
    const empty: EngagementState = {
      supported: false,
      participating: false,
      participationKind: null,
    }
    if (!import.meta.client) return empty
    try {
      const raw = localStorage.getItem(`${storageKey}:state`)
        || localStorage.getItem(`${legacyKey}:state`)
      if (!raw) return empty
      const parsed = JSON.parse(raw) as Record<string, unknown>
      // Migration depuis intended/attended
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
      return empty
    }
  }

  function setLocalState(state: EngagementState) {
    if (!import.meta.client) return
    localStorage.setItem(`${storageKey}:state`, JSON.stringify(state))
  }

  return { getOrCreateToken, getLocalState, setLocalState }
}
