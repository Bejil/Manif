export const EVENT_CATEGORIES = [
  { id: 'social', label: 'Social / Solidarité' },
  { id: 'climat', label: 'Climat / Environnement' },
  { id: 'travail', label: 'Travail / Syndical' },
  { id: 'droits', label: 'Droits / Libertés' },
  { id: 'education', label: 'Éducation' },
  { id: 'sante', label: 'Santé' },
  { id: 'logement', label: 'Logement' },
  { id: 'agriculture', label: 'Agriculture / Ruralité' },
  { id: 'international', label: 'International / Paix' },
  { id: 'autre', label: 'Autre' },
] as const

export type EventCategoryId = (typeof EVENT_CATEGORIES)[number]['id']

export function categoryLabel(id: string): string {
  return EVENT_CATEGORIES.find(c => c.id === id)?.label ?? id
}
