import { requireAdmin } from '../../utils/admin-auth'
import { listAlertsAdmin } from '../../services/alerts-repository'
import type { AlertStatus } from '#shared/constants/alerts'

const STATUSES = new Set(['pending', 'active', 'unsubscribed', 'all'])

export default defineEventHandler(async (event) => {
  requireAdmin(event)
  const query = getQuery(event)
  const raw = typeof query.status === 'string' ? query.status : 'all'
  const status = (STATUSES.has(raw) ? raw : 'all') as AlertStatus | 'all'
  return listAlertsAdmin({ status })
})
