import type { EventCategoryId } from '#shared/constants/categories'
import type { ImportScrapedEvent } from '#shared/types/import'

export const IMPORT_UA = 'ManifInfoBot/1.0 (+https://manif.info; admin-import)'

export const MILITANT_RE = /\b(manif|manifestation|rassemblement|gr[eè]ve|mobilisation|cort[eè]ge|marche|occupation|blocage|solidarit[eé]|antiracis|antifasc|palestin|gaza|climat|ecolog|f[eé]minist|lgbt|pride|syndicat|\bcgt\b|solidaires|logement|sans[\s-]?papiers|expulsion|r[eé]pression|retraite|salaire|contre\s+|kanaky|racis|appel\s+[àa]|urgence|islamophob)/i

export const SOFT_EXCLUDE_RE = /\b(librairie|brunch|yoga|d[eé]gustation|concert jazz|atelier cuisine|visite guid[eé]e|soir[eé]e dansante|permanence caf[eé]|cantine|entraide alimentaire|\bcale\b)/i

export const MONTHS: Record<string, number> = {
  janvier: 1, février: 2, fevrier: 2, mars: 3, avril: 4, mai: 5,
  juin: 6, juillet: 7, août: 8, aout: 8, septembre: 9, octobre: 10,
  novembre: 11, décembre: 12, decembre: 12,
}

export const FR_CITIES = [
  'Paris', 'Lyon', 'Marseille', 'Toulouse', 'Nantes', 'Bordeaux', 'Lille', 'Rennes', 'Nice',
  'Strasbourg', 'Montpellier', 'Grenoble', 'Rouen', 'Dijon', 'Reims', 'Tours', 'Orléans',
  'Clermont-Ferrand', 'Le Havre', 'Saint-Étienne', 'Toulon', 'Nîmes', 'Angers', 'Amiens',
  'Metz', 'Nancy', 'Caen', 'Brest', 'Limoges', 'Perpignan', 'Mulhouse', 'Besançon', 'Pau',
  'La Rochelle', 'Avignon', 'Poitiers', 'Montreuil', 'Saint-Denis', 'Nanterre', 'Dunkerque',
  'Trappes', 'Cahors', 'Albi', 'Tarbes', 'Le Mans', 'Foix', 'Rodez', 'Bourges', 'Carcassonne',
  'Gap', 'Digne-les-Bains', 'Forcalquier',
]

/** Instances Démosphère connues (France métropolitaine). */
export const DEMOSPHERE_HOSTS = [
  'paris', 'lille', 'rennes', 'toulouse', 'nice', 'strasbourgfurieuse', 'gironde',
  'sarthe', 'tarn', 'pyrenees', 'poitiers', 'dunkerque', 'gard', 'limoges',
  'carcassonne', 'berry', 'lot', 'ariege', 'aveyron', 'nantes', 'grenoble',
  'marseille', 'montpellier', 'dijon', 'angers', 'caen', 'rouen', 'brest',
  'lehavre', 'amiens', 'orleans', 'tours', 'reims', 'metz', 'nancy',
  'clermontferrand', 'perpignan', 'pau', 'bayonne', 'chambery', 'annecy',
  '04', '05', '63',
] as const

export const DEMOSPHERE_HOST_CITY: Record<string, string> = {
  paris: 'Paris', lille: 'Lille', rennes: 'Rennes', toulouse: 'Toulouse',
  nice: 'Nice', strasbourg: 'Strasbourg', strasbourgfurieuse: 'Strasbourg',
  gironde: 'Bordeaux', sarthe: 'Le Mans', tarn: 'Albi', pyrenees: 'Tarbes',
  poitiers: 'Poitiers', dunkerque: 'Dunkerque', gard: 'Nîmes', limoges: 'Limoges',
  carcassonne: 'Carcassonne', berry: 'Bourges', lot: 'Cahors', ariege: 'Foix',
  aveyron: 'Rodez', '63': 'Clermont-Ferrand', '05': 'Gap', '04': 'Digne-les-Bains',
  nantes: 'Nantes', grenoble: 'Grenoble', marseille: 'Marseille',
  montpellier: 'Montpellier', dijon: 'Dijon', angers: 'Angers', caen: 'Caen',
  rouen: 'Rouen', brest: 'Brest', lehavre: 'Le Havre', amiens: 'Amiens',
  orleans: 'Orléans', tours: 'Tours', reims: 'Reims', metz: 'Metz', nancy: 'Nancy',
  clermontferrand: 'Clermont-Ferrand', perpignan: 'Perpignan', pau: 'Pau',
  bayonne: 'Bayonne', chambery: 'Chambéry', annecy: 'Annecy',
}

