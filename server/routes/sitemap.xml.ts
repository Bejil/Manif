import { listEvents } from '../services/events-repository'

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const base = config.public.siteUrl.replace(/\/$/, '')
  const { items } = await listEvents({
    statuses: ['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'],
    page: 1,
    pageSize: 2000,
  })

  const staticPages = [
    '',
    '/proposer',
    '/guide',
    '/faq',
    '/comptage',
    '/a-propos',
    '/confidentialite',
    '/mentions-legales',
    '/contact',
    '/soutenir',
  ]

  const urls = [
    ...staticPages.map(p => `${base}${p}`),
    ...items.map(e => `${base}/manifestations/${e.slug}`),
  ]

  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(u => `  <url><loc>${u}</loc></url>`).join('\n')}
</urlset>`

  setHeader(event, 'Content-Type', 'application/xml')
  return body
})
