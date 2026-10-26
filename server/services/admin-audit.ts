import { getMockStore } from './mock-store'
import { getServiceSupabase, useMockDb } from '../utils/supabase'

export interface AdminHistoryEntry {
  id: string
  action: string
  label: string
  detail: string | null
  actorId: string
  createdAt: string
}

const ACTION_LABELS: Record<string, string> = {
  'submission.changes_requested': 'Demande de modifications',
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

function detailFromMetadata(meta: Record<string, unknown> | null | undefined): string | null {
  if (!meta) return null
  const message = meta.message
  const reason = meta.reason
  if (typeof message === 'string' && message.trim()) return message.trim()
  if (typeof reason === 'string' && reason.trim()) return reason.trim()
  return null
}

export async function listEntityHistory(
  entityType: string,
  entityId: string,
): Promise<AdminHistoryEntry[]> {
  if (useMockDb()) {
    return getMockStore().audit
      .filter(a => a.entityType === entityType && a.entityId === entityId)
      .sort((a, b) => b.createdAt.localeCompare(a.createdAt))
      .map(a => ({
        id: a.id,
        action: a.action,
        label: labelFor(a.action),
        detail: detailFromMetadata(a.metadata as Record<string, unknown> | undefined),
        actorId: a.actorId,
        createdAt: a.createdAt,
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

  return (data ?? []).map(row => ({
    id: row.id as string,
    action: row.action as string,
    label: labelFor(row.action as string),
    detail: detailFromMetadata(row.metadata as Record<string, unknown> | null),
    actorId: row.actor_id as string,
    createdAt: row.created_at as string,
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
