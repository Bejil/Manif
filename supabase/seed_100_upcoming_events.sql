-- =============================================================================
-- Manif' — injecter 100 événements à venir partout en France
-- À coller dans le SQL Editor Supabase
--
-- Principe : ~15 campagnes × plusieurs villes → le même titre/revendication
-- peut se dérouler au même moment (ou décalé) dans des lieux différents.
-- Ne TRUNCATE pas les données existantes.
-- =============================================================================

WITH templates AS (
  SELECT *
  FROM (
    VALUES
      (
        1,
        'Marche nationale pour le climat',
        'climat',
        'Appel national à marcher pour le climat et la justice environnementale. Rendez-vous au lieu indiqué, départ du cortège annoncé sur place. Apportez de l’eau et des chaussures confortables. Informations données à titre indicatif — vérifiez auprès des organisateurs locaux.',
        'Collectif Climat France',
        'https://example.org/campagne/marche-climat'
      ),
      (
        2,
        'Rassemblement pour les salaires et les retraites',
        'travail',
        'Rassemblement intersyndical pour les salaires, l’emploi et les retraites. Point de départ au lieu indiqué sur la fiche. Respectez les consignes de sécurité et le caractère pacifique du cortège.',
        'Intersyndicale locale',
        'https://example.org/campagne/salaires-retraites'
      ),
      (
        3,
        'Manifestation pour le droit au logement',
        'logement',
        'Mobilisation pour le droit au logement digne, contre les expulsions et pour des loyers abordables. Rassemblement pacifique au point de rendez-vous indiqué. Source et parcours à confirmer localement.',
        'Droit au logement',
        'https://example.org/campagne/logement'
      ),
      (
        4,
        'Marche des solidarités',
        'social',
        'Marche citoyenne pour la solidarité, l’accès aux droits et la dignité. Cortège familial bienvenu. Suivez les consignes des organisateurs et prévoyez de l’eau.',
        'Collectifs Solidaires',
        'https://example.org/campagne/solidarites'
      ),
      (
        5,
        'Rassemblement pour l’école publique',
        'education',
        'Rassemblement pour défendre l’école publique, les moyens humains et les conditions d’apprentissage. Point de départ au lieu indiqué. Manifestation pacifique.',
        'Parents & personnels éducatifs',
        'https://example.org/campagne/ecole-publique'
      ),
      (
        6,
        'Mobilisation pour l’hôpital et les soignants',
        'sante',
        'Appel à se rassembler pour l’accès aux soins, l’hôpital public et les conditions de travail des soignants. Rendez-vous sur le lieu indiqué. Vérifiez les horaires locaux.',
        'Collectif Santé publique',
        'https://example.org/campagne/sante'
      ),
      (
        7,
        'Manifestation pour les libertés et l’État de droit',
        'droits',
        'Rassemblement pacifique pour les libertés fondamentales et l’État de droit. Lieu de rendez-vous indiqué sur la fiche. Respectez les personnes et les consignes de sécurité.',
        'Collectif Libertés',
        'https://example.org/campagne/libertes'
      ),
      (
        8,
        'Rassemblement agriculture et ruralité',
        'agriculture',
        'Rassemblement pour une agriculture durable, le revenu des producteurs et les territoires ruraux. Point de départ local. Informations pratiques à confirmer sur place.',
        'Collectifs agricoles',
        'https://example.org/campagne/agriculture'
      ),
      (
        9,
        'Marche pour la paix et la solidarité internationale',
        'international',
        'Marche pour la paix, le cessez-le-feu et la solidarité internationale. Cortège pacifique au départ du lieu indiqué. Consultez la source pour le parcours exact.',
        'Collectif Paix',
        'https://example.org/campagne/paix'
      ),
      (
        10,
        'Rassemblement citoyen — agenda local',
        'autre',
        'Rassemblement citoyen d’intérêt général. Les détails du parcours et des prises de parole seront précisés par les organisateurs locaux. Préparez-vous comme pour toute manifestation pacifique.',
        'Comité local',
        'https://example.org/campagne/citoyen'
      ),
      (
        11,
        'Grève et manifestation pour les services publics',
        'travail',
        'Journée de grève et de manifestation pour défendre les services publics. Départ du cortège au lieu indiqué. Restez attentifs aux mises à jour des organisations locales.',
        'Organisations syndicales',
        'https://example.org/campagne/services-publics'
      ),
      (
        12,
        'Marche féministe et pour l’égalité',
        'droits',
        'Marche pour l’égalité, contre les violences et pour les droits des femmes. Rendez-vous au point indiqué. Cortège pacifique et respectueux.',
        'Collectifs féministes',
        'https://example.org/campagne/egalite'
      ),
      (
        13,
        'Rassemblement climat et biodiversité',
        'climat',
        'Rassemblement pour le climat, la biodiversité et la fin des projets climato-destructeurs. Point de départ local. Apportez de l’eau et respectez les consignes.',
        'Alternatiba / collectifs locaux',
        'https://example.org/campagne/biodiversite'
      ),
      (
        14,
        'Mobilisation étudiants et lycéens',
        'education',
        'Mobilisation lycéenne et étudiante pour les conditions d’études et l’avenir. Rassemblement au lieu indiqué. Vérifiez les consignes des organisations de jeunesse locales.',
        'Organisations de jeunesse',
        'https://example.org/campagne/jeunesse'
      ),
      (
        15,
        'Rassemblement anti-raciste et pour l’accueil',
        'droits',
        'Rassemblement anti-raciste pour l’accueil digne et l’égalité des droits. Point de rendez-vous indiqué sur la fiche. Manifestation pacifique.',
        'Collectifs anti-racistes',
        'https://example.org/campagne/antiracisme'
      )
  ) AS t(template_id, title, category, description, organizer_name, source_url)
),
cities AS (
  SELECT *
  FROM (
    VALUES
      (1,  'Paris',            '75011', 'Place de la République',     48.8676,  2.3631, 'Europe/Paris'),
      (2,  'Paris',            '75004', 'Place de la Bastille',       48.8532,  2.3691, 'Europe/Paris'),
      (3,  'Lyon',             '69002', 'Place Bellecour',            45.7578,  4.8320, 'Europe/Paris'),
      (4,  'Marseille',        '13001', 'La Canebière',               43.2965,  5.3800, 'Europe/Paris'),
      (5,  'Toulouse',         '31000', 'Place du Capitole',          43.6045,  1.4440, 'Europe/Paris'),
      (6,  'Nice',             '06000', 'Place Masséna',              43.6970,  7.2700, 'Europe/Paris'),
      (7,  'Nantes',           '44000', 'Place du Commerce',          47.2133, -1.5555, 'Europe/Paris'),
      (8,  'Montpellier',      '34000', 'Place de la Comédie',        43.6085,  3.8795, 'Europe/Paris'),
      (9,  'Strasbourg',       '67000', 'Place Kléber',               48.5839,  7.7455, 'Europe/Paris'),
      (10, 'Bordeaux',         '33000', 'Place de la Bourse',         44.8412, -0.5695, 'Europe/Paris'),
      (11, 'Lille',            '59000', 'Grand Place',                50.6370,  3.0635, 'Europe/Paris'),
      (12, 'Rennes',           '35000', 'Place de la Mairie',         48.1113, -1.6800, 'Europe/Paris'),
      (13, 'Reims',            '51100', 'Place Drouet-d’Erlon',       49.2550,  4.0317, 'Europe/Paris'),
      (14, 'Le Havre',         '76600', 'Hôtel de Ville',             49.4944,  0.1079, 'Europe/Paris'),
      (15, 'Saint-Étienne',    '42000', 'Place Jean-Jaurès',          45.4397,  4.3872, 'Europe/Paris'),
      (16, 'Toulon',           '83000', 'Place de la Liberté',        43.1242,  5.9280, 'Europe/Paris'),
      (17, 'Grenoble',         '38000', 'Place Victor-Hugo',          45.1890,  5.7245, 'Europe/Paris'),
      (18, 'Dijon',            '21000', 'Place de la Libération',     47.3216,  5.0415, 'Europe/Paris'),
      (19, 'Angers',           '49000', 'Place du Ralliement',        47.4712, -0.5516, 'Europe/Paris'),
      (20, 'Nîmes',            '30000', 'Esplanade Charles-de-Gaulle',43.8345,  4.3601, 'Europe/Paris'),
      (21, 'Villeurbanne',     '69100', 'Place Grandclément',         45.7660,  4.8798, 'Europe/Paris'),
      (22, 'Clermont-Ferrand', '63000', 'Place de Jaude',             45.7772,  3.0870, 'Europe/Paris'),
      (23, 'Le Mans',          '72000', 'Place de la République',     48.0077,  0.1984, 'Europe/Paris'),
      (24, 'Aix-en-Provence',  '13100', 'Cours Mirabeau',             43.5263,  5.4454, 'Europe/Paris'),
      (25, 'Brest',            '29200', 'Place de la Liberté',        48.3904, -4.4861, 'Europe/Paris'),
      (26, 'Tours',            '37000', 'Place Jean-Jaurès',          47.3897,  0.6892, 'Europe/Paris'),
      (27, 'Amiens',           '80000', 'Place Gambetta',             49.8941,  2.2957, 'Europe/Paris'),
      (28, 'Limoges',          '87000', 'Place de la République',     45.8336,  1.2611, 'Europe/Paris'),
      (29, 'Perpignan',        '66000', 'Place de la République',     42.6986,  2.8956, 'Europe/Paris'),
      (30, 'Metz',             '57000', 'Place de la République',     49.1193,  6.1757, 'Europe/Paris'),
      (31, 'Besançon',         '25000', 'Esplanade des Droits de l’Homme', 47.2380, 6.0243, 'Europe/Paris'),
      (32, 'Orléans',          '45000', 'Place du Martroi',           47.9022,  1.9040, 'Europe/Paris'),
      (33, 'Rouen',            '76000', 'Place du Vieux-Marché',      49.4431,  1.0993, 'Europe/Paris'),
      (34, 'Mulhouse',         '68100', 'Place de la Réunion',        47.7508,  7.3359, 'Europe/Paris'),
      (35, 'Caen',             '14000', 'Place Saint-Sauveur',        49.1829, -0.3707, 'Europe/Paris'),
      (36, 'Nancy',            '54000', 'Place Stanislas',            48.6936,  6.1833, 'Europe/Paris'),
      (37, 'Argenteuil',       '95100', 'Place du 11-Novembre',       48.9472,  2.2467, 'Europe/Paris'),
      (38, 'Saint-Denis',      '93200', 'Basilique',                  48.9356,  2.3590, 'Europe/Paris'),
      (39, 'Roubaix',          '59100', 'Grand Place',                50.6927,  3.1746, 'Europe/Paris'),
      (40, 'Tourcoing',        '59200', 'Grand Place',                50.7239,  3.1612, 'Europe/Paris'),
      (41, 'Avignon',          '84000', 'Place de l’Horloge',         43.9493,  4.8055, 'Europe/Paris'),
      (42, 'Poitiers',         '86000', 'Place du Maréchal-Leclerc',  46.5802,  0.3404, 'Europe/Paris'),
      (43, 'La Rochelle',      '17000', 'Place de Verdun',            46.1591, -1.1520, 'Europe/Paris'),
      (44, 'Pau',              '64000', 'Place Royale',               43.2951, -0.3708, 'Europe/Paris'),
      (45, 'Bayonne',          '64100', 'Place de la Liberté',        43.4929, -1.4748, 'Europe/Paris'),
      (46, 'Annecy',           '74000', 'Espace rencontre François-Mitterrand', 45.8992, 6.1294, 'Europe/Paris'),
      (47, 'Chambéry',         '73000', 'Place Saint-Léger',          45.5646,  5.9178, 'Europe/Paris'),
      (48, 'Saint-Denis',      '97400', 'Le Barachois',               -20.8789, 55.4481, 'Indian/Reunion'),
      (49, 'Fort-de-France',   '97200', 'La Savane',                  14.6037, -61.0732, 'America/Martinique'),
      (50, 'Pointe-à-Pitre',   '97110', 'Place de la Victoire',       16.2410, -61.5330, 'America/Guadeloupe')
  ) AS c(city_id, city_name, postal_code, location_name, latitude, longitude, timezone)
),
-- Chaque campagne est déployée sur plusieurs villes (même événement, lieux différents)
deployments AS (
  SELECT
    t.template_id,
    t.title,
    t.category,
    t.description,
    t.organizer_name,
    t.source_url,
    c.city_id,
    c.city_name,
    c.postal_code,
    c.location_name,
    c.latitude,
    c.longitude,
    c.timezone,
    -- Décalage léger par ville pour éviter 100 créneaux identiques à la seconde près
    ( ((t.template_id - 1) * 3 + c.city_id) % 45 ) + 2 AS days_ahead,
    CASE
      WHEN (t.template_id + c.city_id) % 4 = 0 THEN 11
      WHEN (t.template_id + c.city_id) % 4 = 1 THEN 14
      WHEN (t.template_id + c.city_id) % 4 = 2 THEN 15
      ELSE 18
    END AS hour_local,
    row_number() OVER (
      ORDER BY t.template_id, c.city_id
    ) AS rn
  FROM templates t
  INNER JOIN cities c
    ON (c.city_id % 15) = (t.template_id % 15)
       OR (c.city_id % 7) = (t.template_id % 7)
),
picked AS (
  SELECT *
  FROM deployments
  ORDER BY rn
  LIMIT 100
)
INSERT INTO events (
  slug,
  title,
  description,
  category,
  city_name,
  postal_code,
  country_code,
  timezone,
  location_name,
  latitude,
  longitude,
  location_reveal_at,
  start_at,
  end_at,
  end_is_estimated,
  organizer_name,
  source_url,
  source_verification_status,
  publication_status,
  event_status_override,
  is_demo,
  published_at,
  created_at,
  updated_at
)
SELECT
  -- Slug unique et stable (sans extension unaccent)
  'seed-' || template_id::text || '-' || city_id::text || '-' || rn::text,
  title,
  description || format(
    E'\n\nÉdition locale : %s — %s.',
    city_name,
    location_name
  ),
  category,
  city_name,
  postal_code,
  'FR',
  timezone,
  location_name,
  latitude,
  longitude,
  NULL,
  -- Début en timezone locale, stocké en timestamptz (UTC)
  (
    (date_trunc('day', timezone(timezone, now())) + (days_ahead || ' days')::interval)
    + (hour_local || ' hours')::interval
  ) AT TIME ZONE timezone,
  (
    (date_trunc('day', timezone(timezone, now())) + (days_ahead || ' days')::interval)
    + (hour_local || ' hours')::interval
    + interval '3 hours'
  ) AT TIME ZONE timezone,
  false,
  organizer_name,
  source_url,
  'source_provided',
  'published',
  NULL,
  false,
  now(),
  now(),
  now()
FROM picked;

-- Contrôle rapide
SELECT
  count(*) AS inserted_approx_check,
  count(DISTINCT title) AS campagnes_distinctes,
  count(DISTINCT city_name) AS villes_distinctes
FROM events
WHERE source_url LIKE 'https://example.org/campagne/%'
  AND published_at >= now() - interval '1 minute';
