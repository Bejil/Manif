import sharp from 'sharp'
import { DateTime } from 'luxon'
import { getEventBySlug } from '../../../services/events-repository'
import { notFound } from '../../../utils/errors'

/**
 * Image Open Graph PNG (1200×630) — compatible Facebook / LinkedIn / X.
 * URL canonique : /api/og/event/:slug
 */
export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')
  if (!slug) throw notFound()
  const item = await getEventBySlug(slug)
  if (!item) throw notFound()

  const date = item.startAt
    ? DateTime.fromISO(item.startAt)
      .setZone(item.timezone)
      .setLocale('fr')
      .toFormat('ccc d LLL yyyy · HH:mm')
    : 'Date à venir'

  const title = escapeXml(truncate(item.title, 72))
  const city = escapeXml(item.cityName)

  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#111111"/>
      <stop offset="100%" stop-color="#252525"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="630" fill="url(#bg)"/>
  <circle cx="1040" cy="120" r="180" fill="#9C6EE8" opacity="0.22"/>
  <circle cx="160" cy="520" r="220" fill="#D1271C" opacity="0.14"/>
  <text x="72" y="110" font-family="Anton, Impact, Arial Narrow, sans-serif" font-size="42" fill="#FFFCF4">MANIF'</text>
  <text x="72" y="150" font-family="Inter, Helvetica, Arial, sans-serif" font-size="22" fill="#9C6EE8">Toutes les manifestations. Toutes les voix.</text>
  <text x="72" y="280" font-family="Inter, Helvetica, Arial, sans-serif" font-size="48" font-weight="700" fill="#FFFFFF">${title}</text>
  <text x="72" y="360" font-family="Inter, Helvetica, Arial, sans-serif" font-size="28" fill="#FFFCF4">${city}</text>
  <text x="72" y="410" font-family="Inter, Helvetica, Arial, sans-serif" font-size="26" fill="#DDDAD3">${escapeXml(date)}</text>
  <rect x="72" y="470" width="120" height="6" rx="2" fill="#9C6EE8"/>
</svg>`

  const png = await sharp(Buffer.from(svg)).png().toBuffer()

  setHeader(event, 'Content-Type', 'image/png')
  setHeader(event, 'Cache-Control', 'public, max-age=3600, stale-while-revalidate=86400')
  return png
})

function truncate(s: string, n: number) {
  return s.length > n ? `${s.slice(0, n - 1)}…` : s
}

function escapeXml(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}
