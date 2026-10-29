/**
 * Envoi d'e-mails via Resend.
 * Sans clé API : log console (mock de développement explicitement identifié).
 */

export async function sendEmail(input: {
  to: string
  subject: string
  html: string
  text: string
}): Promise<{ mocked: boolean }> {
  const config = useRuntimeConfig()
  const apiKey = config.resendApiKey

  if (!apiKey) {
    console.info('[email:mock] ========================================')
    console.info(`[email:mock] To: ${input.to}`)
    console.info(`[email:mock] Subject: ${input.subject}`)
    console.info(`[email:mock] Text:\n${input.text}`)
    console.info('[email:mock] ========================================')
    return { mocked: true }
  }

  await $fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: {
      from: config.emailFrom,
      to: [input.to],
      subject: input.subject,
      html: input.html,
      text: input.text,
    },
  })

  return { mocked: false }
}

function escapeHtml(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}

function bodyParagraph(html: string) {
  return `<p style="margin:0 0 14px;">${html}</p>`
}

function bodyBlockquote(text: string, color = '#6735B6') {
  return `<blockquote style="margin:0 0 14px;border-left:3px solid ${color};padding-left:12px;color:#454545;white-space:pre-wrap;">${escapeHtml(text)}</blockquote>`
}

/** Layout HTML commun Manif' (compatible clients mail). */
export function renderEmailLayout(opts: {
  preview: string
  title: string
  bodyHtml: string
  ctaUrl?: string
  ctaLabel?: string
  footerNote?: string
  siteUrl?: string
}) {
  const siteUrl = (opts.siteUrl || 'https://manif.info').replace(/\/$/, '')
  const preview = escapeHtml(opts.preview)
  const title = escapeHtml(opts.title)
  const footer = escapeHtml(
    opts.footerNote
    || '— Manif\' (plateforme citoyenne indépendante)',
  )
  const cta = opts.ctaUrl && opts.ctaLabel
    ? `
          <tr>
            <td style="padding:20px 28px 8px;">
              <table role="presentation" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="border-radius:4px;background-color:#111111;">
                    <a href="${escapeHtml(opts.ctaUrl)}"
                       style="display:inline-block;padding:14px 22px;font-family:Arial,Helvetica,sans-serif;font-size:15px;font-weight:700;color:#FFFCF4;text-decoration:none;">
                      ${escapeHtml(opts.ctaLabel)}
                    </a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>`
    : ''

  return `<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="color-scheme" content="light">
  <title>Manif'</title>
</head>
<body style="margin:0;padding:0;background-color:#F4F1EA;">
  <div style="display:none;max-height:0;overflow:hidden;opacity:0;">${preview}</div>
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#F4F1EA;">
    <tr>
      <td align="center" style="padding:32px 16px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="max-width:560px;background-color:#FFFCF4;border:1px solid #DDDAD3;border-radius:8px;">
          <tr>
            <td style="padding:24px 28px 16px;border-bottom:1px solid #DDDAD3;">
              <p style="margin:0;font-family:Arial,Helvetica,sans-serif;font-size:11px;font-weight:700;letter-spacing:0.16em;text-transform:uppercase;color:#D1271C;">Manif'</p>
              <p style="margin:8px 0 0;font-family:Arial,Helvetica,sans-serif;font-size:13px;color:#636363;">L’agenda citoyen des manifestations</p>
            </td>
          </tr>
          <tr>
            <td style="padding:28px 28px 8px;">
              <h1 style="margin:0;font-family:Arial Black,Arial,Helvetica,sans-serif;font-size:26px;line-height:1.15;letter-spacing:0.01em;text-transform:uppercase;color:#111111;">${title}</h1>
            </td>
          </tr>
          <tr>
            <td style="padding:12px 28px 8px;font-family:Arial,Helvetica,sans-serif;font-size:16px;line-height:1.55;color:#454545;">
              ${opts.bodyHtml}
            </td>
          </tr>
          ${cta}
          <tr>
            <td style="padding:28px;border-top:1px solid #DDDAD3;">
              <p style="margin:0;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.5;color:#636363;">${footer}</p>
              <p style="margin:12px 0 0;font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#636363;">
                <a href="${escapeHtml(siteUrl)}" style="color:#6735B6;text-decoration:underline;">manif.info</a>
                · Neutre · Gratuit · Sans compte public
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`
}

