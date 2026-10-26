import { getMockStore } from './mock-store'
import { getServiceSupabase, useMockDb } from '../utils/supabase'

export interface AdminHistoryChange {
  field: string
  label: string
  before: string
  after: string
}

export interface AdminHistoryEntry {
  id: string
  action: string
  label: string
  detail: string | null
  changes: AdminHistoryChange[] | null
  actorId: string
  createdAt: string
}

const ACTION_LABELS: Record<string, string> = {
  'submission.changes_requested': 'Demande de modifications',
  'submission.resubmitted': 'Proposition mise à jour par le proposant',
  'submission.reject': 'Refus',
  'submission.approve': 'Approbation / publication',
  'submission.reopen': 'Remise en modération',
  'event.patch': 'Modification',
  'event.unpublish': 'Dépublication',
  'event.merge': 'Fusion',
  'event.delete': 'Suppression',
  'event.cancel': 'Annulation',
}

function labelFor(action: string): string {
  return ACTION_LABELS[action] || action
}

function changesFromMetadata(
  meta: Record<string, unknown> | null | undefined,
): AdminHistoryChange[] | null {
  const raw = meta?.changes
  if (!Array.isArray(raw) || !raw.length) return null
  const out: AdminHistoryChange[] = []
  for (const row of raw) {
    if (!row || typeof row !== 'object') continue
    const r = row as Record<string, unknown>
    if (typeof r.label !== 'string' || typeof r.before !== 'string' || typeof r.after !== 'string') continue
    out.push({
      field: typeof r.field === 'string' ? r.field : '',
      label: r.label,
      before: r.before,
      after: r.after,
    })
  }
  return out.length ? out : null
}

function detailFromMetadata(meta: Record<string, unknown> | null | undefined): string | null {
  if (!meta) return null
  const changes = changesFromMetadata(meta)
  if (changes?.length) {
    return changes
      .map(c => `${c.label} :\n  Avant : ${c.before || '(vide)'}\n  Après : ${c.after || '(vide)'}`)
      .join('\n\n')
  }
  const message = meta.message
  const reason = meta.reason
  if (typeof message === 'string' && message.trim()) return message.trim()
  if (typeof reason === 'string' && reason.trim()) return reason.trim()
  return null
}

function mapAuditRow(row: {
  id: string
  action: string
  actorId: string
  createdAt: string
  metadata?: Record<string, unknown> | null
}): AdminHistoryEntry {
  const meta = row.metadata ?? null
  return {
    id: row.id,
    action: row.action,
    label: labelFor(row.action),
    detail: detailFromMetadata(meta),
    changes: changesFromMetadata(meta),
    actorId: row.actorId,
    createdAt: row.createdAt,
  }
}

export async function listEntityHistory(
  entityType: string,
  entityId: string,
): Promise<AdminHistoryEntry[]> {
  if (useMockDb()) {
    return getMockStore().audit
      .filter(a => a.entityType === entityType && a.entityId === entityId)
      .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
      .map(a => mapAuditRow({
        id: a.id,
        action: a.action,
        actorId: a.actorId,
        createdAt: a.createdAt,
        metadata: a.metadata as Record<string, unknown> | undefined,
      }))
  }

  const supabase = getServiceSupabase()
  const { data, error } = await supabase
    .from('admin_audit')
    .select('id, action, actor_id, metadata, created_at')
    .eq('entity_type', entityType)
    .eq('entity_id', entityId)
    .order('created_at', { ascending: false })
    .limit(100)
  if (error) throw createError({ statusCode: 500, statusMessage: error.message })

  return (data ?? []).map(row => mapAuditRow({
    id: row.id as string,
    action: row.action as string,
    actorId: row.actor_id as string,
    createdAt: row.created_at as string,
    metadata: row.metadata as Record<string, unknown> | null,
  }))
}

/** Historique événement + proposition source (si publiée depuis une soumission). */
export async function listEventAdminHistory(eventId: string): Promise<AdminHistoryEntry[]> {
  const eventHistory = await listEntityHistory('event', eventId)

  let submissionId: string | null = null
  if (useMockDb()) {
    submissionId = getMockStore().submissions.find(s => s.publishedEventId === eventId)?.id ?? null
  }
  else {
    const supabase = getServiceSupabase()
    const { data } = await supabase
      .from('event_submissions')
      .select('id')
      .eq('published_event_id', eventId)
      .maybeSingle()
    submissionId = data?.id ?? null
  }

  const submissionHistory = submissionId
    ? await listEntityHistory('event_submission', submissionId)
    : []

  return [...eventHistory, ...submissionHistory]
    .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
}
