import slugify from 'slugify'

export function createEventSlug(title: string, cityName: string, dateIso: string | null): string {
  const datePart = dateIso ? dateIso.slice(0, 10) : 'date-a-venir'
  const base = slugify(`${title}-${cityName}-${datePart}`, {
    lower: true,
    strict: true,
    locale: 'fr',
  })
  return base.slice(0, 80) || `manif-${datePart}`
}

export function ensureUniqueSlug(base: string, existing: Set<string>): string {
  if (!existing.has(base)) return base
  let i = 2
  while (existing.has(`${base}-${i}`)) i++
  return `${base}-${i}`
}