export function isMilitant(title: string, desc = ''): boolean {
  return MILITANT_RE.test(`${title} ${desc}`)
}

export function categorize(title: string, desc = ''): EventCategoryId {
  const t = `${title} ${desc}`.toLowerCase()
  if (/f[eé]minist|lgbt|pride|queer|trans|violences?\s+sex|ivg/.test(t)) return 'droits'
  if (/palestin|gaza|antiracis|racis|migrant|sans[\s-]?papier|kanaky|islamophob/.test(t)) return 'droits'
  if (/climat|ecolog|environnement|nucleaire|extinction/.test(t)) return 'climat'
  if (/logement|expulsion|loyers?|squat/.test(t)) return 'logement'
  if (/gr[eè]ve|salaire|syndicat|travail|retraite|cgt|solidaires/.test(t)) return 'travail'
  if (/education|lyc[eé]|universit|enseignant/.test(t)) return 'education'
  if (/sant[eé]|hopital|hôpital|soignant/.test(t)) return 'sante'
  if (/agricultur|paysan|rural/.test(t)) return 'agriculture'
  if (/international|paix|guerre|ukraine/.test(t)) return 'international'
  if (/police|justice|prison|r[eé]pression/.test(t)) return 'droits'
  if (/social|solidarit|pr[eé]carit/.test(t)) return 'social'
  return 'autre'
}

export function ensureDescription(title: string, desc: string, city?: string, sourceUrl?: string): string {
  let d = cleanPlainText(desc).replace(/\s+/g, ' ').trim()
  const cleanTitle = cleanPlainText(title)
  if (d.length >= 20 && d.length <= 5000) return d.slice(0, 5000)
  const bits: string[] = []
  if (d) bits.push(d.endsWith('.') ? d : `${d}.`)
  bits.push(`Événement annoncé : ${cleanTitle}.`)
  if (city) bits.push(`Ville : ${cleanPlainText(city)}.`)
  if (sourceUrl) bits.push(`Plus d'infos : ${sourceUrl}.`)
  else bits.push('Détails à vérifier sur la page source.')
  d = bits.join(' ')
  while (d.length < 20) d += ' Informations à confirmer.'
  return d.slice(0, 5000)
}

