import type { EventPublic } from '#shared/types/event'
import { categoryLabel } from '#shared/constants/categories'
import { listAllEventsAdmin } from './events-repository'

export type AdminStatEventRow = {
  id: string
  slug: string
  title: string
  cityName: string
  category: string
  categoryLabel: string
  displayStatus: EventPublic['displayStatus']
  publicationStatus: EventPublic['publicationStatus']
  startAt: string | null
  views: number
  supports: number
  participations: number
  engagement: number
}

export type AdminNamedCount = {
  key: string
  label: string
  count: number
  views: number
  supports: number
  participations: number
}

function toRow(e: EventPublic): AdminStatEventRow {
  const views = e.counts.views ?? 0
  const supports = e.counts.supports ?? 0
  const participations = e.counts.participations ?? 0
  return {
    id: e.id,
    slug: e.slug,
    title: e.title,
    cityName: e.cityName,
    category: e.category,
    categoryLabel: categoryLabel(e.category),
    displayStatus: e.displayStatus,
    publicationStatus: e.publicationStatus,
    startAt: e.startAt,
    views,
    supports,
    participations,
    engagement: supports + participations,
  }
}

function topBy(
  rows: AdminStatEventRow[],
  key: 'views' | 'supports' | 'participations' | 'engagement',
  limit: number,
) {
  return [...rows]
    .filter(r => r[key] > 0)
    .sort((a, b) => b[key] - a[key] || a.title.localeCompare(b.title, 'fr'))
    .slice(0, limit)
}

function aggregateBy(
  rows: AdminStatEventRow[],
  pick: (r: AdminStatEventRow) => { key: string, label: string },
  limit: number,
): AdminNamedCount[] {
  const map = new Map<string, AdminNamedCount>()
  for (const r of rows) {
    const { key, label } = pick(r)
    const cur = map.get(key) ?? {
      key,
      label,
      count: 0,
      views: 0,
      supports: 0,
      participations: 0,
    }
    cur.count += 1
    cur.views += r.views
    cur.supports += r.supports
    cur.participations += r.participations
    map.set(key, cur)
  }
  return [...map.values()]
    .sort((a, b) => b.count - a.count || a.label.localeCompare(b.label, 'fr'))
    .slice(0, limit)
}

export function buildAdminStatsFromEvents(
  all: EventPublic[],
  opts: { topLimit?: number } = {},
) {
  const limit = Math.min(50, Math.max(5, opts.topLimit ?? 15))
  const published = all.filter(e => e.publicationStatus === 'published')
  const rows = published.map(toRow)

  let views = 0
  let supports = 0
  let participations = 0
  let withViews = 0
  let withSupports = 0
  let withParticipations = 0
  for (const r of rows) {
    views += r.views
    supports += r.supports
    participations += r.participations
    if (r.views > 0) withViews += 1
    if (r.supports > 0) withSupports += 1
    if (r.participations > 0) withParticipations += 1
  }

  return {
    totals: {
      published: rows.length,
      views,
      supports,
      participations,
      engagement: supports + participations,
      withViews,
      withSupports,
      withParticipations,
      avgViews: rows.length ? Math.round(views / rows.length) : 0,
      avgSupports: rows.length ? Math.round((supports / rows.length) * 10) / 10 : 0,
      avgParticipations: rows.length ? Math.round((participations / rows.length) * 10) / 10 : 0,
    },
    topViews: topBy(rows, 'views', limit),
    topSupports: topBy(rows, 'supports', limit),
    topParticipations: topBy(rows, 'participations', limit),
    topEngagement: topBy(rows, 'engagement', limit),
    byCity: aggregateBy(rows, r => ({ key: r.cityName, label: r.cityName }), limit),
    byCategory: aggregateBy(
      rows,
      r => ({ key: r.category, label: r.categoryLabel }),
      20,
    ),
  }
}

export async function buildAdminStats(opts: { topLimit?: number } = {}) {
  const all = await listAllEventsAdmin()
  return buildAdminStatsFromEvents(all, opts)
}

/** Aperçu compact pour le tableau de bord (réutilise la liste déjà chargée). */
export function buildDashboardHighlights(all: EventPublic[], top = 5) {
  const stats = buildAdminStatsFromEvents(all, { topLimit: top })
  return {
    views: stats.totals.views,
    supports: stats.totals.supports,
    participations: stats.totals.participations,
    avgViews: stats.totals.avgViews,
    withViews: stats.totals.withViews,
    topViews: stats.topViews,
    topSupports: stats.topSupports,
    topParticipations: stats.topParticipations,
    topCities: stats.byCity.slice(0, top),
    topCategories: stats.byCategory.slice(0, top),
  }
}
