import { clearAdminSession } from '../../utils/admin-auth'

export default defineEventHandler(async (event) => {
  clearAdminSession(event)
  return { ok: true }
})
