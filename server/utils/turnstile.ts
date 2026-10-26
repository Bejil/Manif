import { getRequestIP } from 'h3'
import type { H3Event } from 'h3'

export type TurnstileAction = 'propose' | 'report' | 'engage'

/**
 * Vérifie Cloudflare Turnstile côté serveur (siteverify canonique).
 * Sans clé secrète : bypass explicite (dev sans antibot).
 * Avec clé : exige success, action attendue, et hostname autorisé.
 */
export async function verifyTurnstile(
  event: H3Event,
  token: string | undefined,
  expectedAction?: TurnstileAction,
): Promise<boolean> {
  const config = useRuntimeConfig(event)
  const secret = (config.turnstileSecretKey as string) || ''

  if (!secret) {
    return true
  }

  if (typeof token !== 'string' || token.length === 0 || token.length > 2048) {
    return false
  }

  const expectedHostnames = new Set(
    String(config.turnstileHostnames || '')
      .split(',')
      .map(h => h.trim().toLowerCase())
      .filter(Boolean),
  )
  if (expectedHostnames.size === 0) {
    console.warn('[turnstile] TURNSTILE_HOSTNAMES vide — refus de la vérification')
    return false
  }

  const ip = getRequestIP(event, { xForwardedFor: true })
  const body = new URLSearchParams({
    secret,
    response: token,
  })
  if (ip) body.set('remoteip', ip)

  try {
    const res = await $fetch<{
      success: boolean
      action?: string
      hostname?: string
      'error-codes'?: string[]
    }>('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body,
      signal: AbortSignal.timeout(10_000),
    })

    // Canonique : success + action + hostname (allowlist de déploiement)
    if (!res.success) return false
    if (expectedAction && res.action !== expectedAction) return false

    const hostname = (res.hostname || '').toLowerCase()
    if (!hostname || !expectedHostnames.has(hostname)) return false

    return true
  }
  catch (e) {
    console.warn('[turnstile] siteverify échec', e)
    return false
  }
}
