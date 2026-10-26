export type SharePayload = {
  title: string
  text: string
  url: string
}

export type SocialNetwork = 'facebook' | 'twitter' | 'telegram' | 'instagram'

function encode(value: string) {
  return encodeURIComponent(value)
}

/** URLs d’intent web (Instagram n’en propose pas pour un lien arbitraire). */
export function socialShareUrl(network: Exclude<SocialNetwork, 'instagram'>, payload: SharePayload) {
  const { url, text, title } = payload
  const line = text || title
  switch (network) {
    case 'facebook':
      return `https://www.facebook.com/sharer/sharer.php?u=${encode(url)}`
    case 'twitter':
      return `https://twitter.com/intent/tweet?url=${encode(url)}&text=${encode(line)}`
    case 'telegram':
      return `https://t.me/share/url?url=${encode(url)}&text=${encode(line)}`
  }
}

export function useShare() {
  async function share(input: SharePayload) {
    if (import.meta.client && typeof navigator !== 'undefined' && navigator.share) {
      try {
        await navigator.share(input)
        return { method: 'native' as const }
      }
      catch (e) {
        if ((e as Error).name === 'AbortError') return { method: 'cancelled' as const }
      }
    }
    return copyLink(input.url)
  }

  async function copyLink(url: string) {
    if (import.meta.client && navigator.clipboard) {
      try {
        await navigator.clipboard.writeText(url)
        return { method: 'clipboard' as const }
      }
      catch {
        /* fall through */
      }
    }
    return { method: 'failed' as const }
  }

  function openSocial(network: Exclude<SocialNetwork, 'instagram'>, payload: SharePayload) {
    if (!import.meta.client) return { method: 'failed' as const }
    const href = socialShareUrl(network, payload)
    window.open(href, '_blank', 'noopener,noreferrer,width=600,height=640')
    return { method: 'social' as const, network }
  }

  /** Instagram : pas d’intent web — on copie le lien pour collage manuel. */
  async function shareInstagram(payload: SharePayload) {
    const copied = await copyLink(payload.url)
    return {
      method: copied.method === 'clipboard' ? 'instagram' as const : 'failed' as const,
    }
  }

  function supportsNativeShare() {
    return import.meta.client && typeof navigator !== 'undefined' && typeof navigator.share === 'function'
  }

  return { share, copyLink, openSocial, shareInstagram, supportsNativeShare, socialShareUrl }
}
