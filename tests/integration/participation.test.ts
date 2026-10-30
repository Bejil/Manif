import { beforeEach, describe, expect, it, vi } from 'vitest'
import { DateTime } from 'luxon'
import { createHash } from 'node:crypto'

vi.stubGlobal('useRuntimeConfig', () => ({
  public: { useMockDb: true, engagementsEnabled: true },
  participationTokenPepper: 'test-pepper',
  supabaseUrl: '',
  supabaseServiceRoleKey: '',
}))

vi.stubGlobal('createError', (opts: { statusCode?: number, statusMessage?: string }) => {
  const err = new Error(opts.statusMessage || 'Error') as Error & {
    statusCode?: number
    statusMessage?: string
  }
  err.statusCode = opts.statusCode
  err.statusMessage = opts.statusMessage
  return err
})

const { digestParticipationToken } = await import('../../server/utils/crypto')
const {
  resetMockStore,
  getMockStore,
  seedMockStore,
} = await import('../../server/services/mock-store')
const { buildDemoEvents } = await import('../../server/services/seed-data')
const {
  getEventCounts,
  upsertEngagement,
} = await import('../../server/services/engagements-repository')
const {
  canDeclareParticipation,
  resolveParticipationKind,
} = await import('../../shared/utils/event-time')

const pepper = 'test-pepper'

describe('engagements mock store', () => {
  beforeEach(() => {
    resetMockStore()
    seedMockStore(buildDemoEvents(DateTime.utc()))
  })

  async function act(
    eventId: string,
    token: string,
    action: 'support' | 'withdraw_support' | 'participate' | 'withdraw_participate',
  ) {
    return upsertEngagement({
      eventId,
      eventScopedToken: token,
      action,
      pepper,
      participationEnabled: true,
    })
  }

  it('1. soutient sans participer', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const res = await act(event.id, 'tok-support-only-aaaa', 'support')
    expect(res.state.supported).toBe(true)
    expect(res.state.participating).toBe(false)
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(1)
    expect(counts.participations).toBe(0)
  })

  it('2. participe sans soutenir', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const res = await act(event.id, 'tok-part-only-bbbbbb', 'participate')
    expect(res.state.supported).toBe(false)
    expect(res.state.participating).toBe(true)
    expect(res.state.participationKind).toBe('during')
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(0)
    expect(counts.participations).toBe(1)
  })

  it('3. soutient et participe — compteurs indépendants', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const token = 'tok-both-cccccccccccc'
    await act(event.id, token, 'support')
    await act(event.id, token, 'participate')
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(1)
    expect(counts.participations).toBe(1)
  })

  it('4. retire uniquement le soutien', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const token = 'tok-withdraw-support-'
    await act(event.id, token, 'support')
    await act(event.id, token, 'participate')
    const res = await act(event.id, token, 'withdraw_support')
    expect(res.state.supported).toBe(false)
    expect(res.state.participating).toBe(true)
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(0)
    expect(counts.participations).toBe(1)
  })

  it('5. retire uniquement la participation', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const token = 'tok-withdraw-part----'
    await act(event.id, token, 'support')
    await act(event.id, token, 'participate')
    const res = await act(event.id, token, 'withdraw_participate')
    expect(res.state.supported).toBe(true)
    expect(res.state.participating).toBe(false)
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(1)
    expect(counts.participations).toBe(0)
  })

  it('6–7. refuse une nouvelle participation après la fin', async () => {
    const past = getMockStore().events.find(e => e.cityName === 'Marseille')!
    expect(canDeclareParticipation({
      startAt: past.startAt,
      endAt: past.endAt,
      endIsEstimated: past.endIsEstimated,
      timezone: past.timezone,
      statusOverride: past.eventStatusOverride,
    })).toBe(false)
    await expect(act(past.id, 'tok-too-late-ddddddd', 'participate')).rejects.toMatchObject({
      statusCode: 400,
    })
  })

  it('8. une participation anticipée reste planned (pas une présence confirmée)', async () => {
    const upcoming = getMockStore().events.find(e => e.cityName === 'Paris')!
    expect(resolveParticipationKind({
      startAt: upcoming.startAt,
      endAt: upcoming.endAt,
      endIsEstimated: upcoming.endIsEstimated,
      timezone: upcoming.timezone,
      statusOverride: upcoming.eventStatusOverride,
    })).toBe('planned')
    const res = await act(upcoming.id, 'tok-planned-eeeeeeee', 'participate')
    expect(res.state.participationKind).toBe('planned')
    expect(res.state.participating).toBe(true)
  })

  it('9. déduplique et garde les compteurs cohérents', async () => {
    const event = getMockStore().events.find(e => e.cityName === 'Lyon')!
    const token = 'tok-idempotent-ggggg'
    await act(event.id, token, 'support')
    await act(event.id, token, 'support')
    await act(event.id, token, 'participate')
    await act(event.id, token, 'participate')
    expect(getMockStore().engagements.filter(e => e.eventId === event.id)).toHaveLength(1)
    const counts = await getEventCounts(event.id)
    expect(counts.supports).toBe(1)
    expect(counts.participations).toBe(1)
  })

  it('digest stable et distinct par événement', () => {
    const a = digestParticipationToken('e1', 'tok', 'pep')
    const b = digestParticipationToken('e1', 'tok', 'pep')
    const c = digestParticipationToken('e2', 'tok', 'pep')
    expect(a).toBe(b)
    expect(a).not.toBe(c)
    expect(a).toHaveLength(64)
    expect(createHash('sha256').update(`participation:e1:tok:pep`).digest('hex')).toBe(a)
  })
})
