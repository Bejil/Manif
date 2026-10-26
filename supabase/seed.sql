-- =============================================================================
-- Seed Manif' — événements de démarrage (traités comme données normales)
-- Dates relatives à now() pour conserver des statuts utiles
-- =============================================================================

TRUNCATE engagements, event_reports, event_submissions, admin_audit, erasure_requests, events CASCADE;

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, locality_code,
  country_code, timezone, location_name, latitude, longitude,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at
) VALUES
(
  '11111111-1111-4111-a111-111111111111',
  'marche-climat-paris-republique',
  'Marche pour le climat — République',
  'Rassemblement place de la République pour le climat. Parcours annoncé vers l’Hôtel de Ville.',
  'climat', 'Paris', '75011', '75111', 'FR', 'Europe/Paris',
  'Place de la République', 48.8676, 2.3631,
  now() + interval '5 days', now() + interval '5 days' + interval '3 hours', false,
  'Collectif Climat Paris', 'https://example.org/marche-climat-paris',
  'cross_checked', 'published', NULL, false, now()
),
(
  '22222222-2222-4222-a222-222222222222',
  'rassemblement-lyon-bellecour',
  'Rassemblement — Bellecour',
  'Rassemblement place Bellecour. Point de départ vers la Presqu’île.',
  'social', 'Lyon', '69002', '69382', 'FR', 'Europe/Paris',
  'Place Bellecour', 45.7578, 4.8320,
  now() - interval '1 hour', now() + interval '8 hours', false,
  NULL, 'https://example.org/rassemblement-lyon',
  'source_provided', 'published', NULL, false, now()
),
(
  '33333333-3333-4333-a333-333333333333',
  'manifestation-marseille-canebiere',
  'Manifestation — Canebière',
  'Manifestation sur la Canebière.',
  'travail', 'Marseille', '13001', '13201', 'FR', 'Europe/Paris',
  'La Canebière', 43.2965, 5.3800,
  now() - interval '3 days', now() - interval '3 days' + interval '2 hours', false,
  'Intersyndicale locale', NULL,
  'unconfirmed', 'published', NULL, false, now()
),
(
  '44444444-4444-4444-a444-444444444444',
  'manifestation-nantes-commerce-annulee',
  'Manifestation annulée — Commerce',
  'Cette manifestation a été annulée par les organisateurs.',
  'education', 'Nantes', '44000', '44109', 'FR', 'Europe/Paris',
  'Place du Commerce', 47.2133, -1.5555,
  now() + interval '10 days', NULL, true,
  NULL, 'https://example.org/nantes-commerce',
  'source_provided', 'published', 'cancelled', false, now()
),
(
  '99999999-9999-4999-a999-999999999999',
  'marche-reportee-strasbourg-kleber',
  'Marche reportée — Place Kléber',
  'Cette marche est reportée à une date ultérieure. La nouvelle date sera annoncée ici.',
  'droits', 'Strasbourg', '67000', '67482', 'FR', 'Europe/Paris',
  'Place Kléber', 48.5839, 7.7455,
  now() + interval '12 days', NULL, true,
  NULL, NULL,
  'source_provided', 'published', 'postponed', false, now()
),
(
  '55555555-5555-4555-a555-555555555555',
  'rassemblement-toulouse-capitole',
  'Rassemblement logement — Capitole',
  'Rassemblement pour le droit au logement place du Capitole.',
  'logement', 'Toulouse', '31000', '31555', 'FR', 'Europe/Paris',
  'Place du Capitole', NULL, NULL,
  now() + interval '7 days', NULL, true,
  'Association Droit au logement', NULL,
  'unconfirmed', 'published', NULL, false, now()
),
(
  '66666666-6666-4666-a666-666666666666',
  'rassemblement-saint-denis-reunion',
  'Rassemblement — Saint-Denis (La Réunion)',
  'Rassemblement au Barachois. Horaires en heure locale (Indian/Reunion).',
  'droits', 'Saint-Denis', '97400', '97411', 'FR', 'Indian/Reunion',
  'Barachois', -20.8789, 55.4481,
  (now() AT TIME ZONE 'Indian/Reunion' + interval '4 days'),
  (now() AT TIME ZONE 'Indian/Reunion' + interval '4 days' + interval '2 hours'),
  false, NULL, 'https://example.org/reunion-barachois',
  'cross_checked', 'published', NULL, false, now()
),
(
  '77777777-7777-4777-a777-777777777777',
  'marche-interpro-paris-date-a-venir',
  'Marche interprofessionnelle — date à confirmer',
  'Rassemblement annoncé à Paris. La date précise sera communiquée prochainement par les organisateurs.',
  'travail', 'Paris', '75001', '75101', 'FR', 'Europe/Paris',
  'Place de la République', 48.8676, 2.3631,
  NULL, NULL, true,
  NULL, NULL,
  'source_provided', 'published', NULL, false, now()
),
(
  '88888888-8888-4888-a888-888888888888',
  'rassemblement-climat-lyon-date-a-venir',
  'Rassemblement climat — date à venir',
  'Appel à rassemblement à Lyon. Horaires en cours de finalisation.',
  'climat', 'Lyon', '69002', '69382', 'FR', 'Europe/Paris',
  'Place Bellecour', 45.7578, 4.8320,
  NULL, NULL, true,
  'Collectif Climat Lyon', NULL,
  'unconfirmed', 'published', NULL, false, now()
);
