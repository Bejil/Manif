import { getRequestIP, readMultipartFormData } from 'h3'
import { getAdminSession } from '../../utils/admin-auth'
import { uploadEventImage } from '../../services/media-upload'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'
import { verifyTurnstile } from '../../utils/turnstile'

/**
 * Upload d’image événement → Storage Supabase (bucket event-media).
 * Admin authentifié, ou public avec Turnstile.
 * Les vidéos passent uniquement par URL (limites serverless).
 */
export default defineEventHandler(async (event) => {
  const admin = getAdminSession(event)
  const form = await readMultipartFormData(event)
  if (!form?.length) throw badRequest('Fichier manquant')

  const filePart = form.find(p => p.name === 'file' && p.data && p.filename)
  const turnstilePart = form.find(p => p.name === 'turnstileToken')
  if (!filePart?.data) throw badRequest('Fichier manquant')

  if (!admin) {
    const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
    const rl = await checkRateLimit({ key: `media-upload:${ip}`, limit: 10, windowMs: 60 * 60_000 })
    if (!rl.ok) throw tooManyRequests('Trop d’uploads. Réessayez plus tard.')

    const token = turnstilePart?.data ? Buffer.from(turnstilePart.data).toString('utf8') : ''
    const ok = await verifyTurnstile(event, token || undefined, 'media-upload')
    if (!ok) throw badRequest('Vérification antibot requise pour l’upload')
  }

  const uploaded = await uploadEventImage({
    data: filePart.data,
    type: filePart.type || 'application/octet-stream',
    filename: filePart.filename,
  })

  return { url: uploaded.url, mocked: uploaded.mocked }
})
