import type { ImportScrapedEvent } from '#shared/types/import'
import {
  categorize,
  fetchText,
  inferCity,
  isMilitant,
  normalizeScraped,
  parseFrenchDate,
  parseRssItems,
  toIsoZ,
} from './shared'

const FEEDS = [
  'https://mobilizon.extinctionrebellion.fr/feed/instance/atom',
]

export async function scrapeMobilizonXr(options: {
  militantOnly?: boolean
  maxPerSource?: number
}): Promise<ImportScrapedEvent[]> {
  const militantOnly = options.militantOnly !== false
  const max = options.maxPerSource ?? 200
  const out: ImportScrapedEvent[] = []
  const minTs = Date.now() - 24 * 3600 * 1000
  const maxTs = Date.now() + 365 * 24 * 3600 * 1000

  for (const feed of FEEDS) {
    let xml: string
    try {
      xml = await fetchText(feed)
    }
    catch {
      continue
    }
    // Strip default xmlns to help regex tags
    xml = xml.replace(/\sxmlns="[^"]+"/g, '')
    const items = parseRssItems(xml)
    for (const item of items) {
      if (out.length >= max) break
      const title = item.title.trim()
      if (!title) continue
      const desc = item.description
      if (militantOnly && !isMilitant(title, desc) && !/XR|Extinction|climat|action/i.test(`${title} ${desc}`)) {
        continue
      }

      let start: Date | null = null
      if (item.pubDate) {
        const iso = item.pubDate.match(/(\d{4}-\d{2}-\d{2})T(\d{2}):(\d{2})/)
        if (iso) {
          start = new Date(`${iso[1]}T${iso[2]}:${iso[3]}:00Z`)
        }
        else {
          const t = Date.parse(item.pubDate)
          if (!Number.isNaN(t)) start = new Date(t)
        }
      }
      if (!start) start = parseFrenchDate(`${title} ${desc}`)
      if (!start || start.getTime() < minTs || start.getTime() > maxTs) continue

      const city = inferCity(`${title} ${desc}`, 'Paris')
      const end = new Date(start.getTime() + 3 * 3600 * 1000)
      const link = item.link || feed
      out.push(normalizeScraped({
        source: 'mobilizon_xr',
        sourceUrl: link,
        externalId: link,
        title,
        description: desc || 'Action Extinction Rebellion (Mobilizon).',
        category: categorize(title, desc) === 'autre' ? 'climat' : categorize(title, desc),
        cityName: city,
        locationName: city,
        startAt: toIsoZ(start),
        endAt: toIsoZ(end),
        endIsEstimated: true,
      }))
    }
  }
  return out
}
