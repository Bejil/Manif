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

export function buildVerificationEmail(opts: {
  siteUrl: string
  token: string
  title: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const link = `${base}/proposer/confirmation?token=${encodeURIComponent(opts.token)}`
  const subject = `Confirmez votre proposition — Manif'`
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

  const html = `
    <p>Vous avez proposé la manifestation <strong>${escapeHtml(opts.title)}</strong> sur Manif'.</p>
    <p><a href="${link}">Confirmer mon adresse e-mail</a> (valable 24 heures)</p>
    <p>Si vous n'êtes pas à l'origine de cette proposition, ignorez ce message.</p>
  `

  return { subject, text, html, link }
}

export function buildChangesRequestedEmail(opts: {
  siteUrl: string
  title: string
  message: string
}) {
  const base = opts.siteUrl.replace(/\/$/, '')
  const subject = `Modifications demandées — « ${opts.title} » — Manif'`
  const text = [
    `Concernant votre proposition « ${opts.title} » sur Manif' :`,
    '',
    'L’équipe de modération souhaite des précisions ou des corrections avant publication :',
    '',
    opts.message,
    '',
    `Vous pouvez répondre à cet e-mail ou renvoyer une proposition mise à jour via ${base}/proposer.`,
    '',
    '— Manif\' (plateforme citoyenne indépendante)',
  ].join('\n')

  const html = `
    <p>Concernant votre proposition <strong>${escapeHtml(opts.title)}</strong> sur Manif' :</p>
    <p>L’équipe de modération souhaite des précisions ou des corrections avant publication :</p>
    <blockquote style="border-left:3px solid #6735B6;padding-left:12px;color:#454545;white-space:pre-wrap;">${escapeHtml(opts.message)}</blockquote>
    <p>Vous pouvez répondre à cet e-mail ou <a href="${base}/proposer">renvoyer une proposition mise à jour</a>.</p>
  `

  return { subject, text, html }
}

function escapeHtml(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}
