import { DateTime } from 'luxon'
import { randomUUID } from 'node:crypto'
import type { EventRecord } from '#shared/types/event'
import type { EngagementRecord } from '#shared/types/engagement'
import type { EventSubmissionRecord } from '#shared/types/submission'
import type { EventAlertRecord } from '#shared/types/alert'
import type { ReportReasonId } from '#shared/constants/statuses'

export interface ReportRecord {
  id: string
  eventId: string
  reason: ReportReasonId
  details: string
  status: 'open' | 'in_progress' | 'resolved' | 'dismissed'
  createdAt: string
  resolvedAt: string | null
  adminNote: string | null
}

export interface AuditRecord {
  id: string
  action: string
  entityType: string
  entityId: string
  actorId: string
  metadata?: Record<string, unknown>
  createdAt: string
}

export interface MockStore {
  events: EventRecord[]
  submissions: EventSubmissionRecord[]
  engagements: EngagementRecord[]
  reports: ReportRecord[]
  audit: AuditRecord[]
  eventAlerts: EventAlertRecord[]
  /** Incrémente pour forcer un rechargement du seed en mémoire */
  seedVersion?: number
}

const SEED_VERSION = 7
const globalKey = '__manif_mock_store__'

function emptyStore(): MockStore {
  return {
    events: [],
    submissions: [],
    engagements: [],
    reports: [],
    audit: [],
    eventAlerts: [],
    seedVersion: 0,
  }
}

export function getMockStore(): MockStore {
  const g = globalThis as typeof globalThis & { [globalKey]?: MockStore }
  if (!g[globalKey]) {
    g[globalKey] = emptyStore()
  }
  const store = g[globalKey]!
  if (!store.eventAlerts) store.eventAlerts = []
  if (!store.engagements) store.engagements = []
  return store
}

export function resetMockStore() {
  const g = globalThis as typeof globalThis & { [globalKey]?: MockStore }
  g[globalKey] = emptyStore()
}

export function seedMockStore(events: EventRecord[]) {
  const store = getMockStore()
  const hasLegacyDemo = store.events.some(
    e => e.isDemo || /\bDÉMO\b|\bDEMO\b/i.test(e.title) || /^Données de démonstration/i.test(e.description),
  )
  if (store.events.length > 0 && store.seedVersion === SEED_VERSION && !hasLegacyDemo) return
  store.events = events.map(e => ({ ...e }))
  store.seedVersion = SEED_VERSION
}

export function newId(): string {
  return randomUUID()
}

export function nowIso(): string {
  return DateTime.utc().toISO()!
}