export function buildVerificationEmail(opts: {
  siteUrl: string
  token: string
  title: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/proposer/confirmation?token=${encodeURIComponent(opts.token)}`
  const subject = `Manif' — Confirmez votre proposition`
  const text = [
    `Vous avez proposé la manifestation « ${opts.title} » sur Manif'.`,
    '',
    'Pour confirmer votre adresse e-mail, ouvrez ce lien (valable 24 heures) :',
    link,
    '',
    'Si vous n\'êtes pas à l\'origine de cette proposition, ignorez ce message.',
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: 'Confirmez votre proposition sur Manif\'',
    title: 'Confirmez votre e-mail',
    bodyHtml: [
      bodyParagraph(`Vous avez proposé la manifestation <strong>${escapeHtml(opts.title)}</strong> sur Manif'.`),
      bodyParagraph('Ce lien de confirmation est valable <strong>24 heures</strong>.'),
    ].join(''),
    ctaUrl: link,
    ctaLabel: 'Confirmer mon adresse e-mail',
    footerNote: 'Si vous n’êtes pas à l’origine de cette proposition, ignorez ce message.',
  })

  return { subject, text, html, link }
}

export function buildAdminPendingModerationEmail(opts: {
  siteUrl: string
  title: string
  cityName: string
  submissionId: string
  kind: 'new' | 'updated'
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/admin/propositions/${opts.submissionId}`
  const isUpdate = opts.kind === 'updated'
  const subject = isUpdate
    ? `Manif' — Proposition modifiée à valider — « ${opts.title} »`
    : `Manif' — Nouvelle proposition à valider — « ${opts.title} »`
  const lead = isUpdate
    ? 'Une proposition a été modifiée et revient en file de modération.'
    : 'Une nouvelle proposition d’événement est à valider.'
  const text = [
    lead,
    '',
    `Titre : ${opts.title}`,
    `Ville : ${opts.cityName}`,
    '',
    'Ouvrir dans l’admin :',
    link,
    '',
    '— Manif\'',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: lead,
    title: isUpdate ? 'Proposition à revoir' : 'Nouvelle proposition',
    bodyHtml: [
      bodyParagraph(escapeHtml(lead)),
      bodyParagraph(`<strong>${escapeHtml(opts.title)}</strong><br>${escapeHtml(opts.cityName)}`),
    ].join(''),
    ctaUrl: link,
    ctaLabel: 'Ouvrir dans l’admin',
    footerNote: '— Manif\'',
  })

  return { subject, text, html, link }
}

export function buildAdminNewReportEmail(opts: {
  siteUrl: string
  reportId: string
  eventTitle: string
  eventSlug: string
  reasonLabel: string
  details?: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/admin/signalements/${opts.reportId}`
  const eventLink = `${base}/manifestations/${opts.eventSlug}`
  const subject = `Manif' — Nouveau signalement — « ${opts.eventTitle} »`
  const details = (opts.details || '').trim()
  const text = [
    'Un signalement vient d’être déposé sur Manif\'.',
    '',
    `Événement : ${opts.eventTitle}`,
    `Motif : ${opts.reasonLabel}`,
    ...(details ? ['', 'Précisions :', details] : []),
    '',
    'Ouvrir dans l’admin :',
    link,
    '',
    'Fiche publique :',
    eventLink,
    '',
    '— Manif\'',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: `Signalement : ${opts.eventTitle}`,
    title: 'Nouveau signalement',
    bodyHtml: [
      bodyParagraph('Un signalement vient d’être déposé sur Manif\'.'),
      bodyParagraph(`<strong>${escapeHtml(opts.eventTitle)}</strong><br>Motif : ${escapeHtml(opts.reasonLabel)}`),
      details ? `<p style="margin:0 0 8px;">Précisions :</p>${bodyBlockquote(details, '#AD291F')}` : '',
      bodyParagraph(`<a href="${escapeHtml(eventLink)}" style="color:#6735B6;">Voir la fiche publique</a>`),
    ].join(''),
    ctaUrl: link,
    ctaLabel: 'Ouvrir le signalement',
    footerNote: '— Manif\'',
  })

  return { subject, text, html, link }
}

