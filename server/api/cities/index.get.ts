import { listPublishedCities } from '../../services/events-repository'

/** Villes avec manifestations publiées (SEO + maillage). */
export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const limit = Math.min(100, Math.max(1, Number(query.limit) || 40))
  const onlyUpcoming = query.upcoming === '1' || query.upcoming === 'true'

  let cities = await listPublishedCities()
  if (onlyUpcoming) cities = cities.filter(c => c.upcoming > 0)

  return {
    items: cities.slice(0, limit),
    total: cities.length,
  }
})
