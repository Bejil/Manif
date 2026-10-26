-- À exécuter dans le SQL Editor Supabase si la migration n’est pas encore appliquée.
ALTER TABLE event_submissions
  DROP CONSTRAINT IF EXISTS event_submissions_moderation_status_check;

ALTER TABLE event_submissions
  ADD CONSTRAINT event_submissions_moderation_status_check
  CHECK (moderation_status IN (
    'awaiting_verification',
    'pending_moderation',
    'changes_requested',
    'approved',
    'rejected'
  ));