export function buildSubmissionApprovedEmail(opts: {
  siteUrl: string
  title: string
  eventSlug: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/manifestations/${opts.eventSlug}`
  const subject = `Manif' — Proposition publiée — « ${opts.title} »`
  const text = [
    `Bonne nouvelle : votre proposition « ${opts.title} » a été validée et publiée sur Manif'.`,
    '',
    'Voir la fiche :',
    link,
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: `Votre proposition « ${opts.title} » est publiée`,
    title: 'Proposition publiée',
    bodyHtml: bodyParagraph(
      `Bonne nouvelle : votre proposition <strong>${escapeHtml(opts.title)}</strong> a été validée et publiée sur Manif'.`,
    ),
    ctaUrl: link,
    ctaLabel: 'Voir la fiche publique',
  })

  return { subject, text, html, link }
}

export function buildSubmissionRejectedEmail(opts: {
  title: string
  reason?: string | null
  siteUrl?: string
}) {
  const subject = `Manif' — Proposition non retenue — « ${opts.title} »`
  const reason = (opts.reason || '').trim()
  const text = [
    `Votre proposition « ${opts.title} » n’a pas été retenue pour publication sur Manif'.`,
    '',
    ...(reason
      ? ['Motif :', reason, '']
      : []),
    'Vous pouvez proposer une autre manifestation via le formulaire Proposer.',
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: opts.siteUrl,
    preview: `Proposition non retenue : ${opts.title}`,
    title: 'Proposition non retenue',
    bodyHtml: [
      bodyParagraph(
        `Votre proposition <strong>${escapeHtml(opts.title)}</strong> n’a pas été retenue pour publication sur Manif'.`,
      ),
      reason
        ? `<p style="margin:0 0 8px;">Motif :</p>${bodyBlockquote(reason, '#AD291F')}`
        : '',
      bodyParagraph('Vous pouvez proposer une autre manifestation via le formulaire Proposer.'),
    ].join(''),
  })

  return { subject, text, html }
}

export function buildAlertConfirmEmail(opts: {
  siteUrl: string
  token: string
  locationLabel: string
  radiusKm: number
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/api/alerts/confirm?token=${encodeURIComponent(opts.token)}`
  const subject = `Manif' — Confirmez votre alerte près de ${opts.locationLabel}`
  const text = [
    `Vous vous êtes inscrit·e aux alertes Manif' pour les nouvelles manifestations dans un rayon de ${opts.radiusKm} km autour de ${opts.locationLabel}.`,
    '',
    'Confirmez votre adresse e-mail pour activer l’alerte :',
    link,
    '',
    'Si vous n’êtes pas à l’origine de cette demande, ignorez ce message.',
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: `Confirmez votre alerte près de ${opts.locationLabel}`,
    title: 'Confirmez votre alerte',
    bodyHtml: [
      bodyParagraph(
        `Vous vous êtes inscrit·e aux alertes Manif' pour les nouvelles manifestations dans un rayon de <strong>${opts.radiusKm}&nbsp;km</strong> autour de <strong>${escapeHtml(opts.locationLabel)}</strong>.`,
      ),
      bodyParagraph('Ce lien active l’alerte sur votre adresse e-mail.'),
    ].join(''),
    ctaUrl: link,
    ctaLabel: 'Confirmer mon alerte',
    footerNote: 'Si vous n’êtes pas à l’origine de cette demande, ignorez ce message.',
  })

  return { subject, text, html, link }
}

export function buildAlertUpdatedEmail(opts: {
  siteUrl: string
  locationLabel: string
  radiusKm: number
  unsubscribeToken: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const unsub = `${base}/api/alerts/unsubscribe?token=${encodeURIComponent(opts.unsubscribeToken)}`
  const subject = `Manif' — Alerte mise à jour — ${opts.locationLabel}`
  const text = [
    `Votre alerte Manif' a été mise à jour : ${opts.radiusKm} km autour de ${opts.locationLabel}.`,
    '',
    'Vous recevrez un e-mail lorsqu’une nouvelle manifestation sera publiée dans cette zone.',
    '',
    'Se désinscrire :',
    unsub,
    '',
    '— Manif\'',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: `Alerte mise à jour : ${opts.locationLabel}`,
    title: 'Alerte mise à jour',
    bodyHtml: [
      bodyParagraph(
        `Votre alerte est active : <strong>${opts.radiusKm}&nbsp;km</strong> autour de <strong>${escapeHtml(opts.locationLabel)}</strong>.`,
      ),
      bodyParagraph('Vous serez prévenu·e des nouvelles manifestations publiées dans cette zone.'),
      bodyParagraph(
        `<a href="${escapeHtml(unsub)}" style="color:#6735B6;">Se désinscrire</a>`,
      ),
    ].join(''),
    footerNote: '— Manif\'',
  })

  return { subject, text, html }
}

