import { unsubscribeAlert } from '../../services/alerts-repository'

export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const token = typeof query.token === 'string' ? query.token.trim() : ''
  const config = useRuntimeConfig()
  const siteUrl = String(config.public.siteUrl || '/').replace(/\/$/, '') || ''

  if (!token) {
    return sendRedirect(event, `${siteUrl}/?alertes=invalid#alertes`, 302)
  }

  const pepper = String(config.participationTokenPepper || '')
  const result = await unsubscribeAlert(token, pepper)

  if (!result.ok) {
    return sendRedirect(event, `${siteUrl}/?alertes=invalid#alertes`, 302)
  }

  return sendRedirect(event, `${siteUrl}/?alertes=unsubscribed#alertes`, 302)
})
