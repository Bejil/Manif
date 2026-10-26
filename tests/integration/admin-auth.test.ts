import { describe, expect, it } from 'vitest'
import { createHmac } from 'node:crypto'

describe('admin session cookie signing', () => {
  it('rejette une signature altérée', () => {
    const secret = 'test-secret'
    const payload = Buffer.from(JSON.stringify({
      email: 'contact@manif.info',
      exp: Date.now() + 60_000,
      mode: 'hmac',
    })).toString('base64url')
    const sig = createHmac('sha256', secret).update(payload).digest('base64url')
    const forged = createHmac('sha256', 'other').update(payload).digest('base64url')
    expect(sig).not.toBe(forged)
    expect(sig.length).toBeGreaterThan(20)
  })
})
