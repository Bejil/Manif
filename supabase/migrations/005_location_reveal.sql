-- Localisation différée : le lieu précis (nom + coords) peut n’être public
-- qu’à partir de location_reveal_at. NULL = toujours public.

ALTER TABLE events
  ADD COLUMN IF NOT EXISTS location_reveal_at TIMESTAMPTZ;

ALTER TABLE event_submissions
  ADD COLUMN IF NOT EXISTS location_reveal_hours_before INTEGER
    CHECK (
      location_reveal_hours_before IS NULL
      OR (location_reveal_hours_before >= 1 AND location_reveal_hours_before <= 336)
    );

COMMENT ON COLUMN events.location_reveal_at IS
  'Horodatage à partir duquel le lieu précis (nom + GPS) est public. NULL = immédiat.';

COMMENT ON COLUMN event_submissions.location_reveal_hours_before IS
  'Nombre d’heures avant le début avant de publier le lieu. NULL = immédiat.';

-- Exemples : restaurer un lieu réel + révélation différée (Toulouse)
UPDATE events SET
  location_name = 'Place du Capitole',
  latitude = 43.6045,
  longitude = 1.4440,
  location_reveal_at = start_at - interval '24 hours'
WHERE id = '55555555-5555-4555-a555-555555555555'
   OR slug ILIKE '%toulouse%capitole%';

-- Deux événements parisiens masqués jusqu’à J-1 / J-2
UPDATE events SET
  location_name = 'Place de la République',
  latitude = 48.8676,
  longitude = 2.3631,
  location_reveal_at = start_at - interval '48 hours'
WHERE slug = 'point-depart-secret-est';

UPDATE events SET
  location_name = 'Place de la Bastille',
  latitude = 48.8532,
  longitude = 2.3691,
  location_reveal_at = start_at - interval '24 hours'
WHERE slug = 'rendez-vous-rive-droite';
