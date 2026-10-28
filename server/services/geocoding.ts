import { timezoneFromPostalOrCity } from '../utils/timezone'

export interface GeocodeResult {
  latitude: number
  longitude: number
  cityName: string
  postalCode: string | null
  label: string
  timezone: string
}

const cityCenterCache = new Map<string, GeocodeResult | null>()
const placeCache = new Map<string, GeocodeResult | null>()

const BAN_TIMEOUT_MS = 8_000

async function banSearch(query: Record<string, string | number>) {
  return $fetch<{
    features?: Array<{
      properties: {
        label: string
        city?: string
        postcode?: string
        citycode?: string
      }
      geometry: { coordinates: [number, number] }
    }>
  }>('https://api-adresse.data.gouv.fr/search/', {
    query,
    timeout: BAN_TIMEOUT_MS,
  })
}

function toResult(
  feature: {
    properties: { label: string, city?: string, postcode?: string }
    geometry: { coordinates: [number, number] }
  },
  fallbackCity: string,
  fallbackPostal?: string | null,
): GeocodeResult {
  const [longitude, latitude] = feature.geometry.coordinates
  const postalCode = feature.properties.postcode ?? fallbackPostal ?? null
  const cityName = feature.properties.city || fallbackCity
  return {
    latitude,
    longitude,
    cityName,
    postalCode,
    label: feature.properties.label,
    timezone: timezoneFromPostalOrCity(postalCode, cityName),
  }
}

/** Centre-ville (cache mémoire) — pour carte publique avant révélation du lieu. */
export async function geocodeCityCenter(input: {
  cityName: string
  postalCode?: string | null
}): Promise<GeocodeResult | null> {
  const cityName = input.cityName.trim()
  if (!cityName) return null
  const key = `${(input.postalCode || '').trim()}|${cityName.toLowerCase()}`
  if (cityCenterCache.has(key)) return cityCenterCache.get(key) ?? null

  try {
    const q = [input.postalCode?.trim(), cityName].filter(Boolean).join(' ')
    const res = await banSearch({ q, limit: 1, type: 'municipality' })
    const feature = res.features?.[0]
    if (!feature) {
      cityCenterCache.set(key, null)
      return null
    }
    const result = toResult(feature, cityName, input.postalCode)
    cityCenterCache.set(key, result)
    return result
  }
  catch (error) {
    console.warn('[geocoding] échec centre-ville', error)
    cityCenterCache.set(key, null)
    return null
  }
}

/**
 * Géocodage via API Adresse (BAN) — data.gouv.fr
 * Cache mémoire + timeout court pour ne pas bloquer les imports.
 */
export async function geocodeFrenchPlace(input: {
  cityName: string
  locationName?: string
  postalCode?: string
}): Promise<GeocodeResult | null> {
  const cityName = input.cityName.trim()
  if (!cityName) return null

  const locationName = input.locationName?.trim() || ''
  const postalCode = input.postalCode?.trim() || ''
  const cacheKey = `${postalCode}|${cityName.toLowerCase()}|${locationName.toLowerCase()}`
  if (placeCache.has(cacheKey)) return placeCache.get(cacheKey) ?? null

  // Lieu = ville seule → centre-ville (déjà caché)
  if (!locationName || locationName.toLowerCase() === cityName.toLowerCase()) {
    const center = await geocodeCityCenter({ cityName, postalCode: postalCode || null })
    placeCache.set(cacheKey, center)
    return center
  }

  try {
    const q = [locationName, postalCode, cityName].filter(Boolean).join(' ')
    const res = await banSearch({ q, limit: 1 })
    let feature = res.features?.[0]
    if (!feature) {
      const cityQ = [postalCode, cityName].filter(Boolean).join(' ')
      const cityRes = await banSearch({ q: cityQ || cityName, limit: 1, type: 'municipality' })
      feature = cityRes.features?.[0]
    }
    if (!feature) {
      placeCache.set(cacheKey, null)
      return null
    }
    const result = toResult(feature, cityName, postalCode || null)
    placeCache.set(cacheKey, result)
    return result
  }
  catch (error) {
    console.warn('[geocoding] échec BAN', error)
    placeCache.set(cacheKey, null)
    return null
  }
}
