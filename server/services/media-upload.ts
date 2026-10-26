import { randomUUID } from 'node:crypto'
import { getServiceSupabase, useMockDb } from '../utils/supabase'

const ALLOWED = new Set(['image/jpeg', 'image/png', 'image/webp', 'image/gif'])
const EXT: Record<string, string> = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp',
  'image/gif': 'gif',
}
const MAX_BYTES = 2_000_000

export async function uploadEventImage(file: {
  data: Buffer | Uint8Array
  type: string
  filename?: string
}) {
  const type = (file.type || '').toLowerCase()
  if (!ALLOWED.has(type)) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Format non accepté (JPEG, PNG, WebP ou GIF)',
    })
  }
  if (file.data.byteLength > MAX_BYTES) {
    throw createError({ statusCode: 400, statusMessage: 'Image trop volumineuse (max 2 Mo)' })
  }
  if (file.data.byteLength < 24) {
    throw createError({ statusCode: 400, statusMessage: 'Fichier image invalide' })
  }

  const ext = EXT[type] || 'jpg'
  const path = `events/${randomUUID()}.${ext}`

  if (useMockDb()) {
    return {
      url: `https://placehold.co/960x540/png?text=Manif`,
      path,
      mocked: true as const,
    }
  }

  const supabase = getServiceSupabase()
  const { error } = await supabase.storage.from('event-media').upload(path, file.data, {
    contentType: type,
    upsert: false,
  })
  if (error) {
    throw createError({
      statusCode: 502,
      statusMessage: `Upload impossible : ${error.message}. Vérifiez le bucket « event-media » (migration 009).`,
    })
  }

  const { data } = supabase.storage.from('event-media').getPublicUrl(path)
  if (!data?.publicUrl) {
    throw createError({ statusCode: 502, statusMessage: 'URL publique introuvable après upload' })
  }
  return { url: data.publicUrl, path, mocked: false as const }
}
