-- À coller dans Supabase → SQL Editor (une seule fois)
-- 1) Autorise les dates à confirmer
-- 2) Ajoute deux manifestations d’exemple sans date

ALTER TABLE events
  ALTER COLUMN start_at DROP NOT NULL;

ALTER TABLE event_submissions
  ALTER COLUMN start_at DROP NOT NULL;

ALTER TABLE events DROP CONSTRAINT IF EXISTS events_end_after_start;
ALTER TABLE events ADD CONSTRAINT events_end_after_start CHECK (
  end_at IS NULL
  OR start_at IS NULL
  OR end_at > start_at
);

COMMENT ON COLUMN events.start_at IS
  'Début de la manifestation. NULL = date à confirmer (affichée « Date à venir »).';

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, locality_code,
  country_code, timezone, location_name, latitude, longitude,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  published_at
) VALUES
(
  '77777777-7777-4777-a777-777777777777',
  'marche-interpro-paris-date-a-venir',
  'Marche interprofessionnelle — date à confirmer',
  'Rassemblement annoncé à Paris. La date précise sera communiquée prochainement par les organisateurs.',
  'travail', 'Paris', '75001', '75101', 'FR', 'Europe/Paris',
  'Place de la République', 48.8676, 2.3631,
  NULL, NULL, true, NULL, NULL,
  'source_provided', 'published', NULL, now()
),
(
  '88888888-8888-4888-a888-888888888888',
  'rassemblement-climat-lyon-date-a-venir',
  'Rassemblement climat — date à venir',
  'Appel à rassemblement à Lyon. Horaires en cours de finalisation.',
  'climat', 'Lyon', '69002', '69382', 'FR', 'Europe/Paris',
  'Place Bellecour', 45.7578, 4.8320,
  NULL, NULL, true, 'Collectif Climat Lyon', NULL,
  'unconfirmed', 'published', NULL, now()
)
ON CONFLICT (id) DO NOTHING;
