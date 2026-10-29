import { getRequestIP } from 'h3'
import { alertSubscribeSchema } from '#shared/schemas/alerts'
import { upsertAlertSubscription } from '../../services/alerts-repository'
import {
  buildAlertConfirmEmail,
  buildAlertUpdatedEmail,
  sendEmail,
} from '../../services/email'
import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'
import { verifyTurnstile } from '../../utils/turnstile'

export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const parsed = alertSubscribeSchema.safeParse(body)
  if (!parsed.success) {
    throw badRequest('Données invalides', parsed.error.flatten())
  }

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `alert:${ip}`, limit: 8, windowMs: 60 * 60_000 })
  if (!rl.ok) throw tooManyRequests('Trop d’inscriptions. Réessayez plus tard.')

  const emailRl = await checkRateLimit({
    key: `alert-email:${parsed.data.email.toLowerCase()}`,
    limit: 5,
    windowMs: 60 * 60_000,
  })
  if (!emailRl.ok) throw tooManyRequests('Trop d’envois pour cette adresse.')

  const turnstileOk = await verifyTurnstile(event, parsed.data.turnstileToken, 'alert')
  if (!turnstileOk) throw badRequest('Vérification antibot échouée')

  const config = useRuntimeConfig()
  const pepper = String(config.participationTokenPepper || '')
  if (!pepper) throw createError({ statusCode: 500, statusMessage: 'Configuration incomplète' })

  const result = await upsertAlertSubscription({
    email: parsed.data.email,
    locationLabel: parsed.data.locationLabel,
    latitude: parsed.data.latitude,
    longitude: parsed.data.longitude,
    radiusKm: parsed.data.radiusKm,
    pepper,
  })

  const siteUrl = String(config.public.siteUrl || '')

  if (result.needsConfirmation && result.confirmToken) {
    const email = buildAlertConfirmEmail({
      siteUrl,
      token: result.confirmToken,
      locationLabel: result.alert.locationLabel,
      radiusKm: result.alert.radiusKm,
    })
    const sent = await sendEmail({
      to: result.alert.email,
      subject: email.subject,
      html: email.html,
      text: email.text,
    })
    return {
      ok: true,
      status: 'pending',
      needsConfirmation: true,
      mocked: sent.mocked,
    }
  }

  const email = buildAlertUpdatedEmail({
    siteUrl,
    locationLabel: result.alert.locationLabel,
    radiusKm: result.alert.radiusKm,
    unsubscribeToken: result.unsubscribeToken,
  })
  const sent = await sendEmail({
    to: result.alert.email,
    subject: email.subject,
    html: email.html,
    text: email.text,
  })
  return {
    ok: true,
    status: 'active',
    needsConfirmation: false,
    mocked: sent.mocked,
  }
})
