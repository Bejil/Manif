import { badRequest, tooManyRequests } from '../../utils/errors'
import { checkRateLimit } from '../../utils/rate-limit'
import { getRequestIP } from 'h3'

export interface GeoSuggestItem {
  label: string
  cityName: string
  postalCode: string | null
  latitude: number
  longitude: number
}

/**
 * Autocomplete public (BAN) — villes uniquement (type municipality).
 */
export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const q = typeof query.q === 'string' ? query.q.trim() : ''
  if (q.length < 2) return { items: [] as GeoSuggestItem[] }
  if (q.length > 120) throw badRequest('Requête trop longue')

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({ key: `geo-suggest:${ip}`, limit: 60, windowMs: 60_000 })
  if (!rl.ok) throw tooManyRequests('Trop de recherches.')

  try {
    const res = await $fetch<{
      features?: Array<{
        properties: {
          label: string
          city?: string
          postcode?: string
          name?: string
          type?: string
        }
        geometry: { coordinates: [number, number] }
      }>
    }>('https://api-adresse.data.gouv.fr/search/', {
      query: {
        q,
        limit: 5,
        autocomplete: 1,
        type: 'municipality',
      },
      timeout: 6_000,
    })

    const items: GeoSuggestItem[] = (res.features || [])
      .filter(f => !f.properties.type || f.properties.type === 'municipality')
      .map((f) => {
        const [longitude, latitude] = f.geometry.coordinates
        const cityName = f.properties.city || f.properties.name || f.properties.label
        const postal = f.properties.postcode || null
        const label = postal ? `${cityName} (${postal})` : cityName
        return {
          label,
          cityName,
          postalCode: postal,
          latitude,
          longitude,
        }
      })

    return { items }
  }
  catch (e) {
    console.warn('[geo/suggest] BAN indisponible', e)
    return { items: [] as GeoSuggestItem[] }
  }
})

