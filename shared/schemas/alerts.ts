import { z } from 'zod'
import { ALERT_RADIUS_KM } from '../constants/alerts'

export const alertSubscribeSchema = z.object({
  email: z.string().email().max(254),
  locationLabel: z.string().trim().min(2).max(200),
  latitude: z.number().min(-90).max(90),
  longitude: z.number().min(-180).max(180),
  radiusKm: z.number().refine(
    (n): n is typeof ALERT_RADIUS_KM[number] =>
      (ALERT_RADIUS_KM as readonly number[]).includes(n),
    { message: 'Rayon invalide' },
  ),
  turnstileToken: z.string().optional(),
})

export type AlertSubscribeInput = z.infer<typeof alertSubscribeSchema>
