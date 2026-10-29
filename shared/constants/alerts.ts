export const ALERT_RADIUS_KM = [5, 10, 25, 50, 100] as const

export type AlertRadiusKm = (typeof ALERT_RADIUS_KM)[number]

export const ALERT_RADIUS_OPTIONS: Array<{ value: AlertRadiusKm, label: string }> = [
  { value: 5, label: '5 km' },
  { value: 10, label: '10 km' },
  { value: 25, label: '25 km' },
  { value: 50, label: '50 km' },
  { value: 100, label: '100 km' },
]

export type AlertStatus = 'pending' | 'active' | 'unsubscribed'
