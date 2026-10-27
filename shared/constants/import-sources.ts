export const IMPORT_SOURCES = [
  {
    id: 'ami',
    label: 'Agenda Militant Indépendant',
    shortLabel: 'AMI',
    description: 'RSS + pages agendamilitant.org (Île-de-France / national)',
  },
  {
    id: 'demosphere',
    label: 'Démosphère',
    shortLabel: 'Démosphère',
    description: 'Flux RSS géolocalisés de toutes les instances régionales',
  },
  {
    id: 'manifs',
    label: 'Manifs.fr',
    shortLabel: 'Manifs.fr',
    description: 'Agenda national des manifestations à venir',
  },
  {
    id: 'manifradar',
    label: 'ManifRadar',
    shortLabel: 'ManifRadar',
    description: 'Manifestations déclarées (API publique Supabase)',
  },
  {
    id: 'mobilizon_xr',
    label: 'Mobilizon · Extinction Rebellion',
    shortLabel: 'Mobilizon XR',
    description: 'Actions climat via Mobilizon XR France',
  },
] as const

export function importSourceShortLabel(id: string): string {
  return IMPORT_SOURCES.find(s => s.id === id)?.shortLabel || id
}

export const IMPORT_RUN_STATUS_LABELS: Record<string, string> = {
  pending: 'En attente',
  running: 'En cours',
  scraped: 'Scrapé',
  applying: 'Écriture',
  completed: 'Terminé',
  failed: 'Échec',
  cancelled: 'Annulé',
}

export type ImportSourceId = (typeof IMPORT_SOURCES)[number]['id']

export const IMPORT_SOURCE_IDS = IMPORT_SOURCES.map(s => s.id)

export const IMPORT_MODES = [
  {
    id: 'draft',
    label: 'Brouillons',
    description: 'Écrit dans events mais invisible sur le site public (à publier ensuite)',
  },
  {
    id: 'published',
    label: 'Publiés',
    description: 'Visibles immédiatement sur l’agenda public',
  },
] as const

export type ImportModeId = (typeof IMPORT_MODES)[number]['id']
