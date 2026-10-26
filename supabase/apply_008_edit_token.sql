-- À coller dans le SQL Editor Supabase si la migration 008 n’a pas été poussée
ALTER TABLE event_submissions
  ADD COLUMN IF NOT EXISTS edit_token_digest TEXT,
  ADD COLUMN IF NOT EXISTS edit_token_expires_at TIMESTAMPTZ;

CREATE INDEX IF NOT EXISTS idx_submissions_edit_token
  ON event_submissions (edit_token_digest)
  WHERE edit_token_digest IS NOT NULL;
