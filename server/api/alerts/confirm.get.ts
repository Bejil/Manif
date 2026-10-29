import { confirmAlert } from '../../services/alerts-repository'

/**
 * Confirmation double opt-in — redirige vers l’accueil.
 */
export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const token = typeof query.token === 'string' ? query.token.trim() : ''
  const config = useRuntimeConfig()
  const siteUrl = String(config.public.siteUrl || '/').replace(/\/$/, '') || ''

  if (!token) {
    return sendRedirect(event, `${siteUrl}/?alertes=invalid#alertes`, 302)
  }

  const pepper = String(config.participationTokenPepper || '')
  const result = await confirmAlert(token, pepper)

  if (!result.ok) {
    const code = result.reason === 'unsubscribed' ? 'unsubscribed' : 'invalid'
    return sendRedirect(event, `${siteUrl}/?alertes=${code}#alertes`, 302)
  }

  return sendRedirect(event, `${siteUrl}/?alertes=confirmed#alertes`, 302)
})
