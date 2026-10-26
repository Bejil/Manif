import { createHmac, timingSafeEqual } from 'node:crypto'
import type { H3Event } from 'h3'
import { getCookie, setCookie, deleteCookie } from 'h3'
import { unauthorized } from './errors'
import { getServiceSupabase, useMockDb } from './supabase'

const COOKIE_NAME = 'manif_admin_session'
const SUPABASE_ACCESS = 'manif_admin_access'
const SUPABASE_REFRESH = 'manif_admin_refresh'

interface AdminSession {
  email: string
  exp: number
  mode: 'hmac' | 'supabase'
}

function sign(payload: string, secret: string): string {
  return createHmac('sha256', secret).update(payload).digest('base64url')
}

function setSessionCookies(
  event: H3Event,
  email: string,
  tokens?: { access: string, refresh: string },
) {
  const config = useRuntimeConfig(event)
  const exp = Date.now() + 12 * 60 * 60 * 1000
  const mode = tokens ? 'supabase' : 'hmac'
  const payload = Buffer.from(
    JSON.stringify({ email, exp, mode } satisfies AdminSession),
  ).toString('base64url')
  const sig = sign(payload, config.adminSessionSecret)
  const cookieOpts = {
    httpOnly: true,
    secure: !import.meta.dev,
    sameSite: 'lax' as const,
    path: '/',
    maxAge: 12 * 60 * 60,
  }
  setCookie(event, COOKIE_NAME, `${payload}.${sig}`, cookieOpts)
  if (tokens) {
    setCookie(event, SUPABASE_ACCESS, tokens.access, cookieOpts)
    setCookie(event, SUPABASE_REFRESH, tokens.refresh, cookieOpts)
  }
}

export function clearAdminSession(event: H3Event) {
  deleteCookie(event, COOKIE_NAME, { path: '/' })
  deleteCookie(event, SUPABASE_ACCESS, { path: '/' })
  deleteCookie(event, SUPABASE_REFRESH, { path: '/' })
}

export function getAdminSession(event: H3Event): AdminSession | null {
  const config = useRuntimeConfig(event)
  const raw = getCookie(event, COOKIE_NAME)
  if (!raw) return null
  const [payload, sig] = raw.split('.')
  if (!payload || !sig) return null
  const expected = sign(payload, config.adminSessionSecret)
  try {
    const a = Buffer.from(sig)
    const b = Buffer.from(expected)
    if (a.length !== b.length || !timingSafeEqual(a, b)) return null
  }
  catch {
    return null
  }
  try {
    const session = JSON.parse(
      Buffer.from(payload, 'base64url').toString('utf8'),
    ) as AdminSession
    if (session.exp < Date.now()) return null
    return session
  }
  catch {
    return null
  }
}

export function requireAdmin(event: H3Event): AdminSession {
  const session = getAdminSession(event)
  if (!session) throw unauthorized('Authentification administrateur requise')
  return session
}

/**
 * Auth admin :
 * 1) Supabase Auth si configuré (USE_MOCK_DB=false)
 * 2) Fallback credentials runtimeConfig / .env (HMAC) — données restent en base
 */
export async function loginAdmin(
  event: H3Event,
  email: string,
  password: string,
): Promise<{ ok: true }> {
  const config = useRuntimeConfig(event)
  const canUseSupabase = Boolean(config.supabaseUrl && config.supabaseServiceRoleKey)
    && !useMockDb()

  if (canUseSupabase) {
    try {
      const supabase = getServiceSupabase()
      const { data, error } = await supabase.auth.signInWithPassword({ email, password })
      if (!error && data.session) {
        const allowed = String(config.adminEmail || '').toLowerCase()
        const allowAny = process.env.ADMIN_ALLOW_ANY === 'true'
        if (!allowAny && allowed && email.toLowerCase() !== allowed) {
          await supabase.auth.admin.signOut(data.session.access_token)
          throw unauthorized('Compte non autorisé pour l\'administration')
        }
        setSessionCookies(event, email, {
          access: data.session.access_token,
          refresh: data.session.refresh_token,
        })
        return { ok: true }
      }
      if (import.meta.dev) {
        console.warn('[admin-login] supabase auth failed, fallback HMAC:', error?.message)
      }
    }
    catch (e) {
      if (e && typeof e === 'object' && 'statusCode' in e && (e as { statusCode: number }).statusCode === 401) {
        throw e
      }
      if (import.meta.dev) {
        console.warn('[admin-login] supabase auth exception, fallback HMAC:', e)
      }
    }
  }

  if (!verifyAdminCredentials(email, password)) {
    throw unauthorized('E-mail ou mot de passe incorrect')
  }
  setSessionCookies(event, email)
  return { ok: true }
}

export function verifyAdminCredentials(email: string, password: string): boolean {
  const config = useRuntimeConfig()
  // Préférer runtimeConfig (.env Nuxt) à process.env shell qui peut polluer
  const expectedEmail = String(config.adminEmail || 'contact@manif.info')
    .toLowerCase()
    .trim()
  const expectedPassword = String(config.adminPassword || '')
  const normalizedEmail = email.toLowerCase().trim()

  if (expectedPassword) {
    return normalizedEmail === expectedEmail && password === expectedPassword
  }

  // Dev : mot de passe local si ADMIN_PASSWORD non défini
  if (import.meta.dev || process.env.NODE_ENV !== 'production') {
    return normalizedEmail === expectedEmail && password === 'dev-admin-change-me'
  }
  return false
}
