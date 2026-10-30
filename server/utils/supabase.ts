import { createClient, type SupabaseClient } from '@supabase/supabase-js'

let cached: SupabaseClient | null = null
let cachedKey: string | null = null

export function useMockDb(): boolean {
  const config = useRuntimeConfig()
  return config.public.useMockDb === true
}

function resolveSupabaseConfig() {
  const config = useRuntimeConfig()
  // Vercel : préférer NUXT_* (override runtime) ; fallback process.env au cas où
  // le build a figé des valeurs vides dans runtimeConfig.
  const url = String(
    config.supabaseUrl
    || process.env.NUXT_SUPABASE_URL
    || process.env.SUPABASE_URL
    || '',
  ).trim()
  const key = String(
    config.supabaseServiceRoleKey
    || process.env.NUXT_SUPABASE_SERVICE_ROLE_KEY
    || process.env.SUPABASE_SERVICE_ROLE_KEY
    || '',
  ).trim()
  return { url, key }
}

/**
 * Refuse les clés anon/publishable : avec RLS sans politique, elles provoquent
 * des listes vides et des INSERT « violates row-level security policy ».
 */
function assertServiceRoleKey(key: string) {
  if (key.startsWith('sb_publishable_')) {
    throw createError({
      statusCode: 503,
      statusMessage:
        'Clé Supabase incorrecte : utilisez SUPABASE_SERVICE_ROLE_KEY (service_role / sb_secret_), pas la clé anon/publishable.',
    })
  }

  // JWT historique : payload.role doit être service_role
  if (key.startsWith('eyJ')) {
    try {
      const payloadPart = key.split('.')[1]
      if (!payloadPart) return
      const json = Buffer.from(payloadPart, 'base64url').toString('utf8')
      const payload = JSON.parse(json) as { role?: string }
      if (payload.role && payload.role !== 'service_role') {
        throw createError({
          statusCode: 503,
          statusMessage:
            `Clé Supabase incorrecte (rôle « ${payload.role} »). Attendu : service_role. Vérifiez NUXT_SUPABASE_SERVICE_ROLE_KEY sur Vercel.`,
        })
      }
    }
    catch (e) {
      if (e && typeof e === 'object' && 'statusCode' in e) throw e
      // JWT mal formé : laisser createClient échouer plus loin
    }
  }
}

/**
 * Client serveur exclusif (bypass RLS).
 * Authorization est figé sur la clé secret/service_role : une session utilisateur
 * (ex. signInWithPassword) ne doit jamais remplacer ce header.
 */
export function getServiceSupabase(): SupabaseClient {
  const { url, key } = resolveSupabaseConfig()
  if (!url || !key) {
    throw createError({
      statusCode: 503,
      statusMessage: 'Supabase non configuré (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY)',
    })
  }
  assertServiceRoleKey(key)

  if (!cached || cachedKey !== key) {
    cached = createClient(url, key, {
      auth: {
        persistSession: false,
        autoRefreshToken: false,
        detectSessionInUrl: false,
      },
      global: {
        headers: {
          Authorization: `Bearer ${key}`,
        },
      },
    })
    cachedKey = key
  }
  return cached
}

/**
 * Client éphémère pour Auth (login admin) — ne partage JAMAIS le cache service,
 * sinon la session utilisateur pollue les écritures et déclenche le RLS.
 */
export function createAuthSupabase(): SupabaseClient {
  const { url, key } = resolveSupabaseConfig()
  if (!url || !key) {
    throw createError({
      statusCode: 503,
      statusMessage: 'Supabase non configuré (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY)',
    })
  }
  return createClient(url, key, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
      detectSessionInUrl: false,
    },
  })
}
