export interface ImportFieldChange {
  field: string
  label: string
  before: string
  after: string
}

function norm(value: unknown): string {
  if (value == null || value === '') return '—'
  if (typeof value === 'number') return String(value)
  if (typeof value === 'boolean') return value ? 'oui' : 'non'
  return String(value).replace(/\s+/g, ' ').trim() || '—'
}

function sameText(a: unknown, b: unknown): boolean {
  return norm(a).toLowerCase() === norm(b).toLowerCase()
}

/**
 * Compare l’événement existant aux valeurs candidates / patchées.
 * Ne retourne que les champs réellement modifiés.
 */
export function diffImportUpdate(input: {
  before: {
    title: string
    description: string
    category: string
    cityName: string
    postalCode: string | null
    locationName: string
    latitude: number | null
    longitude: number | null
    startAt: string | null
    endAt: string | null
    endIsEstimated: boolean
    organizerName: string | null
    timezone: string
    sourceUrl: string | null
  }
  after: {
    title: string
    description: string
    category: string
    cityName: string
    postalCode: string | null
    locationName: string
    latitude: number | null
    longitude: number | null
    startAt: string | null
    endAt: string | null
    endIsEstimated: boolean
    organizerName: string | null
    timezone: string
    sourceUrl: string | null
  }
}): ImportFieldChange[] {
  const specs: Array<{
    field: string
    label: string
    before: unknown
    after: unknown
  }> = [
    { field: 'title', label: 'Titre', before: input.before.title, after: input.after.title },
    { field: 'description', label: 'Description', before: input.before.description, after: input.after.description },
    { field: 'category', label: 'Catégorie', before: input.before.category, after: input.after.category },
    { field: 'cityName', label: 'Ville', before: input.before.cityName, after: input.after.cityName },
    { field: 'postalCode', label: 'Code postal', before: input.before.postalCode, after: input.after.postalCode },
    { field: 'locationName', label: 'Lieu', before: input.before.locationName, after: input.after.locationName },
    { field: 'startAt', label: 'Début', before: input.before.startAt, after: input.after.startAt },
    { field: 'endAt', label: 'Fin', before: input.before.endAt, after: input.after.endAt },
    { field: 'organizerName', label: 'Organisateur', before: input.before.organizerName, after: input.after.organizerName },
    { field: 'timezone', label: 'Fuseau', before: input.before.timezone, after: input.after.timezone },
    { field: 'sourceUrl', label: 'Source', before: input.before.sourceUrl, after: input.after.sourceUrl },
    {
      field: 'coordinates',
      label: 'Coordonnées',
      before: input.before.latitude != null && input.before.longitude != null
        ? `${input.before.latitude}, ${input.before.longitude}`
        : null,
      after: input.after.latitude != null && input.after.longitude != null
        ? `${input.after.latitude}, ${input.after.longitude}`
        : null,
    },
  ]

  const changes: ImportFieldChange[] = []
  for (const s of specs) {
    if (sameText(s.before, s.after)) continue
    changes.push({
      field: s.field,
      label: s.label,
      before: norm(s.before),
      after: norm(s.after),
    })
  }
  return changes
}

export function readImportChanges(payload: Record<string, unknown> | null | undefined): ImportFieldChange[] {
  const raw = payload?.changes
  if (!Array.isArray(raw)) return []
  return raw
    .filter((row): row is Record<string, unknown> => Boolean(row) && typeof row === 'object')
    .map(row => ({
      field: String(row.field || ''),
      label: String(row.label || row.field || 'Champ'),
      before: String(row.before ?? '—'),
      after: String(row.after ?? '—'),
    }))
    .filter(row => row.field)
}
