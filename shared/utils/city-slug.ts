import slugify from 'slugify'

/** Slug URL pour une ville (ex. « Paris » → `paris`, « Saint-Étienne » → `saint-etienne`). */
export function createCitySlug(cityName: string): string {
  const slug = slugify(cityName.trim(), {
    lower: true,
    strict: true,
    locale: 'fr',
  })
  return slug || 'ville'
}

export function citySlugMatches(cityName: string, slug: string): boolean {
  return createCitySlug(cityName) === slug.trim().toLowerCase()
}