export function buildAlertDigestEmail(opts: {
  siteUrl: string
  locationLabel: string
  radiusKm: number
  unsubscribeToken: string
  events: Array<{
    title: string
    slug: string
    cityName: string
    startAt: string | null
    distanceKm: number
  }>
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const unsub = `${base}/api/alerts/unsubscribe?token=${encodeURIComponent(opts.unsubscribeToken)}`
  const n = opts.events.length
  const subject = n === 1
    ? `Manif' — 1 nouvelle manifestation près de ${opts.locationLabel}`
    : `Manif' — ${n} nouvelles manifestations près de ${opts.locationLabel}`

  const lines = opts.events.map((e) => {
    const when = e.startAt
      ? e.startAt.slice(0, 16).replace('T', ' ')
      : 'Date à confirmer'
    return `• ${e.title} — ${e.cityName} (${e.distanceKm} km) — ${when}\n  ${base}/manifestations/${e.slug}`
  })

  const text = [
    `Nouvelles manifestations publiées dans un rayon de ${opts.radiusKm} km autour de ${opts.locationLabel} :`,
    '',
    ...lines,
    '',
    'Voir l’agenda :',
    `${base}/manifestations`,
    '',
    'Se désinscrire :',
    unsub,
    '',
    '— Manif\'',
  ].join('\n')

  const listHtml = opts.events.map((e) => {
    const when = e.startAt
      ? e.startAt.slice(0, 16).replace('T', ' ')
      : 'Date à confirmer'
    const url = `${base}/manifestations/${e.slug}`
    return `<li style="margin:0 0 12px;">
      <a href="${escapeHtml(url)}" style="color:#6735B6;font-weight:700;text-decoration:underline;">${escapeHtml(e.title)}</a><br>
      <span style="color:#636363;font-size:14px;">${escapeHtml(e.cityName)} · ${e.distanceKm}&nbsp;km · ${escapeHtml(when)}</span>
    </li>`
  }).join('')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: subject,
    title: n === 1 ? 'Nouvelle manifestation' : 'Nouvelles manifestations',
    bodyHtml: [
      bodyParagraph(
        `Dans un rayon de <strong>${opts.radiusKm}&nbsp;km</strong> autour de <strong>${escapeHtml(opts.locationLabel)}</strong> :`,
      ),
      `<ul style="margin:0 0 14px;padding-left:18px;">${listHtml}</ul>`,
      bodyParagraph(
        `<a href="${escapeHtml(unsub)}" style="color:#6735B6;font-size:13px;">Se désinscrire de cette alerte</a>`,
      ),
    ].join(''),
    ctaUrl: `${base}/manifestations`,
    ctaLabel: 'Voir l’agenda',
    footerNote: '— Manif\'',
  })

  return { subject, text, html }
}

export function buildChangesRequestedEmail(opts: {
  siteUrl: string
  title: string
  message: string
  editToken: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const editLink = `${base}/proposer?edit=${encodeURIComponent(opts.editToken)}`
  const subject = `Manif' — Modifications demandées — « ${opts.title} »`
  const text = [
    `Concernant votre proposition « ${opts.title} » sur Manif' :`,
    '',
    'L’équipe de modération souhaite des précisions ou des corrections avant publication :',
    '',
    opts.message,
    '',
    'Modifiez votre proposition via ce lien (valable 14 jours) :',
    editLink,
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = renderEmailLayout({
    siteUrl: base,
    preview: `Modifications demandées pour « ${opts.title} »`,
    title: 'Modifications demandées',
    bodyHtml: [
      bodyParagraph(
        `Concernant votre proposition <strong>${escapeHtml(opts.title)}</strong> sur Manif' :`,
      ),
      bodyParagraph('L’équipe de modération souhaite des précisions ou des corrections avant publication :'),
      bodyBlockquote(opts.message, '#6735B6'),
      bodyParagraph('Le lien de modification est valable <strong>14 jours</strong>.'),
    ].join(''),
    ctaUrl: editLink,
    ctaLabel: 'Modifier et renvoyer ma proposition',
  })

  return { subject, text, html, editLink }
}
