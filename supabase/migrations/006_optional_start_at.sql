-- Date optionnelle : une manifestation peut être publiée avant confirmation de la date.
ALTER TABLE events
  ALTER COLUMN start_at DROP NOT NULL;

ALTER TABLE event_submissions
  ALTER COLUMN start_at DROP NOT NULL;

-- Fin uniquement si début connu
ALTER TABLE events DROP CONSTRAINT IF EXISTS events_end_after_start;
ALTER TABLE events ADD CONSTRAINT events_end_after_start CHECK (
  end_at IS NULL
  OR start_at IS NULL
  OR end_at > start_at
);

COMMENT ON COLUMN events.start_at IS
  'Début de la manifestation. NULL = date à confirmer (affichée « Date à venir »).';
