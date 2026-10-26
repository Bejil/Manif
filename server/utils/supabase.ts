import { createClient, type SupabaseClient } from '@supabase/supabase-js'

let cached: SupabaseClient | null = null

export function useMockDb(): boolean {
  const config = useRuntimeConfig()
  return config.public.useMockDb === true
}

export function getServiceSupabase(): SupabaseClient {
  const config = useRuntimeConfig()
  if (!config.supabaseUrl || !config.supabaseServiceRoleKey) {
    throw createError({
      statusCode: 503,
      statusMessage: 'Supabase non configuré (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY)',
    })
  }
  if (!cached) {
    cached = createClient(config.supabaseUrl, config.supabaseServiceRoleKey, {
      auth: { persistSession: false, autoRefreshToken: false },
    })
  }
  return cached
}

export function getAuthSupabase(): SupabaseClient {
  // Même client service pour vérifier les sessions admin côté serveur
  return getServiceSupabase()
}
