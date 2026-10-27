import type { ImportScrapedEvent } from '#shared/types/import'
import {
  categorize,
  cleanPlainText,
  fetchJson,
  inferCity,
  normalizeScraped,
  toIsoZ,
} from './shared'

const SUPA_URL = 'https://pleggocdxecyvdszhdyl.supabase.co'
/** Clé anon publique exposée par manifradar.fr (lecture seule). */
const SUPA_ANON
  = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBsZWdnb2NkeGVjeXZkc3poZHlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MzM0NTIsImV4cCI6MjA4NzUwOTQ1Mn0.2OHVGXhPgf9-I4u2km7EU1Yj5xZDTX64yFOPz3QhLtE'

interface MrRow {
  id?: string
  nom?: string
  date?: string
  heure?: string
  ville?: string
  lieu?: string
  trajet?: string
  description?: string
  organisateur?: string
  lien?: string
  url?: string
}

function parseHeure(heure: string | undefined): { hh: number, mm: number } {
  if (!heure) return { hh: 14, mm: 0 }
  const s = String(heure).trim()
  if (/matin|d[eè]s/i.test(s)) return { hh: 10, mm: 0 }
  if (/48\s*h|journ[eé]e|toute/i.test(s)) return { hh: 8, mm: 0 }
  const hm = s.match(/(\d{1,2})\s*h\s*(\d{0,2})/i)
  if (hm) return { hh: Math.min(Number(hm[1]), 23), mm: Number(hm[2] || 0) % 60 }
  const bare = s.match(/^(\d{1,2})$/)
  if (bare) return { hh: Math.min(Number(bare[1]), 23), mm: 0 }
  return { hh: 14, mm: 0 }
}

export async function scrapeManifRadar(options: {
  maxPerSource?: number
}): Promise<ImportScrapedEvent[]> {
  const max = options.maxPerSource ?? 500
  const rows = await fetchJson<MrRow[]>(
    `${SUPA_URL}/rest/v1/manifestations?select=*&order=date.asc&limit=${max}`,
    {
      headers: {
        apikey: SUPA_ANON,
        Authorization: `Bearer ${SUPA_ANON}`,
      },
    },
  )
  const out: ImportScrapedEvent[] = []
  const minDate = new Date(Date.now() - 24 * 3600 * 1000)
  const maxDate = new Date(Date.now() + 400 * 24 * 3600 * 1000)

  for (const row of rows || []) {
    if (out.length >= max) break
    const title = cleanPlainText(row.nom)
    const dateS = String(row.date || '').trim()
    if (!title || !dateS) continue
    const d = new Date(`${dateS}T00:00:00Z`)
    if (Number.isNaN(d.getTime()) || d < minDate || d > maxDate) continue

    let city = cleanPlainText(row.ville) || 'Paris'
    if (/toute la france|france m[eé]tropolitaine/i.test(city)) city = 'Paris'
    city = inferCity(`${title} ${city}`, city)
    const lieu = cleanPlainText(row.lieu) || city
    const { hh, mm } = parseHeure(row.heure)
    const [y, mo, da] = dateS.split('-').map(Number)
    const start = new Date(Date.UTC(y!, mo! - 1, da!, hh - 1, mm))
    const end = new Date(start.getTime() + 3 * 3600 * 1000)

    const parts: string[] = []
    if (row.trajet) parts.push(`Parcours : ${cleanPlainText(row.trajet)}`)
    if (row.description) parts.push(cleanPlainText(row.description).slice(0, 600))
    const organizer = cleanPlainText(row.organisateur) || null
    if (organizer) parts.push(`Organisé par : ${organizer}`)
    const desc = parts.join(' ') || `Manifestation à ${city}. Source ManifRadar.`
    const src = String(row.lien || row.url || `https://manifradar.fr/?id=${row.id || ''}`).slice(0, 500)

    out.push(normalizeScraped({
      source: 'manifradar',
      sourceUrl: src,
      externalId: row.id || src,
      title,
      description: desc,
      category: categorize(title, desc),
      cityName: city,
      locationName: lieu,
      startAt: toIsoZ(start),
      endAt: toIsoZ(end),
      endIsEstimated: true,
      organizerName: organizer,
    }))
  }
  return out
}
