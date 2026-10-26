import { getSubmissionForEdit } from '../../services/submissions-repository'
import { badRequest } from '../../utils/errors'

export default defineEventHandler(async (event) => {
  const token = String(getQuery(event).token || '')
  if (token.length < 20) throw badRequest('Jeton manquant')
  const config = useRuntimeConfig()
  return getSubmissionForEdit(token, config.participationTokenPepper)
})
