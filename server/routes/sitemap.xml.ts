import { listEvents, listPublishedCities } from '../services/events-repository'

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const base = String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, '')

  const [{ items: events }, cities] = await Promise.all([
    listEvents({
      statuses: ['upcoming', 'ongoing', 'past', 'cancelled', 'postponed'],
      page: 1,
      pageSize: 2000,
    }),
    listPublishedCities(),
  ])

  const staticPages: Array<{ path: string, lastmod?: string, priority?: string }> = [
    { path: '', priority: '1.0' },
    { path: '/manifestations', priority: '0.9' },
    { path: '/proposer', priority: '0.7' },
    { path: '/guide', priority: '0.8' },
    { path: '/faq', priority: '0.7' },
    { path: '/comptage', priority: '0.6' },
    { path: '/a-propos', priority: '0.5' },
    { path: '/confidentialite', priority: '0.3' },
    { path: '/mentions-legales', priority: '0.3' },
    { path: '/contact', priority: '0.4' },
    { path: '/soutenir', priority: '0.5' },
  ]

  const today = new Date().toISOString().slice(0, 10)

  const urls: Array<{ loc: string, lastmod: string, priority?: string }> = [
    ...staticPages.map(p => ({
      loc: `${base}${p.path}`,
      lastmod: today,
      priority: p.priority,
    })),
    ...cities.map(c => ({
      loc: `${base}/manifestations/ville/${c.slug}`,
      lastmod: (c.updatedAt || today).slice(0, 10),
      priority: '0.8',
    })),
    ...events.map(e => ({
      loc: `${base}/manifestations/${e.slug}`,
      lastmod: (e.updatedAt || e.publishedAt || e.createdAt || today).slice(0, 10),
      priority: e.displayStatus === 'upcoming' || e.displayStatus === 'ongoing' ? '0.9' : '0.5',
    })),
  ]

  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(u => `  <url>
    <loc>${escapeXml(u.loc)}</loc>
    <lastmod>${u.lastmod}</lastmod>${u.priority ? `\n    <priority>${u.priority}</priority>` : ''}
  </url>`).join('\n')}
</urlset>`

  setHeader(event, 'Content-Type', 'application/xml; charset=utf-8')
  setHeader(event, 'Cache-Control', 'public, max-age=900')
  return body
})

function escapeXml(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}
