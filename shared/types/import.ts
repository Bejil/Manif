import type { EventCategoryId } from '../constants/categories'
import type { ImportModeId, ImportSourceId } from '../constants/import-sources'

export type ImportRunStatus =
  | 'pending'
  | 'running'
  | 'scraped'
  | 'applying'
  | 'completed'
  | 'failed'
  | 'cancelled'

export type ImportCandidateStatus =
  | 'pending'
  | 'duplicate'
  | 'ready'
  | 'applied'
  | 'skipped'
  | 'error'

export interface ImportScrapedEvent {
  source: ImportSourceId
  sourceUrl: string
  externalId?: string | null
  title: string
  description: string
  category: EventCategoryId
  cityName: string
  postalCode?: string | null
  locationName: string
  latitude?: number | null
  longitude?: number | null
  startAt: string | null
  endAt: string | null
  endIsEstimated?: boolean
  organizerName?: string | null
  timezone?: string
  raw?: Record<string, unknown>
}

export interface ImportRunProgress {
  /** Index de l’unité de travail courante (source ou lot Démosphère) */
  cursor: number
  /** Total d’unités (sources + lots) */
  totalUnits: number
  currentUnit?: string
  unitsDone: string[]
  message?: string
  /** Progression globale 0–100 (scrape → préparation → application) */
  percent?: number
  phase?: 'scrape' | 'prepare' | 'apply' | 'done'
}

export interface ImportRunStats {
  scraped: number
  /** Encore en attente de préparation (match + géocode). */
  pending?: number
  ready: number
  duplicates: number
  created: number
  updated: number
  skipped: number
  errors: number
  bySource: Partial<Record<ImportSourceId, number>>
}

export interface ImportRunRecord {
  id: string
  status: ImportRunStatus
  mode: ImportModeId
  sources: ImportSourceId[]
  options: {
    militantOnly?: boolean
    geocode?: boolean
    maxPerSource?: number
  }
  progress: ImportRunProgress
  stats: ImportRunStats
  errorMessage: string | null
  actorId: string | null
  startedAt: string | null
  finishedAt: string | null
  createdAt: string
  updatedAt: string
}

export interface ImportCandidateRecord {
  id: string
  runId: string
  source: ImportSourceId
  sourceUrl: string
  externalId: string | null
  title: string
  description: string
  category: EventCategoryId
  cityName: string
  postalCode: string | null
  locationName: string
  latitude: number | null
  longitude: number | null
  startAt: string | null
  endAt: string | null
  endIsEstimated: boolean
  organizerName: string | null
  timezone: string
  payload: Record<string, unknown>
  status: ImportCandidateStatus
  matchEventId: string | null
  appliedEventId: string | null
  errorMessage: string | null
  createdAt: string
  updatedAt: string
}
