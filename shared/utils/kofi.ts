/**
 * Valide une URL de contribution Ko-fi (HTTPS, domaine officiel uniquement).
 */
export function isValidKofiUrl(value: unknown): value is string {
  if (typeof value !== 'string' || !value.trim()) return false
  try {
    const url = new URL(value.trim())
    if (url.protocol !== 'https:') return false
    const host = url.hostname.toLowerCase()
    if (host !== 'ko-fi.com' && host !== 'www.ko-fi.com') return false
    if (!url.pathname || url.pathname === '/') return false
    return true
  }
  catch {
    return false
  }
}

export function normalizeKofiUrl(value: string): string | null {
  const trimmed = value.trim()
  if (!isValidKofiUrl(trimmed)) return null
  return trimmed
}

/** Identifiant de page Ko-fi (ex. `manif`). */
export function isValidKofiUsername(value: unknown): value is string {
  if (typeof value !== 'string') return false
  const u = value.trim()
  return /^[a-zA-Z0-9_-]{2,64}$/.test(u)
}

export function extractKofiUsernameFromUrl(url: string): string | null {
  const normalized = normalizeKofiUrl(url)
  if (!normalized) return null
  try {
    const path = new URL(normalized).pathname.replace(/^\/+|\/+$/g, '')
    const first = path.split('/')[0] || ''
    return isValidKofiUsername(first) ? first : null
  }
  catch {
    return null
  }
}

export interface KofiConfig {
  username: string
  pageUrl: string
}

/**
 * Résout username + URL à partir des variables publiques.
 * Priorité : username explicite, sinon extraction depuis l’URL.
 */
export function resolveKofiConfig(input: {
  username?: string | null
  url?: string | null
}): KofiConfig | null {
  const fromUser = (input.username || '').trim()
  if (isValidKofiUsername(fromUser)) {
    return {
      username: fromUser,
      pageUrl: `https://ko-fi.com/${fromUser}`,
    }
  }
  const fromUrl = extractKofiUsernameFromUrl((input.url || '').trim())
  if (fromUrl) {
    return {
      username: fromUrl,
      pageUrl: normalizeKofiUrl((input.url || '').trim()) || `https://ko-fi.com/${fromUrl}`,
    }
  }
  return null
}
