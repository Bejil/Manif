/** Limites médias événement (liens + uploads). */
export const MAX_EVENT_IMAGES = 8
export const MAX_EVENT_VIDEOS = 4
export const MAX_MEDIA_URL_LENGTH = 500

const HTTPS_URL = /^https:\/\/.+/i

export function isHttpsMediaUrl(raw: string): boolean {
  const url = raw.trim()
  if (!url || url.length > MAX_MEDIA_URL_LENGTH) return false
  if (!HTTPS_URL.test(url)) return false
  try {
    const u = new URL(url)
    return u.protocol === 'https:' && Boolean(u.hostname)
  }
  catch {
    return false
  }
}

export function normalizeMediaUrls(input: unknown, max: number): string[] {
  if (!Array.isArray(input)) return []
  const out: string[] = []
  const seen = new Set<string>()
  for (const item of input) {
    if (typeof item !== 'string') continue
    const url = item.trim()
    if (!isHttpsMediaUrl(url) || seen.has(url)) continue
    seen.add(url)
    out.push(url)
    if (out.length >= max) break
  }
  return out
}

export type VideoEmbed =
  | { kind: 'youtube', embedUrl: string, watchUrl: string }
  | { kind: 'vimeo', embedUrl: string, watchUrl: string }
  | { kind: 'file', src: string }

/** Détecte YouTube / Vimeo / fichier vidéo pour l’affichage. */
export function resolveVideoEmbed(url: string): VideoEmbed {
  const trimmed = url.trim()
  try {
    const u = new URL(trimmed)
    const host = u.hostname.replace(/^www\./, '').toLowerCase()

    if (host === 'youtu.be') {
      const id = u.pathname.split('/').filter(Boolean)[0]
      if (id) {
        return {
          kind: 'youtube',
          embedUrl: `https://www.youtube-nocookie.com/embed/${encodeURIComponent(id)}`,
          watchUrl: trimmed,
        }
      }
    }
    if (host === 'youtube.com' || host === 'm.youtube.com' || host === 'music.youtube.com') {
      const id = u.searchParams.get('v')
        || (u.pathname.startsWith('/embed/') ? u.pathname.slice('/embed/'.length).split('/')[0] : null)
        || (u.pathname.startsWith('/shorts/') ? u.pathname.slice('/shorts/'.length).split('/')[0] : null)
      if (id) {
        return {
          kind: 'youtube',
          embedUrl: `https://www.youtube-nocookie.com/embed/${encodeURIComponent(id)}`,
          watchUrl: trimmed,
        }
      }
    }
    if (host === 'vimeo.com' || host === 'player.vimeo.com') {
      const parts = u.pathname.split('/').filter(Boolean)
      const id = host === 'player.vimeo.com' && parts[0] === 'video' ? parts[1] : parts[0]
      if (id && /^\d+$/.test(id)) {
        return {
          kind: 'vimeo',
          embedUrl: `https://player.vimeo.com/video/${id}`,
          watchUrl: trimmed,
        }
      }
    }
  }
  catch {
    /* fall through */
  }
  return { kind: 'file', src: trimmed }
}
