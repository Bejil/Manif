import { createClient, type SupabaseClient } from '@supabase/supabase-js'

let cached: SupabaseClient | null = null

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

export function getServiceSupabase(): SupabaseClient {
  const { url, key } = resolveSupabaseConfig()
  if (!url || !key) {
    throw createError({
      statusCode: 503,
      statusMessage: 'Supabase non configuré (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY)',
    })
  }
  // Clé publishable/anon → RLS sans politique SELECT → listes vides sans erreur 500
  if (key.startsWith('sb_publishable_')) {
    console.warn('[supabase] sb_publishable_ détectée — utiliser sb_secret_ / service_role')
  }
  if (!cached) {
    cached = createClient(url, key, {
      auth: { persistSession: false, autoRefreshToken: false },
    })
  }
  return cached
}

export function getAuthSupabase(): SupabaseClient {
  // Même client service pour vérifier les sessions admin côté serveur
  return getServiceSupabase()
}
