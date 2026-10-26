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
    const res = await $fetch<{
      features?: Array<{
        properties: {
          label: string
          city?: string
          postcode?: string
        }
        geometry: { coordinates: [number, number] }
      }>
    }>('https://api-adresse.data.gouv.fr/search/', {
      query: { q, limit: 1, type: 'municipality' },
    })
    const feature = res.features?.[0]
    if (!feature) {
      cityCenterCache.set(key, null)
      return null
    }
    const [longitude, latitude] = feature.geometry.coordinates
    const postalCode = feature.properties.postcode ?? input.postalCode ?? null
    const resolvedCity = feature.properties.city || cityName
    const result: GeocodeResult = {
      latitude,
      longitude,
      cityName: resolvedCity,
      postalCode,
      label: feature.properties.label,
      timezone: timezoneFromPostalOrCity(postalCode, resolvedCity),
    }
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
 * Conditions d'utilisation : usage raisonnable, attribution recommandée.
 */
export async function geocodeFrenchPlace(input: {
  cityName: string
  locationName?: string
  postalCode?: string
}): Promise<GeocodeResult | null> {
  const q = [input.locationName, input.postalCode, input.cityName]
    .map(s => s?.trim())
    .filter(Boolean)
    .join(' ')
  try {
    const res = await $fetch<{
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
      query: {
        q,
        limit: 1,
      },
    })

    let feature = res.features?.[0]
    if (!feature) {
      const cityQ = [input.postalCode, input.cityName].filter(Boolean).join(' ')
      const cityRes = await $fetch<typeof res>('https://api-adresse.data.gouv.fr/search/', {
        query: { q: cityQ || input.cityName, limit: 1, type: 'municipality' },
      })
      feature = cityRes.features?.[0]
    }
    if (!feature) return null

    const [longitude, latitude] = feature.geometry.coordinates
    const postalCode = feature.properties.postcode ?? null
    const cityName = feature.properties.city || input.cityName

    return {
      latitude,
      longitude,
      cityName,
      postalCode,
      label: feature.properties.label,
      timezone: timezoneFromPostalOrCity(postalCode, cityName),
    }
  }
  catch (error) {
    console.warn('[geocoding] échec BAN', error)
    return null
  }
}
