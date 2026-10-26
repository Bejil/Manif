import { getAdminSession } from '../../utils/admin-auth'

export default defineEventHandler(async (event) => {
  const session = getAdminSession(event)
  if (!session) return { authenticated: false }
  return { authenticated: true, email: session.email }
})
