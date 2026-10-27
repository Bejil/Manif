import type { H3Event } from 'h3'

/**
 * URL publique à mettre dans les e-mails (liens de confirmation, admin, etc.).
 * En développement : origine de la requête (ex. http://localhost:3000),
 * pour que la vérif et les notifs admin restent sur le même serveur local
 * même si NUXT_PUBLIC_SITE_URL pointe vers la prod.
 */
export function resolvePublicSiteUrl(event: H3Event): string {
  const config = useRuntimeConfig(event)
  const configured = String(config.public.siteUrl || '').replace(/\/$/, '')

  try {
    const origin = getRequestURL(event).origin.replace(/\/$/, '')
    if (import.meta.dev && origin) return origin
    return configured || origin
  }
  catch {
    return configured || 'http://localhost:3000'
  }
}
