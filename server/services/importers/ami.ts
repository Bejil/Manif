import type { ImportScrapedEvent } from '#shared/types/import'
import {
  categorize,
  fetchText,
  inferCity,
  isMilitant,
  normalizeScraped,
  parseFrenchDate,
  parseRssItems,
  stripHtml,
  toIsoZ,
} from './shared'

export async function scrapeAmi(options: {
  militantOnly?: boolean
  maxPerSource?: number
}): Promise<ImportScrapedEvent[]> {
  const militantOnly = options.militantOnly !== false
  const max = options.maxPerSource ?? 500
  const xml = await fetchText('https://www.agendamilitant.org/rss.xml')
  const items = parseRssItems(xml)
  const out: ImportScrapedEvent[] = []
  const minTs = Date.now() - 24 * 3600 * 1000
  const maxTs = Date.now() + 200 * 24 * 3600 * 1000

  /** Plafond de pages détail — sinon un run AMI peut durer des dizaines de minutes. */
  const maxDetailFetches = 20
  let detailFetches = 0

  for (const item of items) {
    if (out.length >= max) break
    const title = item.title.trim()
    const link = item.link.trim()
    if (!title || !link) continue
    let desc = item.description
    let start = parseFrenchDate(`${title} ${desc}`)
    if (!start) {
      if (detailFetches >= maxDetailFetches) continue
      try {
        detailFetches++
        const page = await fetchText(link)
        const body = stripHtml(page)
        start = parseFrenchDate(body)
        if (!desc) desc = body.slice(0, 900)
        await new Promise(r => setTimeout(r, 40))
      }
      catch {
        continue
      }
    }
    if (!start || start.getTime() < minTs || start.getTime() > maxTs) continue
    if (militantOnly && !isMilitant(title, desc)) {
      if (!/\d|h\b|place|permanence|r[eé]union|appel|rassembl|manif/i.test(title)) continue
    }
    const city = inferCity(`${title} ${desc}`, 'Paris')
    const end = new Date(start.getTime() + 3 * 3600 * 1000)
    out.push(normalizeScraped({
      source: 'ami',
      sourceUrl: link,
      externalId: link,
      title,
      description: desc,
      category: categorize(title, desc),
      cityName: city,
      locationName: city,
      startAt: toIsoZ(start),
      endAt: toIsoZ(end),
      endIsEstimated: true,
    }))
  }
  return out
}