export function inferCity(blob: string, fallback = 'Paris'): string {
  for (const name of [...FR_CITIES].sort((a, b) => b.length - a.length)) {
    if (new RegExp(`\\b${name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'i').test(blob)) {
      return name
    }
  }
  return fallback
}

export function parseFrenchDate(text: string, defaultHour = 15): Date | null {
  const dm = text.match(
    /(\d{1,2})\s+(janvier|février|fevrier|mars|avril|mai|juin|juillet|août|aout|septembre|octobre|novembre|décembre|decembre)\s+(20\d{2})/i,
  )
  if (!dm) return null
  const month = MONTHS[dm[2]!.toLowerCase()]
  if (!month) return null
  const around = text.slice(Math.max(0, dm.index! - 30), dm.index! + dm[0].length + 80)
  const hm = around.match(/(\d{1,2})\s*h\s*(\d{0,2})/i)
  const hh = Math.min(hm ? Number(hm[1]) : defaultHour, 23)
  const mm = hm?.[2] ? Number(hm[2]) % 60 : 0
  const day = Number(dm[1])
  const year = Number(dm[3])
  // CET/CEST approx: use UTC+1 for storage conversion from local
  const utc = Date.UTC(year, month - 1, day, hh - 1, mm)
  const d = new Date(utc)
  return Number.isNaN(d.getTime()) ? null : d
}

export function toIsoZ(d: Date): string {
  return d.toISOString().replace(/\.\d{3}Z$/, 'Z')
}

/** Timeout HTTP imports — 45s bloquait trop longtemps les lots Démosphère / AMI. */
const IMPORT_FETCH_TIMEOUT_MS = 12_000

export async function fetchText(url: string, init?: RequestInit): Promise<string> {
  const res = await fetch(url, {
    ...init,
    headers: {
      'User-Agent': IMPORT_UA,
      Accept: '*/*',
      ...(init?.headers || {}),
    },
    signal: init?.signal ?? AbortSignal.timeout(IMPORT_FETCH_TIMEOUT_MS),
  })
  if (!res.ok) throw new Error(`HTTP ${res.status} ${url}`)
  return res.text()
}

export async function fetchJson<T>(url: string, init?: RequestInit): Promise<T> {
  const res = await fetch(url, {
    ...init,
    headers: {
      'User-Agent': IMPORT_UA,
      Accept: 'application/json',
      ...(init?.headers || {}),
    },
    signal: init?.signal ?? AbortSignal.timeout(IMPORT_FETCH_TIMEOUT_MS),
  })
  if (!res.ok) throw new Error(`HTTP ${res.status} ${url}`)
  return res.json() as Promise<T>
}

/** Entités HTML nommées courantes (RSS / pages FR). */
const NAMED_ENTITIES: Record<string, string> = {
  amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ',
  eacute: 'é', Eacute: 'É', egrave: 'è', Egrave: 'È', ecirc: 'ê', Ecirc: 'Ê',
  euml: 'ë', Euml: 'Ë', aacute: 'á', Aacute: 'Á', agrave: 'à', Agrave: 'À',
  acirc: 'â', Acirc: 'Â', auml: 'ä', Auml: 'Ä', iacute: 'í', Iacute: 'Í',
  igrave: 'ì', Igrave: 'Ì', icirc: 'î', Icirc: 'Î', iuml: 'ï', Iuml: 'Ï',
  oacute: 'ó', Oacute: 'Ó', ograve: 'ò', Ograve: 'Ò', ocirc: 'ô', Ocirc: 'Ô',
  ouml: 'ö', Ouml: 'Ö', uacute: 'ú', Uacute: 'Ú', ugrave: 'ù', Ugrave: 'Ù',
  ucirc: 'û', Ucirc: 'Û', uuml: 'ü', Uuml: 'Ü', yacute: 'ý', Yacute: 'Ý',
  yuml: 'ÿ', ccedil: 'ç', Ccedil: 'Ç', ntilde: 'ñ', Ntilde: 'Ñ',
  oe: 'œ', OE: 'Œ', aelig: 'æ', AElig: 'Æ', szlig: 'ß',
  laquo: '«', raquo: '»', ldquo: '“', rdquo: '”', lsquo: '‘', rsquo: '’',
  ndash: '–', mdash: '—', hellip: '…', middot: '·', bull: '•',
  euro: '€', pound: '£', copy: '©', reg: '®', trade: '™', deg: '°',
  times: '×', divide: '÷', plusmn: '±', frac12: '½', frac14: '¼', frac34: '¾',
}

/** Décode &#233; / &#xE9; / &eacute; (plusieurs passes si double-encodage). */
export function decodeHtmlEntities(text: string): string {
  let out = text
  for (let pass = 0; pass < 3; pass++) {
    const prev = out
    out = out.replace(/&#x([0-9a-fA-F]+);/g, (_, hex: string) => {
      const code = Number.parseInt(hex, 16)
      return Number.isFinite(code) ? String.fromCodePoint(code) : _
    })
    out = out.replace(/&#(\d+);/g, (_, dec: string) => {
      const code = Number.parseInt(dec, 10)
      return Number.isFinite(code) ? String.fromCodePoint(code) : _
    })
    out = out.replace(/&([a-zA-Z][a-zA-Z0-9]+);/g, (full, name: string) => {
      return NAMED_ENTITIES[name] ?? full
    })
    if (out === prev) break
  }
  return out
}

/** Retire le HTML et décode les entités → texte brut affichable. */
export function stripHtml(html: string): string {
  return cleanPlainText(html)
}

export function cleanPlainText(input: string | null | undefined): string {
  if (!input) return ''
  let text = String(input)
  text = text
    .replace(/<script[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?<\/style>/gi, ' ')
    .replace(/<br\s*\/?>/gi, '\n')
    .replace(/<\/p>/gi, '\n')
    .replace(/<\/div>/gi, '\n')
    .replace(/<\/li>/gi, '\n')
    .replace(/<[^>]+>/g, ' ')
  text = decodeHtmlEntities(text)
  // Si du HTML reste après décodage (ex. &lt;p&gt;), second passage
  if (/<[a-zA-Z][^>]*>/.test(text) || /&(?:#\d+|#x[\da-fA-F]+|[a-zA-Z]+);/.test(text)) {
    text = text.replace(/<[^>]+>/g, ' ')
    text = decodeHtmlEntities(text)
  }
  return text
    .replace(/\u00a0/g, ' ')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/\n[ \t]+/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .replace(/[ \t]{2,}/g, ' ')
    .trim()
}

export function sleep(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export interface RssItem {
  title: string
  link: string
  description: string
  pubDate?: string
  categories: string[]
  georssPoint?: string
  georssFeatureName?: string
}

function tagText(block: string, tag: string): string {
  const m = block.match(new RegExp(`<${tag}[^>]*><!\\[CDATA\\[([\\s\\S]*?)\\]\\]><\\/${tag}>|<${tag}[^>]*>([\\s\\S]*?)<\\/${tag}>`, 'i'))
  return (m?.[1] ?? m?.[2] ?? '').trim()
}

/** Parseur RSS/Atom minimal sans dépendance. */
export function parseRssItems(xml: string): RssItem[] {
  const items: RssItem[] = []
  // RSS 2.0
  for (const m of xml.matchAll(/<item[\s\S]*?<\/item>/gi)) {
    const block = m[0]
    const title = stripHtml(tagText(block, 'title'))
    const link = stripHtml(tagText(block, 'link') || tagText(block, 'guid'))
    const description = stripHtml(tagText(block, 'description') || tagText(block, 'content:encoded'))
    const pubDate = tagText(block, 'pubDate') || undefined
    const categories = [...block.matchAll(/<category[^>]*>([\s\S]*?)<\/category>/gi)].map(c => stripHtml(c[1] || ''))
    const georssPoint = tagText(block, 'georss:point') || undefined
    const georssFeatureName = tagText(block, 'georss:featureName') || undefined
    if (title || link) {
      items.push({ title, link, description, pubDate, categories, georssPoint, georssFeatureName })
    }
  }
  if (items.length) return items
  // Atom
  for (const m of xml.matchAll(/<entry[\s\S]*?<\/entry>/gi)) {
    const block = m[0]
    const title = stripHtml(tagText(block, 'title'))
    const linkHref = block.match(/<link[^>]+href=["']([^"']+)["']/i)?.[1]
      || stripHtml(tagText(block, 'id'))
    const description = stripHtml(tagText(block, 'summary') || tagText(block, 'content'))
    const pubDate = tagText(block, 'published') || tagText(block, 'updated') || undefined
    if (title || linkHref) {
      items.push({
        title,
        link: linkHref || '',
        description,
        pubDate,
        categories: [],
      })
    }
  }
  return items
}

export function normalizeScraped(ev: ImportScrapedEvent): ImportScrapedEvent {
  const titleRaw = cleanPlainText(ev.title).slice(0, 160)
  const title = titleRaw.length >= 5 ? titleRaw : `${titleRaw} — événement`.slice(0, 160)
  const cityName = cleanPlainText(ev.cityName || 'Paris').slice(0, 120) || 'Paris'
  const locationName = cleanPlainText(ev.locationName || cityName).slice(0, 200) || cityName
  const description = ensureDescription(title, ev.description, cityName, ev.sourceUrl)
  const organizerName = ev.organizerName ? cleanPlainText(ev.organizerName).slice(0, 200) || null : null
  return {
    ...ev,
    title,
    description,
    cityName,
    locationName,
    organizerName,
    category: ev.category || categorize(title, description),
    endIsEstimated: ev.endIsEstimated !== false,
    timezone: ev.timezone || 'Europe/Paris',
  }
}
