import type { ImportScrapedEvent } from '#shared/types/import'
import {
  categorize,
  fetchText,
  inferCity,
  isMilitant,
  normalizeScraped,
  parseFrenchDate,
  parseRssItems,
  SOFT_EXCLUDE_RE,
  toIsoZ,
} from './shared'

export async function scrapeManifsFr(options: {
  militantOnly?: boolean
  maxPerSource?: number
}): Promise<ImportScrapedEvent[]> {
  const militantOnly = options.militantOnly !== false
  const max = options.maxPerSource ?? 500
  const xml = await fetchText('https://www.manifs.fr/?format=rss&country=fr&period=upcoming')
  const items = parseRssItems(xml)
  const out: ImportScrapedEvent[] = []
  const minTs = Date.now() - 24 * 3600 * 1000

  for (const item of items) {
    if (out.length >= max) break
    const title = item.title.trim()
    const link = item.link.trim()
    if (!title) continue
    const desc = item.description
    if (SOFT_EXCLUDE_RE.test(title) && !isMilitant(title, desc)) continue
    if (militantOnly && !isMilitant(title, desc)
      && !/\b(manif|rassembl|gr[eè]ve|cort[eè]ge|appel|mobilisation|occupation|blocage|marche)\b/i.test(title)) {
      continue
    }

    let start: Date | null = null
    const lm = link.match(/\/((20\d{2})-(\d{2})-(\d{2}))-/)
    if (lm) {
      const hm = `${title} ${desc}`.match(/(\d{1,2})\s*h\s*(\d{0,2})/i)
      const hh = Math.min(hm ? Number(hm[1]) : 15, 23)
      const mm = hm?.[2] ? Number(hm[2]) % 60 : 0
      // local CET ≈ UTC+1
      start = new Date(Date.UTC(Number(lm[2]), Number(lm[3]) - 1, Number(lm[4]), hh - 1, mm))
    }
    if (!start) start = parseFrenchDate(`${title} ${desc}`)
    if (!start || start.getTime() < minTs) continue

    let city = 'Paris'
    const tag = title.match(/#\s*([A-Za-zÀ-ÿ' -]{2,40})/)
    if (tag) city = tag[1]!.trim()
    else {
      const head = title.match(/^#?\s*([A-Za-zÀ-ÿ' -]{2,40})\s*[-–—]/)
      if (head) city = head[1]!.trim()
    }
    city = inferCity(`${title} ${desc}`, city)

    const end = new Date(start.getTime() + 3 * 3600 * 1000)
    out.push(normalizeScraped({
      source: 'manifs',
      sourceUrl: link || `https://www.manifs.fr/#${encodeURIComponent(title)}`,
      externalId: link || title,
      title,
      description: desc || 'Source manifs.fr.',
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
