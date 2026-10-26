import type { ReportReasonId } from '#shared/constants/statuses'
import { computeDisplayStatus } from '#shared/utils/event-time'
import { getServiceSupabase, useMockDb } from '../utils/supabase'
import { getMockStore, newId, nowIso, seedMockStore } from './mock-store'
import { buildDemoEvents } from './seed-data'
import type { ReportRecord } from './mock-store'
import { getEventById, toPublic } from './events-repository'
import { getEventCounts } from './engagements-repository'

function ensureSeeded() {
  if (useMockDb()) seedMockStore(buildDemoEvents())
}

export type ReportWithEvent = ReportRecord & {
  event: {
    id: string
    slug: string
    title: string
    cityName: string
    publicationStatus: string
    displayStatus: string
    startAt: string | null
  } | null
}

async function attachEvent(report: ReportRecord): Promise<ReportWithEvent> {
  const record = await getEventById(report.eventId)
  if (!record) return { ...report, event: null }
  return {
    ...report,
    event: {
      id: record.id,
      slug: record.slug,
      title: record.title,
      cityName: record.cityName,
      publicationStatus: record.publicationStatus,
      displayStatus: computeDisplayStatus({
        startAt: record.startAt,
        endAt: record.endAt,
        endIsEstimated: record.endIsEstimated,
        timezone: record.timezone,
        statusOverride: record.eventStatusOverride,
      }),
      startAt: record.startAt,
    },
  }
}

export async function createReport(input: {
  eventId: string
  reason: ReportReasonId
  details: string
}) {
  ensureSeeded()
  const report: ReportRecord = {
    id: newId(),
    eventId: input.eventId,
    reason: input.reason,
    details: input.details,
    status: 'open',
    createdAt: nowIso(),
    resolvedAt: null,
    adminNote: null,
  }

  if (useMockDb()) {
    getMockStore().reports.push(report)
    return report
  }

  const supabase = getServiceSupabase()
  const { data, error } = await supabase.from('event_reports').insert({
    id: report.id,
    event_id: report.eventId,
    reason: report.reason,
    details: report.details,
    status: report.status,
  }).select('*').single()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  return {
    id: data.id,
    eventId: data.event_id,
    reason: data.reason,
    details: data.details,
    status: data.status,
    createdAt: data.created_at,
    resolvedAt: data.resolved_at,
    adminNote: data.admin_note,
  } as ReportRecord
}

export async function listReports(): Promise<ReportWithEvent[]> {
  ensureSeeded()
  let reports: ReportRecord[]
  if (useMockDb()) {
    reports = getMockStore().reports.slice().sort((a, b) => b.createdAt.localeCompare(a.createdAt))
  }
  else {
    const supabase = getServiceSupabase()
    const { data, error } = await supabase
      .from('event_reports')
      .select('*')
      .order('created_at', { ascending: false })
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    reports = (data ?? []).map(r => ({
      id: r.id as string,
      eventId: r.event_id as string,
      reason: r.reason as ReportReasonId,
      details: (r.details as string) || '',
      status: r.status as ReportRecord['status'],
      createdAt: r.created_at as string,
      resolvedAt: (r.resolved_at as string | null) ?? null,
      adminNote: (r.admin_note as string | null) ?? null,
    }))
  }
  return Promise.all(reports.map(attachEvent))
}

export async function getReportForAdmin(id: string) {
  ensureSeeded()
  let report: ReportRecord | null = null
  if (useMockDb()) {
    report = getMockStore().reports.find(r => r.id === id) ?? null
  }
  else {
    const supabase = getServiceSupabase()
    const { data, error } = await supabase.from('event_reports').select('*').eq('id', id).maybeSingle()
    if (error) throw createError({ statusCode: 500, statusMessage: error.message })
    if (data) {
      report = {
        id: data.id as string,
        eventId: data.event_id as string,
        reason: data.reason as ReportReasonId,
        details: (data.details as string) || '',
        status: data.status as ReportRecord['status'],
        createdAt: data.created_at as string,
        resolvedAt: (data.resolved_at as string | null) ?? null,
        adminNote: (data.admin_note as string | null) ?? null,
      }
    }
  }
  if (!report) return null

  const withEvent = await attachEvent(report)
  const record = await getEventById(report.eventId)
  const eventPublic = record
    ? toPublic(record, await getEventCounts(record.id), { maskLocation: false })
    : null

  return { ...withEvent, eventPublic }
}

export async function patchReport(
  id: string,
  patch: { status: ReportRecord['status'], adminNote?: string },
) {
  ensureSeeded()
  if (useMockDb()) {
    const report = getMockStore().reports.find(r => r.id === id)
    if (!report) return null
    report.status = patch.status
    if (patch.adminNote !== undefined) report.adminNote = patch.adminNote
    if (patch.status === 'resolved' || patch.status === 'dismissed') {
      report.resolvedAt = nowIso()
    }
    return report
  }
  const supabase = getServiceSupabase()
  const updates: Record<string, unknown> = { status: patch.status }
  if (patch.adminNote !== undefined) updates.admin_note = patch.adminNote
  if (patch.status === 'resolved' || patch.status === 'dismissed') {
    updates.resolved_at = nowIso()
  }
  const { data, error } = await supabase
    .from('event_reports')
    .update(updates)
    .eq('id', id)
    .select('*')
    .maybeSingle()
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })
  if (!data) return null
  return {
    id: data.id,
    eventId: data.event_id,
    reason: data.reason,
    details: data.details,
    status: data.status,
    createdAt: data.created_at,
    resolvedAt: data.resolved_at,
    adminNote: data.admin_note,
  } as ReportRecord
}

export async function countOpenReports() {
  const items = await listReports()
  return items.filter(r => r.status === 'open').length
}
