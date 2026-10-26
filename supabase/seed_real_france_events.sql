-- Manif' — événements RÉELS partout en France (agendas Démosphère)
-- Généré le 2026-10-26T22:37:43.031140+01:00 — horizon 60 jours — 450 événements
-- 22 agendas · 141 villes/lieux
-- GPS : georss Démosphère ou BAN (api-adresse.data.gouv.fr)
-- Descriptions factuelles + source_url. Validation éditoriale recommandée avant prod « sensible ».

DELETE FROM events WHERE slug LIKE 'ds-%' AND source_url LIKE 'https://%.demosphere.%';

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6c7299ea-5dad-4924-86a1-488790d6f320',
  'ds-akira-projection-du-film-culte-20261026-montrejeau-0',
  'Akira ! projection du film culte !',
  'Événement annoncé : Akira ! projection du film culte !. Lieu indiqué : Montréjeau (Montréjeau). Début prévu le 26/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montréjeau',
  NULL,
  'FR', 'Europe/Paris',
  'Montréjeau',
  43.084698, 0.571318, NULL,
  '2026-10-26T19:00:00Z'::timestamptz,
  '2026-10-26T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52482',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '50d73f0a-0756-4325-9399-5f7a88c2524a',
  'ds-vacances-d-automne-et-sism-au-musee-20261027-st-gaudens-1',
  'Vacances d''automne et SISM au musée',
  'Événement annoncé : Vacances d''automne et SISM au musée. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 27/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.107268, 0.725672, NULL,
  '2026-10-27T09:00:00Z'::timestamptz,
  '2026-10-27T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52037',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b321bacf-ab74-4a17-b018-f83031a3cacb',
  'ds-journee-stage-cirque-pour-les-6-7-ans-20261027-cazeres-2',
  'Journée stage cirque pour les 6-7 ans',
  'Événement annoncé : Journée stage cirque pour les 6-7 ans. Lieu indiqué : Cazères (Cazères). Début prévu le 27/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.20722, 1.078087, NULL,
  '2026-10-27T09:00:00Z'::timestamptz,
  '2026-10-27T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52343',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c171b2ca-9fb7-475f-93b4-2312b6b32cd2',
  'ds-cours-d-espagnol-pour-debutants-faux-debutants-aux-ateliers-du-temps-l-20261027-aspet-3',
  'Cours d''espagnol pour débutants - faux débutants aux Ateliers du Temps Libre ( EVS)',
  'Événement annoncé : Cours d''espagnol pour débutants - faux débutants aux Ateliers du Temps Libre ( EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 27/10/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-27T09:30:00Z'::timestamptz,
  '2026-10-27T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51706',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2991b6a3-c912-4c70-90d9-0972fee04245',
  'ds-atelier-parure-prehistorique-20261027-aurignac-4',
  'Atelier Parure préhistorique',
  'Événement annoncé : Atelier Parure préhistorique. Lieu indiqué : Aurignac (Aurignac). Début prévu le 27/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-27T10:00:00Z'::timestamptz,
  '2026-10-27T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52329',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f9a78f12-25cf-4606-ab79-025a9980b169',
  'ds-1h-d-escalade-pour-les-enfants-de-3-a-5-ans-accessible-a-tous-20261027-labroquere-5',
  '1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.',
  'Événement annoncé : 1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 27/10/2026 à 11:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-27T10:30:00Z'::timestamptz,
  '2026-10-27T13:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52453',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e3b0caf2-b6ab-4182-9844-7d55235a4897',
  'ds-2h-d-escalade-pour-les-enfants-de-6-a-9-ans-accessible-a-tout-les-nive-20261027-labroquere-6',
  '2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 27/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-27T12:30:00Z'::timestamptz,
  '2026-10-27T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52458',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4ab59e42-6bb0-438f-8d53-8c83eec75e42',
  'ds-pour-les-vacances-plongeons-dans-l-ambiance-d-halloween-avec-cet-ateli-20261027-st-gaudens-7',
  'Pour les vacances, plongeons dans l’ambiance d’Halloween avec cet atelier créatif',
  'Événement annoncé : Pour les vacances, plongeons dans l’ambiance d’Halloween avec cet atelier créatif. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 27/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.109731, 0.728335, NULL,
  '2026-10-27T13:30:00Z'::timestamptz,
  '2026-10-27T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/50181',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eba2a0a7-f43b-4362-a56a-f3cc4bd45b2b',
  'ds-visite-commentee-du-musee-de-prehistoire-20261027-aurignac-8',
  'Visite commentée du Musée de Préhistoire',
  'Événement annoncé : Visite commentée du Musée de Préhistoire. Lieu indiqué : Aurignac (Aurignac). Début prévu le 27/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-27T13:30:00Z'::timestamptz,
  '2026-10-27T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52253',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '210620df-7d81-4a34-8a20-d7f618dcd06d',
  'ds-cours-d-aquarelle-intermediaires-20261027-aurignac-9',
  'Cours d''aquarelle - Intermédiaires',
  'Événement annoncé : Cours d''aquarelle - Intermédiaires. Lieu indiqué : Aurignac (Aurignac). Début prévu le 27/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-27T14:30:00Z'::timestamptz,
  '2026-10-27T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51714',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c6ff3454-6bad-489d-806c-e242df7eba16',
  'ds-cours-d-espagnol-pour-niveau-avance-aux-ateliers-du-temps-libre-evs-20261027-aspet-10',
  'Cours d''espagnol pour niveau avancé aux Ateliers du Temps Libre ( EVS)',
  'Événement annoncé : Cours d''espagnol pour niveau avancé aux Ateliers du Temps Libre ( EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 27/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-27T14:30:00Z'::timestamptz,
  '2026-10-27T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51715',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4e7117be-bf42-4f07-89ab-58a2c1a59207',
  'ds-2h-d-escalade-pour-les-jeunes-de-10-a-16-ans-accessible-a-tout-les-niv-20261027-labroquere-11',
  '2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 27/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-27T14:30:00Z'::timestamptz,
  '2026-10-27T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52461',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3444084a-6547-449e-95db-98d1ccede822',
  'ds-atelier-parure-prehistorique-20261027-aurignac-12',
  'Atelier Parure préhistorique',
  'Événement annoncé : Atelier Parure préhistorique. Lieu indiqué : Aurignac (Aurignac). Début prévu le 27/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-27T15:00:00Z'::timestamptz,
  '2026-10-27T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52330',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '05db4113-be8e-49c2-b4c4-94764662ed12',
  'ds-earlydoors-echange-linguistique-anglais-francais-aux-ateliers-du-temps-20261027-aspet-13',
  'Earlydoors échange linguistique anglais / français aux Ateliers du Temps Libre (EVS)',
  'Événement annoncé : Earlydoors échange linguistique anglais / français aux Ateliers du Temps Libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/50730',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8e26ab51-e9be-4ae0-8874-e00db441e537',
  'ds-1h30-d-escalade-pour-les-adultes-a-partir-de-16-ans-20261027-labroquere-14',
  '1h30 d''escalade pour les adultes à partir de 16 ans.',
  'Événement annoncé : 1h30 d''escalade pour les adultes à partir de 16 ans.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52466',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e14e1731-ecac-4c40-8aeb-613963ab86a7',
  'ds-spectacles-au-cinema-mylene-farmer-egregore-20261027-st-gaudens-15',
  'Spectacles au cinéma // MYLENE FARMER - EGREGORE',
  'Événement annoncé : Spectacles au cinéma // MYLENE FARMER - EGREGORE. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 27/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108465, 0.718753, NULL,
  '2026-10-27T19:00:00Z'::timestamptz,
  '2026-10-27T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51308',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7105cf6c-223f-484e-82cd-d859102aeb24',
  'ds-cine-rencontre-louve-une-vie-dans-les-alpes-20261027-lourdes-16',
  'Ciné-rencontre : Louve une vie dans les Alpes',
  'Événement annoncé : Ciné-rencontre : Louve une vie dans les Alpes. Lieu indiqué : Lourdes (Lourdes). Début prévu le 27/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lourdes',
  NULL,
  'FR', 'Europe/Paris',
  'Lourdes',
  43.095096, -0.049985, NULL,
  '2026-10-27T19:00:00Z'::timestamptz,
  '2026-10-27T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52186',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '758737c6-56b4-4091-a0b0-32bc8575ef49',
  'ds-atelier-chants-polyphoniques-pyreneens-20261027-montrejeau-17',
  'Atelier chants polyphoniques pyrénéens',
  'Événement annoncé : Atelier chants polyphoniques pyrénéens. Lieu indiqué : Montréjeau (Montréjeau). Début prévu le 27/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montréjeau',
  NULL,
  'FR', 'Europe/Paris',
  'Montréjeau',
  43.084147, 0.562907, NULL,
  '2026-10-27T19:00:00Z'::timestamptz,
  '2026-10-27T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52686',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '021aa533-f5e9-4910-9c02-77430660509e',
  'ds-projection-du-film-outrepasser-sur-les-resistances-pyreneennes-20261027-lannemezan-18',
  'Projection du film "Outrepasser" sur les résistances pyrénéennes',
  'Événement annoncé : Projection du film "Outrepasser" sur les résistances pyrénéennes. Lieu indiqué : Lannemezan (Lannemezan). Début prévu le 27/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lannemezan',
  NULL,
  'FR', 'Europe/Paris',
  'Lannemezan',
  43.127097, 0.383186, NULL,
  '2026-10-27T20:00:00Z'::timestamptz,
  '2026-10-27T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52345',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e213011e-f4a7-4267-a250-6ef08e05793a',
  'ds-cours-de-francais-langue-etrangere-aux-ateliers-du-temps-libre-evs-20261028-aspet-19',
  'Cours de Français Langue Etrangère aux Ateliers du Temps Libre (EVS)',
  'Événement annoncé : Cours de Français Langue Etrangère aux Ateliers du Temps Libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 28/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-28T08:00:00Z'::timestamptz,
  '2026-10-28T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51724',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ef1e9f79-d923-4fe6-8538-e36371c258d2',
  'ds-la-bulle-vous-accueille-de-9h-a-13h-20261028-boulogne-sur-gesse-20',
  'La Bulle vous accueille de 9h à 13h',
  'Événement annoncé : La Bulle vous accueille de 9h à 13h. Lieu indiqué : Boulogne-sur-Gesse (Boulogne-sur-Gesse). Début prévu le 28/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Boulogne-sur-Gesse',
  NULL,
  'FR', 'Europe/Paris',
  'Boulogne-sur-Gesse',
  43.289489, 0.646166, NULL,
  '2026-10-28T08:00:00Z'::timestamptz,
  '2026-10-28T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52659',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1c1e27af-8b79-4798-a1a5-4ff28bead009',
  'ds-gymnastique-chaque-mercredi-20261028-antichan-de-frontignes-21',
  'Gymnastique chaque mercredi',
  'Événement annoncé : Gymnastique chaque mercredi. Lieu indiqué : Antichan-de-Frontignes (Antichan-de-Frontignes). Début prévu le 28/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Antichan-de-Frontignes',
  NULL,
  'FR', 'Europe/Paris',
  'Antichan-de-Frontignes',
  42.973699, 0.667812, NULL,
  '2026-10-28T08:30:00Z'::timestamptz,
  '2026-10-28T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51725',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8fca5a08-fa48-4214-bf01-160f12bb2f71',
  'ds-bapteme-en-attelage-canin-du-20-au-30-octobre-venez-decouvrir-le-canik-20261028-station-le-mourti',
  'Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart',
  'Événement annoncé : Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart. Lieu indiqué : Station Le Mourtis (Station Le Mourtis). Début prévu le 28/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Station Le Mourtis',
  NULL,
  'FR', 'Europe/Paris',
  'Station Le Mourtis',
  42.912459, 0.768403, NULL,
  '2026-10-28T08:30:00Z'::timestamptz,
  '2026-10-28T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52276',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0891bb1c-cf54-4caf-a299-ca39e67065bf',
  'ds-atelier-mosaique-me-mo-realisation-d-un-tableau-en-mosaique-20261028-st-bertrand-de-comminges-23',
  'Atelier mosaïque - ME.MO - Réalisation d''un tableau en mosaïque',
  'Événement annoncé : Atelier mosaïque - ME.MO - Réalisation d''un tableau en mosaïque. Lieu indiqué : St-Bertrand-de-Comminges (St-Bertrand-de-Comminges). Début prévu le 28/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Bertrand-de-Comminges',
  NULL,
  'FR', 'Europe/Paris',
  'St-Bertrand-de-Comminges',
  43.026621, 0.57086, NULL,
  '2026-10-28T09:00:00Z'::timestamptz,
  '2026-10-28T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/45146',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cba7602c-3d3a-4b39-9cef-07494dbde0c1',
  'ds-stage-video-et-dessin-pour-les-6-12-ans-20261028-st-gaudens-24',
  '🖍️ Stage vidéo et dessin - pour les 6-12 ans',
  'Événement annoncé : 🖍️ Stage vidéo et dessin - pour les 6-12 ans. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 28/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.106437, 0.719842, NULL,
  '2026-10-28T09:00:00Z'::timestamptz,
  '2026-10-28T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52146',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '51c83bfb-b8b3-4f76-8aaa-5b3c622b5460',
  'ds-cours-de-francais-langue-etrangere-niv-intermediaire-ateliers-du-temps-20261028-aspet-25',
  'Cours de Français Langue Etrangère niv. intermédiaire Ateliers du temps Libre (EVS)',
  'Événement annoncé : Cours de Français Langue Etrangère niv. intermédiaire Ateliers du temps Libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 28/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-28T10:00:00Z'::timestamptz,
  '2026-10-28T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51727',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c5d70ed3-381c-4026-835b-8c5e327af231',
  'ds-atelier-animaux-d-argile-modelage-20261028-aurignac-26',
  'Atelier Animaux d''argile - modelage',
  'Événement annoncé : Atelier Animaux d''argile - modelage. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-28T10:00:00Z'::timestamptz,
  '2026-10-28T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52332',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c898fe50-2130-447d-996d-e27972c2df41',
  'ds-1h-d-escalade-pour-les-enfants-de-3-a-5-ans-accessible-a-tous-20261028-labroquere-27',
  '1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.',
  'Événement annoncé : 1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 28/10/2026 à 11:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-28T10:30:00Z'::timestamptz,
  '2026-10-28T13:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52455',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0f6e04ec-a743-4b94-b20a-2d696e579d36',
  'ds-permanence-du-planning-familial-20261028-st-gaudens-28',
  'Permanence du Planning Familial',
  'Événement annoncé : Permanence du Planning Familial. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 28/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.105992, 0.719006, NULL,
  '2026-10-28T12:30:00Z'::timestamptz,
  '2026-10-28T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51571',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '142ffee9-4a11-4bf8-b2db-75dbf98494d4',
  'ds-2h-d-escalade-pour-les-enfants-de-6-a-9-ans-accessible-a-tout-les-nive-20261028-labroquere-29',
  '2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 28/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-28T12:30:00Z'::timestamptz,
  '2026-10-28T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52459',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd861562b-9044-457a-9d87-c198d6aec9ac',
  'ds-atelier-mosaique-me-mo-realisation-d-un-tableau-en-mosaique-20261028-st-bertrand-de-comminges-30',
  'Atelier mosaïque - ME.MO - Réalisation d''un tableau en mosaïque',
  'Événement annoncé : Atelier mosaïque - ME.MO - Réalisation d''un tableau en mosaïque. Lieu indiqué : St-Bertrand-de-Comminges (St-Bertrand-de-Comminges). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Bertrand-de-Comminges',
  NULL,
  'FR', 'Europe/Paris',
  'St-Bertrand-de-Comminges',
  43.026621, 0.57086, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/45160',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7c56fa80-be7a-4419-a322-dc750ceadb69',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261028-tarbes-31',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : Tarbes (Tarbes). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234341, 0.072931, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51733',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4659ef7d-3806-4aa3-92c8-2265156b9d76',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261028-st-gaudens-32',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108094, 0.722677, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52370',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd4b5d424-817d-4db1-9bd7-d6028a1ca0db',
  'ds-apres-midi-cirque-en-famille-enfants-a-partir-de-3-ans-20261028-cazeres-33',
  'Après-midi cirque en famille - enfants à partir de 3 ans',
  'Événement annoncé : Après-midi cirque en famille - enfants à partir de 3 ans. Lieu indiqué : Cazères (Cazères). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.20722, 1.078087, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52377',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7c45539c-190e-48f8-9020-4999f29bc2d6',
  'ds-cafe-tricot-aux-ateliers-du-temps-libre-evs-20261028-aspet-34',
  'Café tricot aux Ateliers du Temps Libre (EVS)',
  'Événement annoncé : Café tricot aux Ateliers du Temps Libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 28/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-28T13:30:00Z'::timestamptz,
  '2026-10-28T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51734',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c3a3acf1-279b-4811-b42c-91a0c440c3c8',
  'ds-boxe-anglaise-asl-20261026-france-35',
  'Boxe Anglaise // ASL',
  'Événement annoncé : Boxe Anglaise // ASL. Lieu indiqué : Gare (France). Début prévu le 26/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-10-26T19:00:00Z'::timestamptz,
  '2026-10-26T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9862',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fe1545d8-a82f-4948-9b39-a070584db29c',
  'ds-boxe-francaise-a-s-l-20261027-france-36',
  'Boxe française // A.S.L',
  'Événement annoncé : Boxe française // A.S.L. Lieu indiqué : Gare (France). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9866',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e8e38eae-7820-4fd4-b644-58ab814b377b',
  'ds-transbagarre-non-mixite-trans-asl-20261027-france-37',
  'Transbagarre [non-mixité trans] // ASL',
  'Événement annoncé : Transbagarre [non-mixité trans] // ASL. Lieu indiqué : Gare (France). Début prévu le 27/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-10-27T19:00:00Z'::timestamptz,
  '2026-10-27T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9813',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '19ea3a79-c9dc-44b4-bde0-599896308125',
  'ds-combat-libre-asl-20261028-france-38',
  'Combat Libre // ASL',
  'Événement annoncé : Combat Libre // ASL. Lieu indiqué : Gare (France). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9698',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '732268b2-8cb6-4cb4-85ea-8a7f300b9266',
  'ds-rom-molodoi-20261028-france-39',
  'ROM Molodoi',
  'Événement annoncé : ROM Molodoi. Lieu indiqué : Gare (France). Début prévu le 28/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-10-28T19:00:00Z'::timestamptz,
  '2026-10-28T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/8345',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '411c0eb0-5258-40a8-97a6-5850f459a7b2',
  'ds-projection-hugues-barrey-jardinier-eleveur-de-benoit-pupier-20261029-strasbourg-40',
  'Projection « Hugues Barrey, jardinier-éleveur » de Benoît Pupier',
  'Événement annoncé : Projection « Hugues Barrey, jardinier-éleveur » de Benoît Pupier. Lieu indiqué : Strasbourg (Strasbourg). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Strasbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Strasbourg',
  48.583441, 7.749338, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9944',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '203771da-01d0-4095-bb08-81524fe2fbbd',
  'ds-sorties-de-chantier-conferences-gesticulees-20261030-montagne-verte-41',
  'Sorties de chantier - conférences gesticulées',
  'Événement annoncé : Sorties de chantier - conférences gesticulées. Lieu indiqué : Montagne Verte (Montagne Verte). Début prévu le 30/10/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montagne Verte',
  NULL,
  'FR', 'Europe/Paris',
  'Montagne Verte',
  48.570212, 7.711939, NULL,
  '2026-10-30T16:30:00Z'::timestamptz,
  '2026-10-30T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9793',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '39a2b692-1286-4239-a9b8-154fd5cea116',
  'ds-rencontre-avec-rahim-hachemizadah-entre-l-iran-et-la-france-20261030-bischheim-42',
  'Rencontre avec Rahim Hachemizadah - Entre l''Iran et la France',
  'Événement annoncé : Rencontre avec Rahim Hachemizadah - Entre l''Iran et la France. Lieu indiqué : Bischheim (Bischheim). Début prévu le 30/10/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bischheim',
  NULL,
  'FR', 'Europe/Paris',
  'Bischheim',
  48.614055, 7.75215, NULL,
  '2026-10-30T16:30:00Z'::timestamptz,
  '2026-10-30T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10088',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd168f1b2-96e5-4b5c-848b-3716f7db98fc',
  'ds-cercles-de-silence-protestation-silencieuse-contre-les-politiques-migr-20261030-france-43',
  'Cercles de silence - Protestation silencieuse contre les politiques migratoires',
  'Événement annoncé : Cercles de silence - Protestation silencieuse contre les politiques migratoires. Lieu indiqué : Centre (France). Début prévu le 30/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.587881, 7.754071, NULL,
  '2026-10-30T17:00:00Z'::timestamptz,
  '2026-10-30T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9921',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '153cae4f-7122-4436-b197-a8ae8d76297f',
  'ds-jam-de-la-menace-lavande-en-mixite-choisie-lesbiennes-saphiques-gouine-20261030-france-44',
  'Jam de La Menace Lavande en mixité choisie lesbiennes saphiques gouines',
  'Événement annoncé : Jam de La Menace Lavande en mixité choisie lesbiennes saphiques gouines. Lieu indiqué : Centre (France). Début prévu le 30/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-10-30T17:30:00Z'::timestamptz,
  '2026-10-30T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9902',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '732cc2e1-a4ea-436d-bc0d-da3a1199cc13',
  'ds-theatre-17-octobre-1971-je-me-souviens-20261030-esplanade-45',
  'Théatre 17 octobre 1971 - Je me souviens',
  'Événement annoncé : Théatre 17 octobre 1971 - Je me souviens. Lieu indiqué : Esplanade (Esplanade). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Esplanade',
  NULL,
  'FR', 'Europe/Paris',
  'Esplanade',
  48.573126, 7.777345, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10078',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f9b0afb2-24cd-42b5-8d7d-102a4cc98801',
  'ds-la-stammtisch-de-la-hackstub-emancipation-technologique-20261030-cronenbourg-46',
  'La stammtisch de la Hackstub - Émancipation technologique',
  'Événement annoncé : La stammtisch de la Hackstub - Émancipation technologique. Lieu indiqué : Cronenbourg (Cronenbourg). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cronenbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Cronenbourg',
  48.588531, 7.710474, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10093',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6e4e7588-ff88-407b-869d-82fad395f527',
  'ds-sorties-de-chantier-conferences-gesticulees-20261031-montagne-verte-47',
  'Sorties de chantier - conférences gesticulées',
  'Événement annoncé : Sorties de chantier - conférences gesticulées. Lieu indiqué : Montagne Verte (Montagne Verte). Début prévu le 31/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montagne Verte',
  NULL,
  'FR', 'Europe/Paris',
  'Montagne Verte',
  48.570212, 7.711939, NULL,
  '2026-10-31T13:00:00Z'::timestamptz,
  '2026-10-31T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9794',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e86bee35-a342-446a-be84-97cc84908528',
  'ds-brunch-vegan-lgbtqia-20261101-france-48',
  'Brunch vegan LGBTQIA+',
  'Événement annoncé : Brunch vegan LGBTQIA+. Lieu indiqué : Centre (France). Début prévu le 01/11/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-01T09:30:00Z'::timestamptz,
  '2026-11-01T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10101',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd169947d-4080-45c6-918b-8aba5001566d',
  'ds-sorties-de-chantier-conferences-gesticulees-20261101-montagne-verte-49',
  'Sorties de chantier - conférences gesticulées',
  'Événement annoncé : Sorties de chantier - conférences gesticulées. Lieu indiqué : Montagne Verte (Montagne Verte). Début prévu le 01/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montagne Verte',
  NULL,
  'FR', 'Europe/Paris',
  'Montagne Verte',
  48.570212, 7.711939, NULL,
  '2026-11-01T13:00:00Z'::timestamptz,
  '2026-11-01T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9795',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3261e415-962d-42e9-84da-ad1486ed9e09',
  'ds-la-station-permanences-cats-en-non-mixite-entres-personnes-en-demarche-20261101-france-50',
  '[La Station] Permanences CATS en non-mixité entres personnes en démarches de transition',
  'Événement annoncé : [La Station] Permanences CATS en non-mixité entres personnes en démarches de transition. Lieu indiqué : Centre (France). Début prévu le 01/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-01T17:00:00Z'::timestamptz,
  '2026-11-01T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9878',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7fbebfdc-dab8-406c-bf70-8f8064de5c67',
  'ds-cours-de-francais-pour-les-personnes-lgbtqia-20261102-france-51',
  'Cours de français pour les personnes LGBTQIA+',
  'Événement annoncé : Cours de français pour les personnes LGBTQIA+. Lieu indiqué : Centre (France). Début prévu le 02/11/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-02T14:30:00Z'::timestamptz,
  '2026-11-02T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9911',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1d9b7e9c-0f72-4dd4-8286-eb2c3177efe2',
  'ds-permanence-du-kiosque-20261102-france-52',
  'Permanence du Kiosque',
  'Événement annoncé : Permanence du Kiosque. Lieu indiqué : Gare (France). Début prévu le 02/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-02T16:00:00Z'::timestamptz,
  '2026-11-02T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10024',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0392ef5f-d3a6-4780-bd7c-50ecba710379',
  'ds-kick-boxing-a-s-l-20261102-france-53',
  'Kick Boxing // A.S.L',
  'Événement annoncé : Kick Boxing // A.S.L. Lieu indiqué : Gare (France). Début prévu le 02/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-02T17:00:00Z'::timestamptz,
  '2026-11-02T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9670',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '40af95ce-2871-434a-b37d-43a67af7f79f',
  'ds-cafe-de-la-nouvelle-lune-en-non-mixite-femmes-lesbiennes-saphiques-gou-20261102-strasbourg-54',
  'Café de La Nouvelle Lune en non mixité femmes, lesbiennes, saphiques, gouines',
  'Événement annoncé : Café de La Nouvelle Lune en non mixité femmes, lesbiennes, saphiques, gouines. Lieu indiqué : Strasbourg (Strasbourg). Début prévu le 02/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Strasbourg',
  '62000',
  'FR', 'Europe/Paris',
  'Strasbourg',
  50.288262, 2.779796, NULL,
  '2026-11-02T17:30:00Z'::timestamptz,
  '2026-11-02T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9884',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '46042495-6f74-4071-b22e-8ab9850b6a66',
  'ds-boxe-anglaise-asl-20261102-france-55',
  'Boxe Anglaise // ASL',
  'Événement annoncé : Boxe Anglaise // ASL. Lieu indiqué : Gare (France). Début prévu le 02/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-02T19:00:00Z'::timestamptz,
  '2026-11-02T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9885',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f6029ea4-1dde-4a99-b62b-641cf32e8882',
  'ds-boxe-francaise-a-s-l-20261103-france-56',
  'Boxe française // A.S.L',
  'Événement annoncé : Boxe française // A.S.L. Lieu indiqué : Gare (France). Début prévu le 03/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-03T17:00:00Z'::timestamptz,
  '2026-11-03T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9904',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '41620e05-56ec-4bfc-b7c5-0bf8482d25b1',
  'ds-reunion-gays-45-friends-20261103-france-57',
  'Réunion Gays 45+ & Friends',
  'Événement annoncé : Réunion Gays 45+ & Friends. Lieu indiqué : Centre (France). Début prévu le 03/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  '2026-11-03T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10102',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '198ae780-f1bb-49ef-b671-9b3826bba25b',
  'ds-transbagarre-non-mixite-trans-asl-20261103-france-58',
  'Transbagarre [non-mixité trans] // ASL',
  'Événement annoncé : Transbagarre [non-mixité trans] // ASL. Lieu indiqué : Gare (France). Début prévu le 03/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-03T19:00:00Z'::timestamptz,
  '2026-11-03T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9814',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '18c3287b-9aaf-4a24-915e-8ceb6ffc5f57',
  'ds-combat-libre-asl-20261104-france-59',
  'Combat Libre // ASL',
  'Événement annoncé : Combat Libre // ASL. Lieu indiqué : Gare (France). Début prévu le 04/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Gare',
  48.575572, 7.72932, NULL,
  '2026-11-04T17:00:00Z'::timestamptz,
  '2026-11-04T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9699',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '89282ced-185d-41f1-b3c1-bb342ddc3abb',
  'ds-journees-nationales-prisons-conference-et-atelier-medias-vs-prison-20261105-strasbourg-60',
  'Journées Nationales Prisons - Conférence et atelier Médias vs Prison',
  'Événement annoncé : Journées Nationales Prisons - Conférence et atelier Médias vs Prison. Lieu indiqué : Strasbourg (Strasbourg). Début prévu le 05/11/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Strasbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Strasbourg',
  48.583148, 7.747882, NULL,
  '2026-11-05T08:30:00Z'::timestamptz,
  '2026-11-05T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10051',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6c4558b0-d73c-4024-b550-424f01fbba5c',
  'ds-journees-nationales-prisons-conference-juger-a-l-heure-de-prisons-surp-20261105-esplanade-61',
  'Journées Nationales Prisons - Conférence Juger à l’heure de prisons surpeuplées',
  'Événement annoncé : Journées Nationales Prisons - Conférence Juger à l’heure de prisons surpeuplées. Lieu indiqué : Esplanade (Esplanade). Début prévu le 05/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Esplanade',
  NULL,
  'FR', 'Europe/Paris',
  'Esplanade',
  48.580047, 7.765614, NULL,
  '2026-11-05T17:00:00Z'::timestamptz,
  '2026-11-05T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10052',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ff70676b-09c6-4516-b754-143c86f7e0fb',
  'ds-rencontres-queer-racisees-20261105-france-62',
  'Rencontres Queer Racisées',
  'Événement annoncé : Rencontres Queer Racisées. Lieu indiqué : Centre (France). Début prévu le 05/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-05T17:30:00Z'::timestamptz,
  '2026-11-05T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10103',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd3f72045-450f-4aa7-babd-f84ace55dda4',
  'ds-journees-nationales-prisons-rencontre-avec-laelia-veron-20261105-strasbourg-63',
  'Journées Nationales Prisons Rencontre avec Laélia Véron',
  'Événement annoncé : Journées Nationales Prisons Rencontre avec Laélia Véron. Lieu indiqué : Strasbourg (Strasbourg). Début prévu le 05/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Strasbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Strasbourg',
  48.583148, 7.747882, NULL,
  '2026-11-05T18:00:00Z'::timestamptz,
  '2026-11-05T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10053',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7d7ab18d-86ea-46fa-ba5b-6f4403c8c13f',
  'ds-projection-la-vie-en-vrac-de-elisabeth-kapnist-20261106-redessan-64',
  'Projection « La vie en vrac » de Élisabeth Kapnist',
  'Événement annoncé : Projection « La vie en vrac » de Élisabeth Kapnist. Lieu indiqué : Gare (France). Début prévu le 06/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Redessan',
  '30129',
  'FR', 'Europe/Paris',
  'Gare',
  43.810158, 4.522815, NULL,
  '2026-11-06T17:30:00Z'::timestamptz,
  '2026-11-06T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10034',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '29eb916f-2d09-476e-8328-533afc49115c',
  'ds-la-stammtisch-de-la-hackstub-emancipation-technologique-20261106-cronenbourg-65',
  'La stammtisch de la Hackstub - Émancipation technologique',
  'Événement annoncé : La stammtisch de la Hackstub - Émancipation technologique. Lieu indiqué : Cronenbourg (Cronenbourg). Début prévu le 06/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cronenbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Cronenbourg',
  48.588531, 7.710474, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  '2026-11-06T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10094',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '82d86738-4677-4688-9728-c9ff3fdc00ca',
  'ds-permanence-juridique-d-aide-a-la-demande-d-asile-pour-les-personnes-lg-20261107-france-66',
  'Permanence juridique d''aide à la demande d''asile pour les personnes LGBTQIA+',
  'Événement annoncé : Permanence juridique d''aide à la demande d''asile pour les personnes LGBTQIA+. Lieu indiqué : Centre (France). Début prévu le 07/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-07T13:00:00Z'::timestamptz,
  '2026-11-07T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9912',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7b523a9c-2374-4e4b-8b99-ce7794804060',
  'ds-conference-gesticulee-la-revolution-monetaire-ode-a-la-joie-d-un-milit-20261107-strasbourg-67',
  'Conférence gesticulée | La révolution monétaire, ode à la joie d''un militant inachevé',
  'Événement annoncé : Conférence gesticulée | La révolution monétaire, ode à la joie d''un militant inachevé. Lieu indiqué : Strasbourg (Strasbourg). Début prévu le 07/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Strasbourg',
  NULL,
  'FR', 'Europe/Paris',
  'Strasbourg',
  48.583148, 7.747882, NULL,
  '2026-11-07T13:00:00Z'::timestamptz,
  '2026-11-07T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10072',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f948d7e1-7218-4052-bac5-e6fa836c458e',
  'ds-rencontres-queer-racisees-20261107-france-68',
  'Rencontres Queer Racisées',
  'Événement annoncé : Rencontres Queer Racisées. Lieu indiqué : Centre (France). Début prévu le 07/11/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-07T15:00:00Z'::timestamptz,
  '2026-11-07T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/10104',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '23ced58f-5725-4a1f-99ce-708cdf7e4cb6',
  'ds-cours-de-francais-pour-les-personnes-lgbtqia-20261109-france-69',
  'Cours de français pour les personnes LGBTQIA+',
  'Événement annoncé : Cours de français pour les personnes LGBTQIA+. Lieu indiqué : Centre (France). Début prévu le 09/11/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'France',
  NULL,
  'FR', 'Europe/Paris',
  'Centre',
  48.581687, 7.753297, NULL,
  '2026-11-09T14:30:00Z'::timestamptz,
  '2026-11-09T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://strasbourgfurieuse.demosphere.net/rv/9907',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ef13860b-ecf6-4d56-bdb8-0129b56900dc',
  'ds-cine-debat-l-accueil-des-refugies-dans-le-lot-film-welcome-to-europe-20261026-gramat-70',
  'ciné débat : l''accueil des réfugiés dans le Lot - film welcome to Europe',
  'Événement annoncé : ciné débat : l''accueil des réfugiés dans le Lot - film welcome to Europe. Lieu indiqué : Gramat (Gramat). Début prévu le 26/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Gramat',
  NULL,
  'FR', 'Europe/Paris',
  'Gramat',
  44.781712, 1.728509, NULL,
  '2026-10-26T19:30:00Z'::timestamptz,
  '2026-10-26T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8534',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f86397ce-bce7-4627-8224-fdb77aeebe37',
  'ds-solidarite-secours-populaire-gramat-destockage-vetements-20261027-gramat-71',
  'Solidarité Secours Populaire Gramat - déstockage vêtements',
  'Événement annoncé : Solidarité Secours Populaire Gramat - déstockage vêtements. Lieu indiqué : Gramat (Gramat). Début prévu le 27/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Gramat',
  NULL,
  'FR', 'Europe/Paris',
  'Gramat',
  44.780549, 1.726223, NULL,
  '2026-10-27T08:00:00Z'::timestamptz,
  '2026-10-27T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8607',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2eb87504-53f2-40ed-98a7-2647a30e0ba4',
  'ds-spectacle-contes-avec-lea-garcia-le-petit-theatre-cahors-loup-et-villa-20261027-cahors-72',
  'Spectacle Contes avec Léa Garcia Le Petit Théâtre Cahors "Loup et village"',
  'Événement annoncé : Spectacle Contes avec Léa Garcia Le Petit Théâtre Cahors "Loup et village". Lieu indiqué : Cahors (Cahors). Début prévu le 27/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.447092, 1.441656, NULL,
  '2026-10-27T15:00:00Z'::timestamptz,
  '2026-10-27T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8612',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '92103fa4-956c-4bde-9e14-3f5ac346485b',
  'ds-projection-documentaire-etre-vivants-interroger-nos-liens-20261027-lendou-en-quercy-73',
  'Projection documentaire : Etre vivants - Interroger nos liens',
  'Événement annoncé : Projection documentaire : Etre vivants - Interroger nos liens. Lieu indiqué : Lendou-en-Quercy (Lendou-en-Quercy). Début prévu le 27/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lendou-en-Quercy',
  NULL,
  'FR', 'Europe/Paris',
  'Lendou-en-Quercy',
  44.291827, 1.228135, NULL,
  '2026-10-27T18:00:00Z'::timestamptz,
  '2026-10-27T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8585',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cf8f7450-73ef-4f95-81cc-f624bb5ed743',
  'ds-contes-avec-lea-garcia-compagnie-ilot-z-le-petit-theatre-cahors-loup-e-20261028-cahors-74',
  'Contes avec Léa Garcia Compagnie Ilot Z''- Le Petit Théâtre Cahors "Loup et village" -',
  'Événement annoncé : Contes avec Léa Garcia Compagnie Ilot Z''- Le Petit Théâtre Cahors "Loup et village" -. Lieu indiqué : Cahors (Cahors). Début prévu le 28/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.447092, 1.441656, NULL,
  '2026-10-28T15:00:00Z'::timestamptz,
  '2026-10-28T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8613',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '596d2f8e-6321-403b-b09f-6787eb3b8c96',
  'ds-soiree-degustation-brasserie-paysanne-les-bartas-20261028-cahors-75',
  'Soirée dégustation, brasserie paysanne Les Bartas',
  'Événement annoncé : Soirée dégustation, brasserie paysanne Les Bartas. Lieu indiqué : Cahors (Cahors). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.448743, 1.442597, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8602',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8ca48a90-ab21-4e8a-89e1-7c0e7778c8b7',
  'ds-defendons-notre-droit-de-manifester-et-notre-droit-a-vivre-dignement-20261031-figeac-76',
  'Défendons notre droit de manifester, et notre droit à vivre dignement !',
  'Événement annoncé : Défendons notre droit de manifester, et notre droit à vivre dignement !. Lieu indiqué : Figeac (Figeac). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Figeac',
  NULL,
  'FR', 'Europe/Paris',
  'Figeac',
  44.609373, 2.028408, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8615',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '85be2985-adaf-4d15-9994-29d6240a627f',
  'ds-royal-night-booty-s-invite-au-nahaland-ca-bodytchek-pour-halloween-20261031-laval-de-cere-77',
  'Royal Night Booty s''invite au Nahaland! Ca bodytchek pour Halloween!',
  'Événement annoncé : Royal Night Booty s''invite au Nahaland! Ca bodytchek pour Halloween!. Lieu indiqué : Laval-de-Cère (Laval-de-Cère). Début prévu le 31/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Laval-de-Cère',
  '46130',
  'FR', 'Europe/Paris',
  'Laval-de-Cère',
  44.9481, 1.935826, NULL,
  '2026-10-31T17:00:00Z'::timestamptz,
  '2026-10-31T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8528',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd91e8564-9779-48b4-adb9-f34cee1a94e8',
  'ds-kinosplash-5-samain-la-nuit-des-corps-vibrants-20261031-luzech-78',
  'KinoSplash #5 - Samain : La Nuit des Corps Vibrants',
  'Événement annoncé : KinoSplash #5 - Samain : La Nuit des Corps Vibrants. Lieu indiqué : Luzech (Luzech). Début prévu le 31/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Luzech',
  NULL,
  'FR', 'Europe/Paris',
  'Luzech',
  44.476911, 1.289267, NULL,
  '2026-10-31T18:00:00Z'::timestamptz,
  '2026-10-31T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8605',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '011fc798-cb2b-4eef-9c32-b6fac0453db9',
  'ds-projection-documentaires-sur-la-place-des-femmes-dans-l-agriculture-20261103-lendou-en-quercy-79',
  'Projection documentaires sur la place des femmes dans l''agriculture',
  'Événement annoncé : Projection documentaires sur la place des femmes dans l''agriculture. Lieu indiqué : Lendou-en-Quercy (Lendou-en-Quercy). Début prévu le 03/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Lendou-en-Quercy',
  NULL,
  'FR', 'Europe/Paris',
  'Lendou-en-Quercy',
  44.291827, 1.228135, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  '2026-11-03T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8586',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5dabfae3-7fea-46d8-a88a-160f75110c2d',
  'ds-cine-debat-fini-de-rire-20261105-cahors-80',
  'CINÉ-DÉBAT « FINI DE RIRE »',
  'Événement annoncé : CINÉ-DÉBAT « FINI DE RIRE ». Lieu indiqué : Cahors (Cahors). Début prévu le 05/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.451938, 1.439323, NULL,
  '2026-11-05T17:30:00Z'::timestamptz,
  '2026-11-05T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8604',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '291f842e-75f9-4ed8-8906-84c55561952d',
  'ds-cine-rencontre-un-espoir-pour-l-effraie-20261105-gramat-81',
  'ciné rencontre : un espoir pour l''effraie',
  'Événement annoncé : ciné rencontre : un espoir pour l''effraie. Lieu indiqué : Gramat (Gramat). Début prévu le 05/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Gramat',
  NULL,
  'FR', 'Europe/Paris',
  'Gramat',
  44.781712, 1.728509, NULL,
  '2026-11-05T19:30:00Z'::timestamptz,
  '2026-11-05T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8547',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '768fd4f2-47bc-4ba0-b8ba-73579e837de8',
  'ds-solidarite-secours-populaire-gramat-collecte-de-jouets-20261107-gramat-82',
  'Solidarité Secours Populaire Gramat - collecte de JOUETS',
  'Événement annoncé : Solidarité Secours Populaire Gramat - collecte de JOUETS. Lieu indiqué : Gramat (Gramat). Début prévu le 07/11/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Gramat',
  NULL,
  'FR', 'Europe/Paris',
  'Gramat',
  44.785835, 1.720725, NULL,
  '2026-11-07T08:00:00Z'::timestamptz,
  '2026-11-07T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8606',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b6a22b5c-e9e6-455f-8f1d-d7d2f937f289',
  'ds-invitation-au-rassemblement-de-solidarite-avec-le-peuple-palestinien-20261107-cahors-83',
  '🇵🇸 Invitation au rassemblement de solidarité avec le peuple palestinien',
  'Événement annoncé : 🇵🇸 Invitation au rassemblement de solidarité avec le peuple palestinien. Lieu indiqué : Cahors (Cahors). Début prévu le 07/11/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.44679, 1.440917, NULL,
  '2026-11-07T10:00:00Z'::timestamptz,
  '2026-11-07T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8599',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9acca48d-a774-41e6-89f0-c094b86575fe',
  'ds-soiree-de-soutien-a-la-caisse-ivg-delais-depasses-20261107-figeac-84',
  'Soirée de soutien à la caisse IVG délais dépassés',
  'Événement annoncé : Soirée de soutien à la caisse IVG délais dépassés. Lieu indiqué : Figeac (Figeac). Début prévu le 07/11/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Figeac',
  NULL,
  'FR', 'Europe/Paris',
  'Figeac',
  44.610022, 2.032335, NULL,
  '2026-11-07T16:30:00Z'::timestamptz,
  '2026-11-07T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8564',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bb84024f-bc39-4372-8837-ae81b176c3ef',
  'ds-projection-debat-documentaire-l-ombre-des-miroirs-photovoltaisme-et-ag-20261109-le-bourg-85',
  'Projection débat, documentaire "L''OMBRE DES MIROIRS", photovoltaïsme et agriculture',
  'Événement annoncé : Projection débat, documentaire "L''OMBRE DES MIROIRS", photovoltaïsme et agriculture. Lieu indiqué : Le Bourg (Le Bourg). Début prévu le 09/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Le Bourg',
  NULL,
  'FR', 'Europe/Paris',
  'Le Bourg',
  44.712714, 1.903163, NULL,
  '2026-11-09T17:30:00Z'::timestamptz,
  '2026-11-09T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8601',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4e1e481e-5334-4209-902e-029fe6bda5d7',
  'ds-soiree-queerness-diffusion-de-courts-metrages-20261109-gramat-86',
  'soirée queerness - diffusion de courts metrages',
  'Événement annoncé : soirée queerness - diffusion de courts metrages. Lieu indiqué : Gramat (Gramat). Début prévu le 09/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Gramat',
  NULL,
  'FR', 'Europe/Paris',
  'Gramat',
  44.781712, 1.728509, NULL,
  '2026-11-09T19:30:00Z'::timestamptz,
  '2026-11-09T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8548',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '36bccbe2-8221-4ecf-9aef-a0dcf674d0f9',
  'ds-projection-du-documentaire-pilleurs-de-terres-20261110-lendou-en-quercy-87',
  'Projection du documentaire : Pilleurs de terres',
  'Événement annoncé : Projection du documentaire : Pilleurs de terres. Lieu indiqué : Lendou-en-Quercy (Lendou-en-Quercy). Début prévu le 10/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lendou-en-Quercy',
  NULL,
  'FR', 'Europe/Paris',
  'Lendou-en-Quercy',
  44.291827, 1.228135, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  '2026-11-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8587',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '934fab31-c2fe-48c4-8b20-7fd0179e1378',
  'ds-petit-theatre-resistance-en-direct-des-comites-de-liberation-du-lot-ju-20261115-cahors-88',
  'Petit Théâtre - Résistance "En direct des comités de Libération du Lot, Juin 1945" - Cie Ilot Z''',
  'Événement annoncé : Petit Théâtre - Résistance "En direct des comités de Libération du Lot, Juin 1945" - Cie Ilot Z''. Lieu indiqué : Cahors (Cahors). Début prévu le 15/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cahors',
  NULL,
  'FR', 'Europe/Paris',
  'Cahors',
  44.447092, 1.441656, NULL,
  '2026-11-15T17:00:00Z'::timestamptz,
  '2026-11-15T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8614',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e229cf98-5310-4872-8dee-ef743bcdcfa3',
  'ds-projection-documentaire-au-nom-de-la-mer-vers-une-peche-durable-20261117-lendou-en-quercy-89',
  'Projection documentaire :Au nom de la mer, vers une pêche durable ?',
  'Événement annoncé : Projection documentaire :Au nom de la mer, vers une pêche durable ?. Lieu indiqué : Lendou-en-Quercy (Lendou-en-Quercy). Début prévu le 17/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lendou-en-Quercy',
  NULL,
  'FR', 'Europe/Paris',
  'Lendou-en-Quercy',
  44.291827, 1.228135, NULL,
  '2026-11-17T18:00:00Z'::timestamptz,
  '2026-11-17T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8588',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e537eec7-a2c8-47d3-98df-2cc00344c684',
  'ds-film-je-veux-bien-jeudi-19-novembre-20h30-a-l-astrolabe-20261119-figeac-90',
  'Film "Je veux bien", jeudi 19 novembre 20h30 à l''Astrolabe',
  'Événement annoncé : Film "Je veux bien", jeudi 19 novembre 20h30 à l''Astrolabe. Lieu indiqué : Figeac (Figeac). Début prévu le 19/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Figeac',
  NULL,
  'FR', 'Europe/Paris',
  'Figeac',
  44.608709, 2.025834, NULL,
  '2026-11-19T19:30:00Z'::timestamptz,
  '2026-11-19T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8568',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2a87e5af-057d-4b28-9edd-4016ea68bb68',
  'ds-conf-gesticulee-scene-ouverte8-balance-ton-anecdote-sur-l-ecole-20261121-bio-91',
  'Conf gesticulée + scène ouverte8 "balance ton anecdote" sur l''école',
  'Événement annoncé : Conf gesticulée + scène ouverte8 "balance ton anecdote" sur l''école. Lieu indiqué : Bio (Bio). Début prévu le 21/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'education',
  'Bio',
  NULL,
  'FR', 'Europe/Paris',
  'Bio',
  44.779584, 1.768854, NULL,
  '2026-11-21T16:00:00Z'::timestamptz,
  '2026-11-21T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8610',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '99021950-3c0f-4581-bfaa-7ab050cc2c7b',
  'ds-les-rencontres-de-l-economie-sociale-et-solidaire-en-quercy-rouergue-20261124-capdenac-gare-92',
  'Les rencontres de l''Economie Sociale et Solidaire en Quercy Rouergue',
  'Événement annoncé : Les rencontres de l''Economie Sociale et Solidaire en Quercy Rouergue. Lieu indiqué : Capdenac-Gare (Capdenac-Gare). Début prévu le 24/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Capdenac-Gare',
  '12700',
  'FR', 'Europe/Paris',
  'Capdenac-Gare',
  44.575025, 2.079131, NULL,
  '2026-11-24T17:30:00Z'::timestamptz,
  '2026-11-24T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8580',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '773e56e0-b5b5-489d-b79e-cdb78f2fab8f',
  'ds-projection-documentaire-reclaiming-cocoa-20261124-lendou-en-quercy-93',
  'Projection documentaire : Reclaiming cocoa',
  'Événement annoncé : Projection documentaire : Reclaiming cocoa. Lieu indiqué : Lendou-en-Quercy (Lendou-en-Quercy). Début prévu le 24/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lendou-en-Quercy',
  NULL,
  'FR', 'Europe/Paris',
  'Lendou-en-Quercy',
  44.291827, 1.228135, NULL,
  '2026-11-24T18:00:00Z'::timestamptz,
  '2026-11-24T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lot.demosphere.net/rv/8589',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '45fda2ac-dd92-4c15-932d-3bbfb07a0b28',
  'ds-brunch-gouter-autour-de-nos-santes-mentales-20261027-toulouse-94',
  'Brunch/Goûter autour de nos santés mentales',
  'Événement annoncé : Brunch/Goûter autour de nos santés mentales. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 27/10/2026 à 13:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'sante',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.620745, 1.452951, NULL,
  '2026-10-27T12:00:00Z'::timestamptz,
  '2026-10-27T15:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36086',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3d592185-a1c2-4ce4-a7a1-d4ed79b6d1c5',
  'ds-science-tour-garonne-2026-20261027-martres-tolosane-95',
  'Science Tour Garonne 2026',
  'Événement annoncé : Science Tour Garonne 2026. Lieu indiqué : Martres-Tolosane (Martres-Tolosane). Début prévu le 27/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Martres-Tolosane',
  '31220',
  'FR', 'Europe/Paris',
  'Martres-Tolosane',
  43.199587, 1.010987, NULL,
  '2026-10-27T13:00:00Z'::timestamptz,
  '2026-10-27T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36158',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ffef9628-a74f-41d8-8ff7-bc88579974a2',
  'ds-permanences-cras-jeudi-et-mardi-archives-et-bibliotheque-20261027-toulouse-96',
  'Permanences CRAS jeudi et mardi - Archives et bibliothèque',
  'Événement annoncé : Permanences CRAS jeudi et mardi - Archives et bibliothèque. Lieu indiqué : Toulouse  31100 (Toulouse). Début prévu le 27/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse  31100',
  43.587241, 1.420376, NULL,
  '2026-10-27T14:00:00Z'::timestamptz,
  '2026-10-27T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36269',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1369e258-fed0-45d6-82bc-936ee5c486e4',
  'ds-permanence-de-l-imprimerie-du-fond-de-la-casse-20261027-toulouse-97',
  'Permanence de l''imprimerie du Fond de la Casse',
  'Événement annoncé : Permanence de l''imprimerie du Fond de la Casse. Lieu indiqué : Toulouse (Toulouse). Début prévu le 27/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse',
  43.62272, 1.449635, NULL,
  '2026-10-27T15:00:00Z'::timestamptz,
  '2026-10-27T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35883',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '06ec864f-ef71-4422-8ae4-ba5ca673677c',
  'ds-soiree-404-culture-maker-et-reparation-20261027-toulouse-98',
  'Soirée 404 - Culture Maker et réparation',
  'Événement annoncé : Soirée 404 - Culture Maker et réparation. Lieu indiqué : Toulouse 31400 (Toulouse). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31400',
  43.57701, 1.47837, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36213',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6d7283b7-8b54-4447-8073-d2a4a6cf8aa0',
  'ds-cafe-bricol-a-toulouse-saint-michel-lieu-modifie-20261027-toulouse-99',
  'Café Bricol'' à Toulouse Saint-Michel [LIEU MODIFIÉ !!]',
  'Événement annoncé : Café Bricol'' à Toulouse Saint-Michel [LIEU MODIFIÉ !!]. Lieu indiqué : Toulouse 31400 (Toulouse). Début prévu le 27/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31400',
  43.588584, 1.446265, NULL,
  '2026-10-27T17:30:00Z'::timestamptz,
  '2026-10-27T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35645',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c81cb138-26a6-4c9a-93cf-508e79fceb0d',
  'ds-cercle-de-silence-20261027-toulouse-100',
  'Cercle de silence',
  'Événement annoncé : Cercle de silence. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 27/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.604477, 1.443977, NULL,
  '2026-10-27T17:30:00Z'::timestamptz,
  '2026-10-27T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36242',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '225aa1d7-30cd-4ff1-8c54-bac1bbaef3f5',
  'ds-reunion-ouverte-du-comite-de-soutien-a-la-palestine-31-20261027-toulouse-101',
  'Réunion Ouverte du Comité de Soutien à la Palestine 31',
  'Événement annoncé : Réunion Ouverte du Comité de Soutien à la Palestine 31. Lieu indiqué : Toulouse 31100 (Toulouse). Début prévu le 27/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31100',
  43.576329, 1.402056, NULL,
  '2026-10-27T17:30:00Z'::timestamptz,
  '2026-10-27T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36322',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'daad0f0e-a6b6-4033-80f5-b17f463c033a',
  'ds-science-tour-garonne-2026-20261028-cazeres-102',
  'Science Tour Garonne 2026',
  'Événement annoncé : Science Tour Garonne 2026. Lieu indiqué : Cazères (Cazères). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.204437, 1.086472, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36159',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8fa0d775-8cec-42bd-b3d8-d9851a5d7b27',
  'ds-maraichage-solidaire-la-recolte-des-courges-butternut-des-haricots-ver-20261028-toulouse-103',
  'Maraichage solidaire : la récolte des courges butternut, des haricots verts...',
  'Événement annoncé : Maraichage solidaire : la récolte des courges butternut, des haricots verts.... Lieu indiqué : Toulouse 31200 (Toulouse). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31200',
  43.64473, 1.443866, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36162',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ab4acb4d-d599-4338-94df-5235beea621e',
  'ds-maraude-populaire-20261028-toulouse-104',
  'Maraude Populaire',
  'Événement annoncé : Maraude Populaire. Lieu indiqué : Toulouse 31400 (Toulouse). Début prévu le 28/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  '31400',
  'FR', 'Europe/Paris',
  'Toulouse 31400',
  43.582148, 1.450792, NULL,
  '2026-10-28T13:00:00Z'::timestamptz,
  '2026-10-28T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36323',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '40643088-e323-4b93-a1b6-e92214e5a8b9',
  'ds-permanence-de-la-bibli-anarcha-feministe-20261028-toulouse-105',
  'Permanence de la Bibli Anarcha-Féministe',
  'Événement annoncé : Permanence de la Bibli Anarcha-Féministe. Lieu indiqué : Toulouse 31300 (Toulouse). Début prévu le 28/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31300',
  43.590422, 1.432955, NULL,
  '2026-10-28T15:00:00Z'::timestamptz,
  '2026-10-28T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35895',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0c913e1c-5b2a-45d8-8588-77b475e4c94c',
  'ds-formation-zero-waste-toulouse-devenir-benevole-20261028-toulouse-106',
  'Formation Zero Waste Toulouse : Devenir bénévole',
  'Événement annoncé : Formation Zero Waste Toulouse : Devenir bénévole. Lieu indiqué : Toulouse 31200 (Toulouse). Début prévu le 28/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31200',
  43.619597, 1.45136, NULL,
  '2026-10-28T17:30:00Z'::timestamptz,
  '2026-10-28T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35505',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cae04543-2dde-4e54-8aa5-4109e0aaa878',
  'ds-antitsiganisme-rencontre-avec-l-association-rencont-roms-nous-20261028-toulouse-107',
  'Antitsiganisme : rencontre avec l''association Rencont''roms nous',
  'Événement annoncé : Antitsiganisme : rencontre avec l''association Rencont''roms nous. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.602542, 1.441157, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35588',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eb4ded19-0a54-42f6-94ed-5e36ba262731',
  'ds-cercle-d-ecoute-pour-hommes-la-drague-20261028-toulouse-108',
  'Cercle d''écoute pour hommes - La Drague',
  'Événement annoncé : Cercle d''écoute pour hommes - La Drague. Lieu indiqué : Toulouse 31300 (Toulouse). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31300',
  43.590422, 1.432955, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36083',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '53b8b0c5-b2df-4e9e-8f94-889477d9d180',
  'ds-ecologie-decoloniale-projection-debat-agent-orange-une-bombe-a-retarde-20261029-toulouse-109',
  'Écologie decoloniale : projection débat "Agent Orange : une bombe à retardement"',
  'Événement annoncé : Écologie decoloniale : projection débat "Agent Orange : une bombe à retardement". Lieu indiqué : Toulouse (Toulouse). Début prévu le 29/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'climat',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse',
  43.576329, 1.402056, NULL,
  '2026-10-29T13:00:00Z'::timestamptz,
  '2026-10-29T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36319',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3899862e-9bf5-40b8-9006-a34229c0cfd3',
  'ds-assemblee-generale-de-la-crea-20261029-mancioux-110',
  '- Assemblée Générale de la CREA',
  'Événement annoncé : - Assemblée Générale de la CREA. Lieu indiqué : France (France). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mancioux',
  '31360',
  'FR', 'Europe/Paris',
  'France',
  43.167744, 0.941111, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35906',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4956d550-d6c7-4a61-b464-8ca8713fc426',
  'ds-conference-debat-sur-l-urgence-de-taxer-les-riches-20261029-toulouse-111',
  'CONFERENCE/DEBAT SUR L URGENCE... DE TAXER LES RICHES',
  'Événement annoncé : CONFERENCE/DEBAT SUR L URGENCE... DE TAXER LES RICHES. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.603561, 1.446377, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36260',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6c425bf9-b41f-4ee0-9884-3dcdfba1e4b6',
  'ds-electronyx-soiree-bouncy-20261029-toulouse-112',
  'ElectroNyx - Soirée Bouncy',
  'Événement annoncé : ElectroNyx - Soirée Bouncy. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 29/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.609112, 1.453069, NULL,
  '2026-10-29T20:00:00Z'::timestamptz,
  '2026-10-29T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35957',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'abe07400-66f2-47a1-9534-fbefa02cb2b6',
  'ds-asile-colonial-rencontre-avec-raphael-gallien-20261030-toulouse-113',
  'Asile colonial : rencontre avec Raphaël Gallien',
  'Événement annoncé : Asile colonial : rencontre avec Raphaël Gallien. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.602542, 1.441157, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35589',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '056faf8f-4405-4f03-9f90-4bc98d6afc8f',
  'ds-cine-sous-la-serre-l-eau-de-l-insouciance-a-la-desobeissance-20261030-toulouse-114',
  'Ciné sous la serre : L’eau, de l’insouciance à la désobéissance',
  'Événement annoncé : Ciné sous la serre : L’eau, de l’insouciance à la désobéissance. Lieu indiqué : Toulouse 31200 (Toulouse). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31200',
  43.64473, 1.443866, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36164',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'dcdd4e3d-ee8e-4566-ac44-1095d3aee5ab',
  'ds-2026-10-30-balade-nocturne-halloween-20261030-toulouse-115',
  '2026 10 30 Balade Nocturne HALLOWEEN',
  'Événement annoncé : 2026 10 30 Balade Nocturne HALLOWEEN. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 30/10/2026 à 20:15 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.607921, 1.441943, NULL,
  '2026-10-30T19:15:00Z'::timestamptz,
  '2026-10-30T22:15:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36203',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b4fb137f-db10-4777-b5ad-494fbda1aea9',
  'ds-atelier-mangeoires-nichoirs-20261031-escalquens-116',
  'ATELIER MANGEOIRES-NICHOIRS',
  'Événement annoncé : ATELIER MANGEOIRES-NICHOIRS. Lieu indiqué : Escalquens (Escalquens). Début prévu le 31/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Escalquens',
  NULL,
  'FR', 'Europe/Paris',
  'Escalquens',
  43.518174, 1.559158, NULL,
  '2026-10-31T08:00:00Z'::timestamptz,
  '2026-10-31T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36286',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cebe569c-87b0-4d31-8e6e-ec3080aeafa9',
  'ds-permanence-syndicale-cgt-des-bureaux-d-etude-20261031-toulouse-117',
  'Permanence syndicale CGT des bureaux d''étude',
  'Événement annoncé : Permanence syndicale CGT des bureaux d''étude. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 31/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.608258, 1.440984, NULL,
  '2026-10-31T08:30:00Z'::timestamptz,
  '2026-10-31T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35829',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b8d6bf2d-4e09-4952-9896-be3aad1b90c2',
  'ds-cultiver-l-eau-l-habitabilite-et-la-paix-de-nos-territoires-pour-demai-20261031-la-bastide-de-bes',
  'Cultiver l''eau, l''habitabilité et la paix de nos territoires pour demain',
  'Événement annoncé : Cultiver l''eau, l''habitabilité et la paix de nos territoires pour demain. Lieu indiqué : La Bastide de Besplas (La Bastide de Besplas). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'La Bastide de Besplas',
  NULL,
  'FR', 'Europe/Paris',
  'La Bastide de Besplas',
  43.177494, 1.293777, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36074',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '866a6366-ddbc-4e74-be3e-b7f6538be89b',
  'ds-cnt-ait-permanence-hebdomadaire-20261031-toulouse-119',
  'CNT-AIT Permanence hebdomadaire',
  'Événement annoncé : CNT-AIT Permanence hebdomadaire. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 31/10/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.596084, 1.443407, NULL,
  '2026-10-31T16:00:00Z'::timestamptz,
  '2026-10-31T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35927',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd563c715-eb6e-42e6-a6e1-c5b94bf264cc',
  'ds-seeds-for-liberation-soiree-pour-la-palestine-20261031-toulouse-120',
  'SEEDS for LIBERATION soirée pour la Palestine',
  'Événement annoncé : SEEDS for LIBERATION soirée pour la Palestine. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 31/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.605978, 1.444247, NULL,
  '2026-10-31T17:00:00Z'::timestamptz,
  '2026-10-31T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36268',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '22505616-946b-4f40-836f-78de95632b42',
  'ds-film-le-mystere-lucy-lost-accompagnement-musicale-20261101-tournefeuille-121',
  'Film: Le Mystère Lucy Lost + accompagnement musicale',
  'Événement annoncé : Film: Le Mystère Lucy Lost + accompagnement musicale. Lieu indiqué : Tournefeuille‎ (Tournefeuille‎). Début prévu le 01/11/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tournefeuille‎',
  NULL,
  'FR', 'Europe/Paris',
  'Tournefeuille‎',
  43.582187, 1.347203, NULL,
  '2026-11-01T10:00:00Z'::timestamptz,
  '2026-11-01T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36134',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7787acd9-e5c1-42c4-b15e-3417a1b76721',
  'ds-permanence-de-la-bibli-anarcha-feministe-20261101-toulouse-122',
  'Permanence de la Bibli Anarcha-Féministe',
  'Événement annoncé : Permanence de la Bibli Anarcha-Féministe. Lieu indiqué : Toulouse 31300 (Toulouse). Début prévu le 01/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31300',
  43.590422, 1.432955, NULL,
  '2026-11-01T13:00:00Z'::timestamptz,
  '2026-11-01T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35949',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '80a1fa3e-8baf-47fd-918f-c1b9ccb794cf',
  'ds-permanence-oestrosoupe-autodefense-sanitaire-transfem-20261101-toulouse-123',
  'Permanence Oestrosoupe - Autodéfense sanitaire transfem',
  'Événement annoncé : Permanence Oestrosoupe - Autodéfense sanitaire transfem. Lieu indiqué : Toulouse 31000 (Toulouse). Début prévu le 01/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31000',
  43.613818, 1.445452, NULL,
  '2026-11-01T13:00:00Z'::timestamptz,
  '2026-11-01T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36231',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '73196bf0-7ff6-4327-9388-b6512bc20425',
  'ds-fete-de-soutien-a-autonomie-20261101-toulouse-124',
  'Fête de soutien à AutonoMIE',
  'Événement annoncé : Fête de soutien à AutonoMIE. Lieu indiqué : Toulouse 31100 (Toulouse). Début prévu le 01/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31100',
  43.613867, 1.436804, NULL,
  '2026-11-01T13:00:00Z'::timestamptz,
  '2026-11-01T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36315',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e10d7eb8-af62-4aa0-96fb-9ab0ab20f3c4',
  'ds-baf-rencontre-jade-almeida-le-gout-des-fissures-20261101-toulouse-125',
  '[BAF] Rencontre Jade Almeida - Le Gout des fissures',
  'Événement annoncé : [BAF] Rencontre Jade Almeida - Le Gout des fissures. Lieu indiqué : Toulouse 31300 (Toulouse). Début prévu le 01/11/2026 à 16:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31300',
  43.590422, 1.432955, NULL,
  '2026-11-01T15:30:00Z'::timestamptz,
  '2026-11-01T18:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/36078',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9a21fbde-e437-4907-9123-4b5fb7ed4bdc',
  'ds-permanence-du-kiosk-20261102-toulouse-126',
  'Permanence du Kiosk',
  'Événement annoncé : Permanence du Kiosk. Lieu indiqué : Toulouse 31100 (Toulouse). Début prévu le 02/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31100',
  43.613867, 1.436804, NULL,
  '2026-11-02T17:00:00Z'::timestamptz,
  '2026-11-02T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35966',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1b1a9706-0e57-425a-b7d6-808e88c50c30',
  'ds-permanence-d-entraide-et-d-information-du-dal31-20261103-toulouse-127',
  'Permanence d''entraide et d''information du DAL31',
  'Événement annoncé : Permanence d''entraide et d''information du DAL31. Lieu indiqué : Toulouse 31400 (Toulouse). Début prévu le 03/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse 31400',
  43.579397, 1.414606, NULL,
  '2026-11-03T09:00:00Z'::timestamptz,
  '2026-11-03T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35660',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2ba050ee-6c54-48eb-a60b-d73cf23438f1',
  'ds-permanence-de-l-imprimerie-du-fond-de-la-casse-20261103-toulouse-128',
  'Permanence de l''imprimerie du Fond de la Casse',
  'Événement annoncé : Permanence de l''imprimerie du Fond de la Casse. Lieu indiqué : Toulouse (Toulouse). Début prévu le 03/11/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Toulouse',
  NULL,
  'FR', 'Europe/Paris',
  'Toulouse',
  43.62272, 1.449635, NULL,
  '2026-11-03T15:00:00Z'::timestamptz,
  '2026-11-03T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://toulouse.demosphere.net/rv/35975',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '85c4a188-5341-46ff-b36c-ec8f1998e1a2',
  'ds-exposition-la-palestine-entre-les-ruines-et-l-espoir-20261027-rennes-129',
  'exposition La Palestine entre les ruines et l’espoir',
  'Événement annoncé : exposition La Palestine entre les ruines et l’espoir. Lieu indiqué : Rennes (Rennes). Début prévu le 27/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-10-27T12:30:00Z'::timestamptz,
  '2026-10-27T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19809',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0cd8844b-11d0-4a47-bf51-57404b819c61',
  'ds-ag-du-travail-social-en-lutte-35-20261027-rennes-130',
  'AG du travail social en lutte 35',
  'Événement annoncé : AG du travail social en lutte 35. Lieu indiqué : Rennes (Rennes). Début prévu le 27/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.098301, -1.704521, NULL,
  '2026-10-27T17:30:00Z'::timestamptz,
  '2026-10-27T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19873',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '10c717f9-6058-4b37-acd7-3fa6c94cd952',
  'ds-exposition-la-palestine-entre-les-ruines-et-l-espoir-20261028-rennes-131',
  'exposition La Palestine entre les ruines et l’espoir',
  'Événement annoncé : exposition La Palestine entre les ruines et l’espoir. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-10-28T12:30:00Z'::timestamptz,
  '2026-10-28T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19810',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '65c2bd69-f54a-4b09-9180-b39d22b87638',
  'ds-presentation-et-echange-autour-du-livre-nous-autres-20261028-rennes-132',
  'Présentation et échange autour du livre "nous autres"',
  'Événement annoncé : Présentation et échange autour du livre "nous autres". Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19800',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '02786b43-f206-470f-a50f-2ed702b08b36',
  'ds-first-date-faire-connaissance-d-abord-20261028-rennes-133',
  'First Date : Faire connaissance d''abord',
  'Événement annoncé : First Date : Faire connaissance d''abord. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.097964, -1.674727, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19751',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8210caff-96fa-4d7c-a1b1-d6ee7e2e9b7e',
  'ds-rejoins-a2c-rennes-reunion-d-accueil-20261028-rennes-134',
  'Rejoins A2C Rennes : Réunion d''accueil',
  'Événement annoncé : Rejoins A2C Rennes : Réunion d''accueil. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.112403, -1.68632, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19755',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '331b8929-5b54-460b-afb8-d2a7868c35d0',
  'ds-boxe-libre-20261028-rennes-135',
  'Boxe Libre',
  'Événement annoncé : Boxe Libre. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.098714, -1.701538, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19847',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4b41cee7-86f2-4c33-b5a8-52b7b9fe4946',
  'ds-travailleurs-travailleuses-construisons-le-mouvement-construisons-la-g-20261028-rennes-136',
  'Travailleurs, travailleuses ! Construisons le mouvement, construisons la grève !',
  'Événement annoncé : Travailleurs, travailleuses ! Construisons le mouvement, construisons la grève !. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.088437, -1.660677, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19872',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b7714772-a71a-4a13-80f0-07a62bc71f81',
  'ds-cantine-du-r2r-20261028-rennes-137',
  'Cantine du R2R',
  'Événement annoncé : Cantine du R2R. Lieu indiqué : Rennes (Rennes). Début prévu le 28/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-10-28T18:30:00Z'::timestamptz,
  '2026-10-28T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19824',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9ff5fe2b-851e-45d6-828b-1904e32046b5',
  'ds-exposition-la-palestine-entre-les-ruines-et-l-espoir-20261029-rennes-138',
  'exposition La Palestine entre les ruines et l’espoir',
  'Événement annoncé : exposition La Palestine entre les ruines et l’espoir. Lieu indiqué : Rennes (Rennes). Début prévu le 29/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-10-29T12:30:00Z'::timestamptz,
  '2026-10-29T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19811',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b0d6ae49-e081-4e86-9516-8b5a7f3d28e1',
  'ds-exposition-la-palestine-entre-les-ruines-et-l-espoir-20261030-rennes-139',
  'exposition La Palestine entre les ruines et l’espoir',
  'Événement annoncé : exposition La Palestine entre les ruines et l’espoir. Lieu indiqué : Rennes (Rennes). Début prévu le 30/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-10-30T12:30:00Z'::timestamptz,
  '2026-10-30T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19812',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0645248a-4e82-4681-b156-fae385e84cf4',
  'ds-fete-face-a-l-horreur-de-la-repression-20261030-rennes-140',
  'Fête face à l''horreur de la répression',
  'Événement annoncé : Fête face à l''horreur de la répression. Lieu indiqué : Rennes (Rennes). Début prévu le 30/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100818, -1.709156, NULL,
  '2026-10-30T14:00:00Z'::timestamptz,
  '2026-10-30T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19869',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c95b3e27-558f-4d07-8cc9-31eed259c3c6',
  'ds-exposition-la-palestine-entre-les-ruines-et-l-espoir-20261031-rennes-141',
  'exposition La Palestine entre les ruines et l’espoir',
  'Événement annoncé : exposition La Palestine entre les ruines et l’espoir. Lieu indiqué : Rennes (Rennes). Début prévu le 31/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-10-31T12:30:00Z'::timestamptz,
  '2026-10-31T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19813',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4ce67be5-76a9-48cb-9bce-0202d27a15e9',
  'ds-stage-une-journee-une-chanson-feministe-20261101-brie-142',
  'Stage "une journée, une chanson féministe"',
  'Événement annoncé : Stage "une journée, une chanson féministe". Lieu indiqué : Brie (Brie). Début prévu le 01/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Brie',
  '69870',
  'FR', 'Europe/Paris',
  'Brie',
  46.090472, 4.474577, NULL,
  '2026-11-01T09:00:00Z'::timestamptz,
  '2026-11-01T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19780',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '50dec4c2-cf74-4cdf-9be8-61212f9ddefa',
  'ds-2eme-rencontre-du-collectif-tubercule-20261101-rennes-143',
  '2eme rencontre du collectif Tubercule',
  'Événement annoncé : 2eme rencontre du collectif Tubercule. Lieu indiqué : Rennes (Rennes). Début prévu le 01/11/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.087688, -1.655874, NULL,
  '2026-11-01T15:00:00Z'::timestamptz,
  '2026-11-01T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19859',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '72e0b914-22f0-4f42-95d2-87adeefba143',
  'ds-les-rencontres-de-la-librairie-planete-io-archi-et-precarite-avec-lise-20261103-rennes-144',
  'les rencontres de la librairie planète io, archi et précarité avec Lise Gaillard et Emily Mugel',
  'Événement annoncé : les rencontres de la librairie planète io, archi et précarité avec Lise Gaillard et Emily Mugel. Lieu indiqué : Rennes (Rennes). Début prévu le 03/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  '35000',
  'FR', 'Europe/Paris',
  'Rennes',
  48.110899, -1.68365, NULL,
  '2026-11-03T17:30:00Z'::timestamptz,
  '2026-11-03T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19833',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1dd79db8-e3f4-40c9-a61e-fe896f972ff8',
  'ds-conference-gesticulee-mon-corps-leurs-choix-20261103-rennes-145',
  'Conférence gesticulée Mon corps, leurs choix',
  'Événement annoncé : Conférence gesticulée Mon corps, leurs choix. Lieu indiqué : Rennes (Rennes). Début prévu le 03/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.104843, -1.679456, NULL,
  '2026-11-03T19:00:00Z'::timestamptz,
  '2026-11-03T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19875',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '344c4c0d-f4d0-4995-8046-19432e3d5c6e',
  'ds-rencontre-la-bataille-culturelle-20261104-rennes-146',
  'Rencontre: La Bataille culturelle',
  'Événement annoncé : Rencontre: La Bataille culturelle. Lieu indiqué : Rennes (Rennes). Début prévu le 04/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.110249, -1.677052, NULL,
  '2026-11-04T17:30:00Z'::timestamptz,
  '2026-11-04T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19865',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f79d2dfd-017b-4ac8-9f67-3a31c7164df5',
  'ds-ateliers-de-reapproriation-politique-arp-20261104-rennes-147',
  'Ateliers de Réapproriation Politique (ARP)',
  'Événement annoncé : Ateliers de Réapproriation Politique (ARP). Lieu indiqué : Rennes (Rennes). Début prévu le 04/11/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.122085, -1.64819, NULL,
  '2026-11-04T17:45:00Z'::timestamptz,
  '2026-11-04T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19834',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a3c60ea6-2f96-49a4-8448-5c7c5abb282f',
  'ds-boxe-libre-20261104-rennes-148',
  'Boxe Libre',
  'Événement annoncé : Boxe Libre. Lieu indiqué : Rennes (Rennes). Début prévu le 04/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.098714, -1.701538, NULL,
  '2026-11-04T18:00:00Z'::timestamptz,
  '2026-11-04T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19848',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '763016a6-a4aa-4944-a9b6-1eaf78d4d789',
  'ds-cantine-du-r2r-20261104-rennes-149',
  'Cantine du R2R',
  'Événement annoncé : Cantine du R2R. Lieu indiqué : Rennes (Rennes). Début prévu le 04/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-11-04T18:30:00Z'::timestamptz,
  '2026-11-04T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19825',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '703e9e72-60eb-4f2d-8f78-c5d1cafc47c6',
  'ds-liberte-egalite-etc-par-le-collectif-ensemble-tout-contre-20261105-rennes-150',
  'LIBERTE, EGALITE, ETC, par le Collectif "Ensemble Tout Contre"',
  'Événement annoncé : LIBERTE, EGALITE, ETC, par le Collectif "Ensemble Tout Contre". Lieu indiqué : Rennes (Rennes). Début prévu le 05/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-11-05T19:00:00Z'::timestamptz,
  '2026-11-05T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19842',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '84126bdd-a061-4ca0-b39b-1f98596779ba',
  'ds-arpentage-de-joie-militante-20261106-rennes-151',
  'Arpentage de Joie militante',
  'Événement annoncé : Arpentage de Joie militante. Lieu indiqué : Rennes (Rennes). Début prévu le 06/11/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.105688, -1.672759, NULL,
  '2026-11-06T15:00:00Z'::timestamptz,
  '2026-11-06T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19866',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '72d826c8-68f2-4d42-95c6-3b8f6df8f243',
  'ds-liberte-egalite-etc-par-le-collectif-ensemble-tout-contre-20261106-melesse-152',
  'LIBERTE, EGALITE, ETC. par le Collectif "Ensemble Tout Contre"',
  'Événement annoncé : LIBERTE, EGALITE, ETC. par le Collectif "Ensemble Tout Contre". Lieu indiqué : Melesse (Melesse). Début prévu le 06/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Melesse',
  NULL,
  'FR', 'Europe/Paris',
  'Melesse',
  48.219768, -1.698219, NULL,
  '2026-11-06T19:00:00Z'::timestamptz,
  '2026-11-06T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19843',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ba3e335d-f1d6-4821-a24a-1d8bbab4c386',
  'ds-week-end-de-formation-debats-d-a2c-de-l-insurrection-a-la-revolution-20261107-rennes-153',
  'Week-end de formation & débats d''A2C - DE L''INSURRECTION A LA REVOLUTION 🔥',
  'Événement annoncé : Week-end de formation & débats d''A2C - DE L''INSURRECTION A LA REVOLUTION 🔥. Lieu indiqué : Rennes (Rennes). Début prévu le 07/11/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.107089, -1.67255, NULL,
  '2026-11-07T08:30:00Z'::timestamptz,
  '2026-11-07T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19870',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4cb48fda-5890-41a5-b289-3a3caea32f28',
  'ds-week-end-de-debats-et-formations-d-a2c-de-l-insurrection-a-la-revoluti-20261108-rennes-154',
  'Week-end de débats et formations d''A2C - DE L''INSURRECTION A LA REVOLUTION 🔥',
  'Événement annoncé : Week-end de débats et formations d''A2C - DE L''INSURRECTION A LA REVOLUTION 🔥. Lieu indiqué : Rennes (Rennes). Début prévu le 08/11/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.107089, -1.67255, NULL,
  '2026-11-08T08:30:00Z'::timestamptz,
  '2026-11-08T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19871',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9a0e62ca-5fc8-48a0-aa86-06830cc1132a',
  'ds-causerie-sur-l-extractivisme-avec-stoptoutour-20261109-rennes-155',
  'Causerie sur l''extractivisme avec STOPTOUTOUR',
  'Événement annoncé : Causerie sur l''extractivisme avec STOPTOUTOUR. Lieu indiqué : Rennes (Rennes). Début prévu le 09/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.11085, -1.665862, NULL,
  '2026-11-09T18:30:00Z'::timestamptz,
  '2026-11-09T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19858',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1a19e8e8-5a8b-4fb8-81b1-5ff54aabbe9b',
  'ds-restitutions-il-etait-13h12-20261110-rennes-156',
  'RESTITUTIONS "Il était 13H12"',
  'Événement annoncé : RESTITUTIONS "Il était 13H12". Lieu indiqué : Rennes (Rennes). Début prévu le 10/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.097964, -1.674727, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  '2026-11-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19797',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c8401b39-87dd-4e9b-aa6c-95ee5f21475c',
  'ds-boxe-libre-20261111-rennes-157',
  'Boxe Libre',
  'Événement annoncé : Boxe Libre. Lieu indiqué : Rennes (Rennes). Début prévu le 11/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.098714, -1.701538, NULL,
  '2026-11-11T18:00:00Z'::timestamptz,
  '2026-11-11T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19849',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6dd61cae-5af3-472a-8a94-742ba9b23fc4',
  'ds-cantine-du-r2r-20261111-rennes-158',
  'Cantine du R2R',
  'Événement annoncé : Cantine du R2R. Lieu indiqué : Rennes (Rennes). Début prévu le 11/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-11-11T18:30:00Z'::timestamptz,
  '2026-11-11T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19826',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1acdc75f-d8be-440b-b3ab-6c58f9192cb0',
  'ds-rencontre-la-sante-mentale-un-enjeu-politique-20261112-rennes-159',
  'Rencontre La santé mentale, un enjeu politique',
  'Événement annoncé : Rencontre La santé mentale, un enjeu politique. Lieu indiqué : Rennes (Rennes). Début prévu le 12/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'sante',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.122085, -1.64819, NULL,
  '2026-11-12T18:00:00Z'::timestamptz,
  '2026-11-12T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19855',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2504215b-8256-4b3d-9d24-cddad2201e3b',
  'ds-boxe-libre-20261118-rennes-160',
  'Boxe Libre',
  'Événement annoncé : Boxe Libre. Lieu indiqué : Rennes (Rennes). Début prévu le 18/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.098714, -1.701538, NULL,
  '2026-11-18T18:00:00Z'::timestamptz,
  '2026-11-18T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19850',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fb208c1a-d565-4136-9c7e-6e526de80c0b',
  'ds-cantine-du-r2r-20261118-rennes-161',
  'Cantine du R2R',
  'Événement annoncé : Cantine du R2R. Lieu indiqué : Rennes (Rennes). Début prévu le 18/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.100793, -1.709309, NULL,
  '2026-11-18T18:30:00Z'::timestamptz,
  '2026-11-18T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19827',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '80dcc1be-aca8-43f7-808d-10001f48b20d',
  'ds-cercle-de-parole-climat-sobriete-societe-20261118-chantepie-162',
  'Cercle de parole : climat sobriété société',
  'Événement annoncé : Cercle de parole : climat sobriété société. Lieu indiqué : Chantepie (Chantepie). Début prévu le 18/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'climat',
  'Chantepie',
  NULL,
  'FR', 'Europe/Paris',
  'Chantepie',
  48.086695, -1.621969, NULL,
  '2026-11-18T19:00:00Z'::timestamptz,
  '2026-11-18T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19724',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '31ebcfd4-b24d-4411-bfc7-c5828fddb074',
  'ds-causerie-l-autonomie-nous-ouvre-des-horizons-infinis-20261121-rennes-163',
  'Causerie : L''Autonomie nous ouvre des horizons infinis',
  'Événement annoncé : Causerie : L''Autonomie nous ouvre des horizons infinis. Lieu indiqué : Rennes (Rennes). Début prévu le 21/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rennes',
  NULL,
  'FR', 'Europe/Paris',
  'Rennes',
  48.11085, -1.665862, NULL,
  '2026-11-21T13:00:00Z'::timestamptz,
  '2026-11-21T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://rennes.demosphere.net/rdv/19792',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b8b911ac-8681-47c8-baab-eb93409bc1cc',
  'ds-hommage-aux-victimes-de-trappes-la-verriere-contre-le-racisme-20261027-guillestre-164',
  'Hommage aux victimes de Trappes-La Verriere Contre le Racisme',
  'Événement annoncé : Hommage aux victimes de Trappes-La Verriere Contre le Racisme. Lieu indiqué : Guillestre (Guillestre). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Guillestre',
  '05600',
  'FR', 'Europe/Paris',
  'Guillestre',
  44.660856, 6.621247, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5192',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9a88a4ad-c05a-45a3-821d-a0d903b8924e',
  'ds-soiree-de-soutien-a-la-palestine-20261029-veynes-165',
  'Soirée de soutien à la Palestine',
  'Événement annoncé : Soirée de soutien à la Palestine. Lieu indiqué : Veynes (Veynes). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Veynes',
  '83830',
  'FR', 'Europe/Paris',
  'Veynes',
  43.577607, 6.520943, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5165',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bb763f84-c5f3-4641-bded-9a14dfc2031a',
  'ds-soutien-la-palestine-refleurira-20261030-eyguians-166',
  'SOutien  La Palestine refleurira',
  'Événement annoncé : SOutien  La Palestine refleurira. Lieu indiqué : Eyguians (Eyguians). Début prévu le 30/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Eyguians',
  '05300',
  'FR', 'Europe/Paris',
  'Eyguians',
  44.344344, 5.774277, NULL,
  '2026-10-30T17:00:00Z'::timestamptz,
  '2026-10-30T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5173',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2064f83e-9bb3-4f20-bc30-b4960f32d1b8',
  'ds-gilets-jaunes-x-gen-z-acte-iii-manif-d-halloween-20261031-gap-167',
  'Gilets Jaunes X Gen Z : acte III, manif'' d''Halloween !',
  'Événement annoncé : Gilets Jaunes X Gen Z : acte III, manif'' d''Halloween !. Lieu indiqué : Gap (Gap). Début prévu le 31/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Gap',
  '05000',
  'FR', 'Europe/Paris',
  'Gap',
  44.563233, 6.076778, NULL,
  '2026-10-31T13:00:00Z'::timestamptz,
  '2026-10-31T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5188',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c4cac997-e500-48eb-8a34-03d871c5c932',
  'ds-ensemble-pour-la-palestine-20261031-embrun-168',
  'Ensemble pour la Palestine !',
  'Événement annoncé : Ensemble pour la Palestine !. Lieu indiqué : Embrun (Embrun). Début prévu le 31/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Embrun',
  '05200',
  'FR', 'Europe/Paris',
  'Embrun',
  44.568046, 6.484718, NULL,
  '2026-10-31T17:30:00Z'::timestamptz,
  '2026-10-31T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5191',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '34b78096-483d-4ea0-8543-0fd85724616a',
  'ds-soiree-de-soutien-a-la-palestine-aiguilles-20261101-aiguilles-169',
  'Soirée de soutien à la Palestine - Aiguilles',
  'Événement annoncé : Soirée de soutien à la Palestine - Aiguilles. Lieu indiqué : Aiguilles (Aiguilles). Début prévu le 01/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Aiguilles',
  '83470',
  'FR', 'Europe/Paris',
  'Aiguilles',
  43.480749, 5.863628, NULL,
  '2026-11-01T16:00:00Z'::timestamptz,
  '2026-11-01T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5166',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '03bc4b53-ecd7-45aa-98fc-ff2178dfa901',
  'ds-soiree-de-soutien-palestine-gap-20261102-gap-170',
  'Soirée de soutien Palestine - Gap',
  'Événement annoncé : Soirée de soutien Palestine - Gap. Lieu indiqué : Gap (Gap). Début prévu le 02/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Gap',
  NULL,
  'FR', 'Europe/Paris',
  'Gap',
  44.55609, 6.077882, NULL,
  '2026-11-02T17:00:00Z'::timestamptz,
  '2026-11-02T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5174',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4ff66263-b925-4c45-9882-11fb58825a6a',
  'ds-table-d-ecriture-aux-enferme-e-s-20261104-gap-171',
  'Table d''écriture aux enfermé.e.s',
  'Événement annoncé : Table d''écriture aux enfermé.e.s. Lieu indiqué : Gap (Gap). Début prévu le 04/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Gap',
  NULL,
  'FR', 'Europe/Paris',
  'Gap',
  44.557769, 6.07849, NULL,
  '2026-11-04T17:30:00Z'::timestamptz,
  '2026-11-04T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5146',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '14132966-dbbd-4fa8-b34b-9f9a54731ceb',
  'ds-festival-d-impression-artisanale-et-experimentale-20261113-serres-172',
  'Festival d''impression artisanale et expérimentale',
  'Événement annoncé : Festival d''impression artisanale et expérimentale. Lieu indiqué : Serres (Serres). Début prévu le 13/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Serres',
  '83490',
  'FR', 'Europe/Paris',
  'Serres',
  43.483894, 6.563893, NULL,
  '2026-11-13T17:00:00Z'::timestamptz,
  '2026-11-13T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5182',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '110de5aa-e264-4893-82bb-9c4578045fdf',
  'ds-kino-court-metrage-decale-20261113-gap-173',
  'Kino Court métrage Décalé',
  'Événement annoncé : Kino Court métrage Décalé. Lieu indiqué : Gap (Gap). Début prévu le 13/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Gap',
  '05000',
  'FR', 'Europe/Paris',
  'Gap',
  44.563233, 6.076778, NULL,
  '2026-11-13T18:00:00Z'::timestamptz,
  '2026-11-13T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5131',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ebaf29ae-04d7-4421-847b-02ddad66590e',
  'ds-marche-climat-20261114-gap-174',
  'Marche climat',
  'Événement annoncé : Marche climat. Lieu indiqué : Gap (Gap). Début prévu le 14/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'climat',
  'Gap',
  '05000',
  'FR', 'Europe/Paris',
  'Gap',
  44.563233, 6.076778, NULL,
  '2026-11-14T13:00:00Z'::timestamptz,
  '2026-11-14T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5175',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9e7432cf-658f-4bd2-97f2-23a56b2e7a6a',
  'ds-festival-d-impression-artisanale-et-experimentale-20261114-serres-175',
  'Festival d''impression artisanale et expérimentale',
  'Événement annoncé : Festival d''impression artisanale et expérimentale. Lieu indiqué : Serres (Serres). Début prévu le 14/11/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Serres',
  '83490',
  'FR', 'Europe/Paris',
  'Serres',
  43.483894, 6.563893, NULL,
  '2026-11-14T13:30:00Z'::timestamptz,
  '2026-11-14T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5183',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b8697ecd-15bb-49d8-9801-1eeac18463a4',
  'ds-journee-internationale-contre-les-violences-faites-aux-femmes-20261124-gap-176',
  'Journée internationale contre les violences faites aux femmes',
  'Événement annoncé : Journée internationale contre les violences faites aux femmes. Lieu indiqué : Gap (Gap). Début prévu le 24/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Gap',
  '05000',
  'FR', 'Europe/Paris',
  'Gap',
  44.563233, 6.076778, NULL,
  '2026-11-24T18:00:00Z'::timestamptz,
  '2026-11-24T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5177',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '47f352e4-70fd-4405-a16b-e0fca20cdc65',
  'ds-permanence-saisonnier-e-s-agricoles-20261129-laragne-177',
  'Permanence saisonnier.e.s agricoles',
  'Événement annoncé : Permanence saisonnier.e.s agricoles. Lieu indiqué : Laragne (Laragne). Début prévu le 29/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Laragne',
  '05700',
  'FR', 'Europe/Paris',
  'Laragne',
  44.416059, 5.72309, NULL,
  '2026-11-29T09:00:00Z'::timestamptz,
  '2026-11-29T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5140',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '72a85c44-300a-4478-801a-93036ead95d6',
  'ds-3-jours-entre-meufs-pour-politiser-notre-rapport-a-la-montagne-20261211-nevache-178',
  '🏔️ 3 jours entre meufs pour politiser notre rapport à la montagne 🏔️',
  'Événement annoncé : 🏔️ 3 jours entre meufs pour politiser notre rapport à la montagne 🏔️. Lieu indiqué : Névache (Névache). Début prévu le 11/12/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Névache',
  '05100',
  'FR', 'Europe/Paris',
  'Névache',
  45.0194, 6.599508, NULL,
  '2026-12-11T10:00:00Z'::timestamptz,
  '2026-12-11T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://05.demosphere.net/rv/5148',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8d4b3eb3-060a-47ef-a50e-de7f35e289fe',
  'ds-reunion-d-orga-20261027-saint-girons-179',
  'RÉUNION D''ORGA',
  'Événement annoncé : RÉUNION D''ORGA. Lieu indiqué : Saint Girons (Saint Girons). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint Girons',
  43.544589, -0.813851, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19770',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '399b81d8-1cdd-4733-9e24-c50bd36bf2cc',
  'ds-linux-party-20261029-saint-girons-180',
  'LINUX PARTY',
  'Événement annoncé : LINUX PARTY. Lieu indiqué : Saint-Girons (Saint-Girons). Début prévu le 29/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint-Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint-Girons',
  43.544589, -0.813851, NULL,
  '2026-10-29T08:00:00Z'::timestamptz,
  '2026-10-29T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19771',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '021edffa-2ae7-46d7-8cd8-6b9233826e46',
  'ds-cafe-de-patate-20261029-saint-girons-181',
  'Café de patate',
  'Événement annoncé : Café de patate. Lieu indiqué : Saint Girons (Saint Girons). Début prévu le 29/10/2026 à 12:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint Girons',
  43.544589, -0.813851, NULL,
  '2026-10-29T11:30:00Z'::timestamptz,
  '2026-10-29T14:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19730',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd3711d41-4795-4228-a706-a27a8040b3ae',
  'ds-atelier-aquarelle-20261030-saint-girons-182',
  'ATELIER AQUARELLE',
  'Événement annoncé : ATELIER AQUARELLE. Lieu indiqué : Saint Girons (Saint Girons). Début prévu le 30/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint Girons',
  43.544589, -0.813851, NULL,
  '2026-10-30T14:00:00Z'::timestamptz,
  '2026-10-30T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19772',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '71315cb3-db0c-4fe9-8309-822922094cf6',
  'ds-cantine-solidaire-20261031-saint-girons-183',
  'Cantine Solidaire',
  'Événement annoncé : Cantine Solidaire. Lieu indiqué : Saint Girons (Saint Girons). Début prévu le 31/10/2026 à 12:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint Girons',
  43.544589, -0.813851, NULL,
  '2026-10-31T11:30:00Z'::timestamptz,
  '2026-10-31T14:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19740',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '68f1ec57-cd14-4bfd-8257-8212cc6cfda8',
  'ds-concert-youpi-20261101-saint-girons-184',
  'CONCERT YOUPI !',
  'Événement annoncé : CONCERT YOUPI !. Lieu indiqué : Saint Girons (Saint Girons). Début prévu le 01/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Girons',
  '64300',
  'FR', 'Europe/Paris',
  'Saint Girons',
  43.544589, -0.813851, NULL,
  '2026-11-01T17:00:00Z'::timestamptz,
  '2026-11-01T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19773',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'aeec44d3-39e4-4029-b5ba-c6e11347b291',
  'ds-winterreise-20261107-tourtouse-185',
  'Winterreise',
  'Événement annoncé : Winterreise. Lieu indiqué : Tourtouse (Tourtouse). Début prévu le 07/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tourtouse',
  '09230',
  'FR', 'Europe/Paris',
  'Tourtouse',
  43.09826, 1.122175, NULL,
  '2026-11-07T17:30:00Z'::timestamptz,
  '2026-11-07T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://ariege.demosphere.net/rv/19213',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3a0985d3-73d1-4a66-83f1-bb63db4d8ddc',
  'ds-appel-a-un-grand-rassemblement-unitaire-20261027-nice-186',
  'Appel à un grand rassemblement unitaire',
  'Événement annoncé : Appel à un grand rassemblement unitaire. Lieu indiqué : Nice (Nice). Début prévu le 27/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Nice',
  '73120',
  'FR', 'Europe/Paris',
  'Nice',
  45.43383, 6.635974, NULL,
  '2026-10-27T17:00:00Z'::timestamptz,
  '2026-10-27T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7070',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e79371c4-b5c4-42fb-8586-3ffcc3e7f1db',
  'ds-projection-rencontre-du-film-etre-s-vivant-20261028-luceram-187',
  'Projection-rencontre du film: ETRE(S) VIVANT',
  'Événement annoncé : Projection-rencontre du film: ETRE(S) VIVANT. Lieu indiqué : luceram (luceram). Début prévu le 28/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'luceram',
  NULL,
  'FR', 'Europe/Paris',
  'luceram',
  43.882133, 7.359109, NULL,
  '2026-10-28T13:30:00Z'::timestamptz,
  '2026-10-28T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7069',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '43d118fc-79c2-4a75-912b-03206f6b8abc',
  'ds-chocolat-et-logiques-neocoloniales-reclaiming-cocoa-avec-alternatiba06-20261029-nice-188',
  'Chocolat et logiques néocoloniales: "Reclaiming cocoa" avec Alternatiba06',
  'Événement annoncé : Chocolat et logiques néocoloniales: "Reclaiming cocoa" avec Alternatiba06. Lieu indiqué : Nice (Nice). Début prévu le 29/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  NULL,
  'FR', 'Europe/Paris',
  'Nice',
  43.709977, 7.284544, NULL,
  '2026-10-29T18:30:00Z'::timestamptz,
  '2026-10-29T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7054',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '045e7b75-c422-4884-afea-16e837ebb1eb',
  'ds-fete-de-l-arbre-a-greolieres-20261031-greolieres-189',
  'Fête de l''arbre à Gréolières',
  'Événement annoncé : Fête de l''arbre à Gréolières. Lieu indiqué : Gréolières (Gréolières). Début prévu le 31/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Gréolières',
  NULL,
  'FR', 'Europe/Paris',
  'Gréolières',
  43.809653, 6.878574, NULL,
  '2026-10-31T08:30:00Z'::timestamptz,
  '2026-10-31T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7068',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '798bbb09-82f1-48c5-9f9e-c80a5a983b4f',
  'ds-sartoux-festin-amap-avec-des-nombreux-ateliers-et-restauration-20261031-mouans-sartoux-190',
  'Sartoux - Festin''amap avec des nombreux ateliers et restauration',
  'Événement annoncé : Sartoux - Festin''amap avec des nombreux ateliers et restauration. Lieu indiqué : Mouans - Sartoux (Mouans - Sartoux). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mouans - Sartoux',
  '06370',
  'FR', 'Europe/Paris',
  'Mouans - Sartoux',
  43.638912, 6.986241, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7060',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1e9fc93d-be3f-4c30-82dd-6ec5fa55a901',
  'ds-assises-intergalatik-de-l-antifascisme-et-de-l-antiracisme-20261031-saorge-191',
  'Assises Intergalatik de l''antifascisme et de l''antiracisme',
  'Événement annoncé : Assises Intergalatik de l''antifascisme et de l''antiracisme. Lieu indiqué : Saorge (Saorge). Début prévu le 31/10/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Saorge',
  NULL,
  'FR', 'Europe/Paris',
  'Saorge',
  43.988452, 7.551995, NULL,
  '2026-10-31T09:30:00Z'::timestamptz,
  '2026-10-31T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7064',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0d398f86-5a40-4669-a6a4-c92705b7a916',
  'ds-kidical-mass-veloween-la-velorution-des-pitchouns-20261031-nice-192',
  'Kidical Mass Véloween - La vélorution des pitchouns',
  'Événement annoncé : Kidical Mass Véloween - La vélorution des pitchouns. Lieu indiqué : Nice (Nice). Début prévu le 31/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  '73120',
  'FR', 'Europe/Paris',
  'Nice',
  45.43383, 6.635974, NULL,
  '2026-10-31T13:30:00Z'::timestamptz,
  '2026-10-31T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7044',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8bf1a51d-1ab3-4020-b2bf-c049801a6712',
  'ds-assises-intergalatik-de-l-antifascisme-et-de-l-antiracisme-20261101-saorge-193',
  'Assises Intergalatik de l''antifascisme et de l''antiracisme',
  'Événement annoncé : Assises Intergalatik de l''antifascisme et de l''antiracisme. Lieu indiqué : Saorge (Saorge). Début prévu le 01/11/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Saorge',
  NULL,
  'FR', 'Europe/Paris',
  'Saorge',
  43.988452, 7.551995, NULL,
  '2026-11-01T09:30:00Z'::timestamptz,
  '2026-11-01T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7065',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '111b00cd-9c83-460b-92ec-719513bfed22',
  'ds-lancement-de-la-securite-sociale-de-l-alimentation-a-nice-20261103-nice-194',
  'Lancement de la sécurité sociale de l''alimentation à Nice',
  'Événement annoncé : Lancement de la sécurité sociale de l''alimentation à Nice. Lieu indiqué : Nice (Nice). Début prévu le 03/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  NULL,
  'FR', 'Europe/Paris',
  'Nice',
  43.713471, 7.258943, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  '2026-11-03T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7062',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b097cc21-76dc-41ce-843c-f5ef45edd133',
  'ds-greve-et-des-manifestations-interprofessionnelles-20261105-nice-195',
  'grève et des manifestations interprofessionnelles',
  'Événement annoncé : grève et des manifestations interprofessionnelles. Lieu indiqué : Nice (Nice). Début prévu le 05/11/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Nice',
  NULL,
  'FR', 'Europe/Paris',
  'Nice',
  43.70094, 7.2801, NULL,
  '2026-11-05T08:30:00Z'::timestamptz,
  '2026-11-05T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7059',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd1396e0f-7eba-4e65-a5c1-3e459d085109',
  'ds-insecticide-comment-l-agrochimie-a-tue-les-insectes-20261106-nice-196',
  '"Insecticide, comment l''agrochimie a tué les insectes"',
  'Événement annoncé : "Insecticide, comment l''agrochimie a tué les insectes". Lieu indiqué : Nice (Nice). Début prévu le 06/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  '73120',
  'FR', 'Europe/Paris',
  'Nice',
  45.43383, 6.635974, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  '2026-11-06T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7029',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fbcb9b6e-7ef6-4824-b047-2523dda49618',
  'ds-vers-une-alimentation-saine-discussion-autour-des-perturbateurs-endocr-20261107-nice-197',
  'Vers une alimentation saine : discussion autour des perturbateurs endocriniens',
  'Événement annoncé : Vers une alimentation saine : discussion autour des perturbateurs endocriniens. Lieu indiqué : Nice (Nice). Début prévu le 07/11/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  NULL,
  'FR', 'Europe/Paris',
  'Nice',
  43.709406, 7.261736, NULL,
  '2026-11-07T13:30:00Z'::timestamptz,
  '2026-11-07T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7026',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '745f5635-b5ee-4e88-8006-08eba6e6454a',
  'ds-film-pilleurs-de-terre-20261114-nice-198',
  'film : Pilleurs de terre',
  'Événement annoncé : film : Pilleurs de terre. Lieu indiqué : Nice (Nice). Début prévu le 14/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  '73120',
  'FR', 'Europe/Paris',
  'Nice',
  45.43383, 6.635974, NULL,
  '2026-11-14T18:00:00Z'::timestamptz,
  '2026-11-14T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7030',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'afcaf496-ea74-458d-ac65-b95b18789be9',
  'ds-film-pilleurs-de-terre-20261120-nice-199',
  'Film : Pilleurs de terre',
  'Événement annoncé : Film : Pilleurs de terre. Lieu indiqué : Nice (Nice). Début prévu le 20/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nice',
  '73120',
  'FR', 'Europe/Paris',
  'Nice',
  45.43383, 6.635974, NULL,
  '2026-11-20T18:00:00Z'::timestamptz,
  '2026-11-20T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://nice.demosphere.net/rv/7031',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7799bbd8-1d34-4cf1-90d8-8f417223c05e',
  'ds-les-capitalistes-anonymes-atelier-les-marches-du-pouvoir-20261027-merignac-200',
  'Les Capitalistes Anonymes - Atelier les marches du pouvoir',
  'Événement annoncé : Les Capitalistes Anonymes - Atelier les marches du pouvoir. Lieu indiqué : Mérignac (Mérignac). Début prévu le 27/10/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mérignac',
  '33700',
  'FR', 'Europe/Paris',
  'Mérignac',
  44.83852, -0.622997, NULL,
  '2026-10-27T17:45:00Z'::timestamptz,
  '2026-10-27T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16969',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1b9aaef0-15f5-4a6e-bc01-0337383d03ff',
  'ds-la-prairie-du-belier-savant-presentation-du-projet-d-ecolieu-20261027-en-ligne-201',
  'La Prairie du Bélier Savant - Présentation du projet d''écolieu',
  'Événement annoncé : La Prairie du Bélier Savant - Présentation du projet d''écolieu. Lieu indiqué : En ligne (En ligne). Début prévu le 27/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'En ligne',
  '73260',
  'FR', 'Europe/Paris',
  'En ligne',
  45.560464, 6.467978, NULL,
  '2026-10-27T18:30:00Z'::timestamptz,
  '2026-10-27T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16895',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3be09f94-68fe-4da6-b086-f6641e8acd0f',
  'ds-cercle-de-silence-pour-gaza-et-le-peuple-palestinien-20261028-bordeaux-202',
  'Cercle de silence pour Gaza et le peuple palestinien',
  'Événement annoncé : Cercle de silence pour Gaza et le peuple palestinien. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17010',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a399dbb0-cc94-4ed3-bec5-d194cf000510',
  'ds-rencontre-les-femmes-anarchistes-et-la-revolution-espagnole-20261028-bordeaux-203',
  'Rencontre - Les femmes anarchistes et la révolution espagnole',
  'Événement annoncé : Rencontre - Les femmes anarchistes et la révolution espagnole. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17019',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b10b1fde-3b40-4241-9d47-96ada4cc1578',
  'ds-soiree-cnt-gironde-atelier-linux-et-papotages-revolutionnaires-20261029-bordeaux-204',
  'Soirée CNT Gironde : Atelier Linux et papotages revolutionnaires',
  'Événement annoncé : Soirée CNT Gironde : Atelier Linux et papotages revolutionnaires. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17057',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8725b31a-1283-417e-9bc7-01fd999bfd57',
  'ds-projection-rencontre-felix-castan-un-philosophe-occitan-20261029-begles-205',
  'Projection-Rencontre- "Félix Castan un philosophe occitan"',
  'Événement annoncé : Projection-Rencontre- "Félix Castan un philosophe occitan". Lieu indiqué : Bègles (Bègles). Début prévu le 29/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bègles',
  '33130',
  'FR', 'Europe/Paris',
  'Bègles',
  44.81313, -0.564501, NULL,
  '2026-10-29T19:00:00Z'::timestamptz,
  '2026-10-29T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17054',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '71c78779-927d-47d2-84d4-647162d54381',
  'ds-cercle-de-silence-pour-gaza-et-le-peuple-palestinien-20261104-bordeaux-206',
  'Cercle de silence pour Gaza et le peuple palestinien',
  'Événement annoncé : Cercle de silence pour Gaza et le peuple palestinien. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 04/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-04T17:00:00Z'::timestamptz,
  '2026-11-04T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17011',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2c2eccce-5b7b-4f4d-907f-eca61d151cc9',
  'ds-rencontre-surrealistes-et-revolution-espagnole-par-lie-collectif-liber-20261104-bordeaux-207',
  'Rencontre - "Surréalistes et révolution espagnole", par lie Collectif Libertaire de Gironde',
  'Événement annoncé : Rencontre - "Surréalistes et révolution espagnole", par lie Collectif Libertaire de Gironde. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 04/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-04T18:00:00Z'::timestamptz,
  '2026-11-04T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16991',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '27f20d0a-80e9-42aa-b849-0702b483ce7d',
  'ds-cine-debat-the-true-cost-qui-paye-reellement-le-prix-de-vos-vetements-20261105-bordeaux-208',
  'Ciné-débat - "The True Cost" : qui paye réellement le prix de vos vêtements ?',
  'Événement annoncé : Ciné-débat - "The True Cost" : qui paye réellement le prix de vos vêtements ?. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 05/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-05T17:00:00Z'::timestamptz,
  '2026-11-05T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17053',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c226306a-3ae2-48fb-826d-a16f2f4a2f0b',
  'ds-evenement-populaire-pour-un-syndicalisme-antimilitariste-20261107-bordeaux-209',
  'Évènement populaire pour un syndicalisme antimilitariste',
  'Événement annoncé : Évènement populaire pour un syndicalisme antimilitariste. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 07/11/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-07T13:30:00Z'::timestamptz,
  '2026-11-07T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17034',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a64f9d3b-aa26-4368-950b-855a1e0837c8',
  'ds-conference-gesticulee-upb-rsa-guerre-aux-pauvres-et-paix-sociale-20261107-bordeaux-210',
  'Conférence gesticulée UPB - RSA, guerre aux pauvres et paix sociale',
  'Événement annoncé : Conférence gesticulée UPB - RSA, guerre aux pauvres et paix sociale. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 07/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-07T16:00:00Z'::timestamptz,
  '2026-11-07T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17040',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '51e0f245-19a0-4f3b-a3b9-a82fd83a91f2',
  'ds-concert-cockney-rejects-arene-6-ramblin-firm-20261107-bordeaux-211',
  'Concert - Cockney Rejects - Arene 6 - Ramblin'' Firm',
  'Événement annoncé : Concert - Cockney Rejects - Arene 6 - Ramblin'' Firm. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 07/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-07T18:30:00Z'::timestamptz,
  '2026-11-07T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16997',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd1bb5812-c67b-45cc-8ef1-c49cc3c4bc6c',
  'ds-les-capitalistes-anonymes-20261109-merignac-212',
  'Les Capitalistes Anonymes',
  'Événement annoncé : Les Capitalistes Anonymes. Lieu indiqué : Mérignac (Mérignac). Début prévu le 09/11/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mérignac',
  '33700',
  'FR', 'Europe/Paris',
  'Mérignac',
  44.83852, -0.622997, NULL,
  '2026-11-09T17:45:00Z'::timestamptz,
  '2026-11-09T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16970',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0d3d55dc-55db-4574-9864-0d777e7ec718',
  'ds-festival-alimenterre-cine-debat-outre-mer-20261110-pondaurat-213',
  'Festival AlimenTerre - Ciné-débat "Outre-mer"',
  'Événement annoncé : Festival AlimenTerre - Ciné-débat "Outre-mer". Lieu indiqué : Pondaurat (Pondaurat). Début prévu le 10/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Pondaurat',
  '33190',
  'FR', 'Europe/Paris',
  'Pondaurat',
  44.535287, -0.088513, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  '2026-11-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17049',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0d61814b-5ea3-42f1-9c1a-2c713f676ab0',
  'ds-projection-julian-assange-6-billion-dollar-man-20261110-bordeaux-214',
  'Projection - Julian Assange : "6 Billion Dollar Man"',
  'Événement annoncé : Projection - Julian Assange : "6 Billion Dollar Man". Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 10/11/2026 à 19:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-10T18:45:00Z'::timestamptz,
  '2026-11-10T21:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17005',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8bb0ea8b-c1f3-4630-99bc-53829d7d15a5',
  'ds-concert-ph-laval-r-bourbon-b-laurent-20261111-begles-215',
  'Concert - Ph. Laval R. Bourbon B. Laurent',
  'Événement annoncé : Concert - Ph. Laval R. Bourbon B. Laurent. Lieu indiqué : Bègles (Bègles). Début prévu le 11/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bègles',
  '33130',
  'FR', 'Europe/Paris',
  'Bègles',
  44.81313, -0.564501, NULL,
  '2026-11-11T18:30:00Z'::timestamptz,
  '2026-11-11T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17056',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7af296fc-5576-4106-9f62-c5f1537fbbf9',
  'ds-arpentage-upb-le-contrat-racial-de-charles-w-mills-20261115-bordeaux-216',
  'Arpentage UPB - "Le contrat racial" de Charles W Mills',
  'Événement annoncé : Arpentage UPB - "Le contrat racial" de Charles W Mills. Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 15/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-15T13:00:00Z'::timestamptz,
  '2026-11-15T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16878',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bd3758e7-8c93-434c-853f-439af4d3b305',
  'ds-burdiparty-10-ans-de-burdigala-records-punk-diy-20261120-bordeaux-217',
  'Burdiparty - 10 ans de Burdigala Records (punk DIY)',
  'Événement annoncé : Burdiparty - 10 ans de Burdigala Records (punk DIY). Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 20/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-20T18:30:00Z'::timestamptz,
  '2026-11-20T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16987',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0627c804-eb5c-4c3a-82af-b695dd5ad3c7',
  'ds-repair-cafe-bordeaux-session-de-co-reparation-20261121-le-bouscat-218',
  'Repair Café Bordeaux - Session de co-réparation',
  'Événement annoncé : Repair Café Bordeaux - Session de co-réparation. Lieu indiqué : Le Bouscat (Le Bouscat). Début prévu le 21/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Bouscat',
  '33110',
  'FR', 'Europe/Paris',
  'Le Bouscat',
  44.866044, -0.618773, NULL,
  '2026-11-21T09:00:00Z'::timestamptz,
  '2026-11-21T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17055',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd5c1101c-dc94-43e4-99f0-5d8f355ea7ad',
  'ds-burdiparty-10-ans-de-burdigala-records-punk-diy-20261121-bordeaux-219',
  'Burdiparty - 10 ans de Burdigala Records (punk DIY)',
  'Événement annoncé : Burdiparty - 10 ans de Burdigala Records (punk DIY). Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 21/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-21T18:30:00Z'::timestamptz,
  '2026-11-21T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16989',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eeb7dce7-54b5-48af-9d1e-4f206464f706',
  'ds-festival-alimenterre-cine-debat-insecticide-repas-20261122-pondaurat-220',
  'Festival AlimenTerre - Ciné-débat - "Insecticide" + Repas',
  'Événement annoncé : Festival AlimenTerre - Ciné-débat - "Insecticide" + Repas. Lieu indiqué : Pondaurat (Pondaurat). Début prévu le 22/11/2026 à 13:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Pondaurat',
  '33190',
  'FR', 'Europe/Paris',
  'Pondaurat',
  44.535287, -0.088513, NULL,
  '2026-11-22T12:00:00Z'::timestamptz,
  '2026-11-22T15:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17050',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c26b5834-8dd2-490d-b982-999d8cf05dae',
  'ds-les-capitalistes-anonymes-20261124-merignac-221',
  'Les Capitalistes Anonymes',
  'Événement annoncé : Les Capitalistes Anonymes. Lieu indiqué : Mérignac (Mérignac). Début prévu le 24/11/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mérignac',
  '33700',
  'FR', 'Europe/Paris',
  'Mérignac',
  44.83852, -0.622997, NULL,
  '2026-11-24T17:45:00Z'::timestamptz,
  '2026-11-24T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16971',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4195650e-4148-4e7b-b3cf-3879fc147326',
  'ds-exposition-dominants-dominees-20261125-libourne-222',
  'Exposition - Dominants-Dominées',
  'Événement annoncé : Exposition - Dominants-Dominées. Lieu indiqué : Libourne (Libourne). Début prévu le 25/11/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Libourne',
  '33240',
  'FR', 'Europe/Paris',
  'Libourne',
  44.987503, -0.419246, NULL,
  '2026-11-25T10:00:00Z'::timestamptz,
  '2026-11-25T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17032',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3180b3a7-e8d3-4cd3-8dcb-7bc6939125a0',
  'ds-rencontre-f-gomez-folies-d-espagne-ombres-et-lumieres-d-un-anarchisme--20261125-bordeaux-223',
  'Rencontre - F. Gomez : "Folies d''Espagne, ombres et lumières d''un anarchisme de guerre"',
  'Événement annoncé : Rencontre - F. Gomez : "Folies d''Espagne, ombres et lumières d''un anarchisme de guerre". Lieu indiqué : Bordeaux (Bordeaux). Début prévu le 25/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordeaux',
  '16000',
  'FR', 'Europe/Paris',
  'Bordeaux',
  45.647524, 0.142652, NULL,
  '2026-11-25T18:00:00Z'::timestamptz,
  '2026-11-25T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16992',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c0cc3039-79d9-4773-aa3d-30122274fc8c',
  'ds-exposition-dominants-dominees-20261126-libourne-224',
  'Exposition - Dominants-Dominées',
  'Événement annoncé : Exposition - Dominants-Dominées. Lieu indiqué : Libourne (Libourne). Début prévu le 26/11/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Libourne',
  '33240',
  'FR', 'Europe/Paris',
  'Libourne',
  44.987503, -0.419246, NULL,
  '2026-11-26T10:00:00Z'::timestamptz,
  '2026-11-26T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/17033',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd928e782-ade8-4681-aa4c-6a3fd6cecc01',
  'ds-la-prairie-du-belier-savant-presentation-du-projet-d-ecolieu-20261201-en-ligne-225',
  'La Prairie du Bélier Savant - Présentation du projet d''écolieu',
  'Événement annoncé : La Prairie du Bélier Savant - Présentation du projet d''écolieu. Lieu indiqué : En ligne (En ligne). Début prévu le 01/12/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'En ligne',
  '73260',
  'FR', 'Europe/Paris',
  'En ligne',
  45.560464, 6.467978, NULL,
  '2026-12-01T18:30:00Z'::timestamptz,
  '2026-12-01T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16897',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0e189357-dc99-44f8-953d-ad6dd98c8eb8',
  'ds-les-capitalistes-anonymes-20261207-merignac-226',
  'Les Capitalistes Anonymes',
  'Événement annoncé : Les Capitalistes Anonymes. Lieu indiqué : Mérignac (Mérignac). Début prévu le 07/12/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mérignac',
  '33700',
  'FR', 'Europe/Paris',
  'Mérignac',
  44.83852, -0.622997, NULL,
  '2026-12-07T17:45:00Z'::timestamptz,
  '2026-12-07T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16972',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '780d8009-3018-4fa1-967b-83bbe9e7aba5',
  'ds-les-capitalistes-anonymes-20261222-merignac-227',
  'Les Capitalistes Anonymes',
  'Événement annoncé : Les Capitalistes Anonymes. Lieu indiqué : Mérignac (Mérignac). Début prévu le 22/12/2026 à 18:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mérignac',
  '33700',
  'FR', 'Europe/Paris',
  'Mérignac',
  44.83852, -0.622997, NULL,
  '2026-12-22T17:45:00Z'::timestamptz,
  '2026-12-22T20:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://gironde.demosphere.net/rv/16973',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0d6ce9b1-3309-4aa5-ba8a-d0f3522ca1e4',
  'ds-projets-photo-voltaiques-film-documentaire-l-ombre-des-miroirs-20261027-saint-paul-cap-de-joux-22',
  '[Projets photo-voltaïques] Film Documentaire L''ombre des miroirs',
  'Événement annoncé : [Projets photo-voltaïques] Film Documentaire L''ombre des miroirs. Lieu indiqué : Saint-Paul Cap de Joux (Saint-Paul Cap de Joux). Début prévu le 27/10/2026 à 20:15 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint-Paul Cap de Joux',
  '81300',
  'FR', 'Europe/Paris',
  'Saint-Paul Cap de Joux',
  43.746179, 1.992531, NULL,
  '2026-10-27T19:15:00Z'::timestamptz,
  '2026-10-27T22:15:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26119',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8f02a0f5-a677-4eb6-a69a-d25000ce2198',
  'ds-concert-duo-marambu-20261027-albi-229',
  'CONCERT DUO MARAMBU',
  'Événement annoncé : CONCERT DUO MARAMBU. Lieu indiqué : Albi (Albi). Début prévu le 27/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.929202, 2.146931, NULL,
  '2026-10-27T19:30:00Z'::timestamptz,
  '2026-10-27T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25823',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f1598f9a-2263-44e1-ba20-426fc991de71',
  'ds-le-voyage-de-camilo-20261028-labruguiere-230',
  'Le Voyage de Camilo',
  'Événement annoncé : Le Voyage de Camilo. Lieu indiqué : Labruguière (Labruguière). Début prévu le 28/10/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labruguière',
  NULL,
  'FR', 'Europe/Paris',
  'Labruguière',
  43.538428, 2.26235, NULL,
  '2026-10-28T09:30:00Z'::timestamptz,
  '2026-10-28T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25747',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'df6364fd-a802-412e-a5b3-4f175b86718b',
  'ds-atelier-apparitions-20261028-albi-231',
  'Atelier « Apparitions »',
  'Événement annoncé : Atelier « Apparitions ». Lieu indiqué : Albi (Albi). Début prévu le 28/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.925811, 2.138539, NULL,
  '2026-10-28T14:00:00Z'::timestamptz,
  '2026-10-28T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25499',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4fcec186-390d-436f-83df-6992b3a374e4',
  'ds-l-histoire-du-monde-revue-et-corrigee-un-spectacle-familial-20261028-lautrec-232',
  'L’histoire du monde revue et corrigée // Un spectacle familial',
  'Événement annoncé : L’histoire du monde revue et corrigée // Un spectacle familial. Lieu indiqué : Lautrec (Lautrec). Début prévu le 28/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-10-28T14:30:00Z'::timestamptz,
  '2026-10-28T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26014',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7af12896-5032-42d2-8e9a-1fce62aaa954',
  'ds-concert-de-tango-et-bal-gratuit-20261028-albi-233',
  'concert de tango et bal (gratuit)',
  'Événement annoncé : concert de tango et bal (gratuit). Lieu indiqué : Albi (Albi). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  '81000',
  'FR', 'Europe/Paris',
  'Albi',
  43.930374, 2.136314, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25824',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '419903a5-e5e2-4654-9527-62145769141c',
  'ds-stage-decouverte-tango-argentin-20261029-albi-234',
  'STAGE DECOUVERTE TANGO ARGENTIN',
  'Événement annoncé : STAGE DECOUVERTE TANGO ARGENTIN. Lieu indiqué : Albi (Albi). Début prévu le 29/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.929202, 2.146931, NULL,
  '2026-10-29T13:00:00Z'::timestamptz,
  '2026-10-29T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25932',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '93ba9da3-5535-486a-8f56-b1d04c05155d',
  'ds-2-films-argentins-dans-le-cadre-d-argentina-fest-20261029-albi-235',
  '2 FILMS ARGENTINS dans le cadre d''ARGENTINA FEST',
  'Événement annoncé : 2 FILMS ARGENTINS dans le cadre d''ARGENTINA FEST. Lieu indiqué : Albi (Albi). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.923399, 2.145024, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25825',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a2135e76-5cc1-4729-861a-f8aae608ea40',
  'ds-le-colporteur-d-images-les-15-ans-au-cafe-plum-20261029-lautrec-236',
  'Le Colporteur d''Images : Les 15 ans ! au Café Plùm',
  'Événement annoncé : Le Colporteur d''Images : Les 15 ans ! au Café Plùm. Lieu indiqué : Lautrec (Lautrec). Début prévu le 29/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-10-29T19:00:00Z'::timestamptz,
  '2026-10-29T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26077',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e4c14801-1ca6-4c72-83fa-55fc4a362b67',
  'ds-les-primeurs-de-castres-20261030-castres-237',
  'LES PRIMEURS DE CASTRES',
  'Événement annoncé : LES PRIMEURS DE CASTRES. Lieu indiqué : Castres (Castres). Début prévu le 30/10/2026 à 03:33 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Castres',
  '48100',
  'FR', 'Europe/Paris',
  'Castres',
  44.575647, 3.276382, NULL,
  '2026-10-30T02:33:00Z'::timestamptz,
  '2026-10-30T05:33:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25356',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '51eddaf2-1e57-4adb-b5d6-95fedb9855a7',
  'ds-conference-repas-concert-tangonella-20261030-albi-238',
  'CONFERENCE/REPAS/CONCERT TANGONELLA',
  'Événement annoncé : CONFERENCE/REPAS/CONCERT TANGONELLA. Lieu indiqué : Albi (Albi). Début prévu le 30/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.929202, 2.146931, NULL,
  '2026-10-30T17:30:00Z'::timestamptz,
  '2026-10-30T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25826',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bbc4ad68-43fb-4175-87cc-69b5d4d1e628',
  'ds-rencontre-avec-elodie-potente-fiertes-des-champs-20261030-carmaux-239',
  'Rencontre avec Elodie Potente // Fiertés des champs',
  'Événement annoncé : Rencontre avec Elodie Potente // Fiertés des champs. Lieu indiqué : Carmaux (Carmaux). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.049912, 2.157869, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26135',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7a42ee6c-e5c9-40c5-bb96-7677a8272adb',
  'ds-visite-a-la-lampe-torche-quand-brillent-les-fantomes-20261030-albi-240',
  'Visite à la lampe torche : Quand brillent les fantômes',
  'Événement annoncé : Visite à la lampe torche : Quand brillent les fantômes. Lieu indiqué : Albi (Albi). Début prévu le 30/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.925811, 2.138539, NULL,
  '2026-10-30T19:30:00Z'::timestamptz,
  '2026-10-30T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25494',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2aa4912f-8f32-4333-9977-b1096e806d94',
  'ds-theatre-d-improvisation-avec-la-troupe-les-particules-la-grande-scene-20261030-albi-241',
  'Théâtre d''improvisation avec la troupe les Particules - La grande scène',
  'Événement annoncé : Théâtre d''improvisation avec la troupe les Particules - La grande scène. Lieu indiqué : Albi (Albi). Début prévu le 30/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.936197, 2.194725, NULL,
  '2026-10-30T19:30:00Z'::timestamptz,
  '2026-10-30T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26004',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1591db62-c425-42ad-845f-772f6e292116',
  'ds-grace-et-volupte-van-van-rap-electro-punk-20261030-lautrec-242',
  'Grace et Volupté Van Van // Rap électro-punk',
  'Événement annoncé : Grace et Volupté Van Van // Rap électro-punk. Lieu indiqué : Lautrec (Lautrec). Début prévu le 30/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-10-30T20:00:00Z'::timestamptz,
  '2026-10-30T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26015',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7a4ab9c5-56b7-4d3c-aa37-8c0db79bb66c',
  'ds-festival-de-theatre-les-artomnes-20261030-carmaux-243',
  'Festival de Théâtre Les Artomnes',
  'Événement annoncé : Festival de Théâtre Les Artomnes. Lieu indiqué : Carmaux (Carmaux). Début prévu le 30/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.046255, 2.158047, NULL,
  '2026-10-30T20:00:00Z'::timestamptz,
  '2026-10-30T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26031',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1384dd53-a71b-4b45-9a85-9d87282fc11d',
  'ds-concert-de-fin-de-saison-138-los-siluros-tropical-punk-psychedelique-20261030-salvagnac-244',
  'Concert de fin de saison > 138 LOS SILUROS Tropical punk psychédélique',
  'Événement annoncé : Concert de fin de saison > 138 LOS SILUROS Tropical punk psychédélique. Lieu indiqué : Salvagnac (Salvagnac). Début prévu le 30/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Salvagnac',
  NULL,
  'FR', 'Europe/Paris',
  'Salvagnac',
  43.905942, 1.688053, NULL,
  '2026-10-30T20:00:00Z'::timestamptz,
  '2026-10-30T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26122',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '14862af5-8f38-4339-8325-7de0ae989721',
  'ds-soiree-metal-halloween-ozmosya-narcisse-20261030-livers-cazelles-245',
  'SOIRÉE METAL HALLOWEEN : OZMOSYA + NARCISSE',
  'Événement annoncé : SOIRÉE METAL HALLOWEEN : OZMOSYA + NARCISSE. Lieu indiqué : Livers-Cazelles (Livers-Cazelles). Début prévu le 30/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Livers-Cazelles',
  NULL,
  'FR', 'Europe/Paris',
  'Livers-Cazelles',
  44.047959, 1.998204, NULL,
  '2026-10-30T20:00:00Z'::timestamptz,
  '2026-10-30T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26132',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5759c3d8-66c0-45a5-9b0c-99380837a3b0',
  'ds-atelier-d-ecriture-creative-gratuit-ouvert-a-tous-tes-20261031-carmaux-246',
  'ATELIER D''ÉCRITURE CRÉATIVE (gratuit) Ouvert à tous·tes',
  'Événement annoncé : ATELIER D''ÉCRITURE CRÉATIVE (gratuit) Ouvert à tous·tes. Lieu indiqué : Carmaux (Carmaux). Début prévu le 31/10/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.05309, 2.155176, NULL,
  '2026-10-31T09:30:00Z'::timestamptz,
  '2026-10-31T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25653',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f99b0209-c8c7-4b50-b9ae-af273aaf4efe',
  'ds-exposition-repliques-fragments-plongees-isabelle-giovacchini-20261031-albi-247',
  'Exposition « Répliques, fragments, plongées » | Isabelle Giovacchini',
  'Événement annoncé : Exposition « Répliques, fragments, plongées » | Isabelle Giovacchini. Lieu indiqué : Albi (Albi). Début prévu le 31/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.925811, 2.138539, NULL,
  '2026-10-31T12:30:00Z'::timestamptz,
  '2026-10-31T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25256',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6bd0bf63-6a95-4423-be73-713cc76033b9',
  'ds-festival-de-theatre-les-artomnes-20261031-carmaux-248',
  'Festival de Théâtre Les Artomnes',
  'Événement annoncé : Festival de Théâtre Les Artomnes. Lieu indiqué : Carmaux (Carmaux). Début prévu le 31/10/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.046255, 2.158047, NULL,
  '2026-10-31T16:00:00Z'::timestamptz,
  '2026-10-31T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26032',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '24bf0105-fd4e-4791-8153-93b945d894ec',
  'ds-halloween-2026-ca-va-gnaquer-avec-les-dj-s-melted-modular-jean-michel--20261031-salvagnac-249',
  'HALLOWEEN 2026 - Ca va gnaquer ! Avec les DJ''s Melted Modular + Jean-Michel Sature',
  'Événement annoncé : HALLOWEEN 2026 - Ca va gnaquer ! Avec les DJ''s Melted Modular + Jean-Michel Sature. Lieu indiqué : Salvagnac (Salvagnac). Début prévu le 31/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Salvagnac',
  NULL,
  'FR', 'Europe/Paris',
  'Salvagnac',
  43.905942, 1.688053, NULL,
  '2026-10-31T17:00:00Z'::timestamptz,
  '2026-10-31T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26124',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6231ecd5-f702-49f1-a476-03cb58744e33',
  'ds-concert-cuarteto-tajy-20261031-lautrec-250',
  'concert CUARTETO TAJY',
  'Événement annoncé : concert CUARTETO TAJY. Lieu indiqué : Lautrec (Lautrec). Début prévu le 31/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-10-31T19:30:00Z'::timestamptz,
  '2026-10-31T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25827',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '052cbc99-4690-454a-b602-5931ead02e8f',
  'ds-theatre-d-improvisation-avec-les-particules-moisson-mortelle-20261031-livers-cazelles-251',
  'Théâtre d''improvisation avec les Particules - Moisson Mortelle',
  'Événement annoncé : Théâtre d''improvisation avec les Particules - Moisson Mortelle. Lieu indiqué : Livers Cazelles (Livers Cazelles). Début prévu le 31/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Livers Cazelles',
  '81170',
  'FR', 'Europe/Paris',
  'Livers Cazelles',
  44.050581, 2.01567, NULL,
  '2026-10-31T19:30:00Z'::timestamptz,
  '2026-10-31T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26006',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f7ac4fb0-1efb-41a3-9f18-ab0fe4322d0b',
  'ds-bal-occitan-20261031-roumegoux-252',
  'Bal occitan',
  'Événement annoncé : Bal occitan. Lieu indiqué : Roumegoux (Roumegoux). Début prévu le 31/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Roumegoux',
  NULL,
  'FR', 'Europe/Paris',
  'Roumegoux',
  43.79968, 2.264015, NULL,
  '2026-10-31T20:00:00Z'::timestamptz,
  '2026-10-31T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25800',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '115afa87-e441-49f4-a2db-07bc25cb9b49',
  'ds-atelier-kiffe-ta-pre-menopause-20261101-monesties-253',
  'Atelier Kiffe ta (pré)ménopause',
  'Événement annoncé : Atelier Kiffe ta (pré)ménopause. Lieu indiqué : Monestiés (Monestiés). Début prévu le 01/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Monestiés',
  NULL,
  'FR', 'Europe/Paris',
  'Monestiés',
  44.07075, 2.096881, NULL,
  '2026-11-01T14:00:00Z'::timestamptz,
  '2026-11-01T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26129',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd1d50348-f4c9-49d0-be19-f4e955997570',
  'ds-arpentage-la-charge-raciale-au-cafe-plum-20261101-lautrec-254',
  'Arpentage // « La charge raciale » au Café Plùm',
  'Événement annoncé : Arpentage // « La charge raciale » au Café Plùm. Lieu indiqué : Lautrec (Lautrec). Début prévu le 01/11/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-11-01T14:30:00Z'::timestamptz,
  '2026-11-01T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26078',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c88501dd-f95a-47e5-9b71-c3bd9d76b906',
  'ds-rencontre-librairie-avec-douce-dibondo-20261103-carmaux-255',
  'Rencontre librairie avec DOUCE DIBONDO',
  'Événement annoncé : Rencontre librairie avec DOUCE DIBONDO. Lieu indiqué : Carmaux (Carmaux). Début prévu le 03/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.049912, 2.157869, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  '2026-11-03T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26133',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '207a0201-849c-4735-b6df-2f188890e1b5',
  'ds-rencontre-avec-douce-dibondo-autour-de-son-livre-le-mouvement-au-cafe--20261105-lautrec-256',
  'Rencontre avec Douce Dibondo autour de son livre « Le mouvement » au Café Plùm',
  'Événement annoncé : Rencontre avec Douce Dibondo autour de son livre « Le mouvement » au Café Plùm. Lieu indiqué : Lautrec (Lautrec). Début prévu le 05/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-11-05T17:00:00Z'::timestamptz,
  '2026-11-05T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26081',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0315a968-5633-4eab-8e16-b0f94f13dc5b',
  'ds-cafe-asso-de-la-crouzie-20261106-tanus-257',
  'Café asso de la Crouzié',
  'Événement annoncé : Café asso de la Crouzié. Lieu indiqué : Tanus (Tanus). Début prévu le 06/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tanus',
  NULL,
  'FR', 'Europe/Paris',
  'Tanus',
  44.095027, 2.282456, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  '2026-11-06T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25988',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0bcdd380-4d0b-4b1c-8805-15bcccf4653d',
  'ds-les-lecons-impertinentes-de-zou-hors-saison-au-cafe-plum-20261106-lautrec-258',
  'Les Leçons Impertinentes de Zou #Hors saison au Café Plùm',
  'Événement annoncé : Les Leçons Impertinentes de Zou #Hors saison au Café Plùm. Lieu indiqué : Lautrec (Lautrec). Début prévu le 06/11/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lautrec',
  NULL,
  'FR', 'Europe/Paris',
  'Lautrec',
  43.705878, 2.137737, NULL,
  '2026-11-06T20:00:00Z'::timestamptz,
  '2026-11-06T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26082',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a0d95d83-c80a-4588-b91d-51ff950d02d1',
  'ds-projection-de-courts-metrages-theme-anniversaire-15-ans-du-colporteur-20261106-livers-cazelles-25',
  'Projection de courts-métrages - Thème : "Anniversaire 15 ans du Colporteur"',
  'Événement annoncé : Projection de courts-métrages - Thème : "Anniversaire 15 ans du Colporteur". Lieu indiqué : Livers-Cazelles (Livers-Cazelles). Début prévu le 06/11/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Livers-Cazelles',
  NULL,
  'FR', 'Europe/Paris',
  'Livers-Cazelles',
  44.047959, 1.998204, NULL,
  '2026-11-06T20:00:00Z'::timestamptz,
  '2026-11-06T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26134',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6e4a87bc-dda3-4bfa-ac6f-b0c818b3ccf8',
  'ds-cafe-menstruel-syndrome-premenstruel-spm-20261107-carmaux-260',
  'Café menstruel : syndrome prémenstruel (SPM)',
  'Événement annoncé : Café menstruel : syndrome prémenstruel (SPM). Lieu indiqué : Carmaux (Carmaux). Début prévu le 07/11/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carmaux',
  NULL,
  'FR', 'Europe/Paris',
  'Carmaux',
  44.049912, 2.157869, NULL,
  '2026-11-07T09:30:00Z'::timestamptz,
  '2026-11-07T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/25794',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '25a07319-bb5a-4387-974b-e42334f07166',
  'ds-les-jolies-saisons-l-automne-spectacle-musical-0-4-ans-20261107-albi-261',
  'LES JOLIES SAISONS-L''AUTOMNE, spectacle musical 0-4 ans',
  'Événement annoncé : LES JOLIES SAISONS-L''AUTOMNE, spectacle musical 0-4 ans. Lieu indiqué : Albi (Albi). Début prévu le 07/11/2026 à 16:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.925927, 2.13539, NULL,
  '2026-11-07T15:30:00Z'::timestamptz,
  '2026-11-07T18:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26101',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1935d67f-2d35-4f46-90c5-3237aa602c3f',
  'ds-more-poetry-is-needed-2-20261107-albi-262',
  'More poetry is needed #2',
  'Événement annoncé : More poetry is needed #2. Lieu indiqué : Albi (Albi). Début prévu le 07/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Albi',
  NULL,
  'FR', 'Europe/Paris',
  'Albi',
  43.923399, 2.145024, NULL,
  '2026-11-07T17:00:00Z'::timestamptz,
  '2026-11-07T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://tarn.demosphere.net/rv/26061',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '603fff8b-fa98-4ae9-b508-895f79545501',
  'ds-cantine-populaire-20261028-forcalquier-263',
  'Cantine Populaire',
  'Événement annoncé : Cantine Populaire. Lieu indiqué : Forcalquier (Forcalquier). Début prévu le 28/10/2026 à 12:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Forcalquier',
  NULL,
  'FR', 'Europe/Paris',
  'Forcalquier',
  43.95943, 5.783412, NULL,
  '2026-10-28T11:00:00Z'::timestamptz,
  '2026-10-28T14:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://04.demosphere.net/rv/2496',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f2e1c66a-248d-4ce4-957e-e8b77cfa344d',
  'ds-soiree-de-soutien-planning-04-hallo-queen-20261031-chateau-arnoux-saint-auban-264',
  'Soirée de soutien Planning 04 : Hallo''Queen',
  'Événement annoncé : Soirée de soutien Planning 04 : Hallo''Queen. Lieu indiqué : Château-Arnoux-Saint-Auban (Château-Arnoux-Saint-Auban). Début prévu le 31/10/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Château-Arnoux-Saint-Auban',
  NULL,
  'FR', 'Europe/Paris',
  'Château-Arnoux-Saint-Auban',
  44.071338, 5.997495, NULL,
  '2026-10-31T16:00:00Z'::timestamptz,
  '2026-10-31T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://04.demosphere.net/rv/2500',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f7b79698-558e-4b06-92e2-2ca0b4164512',
  'ds-soiree-de-soutien-a-la-palestine-20261104-digne-les-bains-265',
  'Soirée de soutien à la Palestine',
  'Événement annoncé : Soirée de soutien à la Palestine. Lieu indiqué : Digne-les-Bains (Digne-les-Bains). Début prévu le 04/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Digne-les-Bains',
  NULL,
  'FR', 'Europe/Paris',
  'Digne-les-Bains',
  44.089177, 6.249034, NULL,
  '2026-11-04T17:00:00Z'::timestamptz,
  '2026-11-04T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://04.demosphere.net/rv/2499',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a6ee51f2-bb9e-4a3d-a62c-eb8954de7d41',
  'ds-tant-qu-il-y-aura-des-prisons-gwenola-ricordeau-20261105-forcalquier-266',
  '"Tant qu''il y aura des prisons" Gwenola Ricordeau',
  'Événement annoncé : "Tant qu''il y aura des prisons" Gwenola Ricordeau. Lieu indiqué : Forcalquier (Forcalquier). Début prévu le 05/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Forcalquier',
  NULL,
  'FR', 'Europe/Paris',
  'Forcalquier',
  43.958039, 5.779727, NULL,
  '2026-11-05T18:00:00Z'::timestamptz,
  '2026-11-05T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://04.demosphere.net/rv/2501',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'aca12ab5-5ccd-4ad3-a59a-0021a24ea36d',
  'ds-cantine-populaire-20261111-forcalquier-267',
  'Cantine Populaire',
  'Événement annoncé : Cantine Populaire. Lieu indiqué : Forcalquier (Forcalquier). Début prévu le 11/11/2026 à 12:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Forcalquier',
  NULL,
  'FR', 'Europe/Paris',
  'Forcalquier',
  43.95926, 5.783326, NULL,
  '2026-11-11T11:00:00Z'::timestamptz,
  '2026-11-11T14:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://04.demosphere.net/rv/2497',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c20d4052-f04d-4f75-b999-06c1ac6a9430',
  'ds-adieu-windows-bienvenue-linux-20261028-le-mans-268',
  'Adieu windows Bienvenue Linux',
  'Événement annoncé : Adieu windows Bienvenue Linux. Lieu indiqué : Le Mans (Le Mans). Début prévu le 28/10/2026 à 12:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  47.973723, 0.209263, NULL,
  '2026-10-28T11:30:00Z'::timestamptz,
  '2026-10-28T14:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7098',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c15d31a3-25f5-4f60-a8b2-51112cb673e4',
  'ds-on-ne-joue-pas-avec-le-genocide-boycott-israel-20261028-le-mans-269',
  'On ne joue pas avec le génocide! Boycott Israël',
  'Événement annoncé : On ne joue pas avec le génocide! Boycott Israël. Lieu indiqué : Le Mans (Le Mans). Début prévu le 28/10/2026 à 12:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.007373, 0.196883, NULL,
  '2026-10-28T11:30:00Z'::timestamptz,
  '2026-10-28T14:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7158',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9289eabf-af81-4a61-890b-252b57b978f0',
  'ds-encore-heureux-soiree-discussion-autour-de-la-sante-communautaire-20261030-le-mans-270',
  '[Encore Heureux] Soirée discussion autour de la santé communautaire',
  'Événement annoncé : [Encore Heureux] Soirée discussion autour de la santé communautaire. Lieu indiqué : Le Mans (Le Mans). Début prévu le 30/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'sante',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.007538, 0.188554, NULL,
  '2026-10-30T17:30:00Z'::timestamptz,
  '2026-10-30T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7125',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '64778615-9aca-4294-9ad9-67bbc5378a16',
  'ds-festival-open-the-gates-4-carte-blanche-musicale-a-nananerfs-20261030-le-mans-271',
  'Festival Open The Gates #4 - Carte Blanche Musicale à Nananerfs',
  'Événement annoncé : Festival Open The Gates #4 - Carte Blanche Musicale à Nananerfs. Lieu indiqué : Le Mans (Le Mans). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.019858, 0.182336, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7114',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e2f71ccf-1fb7-4762-a26a-cd9054014f33',
  'ds-cafe-reparations-et-couture-20261031-72100-le-mans-272',
  'café réparations et couture',
  'Événement annoncé : café réparations et couture. Lieu indiqué : 72100 Le Mans (72100 Le Mans). Début prévu le 31/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '72100 Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  '72100 Le Mans',
  47.982873, 0.214016, NULL,
  '2026-10-31T08:30:00Z'::timestamptz,
  '2026-10-31T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7139',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7bdc88d7-5b88-43d1-af00-aa10fb09e961',
  'ds-reunion-d-informations-sur-le-projet-de-mega-data-center-a-besse-sur-b-20261031-bonneveau-273',
  'réunion d''informations sur le projet de méga data center à Bessé-sur-Braye',
  'Événement annoncé : réunion d''informations sur le projet de méga data center à Bessé-sur-Braye. Lieu indiqué : bonneveau (bonneveau). Début prévu le 31/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'bonneveau',
  '41800',
  'FR', 'Europe/Paris',
  'bonneveau',
  47.811763, 0.782365, NULL,
  '2026-10-31T15:00:00Z'::timestamptz,
  '2026-10-31T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7145',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'dddf08d0-806c-4e78-85ea-cc01674b9dee',
  'ds-festival-open-the-gates-4-soiree-stand-up-theatre-20261031-le-mans-274',
  '[Festival Open The Gates] #4 - Soirée Stand Up & Théâtre',
  'Événement annoncé : [Festival Open The Gates] #4 - Soirée Stand Up & Théâtre. Lieu indiqué : Le Mans (Le Mans). Début prévu le 31/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.019858, 0.182336, NULL,
  '2026-10-31T19:00:00Z'::timestamptz,
  '2026-10-31T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7115',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '63cc0a7f-ac4e-4c47-b5e1-54498885942b',
  'ds-encore-heureux-concerts-treizes-ron-pon-20261031-le-mans-275',
  '[Encore heureux] Concerts Treizes & Ron-Pon',
  'Événement annoncé : [Encore heureux] Concerts Treizes & Ron-Pon. Lieu indiqué : Le Mans (Le Mans). Début prévu le 31/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.007538, 0.188554, NULL,
  '2026-10-31T19:30:00Z'::timestamptz,
  '2026-10-31T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7126',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a7ee004c-0c09-4371-b9e0-03c1d5c3af98',
  'ds-encore-heureux-concerts-les-loups-garous-pierre-veyser-20261101-le-mans-276',
  '[Encore Heureux] Concerts Les Loups-garous & Pierre Veyser',
  'Événement annoncé : [Encore Heureux] Concerts Les Loups-garous & Pierre Veyser. Lieu indiqué : Le Mans (Le Mans). Début prévu le 01/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.007538, 0.188554, NULL,
  '2026-11-01T16:00:00Z'::timestamptz,
  '2026-11-01T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7127',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f0b1d75d-f8d9-4df0-9c91-2b3bb5545551',
  'ds-encore-heureux-a-propos-de-l-uvre-de-guillaume-pujolle-20261103-le-mans-277',
  '[Encore Heureux] à propos de l’œuvre de Guillaume Pujolle',
  'Événement annoncé : [Encore Heureux] à propos de l’œuvre de Guillaume Pujolle. Lieu indiqué : Le Mans (Le Mans). Début prévu le 03/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.007538, 0.188554, NULL,
  '2026-11-03T17:00:00Z'::timestamptz,
  '2026-11-03T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7128',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4b74b270-2318-4eef-95db-d622c58f4f08',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261104-le-mans-278',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 04/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-11-04T14:00:00Z'::timestamptz,
  '2026-11-04T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7018',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '56dcf300-6ed9-4907-97f5-f1c5e53bcaf2',
  'ds-encore-heureux-concerts-vin-de-sprite-cave-de-cristal-20261104-le-mans-279',
  '[Encore Heureux] Concerts Vin de Sprite & Cave de Cristal',
  'Événement annoncé : [Encore Heureux] Concerts Vin de Sprite & Cave de Cristal. Lieu indiqué : Le Mans (Le Mans). Début prévu le 04/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.002429, 0.196261, NULL,
  '2026-11-04T18:30:00Z'::timestamptz,
  '2026-11-04T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7129',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ea06f753-8b4d-4bbe-bde3-3d1ef7965173',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261105-le-mans-280',
  'Ciné-débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné-débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : Le Mans (Le Mans). Début prévu le 05/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.015345, 0.228902, NULL,
  '2026-11-05T19:00:00Z'::timestamptz,
  '2026-11-05T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7068',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '76704b9f-d362-4d32-abb2-95ccfc1fcc18',
  'ds-pierrick-bourgault-raconte-ses-livres-sur-les-cafes-et-bistrots-du-mon-20261107-la-chartre-sur-le',
  'Pierrick Bourgault raconte ses livres sur les cafés et bistrots du monde',
  'Événement annoncé : Pierrick Bourgault raconte ses livres sur les cafés et bistrots du monde. Lieu indiqué : La Chartre-sur-le-Loir (La Chartre-sur-le-Loir). Début prévu le 07/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'La Chartre-sur-le-Loir',
  NULL,
  'FR', 'Europe/Paris',
  'La Chartre-sur-le-Loir',
  47.729494, 0.573313, NULL,
  '2026-11-07T09:00:00Z'::timestamptz,
  '2026-11-07T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7083',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f763f057-d731-4060-bd0d-c07315ac1d6a',
  'ds-troc-plantes-et-graines-20261107-72100-le-mans-282',
  'troc plantes et graines',
  'Événement annoncé : troc plantes et graines. Lieu indiqué : 72100 Le Mans (72100 Le Mans). Début prévu le 07/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '72100 Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  '72100 Le Mans',
  47.981936, 0.209038, NULL,
  '2026-11-07T09:00:00Z'::timestamptz,
  '2026-11-07T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7148',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b8f2817b-9409-43cf-84e8-482ecb09aab1',
  'ds-boutique-gratuite-le-partage-dons-20261107-roeze-sur-sarthe-283',
  'Boutique gratuite le "partage''dons"',
  'Événement annoncé : Boutique gratuite le "partage''dons". Lieu indiqué : Roézé sur sarthe (Roézé sur sarthe). Début prévu le 07/11/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Roézé sur sarthe',
  NULL,
  'FR', 'Europe/Paris',
  'Roézé sur sarthe',
  47.893914, 0.066372, NULL,
  '2026-11-07T09:30:00Z'::timestamptz,
  '2026-11-07T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7123',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '33dd7c32-db96-4f01-974f-3bd262c7d266',
  'ds-reunion-d-information-l214-20261107-72100-le-mans-284',
  'Réunion d''information L214',
  'Événement annoncé : Réunion d''information L214. Lieu indiqué : 72100 Le Mans (72100 Le Mans). Début prévu le 07/11/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '72100 Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  '72100 Le Mans',
  47.982873, 0.214016, NULL,
  '2026-11-07T12:30:00Z'::timestamptz,
  '2026-11-07T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7151',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '76d984c9-6384-4d48-948f-363d3011c368',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261107-st-pierre-du-lorouer-285',
  'Ciné débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : St pierre du lorouer (St pierre du lorouer). Début prévu le 07/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St pierre du lorouer',
  '72150',
  'FR', 'Europe/Paris',
  'St pierre du lorouer',
  47.803156, 0.516244, NULL,
  '2026-11-07T14:00:00Z'::timestamptz,
  '2026-11-07T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7152',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9adda779-dddc-44ba-aa04-b7f5a90c5254',
  'ds-fest-alimenterre-cine-debat-au-fil-de-l-eau-de-l-insouciance-a-la-deso-20261107-malicorne-sur-sar',
  '[Fest. AlimenTERRE] Ciné-débat "Au fil de l''eau, de l''insouciance à la désobéissance"',
  'Événement annoncé : [Fest. AlimenTERRE] Ciné-débat "Au fil de l''eau, de l''insouciance à la désobéissance". Lieu indiqué : Malicorne Sur Sarthe (Malicorne Sur Sarthe). Début prévu le 07/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Malicorne Sur Sarthe',
  NULL,
  'FR', 'Europe/Paris',
  'Malicorne Sur Sarthe',
  47.811853, -0.093904, NULL,
  '2026-11-07T17:00:00Z'::timestamptz,
  '2026-11-07T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7159',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '98b28211-fa47-4973-8b57-23e13eba9bb6',
  'ds-projection-au-fabuleux-bistrot-de-jeannine-cinema-le-royal-20261108-le-mans-287',
  'Projection "Au Fabuleux bistrot de Jeannine", Cinéma Le Royal',
  'Événement annoncé : Projection "Au Fabuleux bistrot de Jeannine", Cinéma Le Royal. Lieu indiqué : Le Mans (Le Mans). Début prévu le 08/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  47.968621, 0.204154, NULL,
  '2026-11-08T14:00:00Z'::timestamptz,
  '2026-11-08T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7146',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cc36a3ac-b05b-4545-88db-81eb7832b2a2',
  'ds-assemblee-du-collectif-sarthois-des-soulevements-de-la-terre-20261109-72100-le-mans-288',
  'Assemblée du collectif sarthois des soulèvements de la terre !',
  'Événement annoncé : Assemblée du collectif sarthois des soulèvements de la terre !. Lieu indiqué : 72100 Le Mans (72100 Le Mans). Début prévu le 09/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '72100 Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  '72100 Le Mans',
  47.982873, 0.214016, NULL,
  '2026-11-09T17:30:00Z'::timestamptz,
  '2026-11-09T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7063',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eecdaacc-d6d1-4fff-85ba-d741f6afeca7',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261110-ecommoy-289',
  'Ciné-débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné-débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : Ecommoy (Ecommoy). Début prévu le 10/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Ecommoy',
  NULL,
  'FR', 'Europe/Paris',
  'Ecommoy',
  47.825179, 0.280708, NULL,
  '2026-11-10T19:00:00Z'::timestamptz,
  '2026-11-10T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7153',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '902837e4-b56f-4cd5-ab07-c9d1215845b6',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261111-le-mans-290',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 11/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-11-11T14:00:00Z'::timestamptz,
  '2026-11-11T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7019',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3bf413cb-a271-41ee-b214-22a19d6e1038',
  'ds-journee-conviviale-et-ateliers-autour-de-la-pensee-d-ivan-illich-20261113-le-mans-291',
  'Journée conviviale et ateliers autour de la pensée d''Ivan Illich',
  'Événement annoncé : Journée conviviale et ateliers autour de la pensée d''Ivan Illich. Lieu indiqué : Le Mans (Le Mans). Début prévu le 13/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.015377, 0.160945, NULL,
  '2026-11-13T09:00:00Z'::timestamptz,
  '2026-11-13T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7160',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1f0f701f-39ea-4ccc-89e4-d3ac418893d4',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261113-mamers-292',
  'Ciné débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : Mamers (Mamers). Début prévu le 13/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mamers',
  NULL,
  'FR', 'Europe/Paris',
  'Mamers',
  48.347171, 0.364347, NULL,
  '2026-11-13T18:00:00Z'::timestamptz,
  '2026-11-13T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7088',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'efa1dbc6-3b73-433e-b683-8d6c186df69b',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261113-saint-marceau-293',
  'Ciné débat "Que se passe-t-il dans nos champs ?',
  'Événement annoncé : Ciné débat "Que se passe-t-il dans nos champs ?. Lieu indiqué : Saint Marceau (Saint Marceau). Début prévu le 13/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Saint Marceau',
  NULL,
  'FR', 'Europe/Paris',
  'Saint Marceau',
  48.17883, 0.127568, NULL,
  '2026-11-13T19:00:00Z'::timestamptz,
  '2026-11-13T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7163',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '56c76824-a129-4a9a-9614-4297ae4814f3',
  'ds-pesticides-conferences-et-echanges-avec-le-public-20261114-le-mans-294',
  'Pesticides : conférences et échanges avec le public',
  'Événement annoncé : Pesticides : conférences et échanges avec le public. Lieu indiqué : Le Mans (Le Mans). Début prévu le 14/11/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.01578, 0.160927, NULL,
  '2026-11-14T12:30:00Z'::timestamptz,
  '2026-11-14T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7089',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fff307a4-5c67-4788-beef-9c060dbae58f',
  'ds-conferences-scientifiques-du-collectif-sarthois-sante-pesticides-20261114-le-mans-295',
  'conférences scientifiques du collectif sarthois santé pesticides',
  'Événement annoncé : conférences scientifiques du collectif sarthois santé pesticides. Lieu indiqué : Le Mans (Le Mans). Début prévu le 14/11/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'sante',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.017716, 0.157178, NULL,
  '2026-11-14T12:30:00Z'::timestamptz,
  '2026-11-14T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7166',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eb227594-3570-4eef-9bd7-993b9eea24d8',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261117-saint-mars-du-locquenay-296',
  'Ciné débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : saint mars du locquenay (saint mars du locquenay). Début prévu le 17/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'saint mars du locquenay',
  NULL,
  'FR', 'Europe/Paris',
  'saint mars du locquenay',
  47.928221, 0.484429, NULL,
  '2026-11-17T19:00:00Z'::timestamptz,
  '2026-11-17T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7164',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '135d8993-ae25-4fb9-9eca-fd4aea46d2e5',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261118-le-mans-297',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 18/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-11-18T14:00:00Z'::timestamptz,
  '2026-11-18T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7020',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '31f64c35-e976-42b5-ab57-889ae010b7ef',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261125-le-mans-298',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 25/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-11-25T14:00:00Z'::timestamptz,
  '2026-11-25T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7021',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '32334155-456b-423f-9594-908abc802b84',
  'ds-cine-debat-que-se-passe-t-il-dans-nos-champs-20261125-le-grand-luce-299',
  'Ciné-débat "Que se passe-t-il dans nos champs ?"',
  'Événement annoncé : Ciné-débat "Que se passe-t-il dans nos champs ?". Lieu indiqué : Le Grand Lucé (Le Grand Lucé). Début prévu le 25/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Grand Lucé',
  NULL,
  'FR', 'Europe/Paris',
  'Le Grand Lucé',
  47.867153, 0.460809, NULL,
  '2026-11-25T19:00:00Z'::timestamptz,
  '2026-11-25T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7154',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a5d59d2e-c174-433b-92f0-805ebcd09e75',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261202-le-mans-300',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 02/12/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-12-02T14:00:00Z'::timestamptz,
  '2026-12-02T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7022',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '76ac12c5-80f5-4e45-bceb-52a662d7e0e5',
  'ds-centre-de-documentation-ritimo-ouvert-de-15h-a-18h-20261209-le-mans-301',
  'Centre de documentation RITIMO ouvert de 15h à 18h',
  'Événement annoncé : Centre de documentation RITIMO ouvert de 15h à 18h. Lieu indiqué : Le Mans (Le Mans). Début prévu le 09/12/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  'Le Mans',
  48.004603, 0.200328, NULL,
  '2026-12-09T14:00:00Z'::timestamptz,
  '2026-12-09T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7023',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '22ba68ac-6d90-42dd-a9b6-efcf5bcbacab',
  'ds-assemblee-du-collectif-sarthois-des-soulevements-de-la-terre-20261210-72100-le-mans-302',
  'Assemblée du collectif sarthois des soulèvements de la terre !',
  'Événement annoncé : Assemblée du collectif sarthois des soulèvements de la terre !. Lieu indiqué : 72100 Le Mans (72100 Le Mans). Début prévu le 10/12/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '72100 Le Mans',
  NULL,
  'FR', 'Europe/Paris',
  '72100 Le Mans',
  47.982873, 0.214016, NULL,
  '2026-12-10T17:30:00Z'::timestamptz,
  '2026-12-10T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://sarthe.demosphere.net/rv/7064',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e77b17d1-eeed-4682-9106-373ffe7e2169',
  'ds-la-mediatheque-enchantant-20261028-villefranche-de-rouergue-303',
  'La médiathèque enchantant',
  'Événement annoncé : La médiathèque enchantant. Lieu indiqué : Villefranche-de-Rouergue (Villefranche-de-Rouergue). Début prévu le 28/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Villefranche-de-Rouergue',
  '12160',
  'FR', 'Europe/Paris',
  'Villefranche-de-Rouergue',
  44.286083, 2.42379, NULL,
  '2026-10-28T14:00:00Z'::timestamptz,
  '2026-10-28T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://aveyron.demosphere.net/rv/1934',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2cf00c70-e41d-4623-adeb-5fcd423cc125',
  'ds-queerbaret-3-20261204-sainte-radegonde-304',
  'Queerbaret #3',
  'Événement annoncé : Queerbaret #3. Lieu indiqué : Sainte-Radegonde (Sainte-Radegonde). Début prévu le 04/12/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Sainte-Radegonde',
  '79100',
  'FR', 'Europe/Paris',
  'Sainte-Radegonde',
  46.992931, -0.239804, NULL,
  '2026-12-04T18:00:00Z'::timestamptz,
  '2026-12-04T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://aveyron.demosphere.net/rv/1910',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fca18525-9558-4ed7-bfdb-cebb8bfaf540',
  'ds-guerre-aux-frontieres-une-bataille-coloniale-20261028-lille-moulins-305',
  'Guerre aux frontières - Une bataille coloniale',
  'Événement annoncé : Guerre aux frontières - Une bataille coloniale. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 28/10/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.623681, 3.074351, NULL,
  '2026-10-28T16:30:00Z'::timestamptz,
  '2026-10-28T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11659',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8768fe9f-1c3f-4b78-bd32-114fb9118c47',
  'ds-ag-des-luttes-ouverte-a-toustes-20261028-lille-fives-306',
  'AG des Luttes ouverte à toustes',
  'Événement annoncé : AG des Luttes ouverte à toustes. Lieu indiqué : Lille Fives (Lille Fives). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Fives',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Fives',
  50.626265, 3.091424, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11693',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1d6be0da-f453-4223-b9cf-c24fc83d8062',
  'ds-joyeuse-permanence-chez-violette-20261028-lille-moulins-307',
  'Joyeuse permanence - Chez Violette',
  'Événement annoncé : Joyeuse permanence - Chez Violette. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 28/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.62638, 3.056168, NULL,
  '2026-10-28T17:30:00Z'::timestamptz,
  '2026-10-28T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11672',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '53208a71-5065-4803-806e-0edf81f8a15f',
  'ds-sortie-du-numero-2-de-complexe-des-anses-20261029-lille-308',
  'Sortie du numéro 2 de Complexe des anses',
  'Événement annoncé : Sortie du numéro 2 de Complexe des anses. Lieu indiqué : Lille (Lille). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille',
  NULL,
  'FR', 'Europe/Paris',
  'Lille',
  50.631045, 3.08781, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11686',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f79571d8-902e-408f-ba12-91573ffcad46',
  'ds-cercle-tda-chez-violette-20261029-lille-moulins-309',
  'Cercle TDA - Chez Violette',
  'Événement annoncé : Cercle TDA - Chez Violette. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.62638, 3.056168, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11673',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0cf5b7e5-e00b-49ab-ab1d-bc49115fd24c',
  'ds-l-incendiaire-fete-ses-1-an-a-la-moulinette-20261029-lille-moulins-310',
  'L''incendiaire fête ses 1 an à la Moulinette',
  'Événement annoncé : L''incendiaire fête ses 1 an à la Moulinette. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 29/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.622341, 3.062428, NULL,
  '2026-10-29T18:00:00Z'::timestamptz,
  '2026-10-29T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11663',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9b73f2bc-6391-4073-a420-e30e3ef04f92',
  'ds-ateliers-epines-20261101-lille-moulins-311',
  'Ateliers EPINES',
  'Événement annoncé : Ateliers EPINES. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 01/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.62638, 3.056168, NULL,
  '2026-11-01T16:00:00Z'::timestamptz,
  '2026-11-01T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11570',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6cc77a4a-b918-450c-9287-1801402a63c5',
  'ds-conf-gesticulee-sortir-de-l-heterosexualite-et-apres-20261102-villeneuve-d-ascq-312',
  'Conf gesticulée : Sortir de l''hétérosexualité, et après ?',
  'Événement annoncé : Conf gesticulée : Sortir de l''hétérosexualité, et après ?. Lieu indiqué : Villeneuve d''Ascq (Villeneuve d''Ascq). Début prévu le 02/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Villeneuve d''Ascq',
  NULL,
  'FR', 'Europe/Paris',
  'Villeneuve d''Ascq',
  50.609974, 3.140768, NULL,
  '2026-11-02T17:00:00Z'::timestamptz,
  '2026-11-02T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11687',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a4081577-4120-47ba-b6b7-2dd055edcf56',
  'ds-conference-droit-international-proteger-les-bien-culturels-en-temps-de-20261103-villeneuve-d-ascq',
  'Conférence Droit International : Protéger les bien culturels en temps de guerre',
  'Événement annoncé : Conférence Droit International : Protéger les bien culturels en temps de guerre. Lieu indiqué : Villeneuve d''Ascq (Villeneuve d''Ascq). Début prévu le 03/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Villeneuve d''Ascq',
  NULL,
  'FR', 'Europe/Paris',
  'Villeneuve d''Ascq',
  50.609974, 3.140768, NULL,
  '2026-11-03T17:30:00Z'::timestamptz,
  '2026-11-03T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11683',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b233d924-0939-4214-9ecd-81620d72ea32',
  'ds-soiree-jeux-avec-entourage-lille-20261104-lille-moulins-314',
  'Soirée jeux avec Entourage Lille',
  'Événement annoncé : Soirée jeux avec Entourage Lille. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 04/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.622341, 3.062428, NULL,
  '2026-11-04T17:00:00Z'::timestamptz,
  '2026-11-04T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11684',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a36dc5dc-8134-49da-a98f-b6de41e4249f',
  'ds-drag-show-x-podcast-gros-se-20261105-lille-moulins-315',
  'Drag show x Podcast - Gros·se',
  'Événement annoncé : Drag show x Podcast - Gros·se. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 05/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.622341, 3.062428, NULL,
  '2026-11-05T19:30:00Z'::timestamptz,
  '2026-11-05T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11678',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '099d38a9-0874-4bac-8124-eff17f8853da',
  'ds-anniversaire-des-amd-fascisme-en-france-le-grand-malentendu-20261106-lille-centre-316',
  'Anniversaire des AMD "Fascisme en France, le grand malentendu"',
  'Événement annoncé : Anniversaire des AMD "Fascisme en France, le grand malentendu". Lieu indiqué : Lille Centre (Lille Centre). Début prévu le 06/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Centre',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Centre',
  50.63252, 3.08632, NULL,
  '2026-11-06T17:30:00Z'::timestamptz,
  '2026-11-06T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11682',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '69855e37-0c28-4531-8423-d3d8668e5a61',
  'ds-conf-gesticulee-comment-je-me-suis-disputee-ma-vie-en-patriarchie-20261106-lille-sud-317',
  'Conf gesticulée : Comment je me suis disputée ma vie en patriarchie',
  'Événement annoncé : Conf gesticulée : Comment je me suis disputée ma vie en patriarchie. Lieu indiqué : Lille Sud (Lille Sud). Début prévu le 06/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Sud',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Sud',
  50.612298, 3.062645, NULL,
  '2026-11-06T18:30:00Z'::timestamptz,
  '2026-11-06T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11688',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '51b422f2-9ea8-439f-b25e-2db8fb8000a8',
  'ds-ateliers-epines-20261108-lille-moulins-318',
  'Ateliers EPINES',
  'Événement annoncé : Ateliers EPINES. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 08/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.62638, 3.056168, NULL,
  '2026-11-08T16:00:00Z'::timestamptz,
  '2026-11-08T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11586',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e82afbf7-bf2d-4cd7-a0bf-cc775d586441',
  'ds-perm-des-gentes-atelier-velo-sans-hommes-cisgenres-20261113-lille-fives-319',
  'Perm des genTEs : atelier vélo sans hommes cisgenres',
  'Événement annoncé : Perm des genTEs : atelier vélo sans hommes cisgenres. Lieu indiqué : Lille Fives (Lille Fives). Début prévu le 13/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Fives',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Fives',
  50.637418, 3.083954, NULL,
  '2026-11-13T17:00:00Z'::timestamptz,
  '2026-11-13T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11252',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fb11f4ca-2860-4a97-9451-5be2bb0862d5',
  'ds-prince-et-citoyen-sur-le-charisme-des-empereurs-romains-20261114-lille-centre-320',
  'Prince et citoyen. Sur le "charisme" des empereurs romains',
  'Événement annoncé : Prince et citoyen. Sur le "charisme" des empereurs romains. Lieu indiqué : Lille Centre (Lille Centre). Début prévu le 14/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Centre',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Centre',
  50.63246, 3.066199, NULL,
  '2026-11-14T14:00:00Z'::timestamptz,
  '2026-11-14T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11572',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'eee2977d-4c04-4216-b167-546871c52dc1',
  'ds-ateliers-epines-20261115-lille-moulins-321',
  'Ateliers EPINES',
  'Événement annoncé : Ateliers EPINES. Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 15/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.62638, 3.056168, NULL,
  '2026-11-15T16:00:00Z'::timestamptz,
  '2026-11-15T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11642',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'beeeaf1a-7410-4e29-9591-0e5025a1cb72',
  'ds-discussion-neuroatypie-complet-20261118-lille-moulins-322',
  'Discussion neuroatypie (COMPLET)',
  'Événement annoncé : Discussion neuroatypie (COMPLET). Lieu indiqué : Lille Moulins (Lille Moulins). Début prévu le 18/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Moulins',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Moulins',
  50.622341, 3.062428, NULL,
  '2026-11-18T19:00:00Z'::timestamptz,
  '2026-11-18T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11664',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a040aeab-d514-496d-aedf-04d3ac9d3395',
  'ds-theories-du-complot-que-nous-arrive-t-il-quand-la-verite-commune-se-de-20261121-roubaix-323',
  'Théories du complot. Que nous arrive-t-il quand la vérité commune se défait ?',
  'Événement annoncé : Théories du complot. Que nous arrive-t-il quand la vérité commune se défait ?. Lieu indiqué : Roubaix (Roubaix). Début prévu le 21/11/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Roubaix',
  NULL,
  'FR', 'Europe/Paris',
  'Roubaix',
  50.690488, 3.175328, NULL,
  '2026-11-21T10:00:00Z'::timestamptz,
  '2026-11-21T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11691',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a92bd8d9-49e2-4b29-a86a-058e29faf410',
  'ds-terreur-et-contre-insurrection-sur-la-repression-coloniale-francaise-e-20261121-lille-wazemmes-32',
  'Terreur et contre-insurrection : sur la répression coloniale française en Algérie',
  'Événement annoncé : Terreur et contre-insurrection : sur la répression coloniale française en Algérie. Lieu indiqué : Lille Wazemmes (Lille Wazemmes). Début prévu le 21/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Lille Wazemmes',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Wazemmes',
  50.625259, 3.048796, NULL,
  '2026-11-21T14:00:00Z'::timestamptz,
  '2026-11-21T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11676',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4a11ea47-9989-4311-b188-0759ffc40f8e',
  'ds-cine-debat-one-by-one-20261124-lens-325',
  'Ciné débat : One by one',
  'Événement annoncé : Ciné débat : One by one. Lieu indiqué : Lens (Lens). Début prévu le 24/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lens',
  NULL,
  'FR', 'Europe/Paris',
  'Lens',
  50.430272, 2.833203, NULL,
  '2026-11-24T17:30:00Z'::timestamptz,
  '2026-11-24T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11679',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b21ca95c-73b8-4a1f-943d-a4a789a400ea',
  'ds-perm-des-gentes-atelier-velo-sans-hommes-cisgenres-20261211-lille-fives-326',
  'Perm des genTEs : atelier vélo sans hommes cisgenres',
  'Événement annoncé : Perm des genTEs : atelier vélo sans hommes cisgenres. Lieu indiqué : Lille Fives (Lille Fives). Début prévu le 11/12/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Lille Fives',
  NULL,
  'FR', 'Europe/Paris',
  'Lille Fives',
  50.637418, 3.083954, NULL,
  '2026-12-11T17:00:00Z'::timestamptz,
  '2026-12-11T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://lille.demosphere.net/rv/11333',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9359d5bf-a227-4012-a69b-a028bf8159df',
  'ds-afps-veillee-de-solidarite-avec-le-peuple-palestinien-20261028-nimes-327',
  'AFPS - VEILLÉE DE SOLIDARITÉ AVEC LE PEUPLE PALESTINIEN',
  'Événement annoncé : AFPS - VEILLÉE DE SOLIDARITÉ AVEC LE PEUPLE PALESTINIEN. Lieu indiqué : Nîmes (Nîmes). Début prévu le 28/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.838023, 4.35503, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10387',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '293cb509-1a49-47e9-988b-259e4fcc0b42',
  'ds-gratiferia-10-h-16-h-tout-est-gratuit-20261031-nimes-328',
  'Gratiferia 10 h 16 h tout est gratuit',
  'Événement annoncé : Gratiferia 10 h 16 h tout est gratuit. Lieu indiqué : Nîmes (Nîmes). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.839726, 4.355628, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10389',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1f99309e-4749-4978-b7c0-9558271192c2',
  'ds-afps-avec-le-peuple-palestinien-pour-saluer-le-mouvement-de-greve-des-20261031-nimes-329',
  'AFPS - AVEC LE PEUPLE PALESTINIEN POUR SALUER LE MOUVEMENT DE GRÈVE DES ...',
  'Événement annoncé : AFPS - AVEC LE PEUPLE PALESTINIEN POUR SALUER LE MOUVEMENT DE GRÈVE DES .... Lieu indiqué : Nîmes (Nîmes). Début prévu le 31/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.833481, 4.364175, NULL,
  '2026-10-31T10:00:00Z'::timestamptz,
  '2026-10-31T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10388',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5be25f54-a310-4269-9638-7b8d2485fc8e',
  'ds-afps-comment-je-suis-devenu-juif-en-l-an-2000-conference-gesticulee-20261101-nimes-330',
  'AFPS - "COMMENT JE SUIS DEVENU JUIF EN L''AN 2000 !" - CONFÉRENCE GESTICULÉE',
  'Événement annoncé : AFPS - "COMMENT JE SUIS DEVENU JUIF EN L''AN 2000 !" - CONFÉRENCE GESTICULÉE. Lieu indiqué : Nîmes (Nîmes). Début prévu le 01/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.835911, 4.352224, NULL,
  '2026-11-01T14:00:00Z'::timestamptz,
  '2026-11-01T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10383',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '57c9eeb8-b47a-45da-a676-9b4b48439bd9',
  'ds-projection-debat-bread-and-roses-de-ken-loach-20261101-nimes-331',
  'projection-débat ''Bread and roses'' de Ken Loach',
  'Événement annoncé : projection-débat ''Bread and roses'' de Ken Loach. Lieu indiqué : Nîmes (Nîmes). Début prévu le 01/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.840466, 4.362581, NULL,
  '2026-11-01T16:00:00Z'::timestamptz,
  '2026-11-01T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10390',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '75c827c4-9274-419f-b140-e399093aab67',
  'ds-theatre-humour-daniel-villanova-buvette-restauration-20261106-durfort-et-saint-martin-de-sossenac',
  'Théâtre & humour - "Daniel Villanova" - Buvette - Restauration',
  'Événement annoncé : Théâtre & humour - "Daniel Villanova" - Buvette - Restauration. Lieu indiqué : Durfort-et-Saint-Martin-de-Sossenac (Durfort-et-Saint-Martin-de-Sossenac). Début prévu le 06/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Durfort-et-Saint-Martin-de-Sossenac',
  NULL,
  'FR', 'Europe/Paris',
  'Durfort-et-Saint-Martin-de-Sossenac',
  43.989088, 3.95472, NULL,
  '2026-11-06T17:00:00Z'::timestamptz,
  '2026-11-06T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10378',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '795f6a67-aeb1-4a7d-ba18-5d7251966447',
  'ds-shng-la-peste-de-1579-a-nimes-conference-20261107-nimes-333',
  'SHNG - "La peste de 1579 à Nîmes" - Conférence',
  'Événement annoncé : SHNG - "La peste de 1579 à Nîmes" - Conférence. Lieu indiqué : Nîmes (Nîmes). Début prévu le 07/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Nîmes',
  NULL,
  'FR', 'Europe/Paris',
  'Nîmes',
  43.82486, 4.368014, NULL,
  '2026-11-07T13:00:00Z'::timestamptz,
  '2026-11-07T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10376',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '790739dd-aad8-4c9a-958d-b8ed062d9daf',
  'ds-theatre-humour-faust-super-nova-la-tete-dans-le-cube-buvette-restaurat-20261107-durfort-et-saint-',
  'Théâtre & humour - "Faust super nova" "La tête dans le cube" - Buvette Restauration',
  'Événement annoncé : Théâtre & humour - "Faust super nova" "La tête dans le cube" - Buvette Restauration. Lieu indiqué : Durfort-et-Saint-Martin-de-Sossenac (Durfort-et-Saint-Martin-de-Sossenac). Début prévu le 07/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Durfort-et-Saint-Martin-de-Sossenac',
  NULL,
  'FR', 'Europe/Paris',
  'Durfort-et-Saint-Martin-de-Sossenac',
  43.989088, 3.95472, NULL,
  '2026-11-07T16:00:00Z'::timestamptz,
  '2026-11-07T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10379',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '43b9dfe5-7e6a-4260-8819-03926a88c0ed',
  'ds-theatre-humour-le-diner-de-cons-buvette-restauration-20261108-durfort-et-saint-martin-de-sossenac',
  'Théâtre & humour - "Le dîner de cons" - Buvette - Restauration',
  'Événement annoncé : Théâtre & humour - "Le dîner de cons" - Buvette - Restauration. Lieu indiqué : Durfort-et-Saint-Martin-de-Sossenac (Durfort-et-Saint-Martin-de-Sossenac). Début prévu le 08/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Durfort-et-Saint-Martin-de-Sossenac',
  NULL,
  'FR', 'Europe/Paris',
  'Durfort-et-Saint-Martin-de-Sossenac',
  43.989088, 3.95472, NULL,
  '2026-11-08T14:00:00Z'::timestamptz,
  '2026-11-08T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://gard.demosphere.net/rv/10380',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '058354d6-0310-4736-8c41-4292d6aa513d',
  'ds-evenement-de-solidarite-avec-les-anarchistes-incarcere-es-en-indonesie-20261029-limoges-336',
  'Evénement de solidarité avec les anarchistes incarcéré-es en Indonésie',
  'Événement annoncé : Evénement de solidarité avec les anarchistes incarcéré-es en Indonésie. Lieu indiqué : Limoges (Limoges). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Limoges',
  '87000',
  'FR', 'Europe/Paris',
  'Limoges',
  45.856159, 1.221254, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://limoges.demosphere.net/rv/1521',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1a632147-3901-4ede-8f31-93031c3c31cb',
  'ds-contact-pour-l-organisation-et-la-gestion-collective-de-cet-agenda-20261101-en-ligne-337',
  'Contact pour l''organisation et la gestion collective de cet agenda ?',
  'Événement annoncé : Contact pour l''organisation et la gestion collective de cet agenda ?. Lieu indiqué : En ligne (En ligne). Début prévu le 01/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'En ligne',
  '73260',
  'FR', 'Europe/Paris',
  'En ligne',
  45.560464, 6.467978, NULL,
  '2026-11-01T19:00:00Z'::timestamptz,
  '2026-11-01T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://limoges.demosphere.net/rv/1513',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4b149c59-6019-4aa9-85ba-9999f0e98e70',
  'ds-soiree-cine-debats-festival-alimenterre-20261029-carcassonne-338',
  'soirée ciné-débats (festival AlimenTERRE)',
  'Événement annoncé : soirée ciné-débats (festival AlimenTERRE). Lieu indiqué : Carcassonne (Carcassonne). Début prévu le 29/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Carcassonne',
  NULL,
  'FR', 'Europe/Paris',
  'Carcassonne',
  43.207707, 2.31712, NULL,
  '2026-10-29T18:30:00Z'::timestamptz,
  '2026-10-29T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4143',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7fb30504-44f3-478f-8c20-24be085d1b68',
  'ds-festival-kultur-elles-11-lancement-et-vernissage-expo-militante-20261105-11800-trebes-339',
  'Festival Kultur''Elles #11 - Lancement et vernissage expo militante',
  'Événement annoncé : Festival Kultur''Elles #11 - Lancement et vernissage expo militante. Lieu indiqué : 11800 Trèbes (11800 Trèbes). Début prévu le 05/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '11800 Trèbes',
  NULL,
  'FR', 'Europe/Paris',
  '11800 Trèbes',
  43.206632, 2.419679, NULL,
  '2026-11-05T17:30:00Z'::timestamptz,
  '2026-11-05T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4127',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b05f03f8-623d-4ff2-831a-fd2f7f9d1df5',
  'ds-festival-kultur-elles-11-concerts-melissmell-osmee-20261106-11800-trebes-340',
  'Festival Kultur''Elles # 11 - Concerts MELISSMELL + OSMÉE',
  'Événement annoncé : Festival Kultur''Elles # 11 - Concerts MELISSMELL + OSMÉE. Lieu indiqué : 11800 Trèbes (11800 Trèbes). Début prévu le 06/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '11800 Trèbes',
  NULL,
  'FR', 'Europe/Paris',
  '11800 Trèbes',
  43.206632, 2.419679, NULL,
  '2026-11-06T19:30:00Z'::timestamptz,
  '2026-11-06T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4128',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '49db23e9-4acc-480f-a0a5-88c2cbac45a1',
  'ds-festival-kultur-elles-11-ateliers-artistiques-militants-20261107-trebes-341',
  'Festival Kultur''Elles #11 - ateliers artistiques militants',
  'Événement annoncé : Festival Kultur''Elles #11 - ateliers artistiques militants. Lieu indiqué : Trèbes (Trèbes). Début prévu le 07/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Trèbes',
  NULL,
  'FR', 'Europe/Paris',
  'Trèbes',
  43.209433, 2.442887, NULL,
  '2026-11-07T13:00:00Z'::timestamptz,
  '2026-11-07T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4129',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4d7f0893-c1ec-4d2e-a54d-4f56f30c8765',
  'ds-kultur-elles-11-concerts-ultramoule-la-pieta-20261107-11800-trebes-342',
  'Kultur''Elles #11 - Concerts ULTRAMOULE + LA PIETÀ',
  'Événement annoncé : Kultur''Elles #11 - Concerts ULTRAMOULE + LA PIETÀ. Lieu indiqué : 11800 Trèbes (11800 Trèbes). Début prévu le 07/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '11800 Trèbes',
  NULL,
  'FR', 'Europe/Paris',
  '11800 Trèbes',
  43.206632, 2.419679, NULL,
  '2026-11-07T19:30:00Z'::timestamptz,
  '2026-11-07T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4130',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5cbeec86-f738-4cb9-9acb-c0d27b22861e',
  'ds-une-peau-plus-loin-20261108-montreal-343',
  'UNE PEAU PLUS LOIN',
  'Événement annoncé : UNE PEAU PLUS LOIN. Lieu indiqué : Montréal (Montréal). Début prévu le 08/11/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montréal',
  NULL,
  'FR', 'Europe/Paris',
  'Montréal',
  43.199557, 2.14057, NULL,
  '2026-11-08T16:00:00Z'::timestamptz,
  '2026-11-08T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4124',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ac9f2e03-e12a-448a-b7c5-9ce2bab03806',
  'ds-biodanza-solidaire-20261111-cesseras-344',
  'BIODANZA SOLIDAIRE',
  'Événement annoncé : BIODANZA SOLIDAIRE. Lieu indiqué : Cesseras 34210 (Cesseras). Début prévu le 11/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cesseras',
  NULL,
  'FR', 'Europe/Paris',
  'Cesseras 34210',
  43.324124, 2.714605, NULL,
  '2026-11-11T13:00:00Z'::timestamptz,
  '2026-11-11T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://carcassonne.demosphere.net/rv/4123',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5e3c3b91-0f17-468e-a734-9354a1e79bcf',
  'ds-la-bourse-ou-la-vie-avec-ludivine-bantigny-20261029-clermont-ferrand-345',
  'La bourse ou la vie avec Ludivine Bantigny',
  'Événement annoncé : La bourse ou la vie avec Ludivine Bantigny. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 29/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-10-29T19:00:00Z'::timestamptz,
  '2026-10-29T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1966',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f8288c50-03a6-48f2-8e2f-e5258f1efda1',
  'ds-corruptions-l-effondrement-de-l-etat-de-droit-avec-j-karsenti-20261030-clermont-ferrand-346',
  'Corruptions. L''effondrement de l''État de droit avec J. Karsenti',
  'Événement annoncé : Corruptions. L''effondrement de l''État de droit avec J. Karsenti. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1957',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f36d5233-4b56-47f4-b967-0728e23db5a2',
  'ds-preparons-la-greve-feministe-20261031-clermont-ferrand-347',
  'Préparons la grève féministe',
  'Événement annoncé : Préparons la grève féministe. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 31/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.78145, 3.085345, NULL,
  '2026-10-31T13:00:00Z'::timestamptz,
  '2026-10-31T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1955',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8c9ba36c-298d-4be1-9b42-a029321a220f',
  'ds-nous-ne-serons-plus-des-chaperons-rouges-avec-stephanie-durdilly-20261106-clermont-ferrand-348',
  'Nous ne serons plus des Chaperons rouges avec Stéphanie Durdilly',
  'Événement annoncé : Nous ne serons plus des Chaperons rouges avec Stéphanie Durdilly. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 06/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  '2026-11-06T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1958',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bd7539c9-ca8d-40f8-8457-11a7df99f5b9',
  'ds-pour-une-histoire-reelle-du-colonialisme-francais-avec-alain-ruscio-20261110-clermont-ferrand-349',
  'Pour une histoire réelle du colonialisme français avec Alain Ruscio',
  'Événement annoncé : Pour une histoire réelle du colonialisme français avec Alain Ruscio. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 10/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  '2026-11-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1959',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4085f90b-48ba-489f-b154-957dacf948b2',
  'ds-arret-de-travail-avec-eva-blanck-20261120-clermont-ferrand-350',
  'Arrêt de travail avec Éva BLANCK',
  'Événement annoncé : Arrêt de travail avec Éva BLANCK. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 20/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-11-20T18:00:00Z'::timestamptz,
  '2026-11-20T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1960',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fbfd0e99-d1ab-4d79-8585-1bd8fcaa53cb',
  'ds-contre-les-violences-faites-aux-femmes-20261121-clermont-ferrand-351',
  'Contre les violences faites aux femmes',
  'Événement annoncé : Contre les violences faites aux femmes. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 21/11/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.776583, 3.08247, NULL,
  '2026-11-21T14:00:00Z'::timestamptz,
  '2026-11-21T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1967',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '29db433b-365b-42dd-ba62-08ede72b1a76',
  'ds-l-ecocide-capitaliste-avec-alain-bihr-20261127-clermont-ferrand-352',
  'L''écocide capitaliste avec Alain Bihr',
  'Événement annoncé : L''écocide capitaliste avec Alain Bihr. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 27/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-11-27T18:00:00Z'::timestamptz,
  '2026-11-27T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1961',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fd0d6310-162e-41ef-873a-ddeae14b7bc6',
  'ds-la-police-contre-la-rue-avec-francois-rabate-20261210-clermont-ferrand-353',
  'La police contre la rue avec François Rabaté',
  'Événement annoncé : La police contre la rue avec François Rabaté. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 10/12/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-12-10T18:00:00Z'::timestamptz,
  '2026-12-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1962',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '43dcd673-a146-40a6-81aa-a997c6c0050c',
  'ds-allemagne-1918-1923-lecons-d-une-revolution-fusillee-avec-anne-deffarg-20261217-clermont-ferrand-',
  'Allemagne 1918-1923. Leçons d’une révolution fusillée avec Anne Deffarges',
  'Événement annoncé : Allemagne 1918-1923. Leçons d’une révolution fusillée avec Anne Deffarges. Lieu indiqué : Clermont-Ferrand (Clermont-Ferrand). Début prévu le 17/12/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Clermont-Ferrand',
  NULL,
  'FR', 'Europe/Paris',
  'Clermont-Ferrand',
  45.770462, 3.085427, NULL,
  '2026-12-17T18:00:00Z'::timestamptz,
  '2026-12-17T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://63.demosphere.net/rv/1963',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '967c3ed0-d6c5-4160-b1fd-6a43467fb48f',
  'ds-cantine-mensuelle-a-la-loco-en-soutien-a-micros-rebelles-20261030-calais-355',
  'Cantine mensuelle à la Loco, en soutien à Micros Rebelles',
  'Événement annoncé : Cantine mensuelle à la Loco, en soutien à Micros Rebelles. Lieu indiqué : #Calais (#Calais). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Calais',
  NULL,
  'FR', 'Europe/Paris',
  '#Calais',
  NULL, NULL, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4560',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3601c33e-6461-4923-a969-b82c9cdc0f1d',
  'ds-confrontiere-expose-sur-les-politiques-migratoires-20261031-calais-356',
  'Confrontière : exposé sur les politiques migratoires',
  'Événement annoncé : Confrontière : exposé sur les politiques migratoires. Lieu indiqué : #Calais (#Calais). Début prévu le 31/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Calais',
  NULL,
  'FR', 'Europe/Paris',
  '#Calais',
  NULL, NULL, NULL,
  '2026-10-31T18:00:00Z'::timestamptz,
  '2026-10-31T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4557',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e3cbe58d-8ad2-4e76-a730-cb5ed0251175',
  'ds-cine-debat-film-le-chene-20261103-rexpoede-357',
  'Ciné-débat - film "Le chêne"',
  'Événement annoncé : Ciné-débat - film "Le chêne". Lieu indiqué : #Rexpoëde (#Rexpoëde). Début prévu le 03/11/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Rexpoëde',
  NULL,
  'FR', 'Europe/Paris',
  '#Rexpoëde',
  NULL, NULL, NULL,
  '2026-11-03T18:30:00Z'::timestamptz,
  '2026-11-03T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4559',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2cdadf4c-d682-4978-8508-31c48a38d9d5',
  'ds-journee-interprofessionnelle-unitaire-de-greves-et-manifestations-20261105-france-358',
  'Journée interprofessionnelle unitaire de grèves et manifestations',
  'Événement annoncé : Journée interprofessionnelle unitaire de grèves et manifestations. Lieu indiqué : #France (#France). Début prévu le 05/11/2026 à 08:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  '#France',
  NULL,
  'FR', 'Europe/Paris',
  '#France',
  NULL, NULL, NULL,
  '2026-11-05T07:00:00Z'::timestamptz,
  '2026-11-05T10:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4551',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '07d0d182-e2e9-4d48-9531-5af33de02317',
  'ds-conference-preserver-la-biodiversite-ca-veut-dire-quoi-20261106-st-sylvestre-c-359',
  'Conférence "Préserver la biodiversité, ça veut dire quoi ?"',
  'Événement annoncé : Conférence "Préserver la biodiversité, ça veut dire quoi ?". Lieu indiqué : #St Sylvestre C. (#St Sylvestre C.). Début prévu le 06/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'climat',
  '#St Sylvestre C.',
  NULL,
  'FR', 'Europe/Paris',
  '#St Sylvestre C.',
  NULL, NULL, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  '2026-11-06T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4550',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd72cc713-4013-4c66-8045-6bec0bc664ee',
  'ds-conference-canicule-phenomene-aux-causes-politiques-20261113-dunkerque-360',
  'Conférence "Canicule, phénomène aux causes politiques"',
  'Événement annoncé : Conférence "Canicule, phénomène aux causes politiques". Lieu indiqué : #Dunkerque (#Dunkerque). Début prévu le 13/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Dunkerque',
  NULL,
  'FR', 'Europe/Paris',
  '#Dunkerque',
  NULL, NULL, NULL,
  '2026-11-13T17:30:00Z'::timestamptz,
  '2026-11-13T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4567',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f1183574-d326-4de5-978a-08f1c3926539',
  'ds-cine-debat-film-au-fil-de-l-eau-de-l-insouciance-a-la-desobeissance-20261118-dunkerque-361',
  'Ciné-débat - film "Au fil de l’eau, de l’insouciance à la désobéissance"',
  'Événement annoncé : Ciné-débat - film "Au fil de l’eau, de l’insouciance à la désobéissance". Lieu indiqué : #Dunkerque (#Dunkerque). Début prévu le 18/11/2026 à 19:45 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Dunkerque',
  NULL,
  'FR', 'Europe/Paris',
  '#Dunkerque',
  NULL, NULL, NULL,
  '2026-11-18T18:45:00Z'::timestamptz,
  '2026-11-18T21:45:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4538',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8e820371-45ca-491b-8233-d7f8d0c0428d',
  'ds-greve-internationale-des-etudiants-contre-la-guerre-20261120-france-362',
  'Grève internationale des étudiants contre la guerre',
  'Événement annoncé : Grève internationale des étudiants contre la guerre. Lieu indiqué : #France (#France). Début prévu le 20/11/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  '#France',
  NULL,
  'FR', 'Europe/Paris',
  '#France',
  NULL, NULL, NULL,
  '2026-11-20T08:00:00Z'::timestamptz,
  '2026-11-20T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4470',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cd582ea4-96b0-458c-8e71-70848e56f4b4',
  'ds-cine-rencontre-insecticide-comment-l-agrochimie-a-tue-les-insectes-20261124-coudekerque-b-363',
  'Ciné-rencontre "Insecticide, comment l’agrochimie a tué les insectes"',
  'Événement annoncé : Ciné-rencontre "Insecticide, comment l’agrochimie a tué les insectes". Lieu indiqué : #Coudekerque-B (#Coudekerque-B). Début prévu le 24/11/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  '#Coudekerque-B',
  NULL,
  'FR', 'Europe/Paris',
  '#Coudekerque-B',
  NULL, NULL, NULL,
  '2026-11-24T19:00:00Z'::timestamptz,
  '2026-11-24T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4537',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6747b8fe-c26b-4702-95d5-f78f21ba8587',
  'ds-soiree-d-echanges-sante-mentale-des-jeunes-20261127-st-sylvestre-c-364',
  'Soirée d''échanges "Santé mentale des jeunes"',
  'Événement annoncé : Soirée d''échanges "Santé mentale des jeunes". Lieu indiqué : #St Sylvestre C. (#St Sylvestre C.). Début prévu le 27/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'sante',
  '#St Sylvestre C.',
  NULL,
  'FR', 'Europe/Paris',
  '#St Sylvestre C.',
  NULL, NULL, NULL,
  '2026-11-27T18:00:00Z'::timestamptz,
  '2026-11-27T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://dunkerque.demosphere.net/rv/4563',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3ac00fc5-c54a-4a86-ba17-4d52185b6bc5',
  'ds-free-palestine-20261031-vierzon-365',
  'Free Palestine',
  'Événement annoncé : Free Palestine. Lieu indiqué : Vierzon (Vierzon). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Vierzon',
  NULL,
  'FR', 'Europe/Paris',
  'Vierzon',
  47.22169, 2.062319, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2356',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1c2e694d-c235-4f5d-bd63-ec5fc95e27c8',
  'ds-free-palestine-20261031-bourges-366',
  'Free Palestine',
  'Événement annoncé : Free Palestine. Lieu indiqué : Bourges (Bourges). Début prévu le 31/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Bourges',
  '37130',
  'FR', 'Europe/Paris',
  'Bourges',
  47.339243, 0.381123, NULL,
  '2026-10-31T13:30:00Z'::timestamptz,
  '2026-10-31T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2361',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '626a23f7-8aec-4e96-bbc6-82c30e151faa',
  'ds-atelier-couture-20261104-morogues-367',
  'Atelier couture',
  'Événement annoncé : Atelier couture. Lieu indiqué : Morogues (Morogues). Début prévu le 04/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Morogues',
  NULL,
  'FR', 'Europe/Paris',
  'Morogues',
  47.233216, 2.592109, NULL,
  '2026-11-04T13:00:00Z'::timestamptz,
  '2026-11-04T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2368',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '286a6011-d086-42a6-b7d9-0b47eeb951bb',
  'ds-cafe-repaire-20261104-vierzon-368',
  'Café Repaire',
  'Événement annoncé : Café Repaire. Lieu indiqué : Vierzon (Vierzon). Début prévu le 04/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Vierzon',
  '18100',
  'FR', 'Europe/Paris',
  'Vierzon',
  47.223215, 2.082045, NULL,
  '2026-11-04T18:00:00Z'::timestamptz,
  '2026-11-04T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2372',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c0766679-7760-42d7-a570-b1fcd49d4e02',
  'ds-free-palestine-20261107-bourges-369',
  'Free Palestine',
  'Événement annoncé : Free Palestine. Lieu indiqué : Bourges (Bourges). Début prévu le 07/11/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'Bourges',
  '37130',
  'FR', 'Europe/Paris',
  'Bourges',
  47.339243, 0.381123, NULL,
  '2026-11-07T13:30:00Z'::timestamptz,
  '2026-11-07T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2359',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '74c09a83-0b3c-438e-8028-007ec14aa9af',
  'ds-festival-alimenterre-20261109-bourges-370',
  'Festival Alimenterre',
  'Événement annoncé : Festival Alimenterre. Lieu indiqué : Bourges (Bourges). Début prévu le 09/11/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bourges',
  NULL,
  'FR', 'Europe/Paris',
  'Bourges',
  47.076683, 2.384195, NULL,
  '2026-11-09T17:30:00Z'::timestamptz,
  '2026-11-09T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2371',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bc4a9d0d-ccbc-4139-a544-6a37c29d0f47',
  'ds-atelier-couture-20261114-morogues-371',
  'Atelier couture',
  'Événement annoncé : Atelier couture. Lieu indiqué : Morogues (Morogues). Début prévu le 14/11/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Morogues',
  NULL,
  'FR', 'Europe/Paris',
  'Morogues',
  47.233216, 2.592109, NULL,
  '2026-11-14T08:30:00Z'::timestamptz,
  '2026-11-14T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2367',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9d537318-0472-47a6-b72c-6328900f070f',
  'ds-atelier-formation-comprendre-et-agir-sur-les-ecarts-d-implication-dans-20261121-morogues-372',
  'Atelier/formation - Comprendre et agir sur les écarts d''implication dans un groupe',
  'Événement annoncé : Atelier/formation - Comprendre et agir sur les écarts d''implication dans un groupe. Lieu indiqué : Morogues (Morogues). Début prévu le 21/11/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Morogues',
  '18220',
  'FR', 'Europe/Paris',
  'Morogues',
  47.283686, 2.578236, NULL,
  '2026-11-21T09:00:00Z'::timestamptz,
  '2026-11-21T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2341',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '073223c0-6087-40fc-b14f-8d1ac8f9d4fc',
  'ds-atelier-couture-20261202-morogues-373',
  'Atelier couture',
  'Événement annoncé : Atelier couture. Lieu indiqué : Morogues (Morogues). Début prévu le 02/12/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Morogues',
  NULL,
  'FR', 'Europe/Paris',
  'Morogues',
  47.233216, 2.592109, NULL,
  '2026-12-02T13:00:00Z'::timestamptz,
  '2026-12-02T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2370',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2f47a7f8-5193-449e-bd8e-5c065a814a7a',
  'ds-atelier-couture-20261216-morogues-374',
  'Atelier couture',
  'Événement annoncé : Atelier couture. Lieu indiqué : Morogues (Morogues). Début prévu le 16/12/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Morogues',
  NULL,
  'FR', 'Europe/Paris',
  'Morogues',
  47.233216, 2.592109, NULL,
  '2026-12-16T13:00:00Z'::timestamptz,
  '2026-12-16T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://berry.demosphere.net/rv/2369',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '03f5c7ae-81bf-448b-8fe6-7cb60cbc3a9a',
  'ds-rassemblement-contre-les-violences-sexistes-et-sexuelles-au-travail-20261102-montmorillon-375',
  'Rassemblement contre les violences sexistes et sexuelles au travail',
  'Événement annoncé : Rassemblement contre les violences sexistes et sexuelles au travail. Lieu indiqué : Montmorillon (Montmorillon). Début prévu le 02/11/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Montmorillon',
  NULL,
  'FR', 'Europe/Paris',
  'Montmorillon',
  46.4239, 0.869789, NULL,
  '2026-11-02T17:00:00Z'::timestamptz,
  '2026-11-02T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://poitiers.demosphere.net/rv/4544',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8dcecc4a-ec0a-4d71-a661-73fa90f6e299',
  'ds-greve-et-rassemblement-20261105-montmorillon-376',
  'Grève et rassemblement',
  'Événement annoncé : Grève et rassemblement. Lieu indiqué : Montmorillon (Montmorillon). Début prévu le 05/11/2026 à 12:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Montmorillon',
  NULL,
  'FR', 'Europe/Paris',
  'Montmorillon',
  46.4239, 0.869789, NULL,
  '2026-11-05T11:00:00Z'::timestamptz,
  '2026-11-05T14:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://poitiers.demosphere.net/rv/4545',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b19b2731-eae8-460a-82f2-2711ac1df6fa',
  'ds-greve-et-manifestation-20261105-poitiers-377',
  'Grève et manifestation',
  'Événement annoncé : Grève et manifestation. Lieu indiqué : Poitiers (Poitiers). Début prévu le 05/11/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'travail',
  'Poitiers',
  NULL,
  'FR', 'Europe/Paris',
  'Poitiers',
  46.590293, 0.340002, NULL,
  '2026-11-05T13:00:00Z'::timestamptz,
  '2026-11-05T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://poitiers.demosphere.net/rv/4546',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '395430c0-a377-470d-865c-c2323590f89d',
  'ds-concert-de-solidarite-avec-le-toit-du-monde-20261106-poitiers-378',
  'Concert de solidarité avec le Toit du monde',
  'Événement annoncé : Concert de solidarité avec le Toit du monde. Lieu indiqué : Poitiers (Poitiers). Début prévu le 06/11/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Poitiers',
  NULL,
  'FR', 'Europe/Paris',
  'Poitiers',
  46.565066, 0.369497, NULL,
  '2026-11-06T19:30:00Z'::timestamptz,
  '2026-11-06T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://poitiers.demosphere.net/rv/4541',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '97e7d925-6869-4885-bd9a-d33352e576fe',
  'ds-manifestation-un-toit-est-un-droit-20261107-poitiers-379',
  'Manifestation Un toit est un droit',
  'Événement annoncé : Manifestation Un toit est un droit. Lieu indiqué : Poitiers (Poitiers). Début prévu le 07/11/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Poitiers',
  '58000',
  'FR', 'Europe/Paris',
  'Poitiers',
  46.984502, 3.118765, NULL,
  '2026-11-07T13:30:00Z'::timestamptz,
  '2026-11-07T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://poitiers.demosphere.net/rv/4538',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e855a944-873d-4741-abfa-bfccf4910832',
  'ds-reunion-mensuelle-ouverte-les-mardis-globenet-services-internet-milita-20261110-paris-380',
  'Réunion mensuelle ouverte « Les Mardis Globenet » - services internet militants',
  'Événement annoncé : Réunion mensuelle ouverte « Les Mardis Globenet » - services internet militants. Lieu indiqué : Paris 11e (Paris). Début prévu le 10/11/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Paris 11e',
  48.852814, 2.392299, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  '2026-11-10T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://paris.demosphere.net/rv/82397',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c129a89f-a11f-4e55-92a6-3954235aff9f',
  'ds-reunion-mensuelle-ouverte-les-mardis-globenet-services-internet-milita-20261208-paris-381',
  'Réunion mensuelle ouverte « Les Mardis Globenet » - services internet militants',
  'Événement annoncé : Réunion mensuelle ouverte « Les Mardis Globenet » - services internet militants. Lieu indiqué : Paris 11e (Paris). Début prévu le 08/12/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Paris 11e',
  48.852814, 2.392299, NULL,
  '2026-12-08T18:00:00Z'::timestamptz,
  '2026-12-08T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://paris.demosphere.net/rv/82398',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ad2e1411-628a-490b-93a8-1aa29c80379a',
  'ds-visite-commentee-du-musee-de-prehistoire-20261028-aurignac-382',
  'Visite commentée du Musée de Préhistoire',
  'Événement annoncé : Visite commentée du Musée de Préhistoire. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-28T13:30:00Z'::timestamptz,
  '2026-10-28T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52254',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd9a3d28e-378f-4a4f-8d35-856a904e5267',
  'ds-ouverture-du-cafe-solidaire-de-l31-centre-social-autogere-20261028-tarbes-383',
  'Ouverture du café solidaire de L31, Centre Social Autogéré',
  'Événement annoncé : Ouverture du café solidaire de L31, Centre Social Autogéré. Lieu indiqué : Tarbes (Tarbes). Début prévu le 28/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234773, 0.070877, NULL,
  '2026-10-28T14:00:00Z'::timestamptz,
  '2026-10-28T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51941',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a7ceddd7-ac09-489b-ba50-7a954febfdb3',
  'ds-visite-contee-et-gouter-offert-a-la-maison-des-sources-20261028-mauleon-barousse-384',
  'Visite contée et Goûter offert à la Maison des Sources',
  'Événement annoncé : Visite contée et Goûter offert à la Maison des Sources. Lieu indiqué : Mauléon-Barousse (Mauléon-Barousse). Début prévu le 28/10/2026 à 15:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mauléon-Barousse',
  NULL,
  'FR', 'Europe/Paris',
  'Mauléon-Barousse',
  42.965439, 0.57026, NULL,
  '2026-10-28T14:00:00Z'::timestamptz,
  '2026-10-28T17:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52567',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '919325b9-2f0b-4dd6-8423-326f73d57ba6',
  'ds-2h-d-escalade-pour-les-jeunes-de-10-a-16-ans-accessible-a-tout-les-niv-20261028-labroquere-385',
  '2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 28/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-28T14:30:00Z'::timestamptz,
  '2026-10-28T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52462',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '087fe622-e62b-4cb0-a895-148dc11987f6',
  'ds-atelier-animaux-d-argiles-au-musee-20261028-aurignac-386',
  'Atelier Animaux d''argiles au Musée',
  'Événement annoncé : Atelier Animaux d''argiles au Musée. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-28T15:00:00Z'::timestamptz,
  '2026-10-28T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/49661',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f1eff04f-64ed-4180-a87e-09ae798c7956',
  'ds-atelier-animaux-d-argile-modelage-20261028-aurignac-387',
  'Atelier Animaux d''argile - modelage',
  'Événement annoncé : Atelier Animaux d''argile - modelage. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-28T15:00:00Z'::timestamptz,
  '2026-10-28T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52333',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '709f2de7-6422-47ed-8610-41e0aeb8dd82',
  'ds-solidarite-avec-la-palestine-rassemblement-a-st-go-20261028-st-gaudens-388',
  'Solidarité avec la Palestine : rassemblement à St-Go',
  'Événement annoncé : Solidarité avec la Palestine : rassemblement à St-Go. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 28/10/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'international',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108642, 0.726912, NULL,
  '2026-10-28T16:30:00Z'::timestamptz,
  '2026-10-28T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52629',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '56961ccf-6a12-4826-ae66-971bfe455775',
  'ds-let-s-talk-in-english-20261028-aurignac-389',
  'Let''s talk in English',
  'Événement annoncé : Let''s talk in English. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51735',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'de03c70d-eebd-468b-bae1-7133b8ac743d',
  'ds-1h30-d-escalade-pour-les-adultes-a-partir-de-16-ans-20261028-labroquere-390',
  '1h30 d''escalade pour les adultes à partir de 16 ans.',
  'Événement annoncé : 1h30 d''escalade pour les adultes à partir de 16 ans.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52467',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '634c20fa-417b-4a3b-b3b2-eae86025cd16',
  'ds-energies-renouvelables-a-aurignac-reunion-publique-projection-20261028-aurignac-391',
  'Energies renouvelables à Aurignac : Réunion publique + Projection',
  'Événement annoncé : Energies renouvelables à Aurignac : Réunion publique + Projection. Lieu indiqué : Aurignac (Aurignac). Début prévu le 28/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.217116, 0.882004, NULL,
  '2026-10-28T17:00:00Z'::timestamptz,
  '2026-10-28T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52551',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c5b72f19-2ed4-45a0-9a46-3713f805db28',
  'ds-atelier-de-danses-occitanes-20261028-cierp-gaud-392',
  'Atelier de danses occitanes',
  'Événement annoncé : Atelier de danses occitanes. Lieu indiqué : Cierp-Gaud (Cierp-Gaud). Début prévu le 28/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cierp-Gaud',
  NULL,
  'FR', 'Europe/Paris',
  'Cierp-Gaud',
  42.913924, 0.638757, NULL,
  '2026-10-28T19:30:00Z'::timestamptz,
  '2026-10-28T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51741',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ae57e2c1-0d8c-40be-b17b-0ba0728e1baa',
  'ds-festival-du-film-paysan-20261028-ibos-393',
  'Festival du film paysan',
  'Événement annoncé : Festival du film paysan. Lieu indiqué : Ibos (Ibos). Début prévu le 28/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Ibos',
  NULL,
  'FR', 'Europe/Paris',
  'Ibos',
  43.239308, 0.013588, NULL,
  '2026-10-28T19:30:00Z'::timestamptz,
  '2026-10-28T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52429',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6da5f685-a5a1-4e83-bec3-5ad1024b9d3a',
  'ds-bapteme-en-attelage-canin-du-20-au-30-octobre-venez-decouvrir-le-canik-20261029-station-le-mourti',
  'Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart',
  'Événement annoncé : Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart. Lieu indiqué : Station Le Mourtis (Station Le Mourtis). Début prévu le 29/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Station Le Mourtis',
  NULL,
  'FR', 'Europe/Paris',
  'Station Le Mourtis',
  42.912459, 0.768403, NULL,
  '2026-10-29T08:30:00Z'::timestamptz,
  '2026-10-29T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52277',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3dfb4aff-9bff-4866-915d-03faa7363c46',
  'ds-atelier-d-ecriture-aux-ateliers-du-temps-libre-evs-20261029-aspet-395',
  'Atelier d''écriture aux Ateliers du Temps Libre (EVS)',
  'Événement annoncé : Atelier d''écriture aux Ateliers du Temps Libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 29/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-29T09:00:00Z'::timestamptz,
  '2026-10-29T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51746',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '47abd065-43c7-4735-8bdd-d3b2e7df8690',
  'ds-stage-cirque-8-12-ans-20261029-cazeres-396',
  'Stage cirque 8-12 ans',
  'Événement annoncé : Stage cirque 8-12 ans. Lieu indiqué : Cazères (Cazères). Début prévu le 29/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.20722, 1.078087, NULL,
  '2026-10-29T09:00:00Z'::timestamptz,
  '2026-10-29T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52378',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7fab490e-e145-4cb6-84d5-aa761ecfea78',
  'ds-lecture-et-visite-speciale-enfant-20261029-aurignac-397',
  'Lecture et visite spéciale enfant',
  'Événement annoncé : Lecture et visite spéciale enfant. Lieu indiqué : Aurignac (Aurignac). Début prévu le 29/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-29T10:00:00Z'::timestamptz,
  '2026-10-29T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52243',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9f258d76-4cab-41c7-a0d7-a119e97dfcfa',
  'ds-1h-d-escalade-pour-les-enfants-de-3-a-5-ans-accessible-a-tous-20261029-labroquere-398',
  '1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.',
  'Événement annoncé : 1h d''escalade pour les enfants de 3 à 5 ans. Accessible à tous.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 29/10/2026 à 11:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-29T10:30:00Z'::timestamptz,
  '2026-10-29T13:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52456',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f7181695-045d-4f3a-a41d-1621fd4d05b7',
  'ds-2h-d-escalade-pour-les-enfants-de-6-a-9-ans-accessible-a-tout-les-nive-20261029-labroquere-399',
  '2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les enfants de 6 à 9 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 29/10/2026 à 13:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-29T12:30:00Z'::timestamptz,
  '2026-10-29T15:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52460',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '99eaacd4-0db8-4620-8061-cd8971f58dad',
  'ds-atelier-de-dessin-et-de-peinture-20261029-seich-400',
  'Atelier de dessin et de peinture',
  'Événement annoncé : Atelier de dessin et de peinture. Lieu indiqué : Seich (Seich). Début prévu le 29/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Seich',
  '65150',
  'FR', 'Europe/Paris',
  'Seich',
  43.016832, 0.489873, NULL,
  '2026-10-29T13:00:00Z'::timestamptz,
  '2026-10-29T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52231',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ea5066da-e8ea-4e77-b94b-db9439f58a7f',
  'ds-ateliers-dessins-aquarelle-techniques-mixtes-aux-ateliers-du-temps-lib-20261029-aspet-401',
  'Ateliers dessins, aquarelle , techniques mixtes aux Ateliers du Temps Libre ( EVS)',
  'Événement annoncé : Ateliers dessins, aquarelle , techniques mixtes aux Ateliers du Temps Libre ( EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 29/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-29T13:30:00Z'::timestamptz,
  '2026-10-29T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51754',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f61d705e-2d2d-42f1-9af4-b505e77e3489',
  'ds-montmaurin-sites-et-musee-archeo-visite-des-5-sens-a-la-villa-20261029-montmaurin-402',
  'MONTMAURIN sites et musée archéo - Visite des 5 sens à la villa',
  'Événement annoncé : MONTMAURIN sites et musée archéo - Visite des 5 sens à la villa. Lieu indiqué : Montmaurin (Montmaurin). Début prévu le 29/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Montmaurin',
  NULL,
  'FR', 'Europe/Paris',
  'Montmaurin',
  43.21654, 0.646075, NULL,
  '2026-10-29T13:30:00Z'::timestamptz,
  '2026-10-29T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52028',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9f586713-ec72-4e05-9a4c-0dc273201f42',
  'ds-visite-commentee-du-musee-de-prehistoire-20261029-aurignac-403',
  'Visite commentée du Musée de Préhistoire',
  'Événement annoncé : Visite commentée du Musée de Préhistoire. Lieu indiqué : Aurignac (Aurignac). Début prévu le 29/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-29T13:30:00Z'::timestamptz,
  '2026-10-29T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52255',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2be9abff-b307-41c5-a8c7-772875b3cdaf',
  'ds-atelier-vannerie-20261029-aurignac-404',
  'Atelier vannerie',
  'Événement annoncé : Atelier vannerie. Lieu indiqué : Aurignac (Aurignac). Début prévu le 29/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-29T13:30:00Z'::timestamptz,
  '2026-10-29T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52334',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9e907a77-8e54-4689-a0ee-56e71fe984a0',
  'ds-2h-d-escalade-pour-les-jeunes-de-10-a-16-ans-accessible-a-tout-les-niv-20261029-labroquere-405',
  '2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.',
  'Événement annoncé : 2h d''escalade pour les jeunes de 10 à 16 ans. Accessible à tout les niveaux.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 29/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-29T14:30:00Z'::timestamptz,
  '2026-10-29T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52464',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cd4a3a55-00a7-478a-a29b-ff0ebff3e266',
  'ds-marche-de-producteurs-du-pays-20261029-castillon-de-saint-martory-406',
  'Marché de producteurs du pays',
  'Événement annoncé : Marché de producteurs du pays. Lieu indiqué : Castillon-de-Saint-Martory (Castillon-de-Saint-Martory). Début prévu le 29/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Castillon-de-Saint-Martory',
  NULL,
  'FR', 'Europe/Paris',
  'Castillon-de-Saint-Martory',
  43.134121, 0.858299, NULL,
  '2026-10-29T15:00:00Z'::timestamptz,
  '2026-10-29T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52595',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '8ab4d7eb-e591-4fad-a23b-4bf3cb390a8b',
  'ds-que-parlam-gascon-20261029-aurignac-407',
  'Que parlam gascon',
  'Événement annoncé : Que parlam gascon. Lieu indiqué : Aurignac (Aurignac). Début prévu le 29/10/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-29T16:00:00Z'::timestamptz,
  '2026-10-29T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51756',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7aaf5c44-0550-4739-99fa-dc153b4673ca',
  'ds-ouverture-du-cafe-solidaire-de-l31-centre-social-autogere-20261029-tarbes-408',
  'Ouverture du café solidaire de L31, Centre Social Autogéré',
  'Événement annoncé : Ouverture du café solidaire de L31, Centre Social Autogéré. Lieu indiqué : Tarbes (Tarbes). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234773, 0.070877, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51946',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e24efeff-ea95-4827-8165-b92222b79e5a',
  'ds-1h30-d-escalade-pour-les-adultes-a-partir-de-16-ans-20261029-labroquere-409',
  '1h30 d''escalade pour les adultes à partir de 16 ans.',
  'Événement annoncé : 1h30 d''escalade pour les adultes à partir de 16 ans.. Lieu indiqué : Labroquère (Labroquère). Début prévu le 29/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Labroquère',
  NULL,
  'FR', 'Europe/Paris',
  'Labroquère',
  43.041403, 0.589793, NULL,
  '2026-10-29T17:00:00Z'::timestamptz,
  '2026-10-29T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52469',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd71a812e-f921-48e3-a530-3765903bda26',
  'ds-sortie-de-residence-esthesis-rock-alternatif-post-progressif-20261029-st-laurent-de-neste-410',
  'Sortie de résidence : Esthesis | Rock Alternatif post progressif',
  'Événement annoncé : Sortie de résidence : Esthesis | Rock Alternatif post progressif. Lieu indiqué : St-Laurent-de-Neste (St-Laurent-de-Neste). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Laurent-de-Neste',
  NULL,
  'FR', 'Europe/Paris',
  'St-Laurent-de-Neste',
  43.080011, 0.481456, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51435',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '46f42895-7658-4554-928e-596a622676fa',
  'ds-cours-de-japonais-20261029-aurignac-411',
  'Cours de japonais',
  'Événement annoncé : Cours de japonais. Lieu indiqué : Aurignac (Aurignac). Début prévu le 29/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-29T17:30:00Z'::timestamptz,
  '2026-10-29T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52426',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f2db2343-de34-41a2-a12e-c265ec6b5915',
  'ds-atelier-hebdomadaire-de-danses-traditionnelles-et-populaires-20261029-aneres-412',
  'Atelier hebdomadaire de danses traditionnelles et populaires',
  'Événement annoncé : Atelier hebdomadaire de danses traditionnelles et populaires. Lieu indiqué : Anères (Anères). Début prévu le 29/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Anères',
  NULL,
  'FR', 'Europe/Paris',
  'Anères',
  43.068838, 0.465899, NULL,
  '2026-10-29T18:30:00Z'::timestamptz,
  '2026-10-29T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/50845',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd5899057-7670-450a-93e0-178f8e41443a',
  'ds-cours-de-danses-trad-occitanes-avec-marie-claire-carre-viala-miramont--20261029-miramont-de-commi',
  'Cours de danses trad occitanes avec Marie-Claire Carré-Viala - Miramont / St Go',
  'Événement annoncé : Cours de danses trad occitanes avec Marie-Claire Carré-Viala - Miramont / St Go. Lieu indiqué : Miramont-de-Comminges (Miramont-de-Comminges). Début prévu le 29/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Miramont-de-Comminges',
  NULL,
  'FR', 'Europe/Paris',
  'Miramont-de-Comminges',
  43.097539, 0.770996, NULL,
  '2026-10-29T19:00:00Z'::timestamptz,
  '2026-10-29T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51757',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0692a72f-97be-45ba-93b2-be5c3fd52125',
  'ds-festival-du-film-paysan-20261029-bagneres-de-bigorre-414',
  'Festival du film paysan',
  'Événement annoncé : Festival du film paysan. Lieu indiqué : Bagnères-de-Bigorre (Bagnères-de-Bigorre). Début prévu le 29/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Bagnères-de-Bigorre',
  NULL,
  'FR', 'Europe/Paris',
  'Bagnères-de-Bigorre',
  43.062694, 0.150832, NULL,
  '2026-10-29T19:30:00Z'::timestamptz,
  '2026-10-29T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52430',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f7bc4a30-3e10-46e6-89ac-23ccef52b723',
  'ds-festival-du-film-paysan-20261030-campan-415',
  'Festival du film paysan',
  'Événement annoncé : Festival du film paysan. Lieu indiqué : Campan (65) (Campan). Début prévu le 30/10/2026 à 03:33 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Campan',
  NULL,
  'FR', 'Europe/Paris',
  'Campan (65)',
  43.017149, 0.177098, NULL,
  '2026-10-30T02:33:00Z'::timestamptz,
  '2026-10-30T05:33:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52427',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4f1e16ef-c18b-492e-ab54-cdf18e672fcb',
  'ds-rassemblement-et-action-contre-la-fabrication-de-drones-tueurs-a-bouss-20261030-boussens-416',
  'Rassemblement et action contre la fabrication de drones tueurs à Boussens',
  'Événement annoncé : Rassemblement et action contre la fabrication de drones tueurs à Boussens. Lieu indiqué : Boussens (Boussens). Début prévu le 30/10/2026 à 07:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'social',
  'Boussens',
  NULL,
  'FR', 'Europe/Paris',
  'Boussens',
  43.176154, 0.972612, NULL,
  '2026-10-30T06:30:00Z'::timestamptz,
  '2026-10-30T09:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52089',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '15948337-9bc3-42a8-866f-3af006665009',
  'ds-cours-d-anglais-pour-debutants-faux-debutants-aux-ateliers-du-temps-li-20261030-aspet-417',
  'Cours d''anglais pour débutants- faux débutants aux Ateliers du Temps Libre d''Aspet',
  'Événement annoncé : Cours d''anglais pour débutants- faux débutants aux Ateliers du Temps Libre d''Aspet. Lieu indiqué : Aspet (Aspet). Début prévu le 30/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-30T08:30:00Z'::timestamptz,
  '2026-10-30T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51776',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e4622a9c-6c4a-4432-8cea-d249e98c746a',
  'ds-bapteme-en-attelage-canin-du-20-au-30-octobre-venez-decouvrir-le-canik-20261030-station-le-mourti',
  'Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart',
  'Événement annoncé : Baptême en attelage canin du 20 au 30 octobre! Venez découvrir le canikart. Lieu indiqué : Station Le Mourtis (Station Le Mourtis). Début prévu le 30/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Station Le Mourtis',
  NULL,
  'FR', 'Europe/Paris',
  'Station Le Mourtis',
  42.912459, 0.768403, NULL,
  '2026-10-30T08:30:00Z'::timestamptz,
  '2026-10-30T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52278',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '50399bf6-34c0-401e-903c-b3514202e18c',
  'ds-atelier-de-peinture-ateliers-du-temps-libre-evs-20261030-aspet-419',
  'Atelier de peinture | Ateliers du temps libre (EVS)',
  'Événement annoncé : Atelier de peinture | Ateliers du temps libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 30/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-30T09:00:00Z'::timestamptz,
  '2026-10-30T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51775',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd8123b72-6fe4-4d35-b98f-332eb70541b3',
  'ds-journee-de-stage-aeriens-cirque-a-partir-de-8-ans-20261030-cazeres-420',
  'Journée de stage aériens - Cirque à partir de 8 ans',
  'Événement annoncé : Journée de stage aériens - Cirque à partir de 8 ans. Lieu indiqué : Cazères (Cazères). Début prévu le 30/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.20722, 1.078087, NULL,
  '2026-10-30T09:00:00Z'::timestamptz,
  '2026-10-30T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52379',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '1d16f5f2-0c72-44dd-8c34-c6ad0ac3edd7',
  'ds-cours-d-anglais-niveau-avance-aux-ateliers-du-temps-libre-evs-20261030-aspet-421',
  'Cours d''anglais niveau avancé aux Ateliers du Temps Libre ( EVS)',
  'Événement annoncé : Cours d''anglais niveau avancé aux Ateliers du Temps Libre ( EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 30/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-30T10:00:00Z'::timestamptz,
  '2026-10-30T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51777',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '25402149-4504-46d8-be7d-9e8163056e77',
  'ds-atelier-art-sur-pierre-20261030-aurignac-422',
  'Atelier Art sur pierre',
  'Événement annoncé : Atelier Art sur pierre. Lieu indiqué : Aurignac (Aurignac). Début prévu le 30/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-30T10:00:00Z'::timestamptz,
  '2026-10-30T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52336',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '908df28a-31cc-4145-bd8f-d5e174d1069e',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261030-st-gaudens-423',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 30/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108094, 0.722677, NULL,
  '2026-10-30T13:00:00Z'::timestamptz,
  '2026-10-30T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51610',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '2136bfc7-0b22-4101-ad29-aa1863acbfee',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261030-tarbes-424',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : Tarbes (Tarbes). Début prévu le 30/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234341, 0.072931, NULL,
  '2026-10-30T13:00:00Z'::timestamptz,
  '2026-10-30T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51779',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '96d09204-71f5-46f8-8bc6-ac931a041be6',
  'ds-visite-commentee-du-musee-de-prehistoire-20261030-aurignac-425',
  'Visite commentée du Musée de Préhistoire',
  'Événement annoncé : Visite commentée du Musée de Préhistoire. Lieu indiqué : Aurignac (Aurignac). Début prévu le 30/10/2026 à 14:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-30T13:30:00Z'::timestamptz,
  '2026-10-30T16:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52256',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '949edede-84b3-4ebd-bfcb-37598573ee22',
  'ds-halloween-avec-l-ape-d-aurignac-20261030-aurignac-426',
  'HALLOWEEN avec l''APE d''Aurignac !',
  'Événement annoncé : HALLOWEEN avec l''APE d''Aurignac !. Lieu indiqué : Aurignac (Aurignac). Début prévu le 30/10/2026 à 15:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-30T14:30:00Z'::timestamptz,
  '2026-10-30T17:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52084',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '779dfa7b-38de-421c-ac5c-02fb0011d2c6',
  'ds-atelier-informatique-ateliers-du-temps-libre-evs-20261030-aspet-427',
  'Atelier informatique | Ateliers du temps libre (EVS)',
  'Événement annoncé : Atelier informatique | Ateliers du temps libre (EVS). Lieu indiqué : Aspet (Aspet). Début prévu le 30/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aspet',
  NULL,
  'FR', 'Europe/Paris',
  'Aspet',
  43.014041, 0.804105, NULL,
  '2026-10-30T15:00:00Z'::timestamptz,
  '2026-10-30T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/50574',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6ed34545-35f5-4aa9-b3f4-f0199aa0a23a',
  'ds-atelier-art-sur-pierre-20261030-aurignac-428',
  'Atelier Art sur pierre',
  'Événement annoncé : Atelier Art sur pierre. Lieu indiqué : Aurignac (Aurignac). Début prévu le 30/10/2026 à 16:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-30T15:00:00Z'::timestamptz,
  '2026-10-30T18:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52337',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c0604de3-29e7-4ebe-b9e1-1848972e1ca1',
  'ds-chasse-aux-fantomes-au-musee-20261030-st-bertrand-de-comminges-429',
  'Chasse aux fantômes au musée !',
  'Événement annoncé : Chasse aux fantômes au musée !. Lieu indiqué : St-Bertrand-de-Comminges (St-Bertrand-de-Comminges). Début prévu le 30/10/2026 à 16:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Bertrand-de-Comminges',
  NULL,
  'FR', 'Europe/Paris',
  'St-Bertrand-de-Comminges',
  43.027018, 0.569858, NULL,
  '2026-10-30T15:30:00Z'::timestamptz,
  '2026-10-30T18:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52182',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a80fd8ef-672f-487b-a1b4-a77dcc9c0009',
  'ds-cafe-deuil-destines-aux-parents-endeuilles-20261030-tarbes-430',
  'Café deuil destinés aux parents endeuillés',
  'Événement annoncé : Café deuil destinés aux parents endeuillés. Lieu indiqué : Tarbes (Tarbes). Début prévu le 30/10/2026 à 17:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.232865, 0.077214, NULL,
  '2026-10-30T16:00:00Z'::timestamptz,
  '2026-10-30T19:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52578',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd2dad39e-dac1-4ea9-bb09-d00f15af8eb0',
  'ds-cours-d-echecs-initiation-et-debutants-20261030-loures-barousse-431',
  'Cours d''échecs : Initiation et débutants',
  'Événement annoncé : Cours d''échecs : Initiation et débutants. Lieu indiqué : Loures-Barousse (Loures-Barousse). Début prévu le 30/10/2026 à 17:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Loures-Barousse',
  NULL,
  'FR', 'Europe/Paris',
  'Loures-Barousse',
  43.025201, 0.605441, NULL,
  '2026-10-30T16:30:00Z'::timestamptz,
  '2026-10-30T19:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51784',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bb57fe16-42d4-48a1-bcb2-2b15064c34fc',
  'ds-ouverture-du-cafe-solidaire-de-l31-centre-social-autogere-20261030-tarbes-432',
  'Ouverture du café solidaire de L31, Centre Social Autogéré',
  'Événement annoncé : Ouverture du café solidaire de L31, Centre Social Autogéré. Lieu indiqué : Tarbes (Tarbes). Début prévu le 30/10/2026 à 18:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234773, 0.070877, NULL,
  '2026-10-30T17:00:00Z'::timestamptz,
  '2026-10-30T20:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51921',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '41314cea-7928-45be-a528-dfb72d998e52',
  'ds-le-court-circuit-epicerie-citoyenne-produits-locaux-zero-marge-20261030-mazeres-sur-salat-433',
  'Le Court-Circuit : épicerie citoyenne - produits locaux - zéro marge',
  'Événement annoncé : Le Court-Circuit : épicerie citoyenne - produits locaux - zéro marge. Lieu indiqué : Mazères-sur-Salat (Mazères-sur-Salat). Début prévu le 30/10/2026 à 18:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Mazères-sur-Salat',
  NULL,
  'FR', 'Europe/Paris',
  'Mazères-sur-Salat',
  43.133585, 0.974951, NULL,
  '2026-10-30T17:30:00Z'::timestamptz,
  '2026-10-30T20:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51785',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'dfc0a46a-4ba5-4ab9-87d3-2427297601f6',
  'ds-soiree-crepes-a-la-maison-de-la-terre-20261030-poucharramet-434',
  'Soirée crêpes à la Maison de la terre !!',
  'Événement annoncé : Soirée crêpes à la Maison de la terre !!. Lieu indiqué : Poucharramet (Poucharramet). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Poucharramet',
  NULL,
  'FR', 'Europe/Paris',
  'Poucharramet',
  43.41721, 1.173718, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51328',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f5b06c82-3921-498b-8b10-fae06aab8d00',
  'ds-cinema-halloween-culte-20261030-st-gaudens-435',
  'Cinéma - Halloween culte !',
  'Événement annoncé : Cinéma - Halloween culte !. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 30/10/2026 à 19:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108465, 0.718753, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52639',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '36c557d7-3780-44f9-8774-0fd41e8b1cbb',
  'ds-atelier-danse-libre-20261030-rieux-volvestre-436',
  'Atelier danse libre !',
  'Événement annoncé : Atelier danse libre !. Lieu indiqué : Rieux-Volvestre (Rieux-Volvestre). Début prévu le 30/10/2026 à 19:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Rieux-Volvestre',
  NULL,
  'FR', 'Europe/Paris',
  'Rieux-Volvestre',
  43.257921, 1.203212, NULL,
  '2026-10-30T18:30:00Z'::timestamptz,
  '2026-10-30T21:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51786',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '96236d5e-93f9-46fa-84a7-010c186529cc',
  'ds-soiree-jeux-mensuelle-avec-plein-de-nouveautes-ludiques-sur-le-theme-n-20261030-cazeres-437',
  'Soirée jeux mensuelle avec plein de nouveautés ludiques sur le thème "nature"',
  'Événement annoncé : Soirée jeux mensuelle avec plein de nouveautés ludiques sur le thème "nature". Lieu indiqué : Cazères (Cazères). Début prévu le 30/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Cazères',
  NULL,
  'FR', 'Europe/Paris',
  'Cazères',
  43.203557, 1.083365, NULL,
  '2026-10-30T19:00:00Z'::timestamptz,
  '2026-10-30T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/50772',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '28495832-41b6-4bb7-9a8e-577607e94b12',
  'ds-soiree-concert-avec-jake-braunecker-nouvelle-biere-20261030-st-laurent-de-neste-438',
  'Soirée concert avec Jake Braunecker // nouvelle bière',
  'Événement annoncé : Soirée concert avec Jake Braunecker // nouvelle bière. Lieu indiqué : St-Laurent-de-Neste (St-Laurent-de-Neste). Début prévu le 30/10/2026 à 20:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'St-Laurent-de-Neste',
  NULL,
  'FR', 'Europe/Paris',
  'St-Laurent-de-Neste',
  43.102179, 0.467721, NULL,
  '2026-10-30T19:00:00Z'::timestamptz,
  '2026-10-30T22:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52166',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '60e33bc2-d256-44ff-bd38-efbbc8ba8864',
  'ds-conference-le-renouveau-du-brandon-le-feu-du-solstice-d-ete-20261030-bordes-de-riviere-439',
  'Conférence : Le renouveau du brandon, Le feu du solstice d''été',
  'Événement annoncé : Conférence : Le renouveau du brandon, Le feu du solstice d''été. Lieu indiqué : Bordes-de-Rivière (Bordes-de-Rivière). Début prévu le 30/10/2026 à 20:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Bordes-de-Rivière',
  NULL,
  'FR', 'Europe/Paris',
  'Bordes-de-Rivière',
  43.105698, 0.635614, NULL,
  '2026-10-30T19:30:00Z'::timestamptz,
  '2026-10-30T22:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52365',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '142703ca-e854-49cc-9813-a2501ff32cad',
  'ds-concert-au-pot-aux-roses-cup-of-tea-pop-folk-20261030-encausse-les-thermes-440',
  'Concert au Pot aux Roses - Cup of tea (pop/folk)',
  'Événement annoncé : Concert au Pot aux Roses - Cup of tea (pop/folk). Lieu indiqué : Encausse-les-Thermes (Encausse-les-Thermes). Début prévu le 30/10/2026 à 21:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Encausse-les-Thermes',
  NULL,
  'FR', 'Europe/Paris',
  'Encausse-les-Thermes',
  43.050018, 0.742517, NULL,
  '2026-10-30T20:00:00Z'::timestamptz,
  '2026-10-30T23:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52435',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '27430624-5050-4790-9aa7-95450b6305cd',
  'ds-fle-aide-aux-devoirs-pour-collegiens-et-lyceens-avec-alter-ego-20261031-aurignac-441',
  'FLE Aide aux devoirs pour collégiens et lycéens avec Alter''Ego',
  'Événement annoncé : FLE Aide aux devoirs pour collégiens et lycéens avec Alter''Ego. Lieu indiqué : Aurignac (Aurignac). Début prévu le 31/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'education',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.216883, 0.88242, NULL,
  '2026-10-31T08:00:00Z'::timestamptz,
  '2026-10-31T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51789',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '28194f87-3efa-4932-b212-174d819044a2',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261031-st-gaudens-442',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : St-Gaudens (St-Gaudens). Début prévu le 31/10/2026 à 09:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'St-Gaudens',
  NULL,
  'FR', 'Europe/Paris',
  'St-Gaudens',
  43.108094, 0.722677, NULL,
  '2026-10-31T08:00:00Z'::timestamptz,
  '2026-10-31T11:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51790',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6635afb3-1fbb-4560-8b2e-baba6d2d9e5f',
  'ds-4-pattes-galipettes-parcours-de-motricite-20261031-ganties-443',
  '4 pattes & galipettes (parcours de motricité)',
  'Événement annoncé : 4 pattes & galipettes (parcours de motricité). Lieu indiqué : Ganties (Ganties). Début prévu le 31/10/2026 à 09:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Ganties',
  NULL,
  'FR', 'Europe/Paris',
  'Ganties',
  43.064343, 0.83109, NULL,
  '2026-10-31T08:30:00Z'::timestamptz,
  '2026-10-31T11:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52579',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '39052291-88d9-4e5c-a6df-95d00d304bdd',
  'ds-exposition-pouma-linogravures-contees-20261031-poucharramet-444',
  'Exposition - Pouma - linogravures contées',
  'Événement annoncé : Exposition - Pouma - linogravures contées. Lieu indiqué : Poucharramet (Poucharramet). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Poucharramet',
  NULL,
  'FR', 'Europe/Paris',
  'Poucharramet',
  43.41721, 1.173718, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/51305',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '3a2d78fa-81a7-4202-9f71-f1329a183d88',
  'ds-halloween-au-musee-20261031-aurignac-445',
  'Halloween au Musée',
  'Événement annoncé : Halloween au Musée. Lieu indiqué : Aurignac (Aurignac). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52322',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ea6629b6-e619-4567-98cd-b0def3142a1c',
  'ds-accept-maison-de-la-diversite-centre-lgbt-hebergement-d-urgence-accuei-20261031-tarbes-446',
  'ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour',
  'Événement annoncé : ACCEPT Maison de la Diversité-Centre LGBT+ / Hébergement d''urgence-Accueil de jour. Lieu indiqué : Tarbes (Tarbes). Début prévu le 31/10/2026 à 10:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'droits',
  'Tarbes',
  NULL,
  'FR', 'Europe/Paris',
  'Tarbes',
  43.234341, 0.072931, NULL,
  '2026-10-31T09:00:00Z'::timestamptz,
  '2026-10-31T12:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52604',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0a3665be-2be8-4fdc-b1ab-d3ce23114ca8',
  'ds-echange-de-plantes-et-de-graines-avec-passe-graines-20261031-martres-tolosane-447',
  '🍀 Échange de plantes 🌿 et de graines 🌱 avec Passe-Graines',
  'Événement annoncé : 🍀 Échange de plantes 🌿 et de graines 🌱 avec Passe-Graines. Lieu indiqué : Martres-Tolosane (Martres-Tolosane). Début prévu le 31/10/2026 à 10:30 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Martres-Tolosane',
  NULL,
  'FR', 'Europe/Paris',
  'Martres-Tolosane',
  43.197105, 1.000395, NULL,
  '2026-10-31T09:30:00Z'::timestamptz,
  '2026-10-31T12:30:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52574',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd2a73652-9f1f-4de7-a8d8-26715c54df51',
  'ds-atelier-fabrication-d-une-bourse-en-cuir-20261031-aurignac-448',
  'Atelier Fabrication d''une bourse en cuir',
  'Événement annoncé : Atelier Fabrication d''une bourse en cuir. Lieu indiqué : Aurignac (Aurignac). Début prévu le 31/10/2026 à 11:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'autre',
  'Aurignac',
  NULL,
  'FR', 'Europe/Paris',
  'Aurignac',
  43.215456, 0.878662, NULL,
  '2026-10-31T10:00:00Z'::timestamptz,
  '2026-10-31T13:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52327',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'da90e6a6-c8ae-4f61-a9f0-c8c89852f6c8',
  'ds-festival-du-film-paysan-20261031-campan-449',
  'Festival du film paysan',
  'Événement annoncé : Festival du film paysan. Lieu indiqué : Campan (65) (Campan). Début prévu le 31/10/2026 à 14:00 (heure de Paris). Source Démosphère — vérifier les détails sur la page d’origine.',
  'agriculture',
  'Campan',
  NULL,
  'FR', 'Europe/Paris',
  'Campan (65)',
  43.017149, 0.177098, NULL,
  '2026-10-31T13:00:00Z'::timestamptz,
  '2026-10-31T16:00:00Z'::timestamptz,
  TRUE, NULL,
  'https://pyrenees.demosphere.net/rv/52431',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

SELECT count(*) AS ds_events, count(*) FILTER (WHERE latitude IS NOT NULL) AS with_coords FROM events WHERE slug LIKE 'ds-%';