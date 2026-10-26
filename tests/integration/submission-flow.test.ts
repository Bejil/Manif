import { beforeEach, describe, expect, it } from 'vitest'
import { DateTime } from 'luxon'
import { digestVerificationToken } from '../../server/utils/crypto'
import { resetMockStore, getMockStore, seedMockStore, newId, nowIso } from '../../server/services/mock-store'
import { buildDemoEvents } from '../../server/services/seed-data'
import { createEventSlug, ensureUniqueSlug } from '../../shared/utils/slug'
import { titleSimilarity } from '../../shared/utils/search'

describe('submission moderation flow (mock)', () => {
  beforeEach(() => {
    resetMockStore()
    seedMockStore(buildDemoEvents(DateTime.utc()))
  })

  it('passe de awaiting_verification à pending_moderation après verify', () => {
    const pepper = 'pep'
    const raw = 'verification-token-abcdefghijklmnop'
    const digest = digestVerificationToken(raw, pepper)
    const id = newId()
    getMockStore().submissions.push({
      id,
      title: 'Nouvelle manif test',
      description: 'Description suffisamment longue pour validation.',
      category: 'autre',
      cityName: 'Rennes',
      locationName: 'Place de la Mairie',
      startAt: DateTime.utc().plus({ days: 8 }).toISO()!,
      endAt: null,
      organizerName: null,
      sourceUrl: null,
      practicalInfo: null,
      proposerEmail: 'user@example.com',
      verificationStatus: 'pending',
      verificationTokenDigest: digest,
      verificationExpiresAt: DateTime.utc().plus({ hours: 24 }).toISO()!,
      moderationStatus: 'awaiting_verification',
      rejectionReason: null,
      publishedEventId: null,
      createdAt: nowIso(),
      updatedAt: nowIso(),
    })

    const s = getMockStore().submissions.find(x => x.id === id)!
    expect(digestVerificationToken(raw, pepper)).toBe(s.verificationTokenDigest)
    s.verificationStatus = 'verified'
    s.verificationTokenDigest = null
    s.moderationStatus = 'pending_moderation'

    expect(s.moderationStatus).toBe('pending_moderation')
    expect(s.proposerEmail).toBe('user@example.com')
  })

  it('détecte les doublons potentiels sans bloquer', () => {
    const existing = getMockStore().events.find(e => e.cityName === 'Paris')!
    const similar = titleSimilarity(existing.title, 'Marche pour le climat Paris centre')
    expect(similar).toBeGreaterThan(0.3)
  })

  it('génère un slug unique à la publication', () => {
    const slugs = new Set(getMockStore().events.map(e => e.slug))
    const base = createEventSlug('Test Unique', 'Nantes', '2026-12-01T10:00:00Z')
    const first = ensureUniqueSlug(base, slugs)
    slugs.add(first)
    const second = ensureUniqueSlug(base, slugs)
    expect(first).not.toBe(second)
  })
})
