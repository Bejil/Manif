import type { AlertRadiusKm, AlertStatus } from '../constants/alerts'

export interface EventAlertRecord {
  id: string
  email: string
  locationLabel: string
  latitude: number
  longitude: number
  radiusKm: AlertRadiusKm
  status: AlertStatus
  confirmTokenDigest: string | null
  unsubscribeTokenDigest: string
  confirmedAt: string | null
  unsubscribedAt: string | null
  lastNotifiedAt: string | null
  createdAt: string
  updatedAt: string
}
