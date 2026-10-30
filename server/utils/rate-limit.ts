/**
 * Rate limiter : mémoire locale, avec backend Upstash Redis optionnel
 * (UPSTASH_REDIS_REST_URL + UPSTASH_REDIS_REST_TOKEN).
 */

interface Bucket {
  count: number
  resetAt: number
}

const buckets = new Map<string, Bucket>()

async function checkUpstash(options: {
  key: string
  limit: number
  windowMs: number
}): Promise<{ ok: boolean, remaining: number, resetAt: number } | null> {
  const url = process.env.UPSTASH_REDIS_REST_URL
  const token = process.env.UPSTASH_REDIS_REST_TOKEN
  if (!url || !token) return null

  const redisKey = `rl:${options.key}`
  const windowSec = Math.ceil(options.windowMs / 1000)

  try {
    const incr = await $fetch<{ result: number }>(`${url}/incr/${encodeURIComponent(redisKey)}`, {
      headers: { Authorization: `Bearer ${token}` },
    })
    if (incr.result === 1) {
      await $fetch(`${url}/expire/${encodeURIComponent(redisKey)}/${windowSec}`, {
        headers: { Authorization: `Bearer ${token}` },
      })
    }
    const ttl = await $fetch<{ result: number }>(`${url}/ttl/${encodeURIComponent(redisKey)}`, {
      headers: { Authorization: `Bearer ${token}` },
    })
    const resetAt = Date.now() + Math.max(ttl.result, 1) * 1000
    const ok = incr.result <= options.limit
    return {
      ok,
      remaining: Math.max(0, options.limit - incr.result),
      resetAt,
    }
  }
  catch (error) {
    console.warn('[rate-limit] Upstash indisponible, fallback mémoire', error)
    return null
  }
}

export async function checkRateLimit(options: {
  key: string
  limit: number
  windowMs: number
}): Promise<{ ok: boolean, remaining: number, resetAt: number }> {
  const remote = await checkUpstash(options)
  if (remote) return remote

  const now = Date.now()
  const existing = buckets.get(options.key)

  if (!existing || existing.resetAt <= now) {
    const resetAt = now + options.windowMs
    buckets.set(options.key, { count: 1, resetAt })
    return { ok: true, remaining: options.limit - 1, resetAt }
  }

  if (existing.count >= options.limit) {
    return { ok: false, remaining: 0, resetAt: existing.resetAt }
  }

  existing.count += 1
  return {
    ok: true,
    remaining: options.limit - existing.count,
    resetAt: existing.resetAt,
  }
}
