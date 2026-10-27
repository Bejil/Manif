import { z } from 'zod'

export const importRunCreateSchema = z.object({
  sources: z.array(z.enum([
    'ami',
    'demosphere',
    'manifs',
    'manifradar',
    'mobilizon_xr',
  ])).min(1),
  mode: z.enum(['draft', 'published']).default('draft'),
  militantOnly: z.boolean().default(true),
  geocode: z.boolean().default(true),
  maxPerSource: z.coerce.number().int().min(1).max(2000).optional(),
})

export const importApplySchema = z.object({
  candidateIds: z.array(z.string().uuid()).optional(),
  onlyReady: z.boolean().default(true),
  /** Forcer le statut de publication à l’application (défaut : published) */
  publicationStatus: z.enum(['draft', 'published']).default('published'),
})
