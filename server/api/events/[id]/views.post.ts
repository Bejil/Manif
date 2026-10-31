import { getRequestIP } from 'h3'
import { getEventById, getEventBySlug, incrementEventViews } from '../../../services/events-repository'
import { notFound, tooManyRequests } from '../../../utils/errors'
import { checkRateLimit } from '../../../utils/rate-limit'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')
  if (!id) throw notFound()

  const ip = getRequestIP(event, { xForwardedFor: true }) || 'unknown'
  const rl = await checkRateLimit({
    key: `views:${ip}:${id}`,
    limit: 8,
    windowMs: 60_000,
  })
  if (!rl.ok) throw tooManyRequests()

  const isUuid = /^[0-9a-f-]{36}$/i.test(id)
  let eventId: string | null = null

  if (isUuid) {
    const record = await getEventById(id)
    if (!record || record.publicationStatus !== 'published') throw notFound('Manifestation introuvable')
    eventId = record.id
  }
  else {
    const pub = await getEventBySlug(id)
    if (!pub) throw notFound('Manifestation introuvable')
    eventId = pub.id
  }

  const views = await incrementEventViews(eventId)
  return { views }
})
