import { createHash, randomBytes, timingSafeEqual } from 'node:crypto'

export function randomToken(bytes = 32): string {
  return randomBytes(bytes).toString('base64url')
}

export function sha256Hex(value: string): string {
  return createHash('sha256').update(value, 'utf8').digest('hex')
}

/** Empreinte dérivée côté serveur pour un jeton de participation scoped à un événement */
export function digestParticipationToken(
  eventId: string,
  eventScopedToken: string,
  pepper: string,
): string {
  return sha256Hex(`participation:${eventId}:${eventScopedToken}:${pepper}`)
}

export function digestVerificationToken(token: string, pepper: string): string {
  return sha256Hex(`verify:${token}:${pepper}`)
}

export function digestEditToken(token: string, pepper: string): string {
  return sha256Hex(`edit:${token}:${pepper}`)
}

export function digestAlertConfirmToken(token: string, pepper: string): string {
  return sha256Hex(`alert-confirm:${token}:${pepper}`)
}

export function digestAlertUnsubscribeToken(token: string, pepper: string): string {
  return sha256Hex(`alert-unsub:${token}:${pepper}`)
}

export function safeEqualHex(a: string, b: string): boolean {
  try {
    const ba = Buffer.from(a, 'hex')
    const bb = Buffer.from(b, 'hex')
    if (ba.length !== bb.length) return false
    return timingSafeEqual(ba, bb)
  }
  catch {
    return false
  }
}
