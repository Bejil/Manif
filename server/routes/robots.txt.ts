export default defineEventHandler((event) => {
  const config = useRuntimeConfig()
  const base = String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, '')

  const body = `User-agent: *
Allow: /
Disallow: /admin
Disallow: /api/admin
Disallow: /mes-manifestations
Disallow: /proposer/confirmation

Sitemap: ${base}/sitemap.xml
`

  setHeader(event, 'Content-Type', 'text/plain; charset=utf-8')
  setHeader(event, 'Cache-Control', 'public, max-age=3600')
  return body
})
