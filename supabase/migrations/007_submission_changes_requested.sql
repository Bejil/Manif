-- Statut « modifications demandées » avant validation
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
