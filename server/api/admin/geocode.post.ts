import { z } from 'zod'
import { requireAdmin } from '../../utils/admin-auth'
import { geocodeFrenchPlace } from '../../services/geocoding'
import { badRequest } from '../../utils/errors'

const bodySchema = z.object({
  cityName: z.string().trim().min(1),
  locationName: z.string().trim().optional(),
  postalCode: z.string().trim().optional(),
})

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const body = await readBody(event)
  const parsed = bodySchema.safeParse(body)
  if (!parsed.success) throw badRequest('Ville requise pour le géocodage')

  const result = await geocodeFrenchPlace({
    cityName: parsed.data.cityName,
    locationName: parsed.data.locationName,
    postalCode: parsed.data.postalCode,
  })

  if (!result) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Adresse introuvable — précisez le lieu ou la ville.',
    })
  }

  return result
})
