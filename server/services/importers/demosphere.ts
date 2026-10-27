import type { ImportScrapedEvent } from '#shared/types/import'
import {
  DEMOSPHERE_HOST_CITY,
  DEMOSPHERE_HOSTS,
  categorize,
  fetchText,
  inferCity,
  isMilitant,
  normalizeScraped,
  parseFrenchDate,
  parseRssItems,
  toIsoZ,
} from './shared'

export function demosphereBatches(size = 5): string[][] {
  const hosts = [...DEMOSPHERE_HOSTS]
  const batches: string[][] = []
  for (let i = 0; i < hosts.length; i += size) {
    batches.push(hosts.slice(i, i + size))
  }
  return batches
}

export async function scrapeDemosphereHosts(
  hosts: string[],
  options: { militantOnly?: boolean, maxPerSource?: number },
): Promise<ImportScrapedEvent[]> {
  const militantOnly = options.militantOnly !== false
  const max = options.maxPerSource ?? 2000
  const out: ImportScrapedEvent[] = []
  const minTs = Date.now() - 24 * 3600 * 1000
  const maxTs = Date.now() + 400 * 24 * 3600 * 1000

  for (const host of hosts) {
    if (out.length >= max) break
    const url = `https://${host}.demosphere.net/events.xml`
    let xml: string
    try {
      xml = await fetchText(url)
    }
    catch {
      continue
    }
    const items = parseRssItems(xml)
    const fallbackCity = DEMOSPHERE_HOST_CITY[host] || host.replace(/furieuse$/, '')
    for (const item of items) {
      if (out.length >= max) break
      const title = item.title.trim()
      const link = item.link.trim()
      if (!title || !link) continue
      const desc = item.description
      if (militantOnly && !isMilitant(title, desc)) continue
      const start = parseFrenchDate(`${title} ${desc}`)
      if (!start || start.getTime() < minTs || start.getTime() > maxTs) continue

      let lat: number | null = null
      let lon: number | null = null
      if (item.georssPoint) {
        const parts = item.georssPoint.trim().split(/\s+/)
        if (parts.length >= 2) {
          lat = Number(parts[0])
          lon = Number(parts[1])
          if (!Number.isFinite(lat) || !Number.isFinite(lon)) lat = lon = null
        }
      }
      const city = inferCity(`${title} ${desc} ${item.georssFeatureName || ''}`, fallbackCity)
      let loc = (item.georssFeatureName || city).trim()
      if (loc === 'Gare' || loc === 'Centre') loc = `${loc} (${city})`
      const end = new Date(start.getTime() + 3 * 3600 * 1000)
      out.push(normalizeScraped({
        source: 'demosphere',
        sourceUrl: link,
        externalId: link,
        title,
        description: desc || `Événement Démosphère (${host}).`,
        category: categorize(title, desc),
        cityName: city,
        locationName: loc,
        latitude: lat,
        longitude: lon,
        startAt: toIsoZ(start),
        endAt: toIsoZ(end),
        endIsEstimated: true,
        raw: { host },
      }))
    }
  }
  return out
}
