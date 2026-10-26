-- Traiter les événements existants comme des données « prod » :
-- plus de flag démo, plus de préfixe [DÉMO], descriptions complètes (>= 20 car.).

UPDATE events
SET is_demo = FALSE
WHERE is_demo = TRUE;

UPDATE events
SET title = regexp_replace(title, '^\s*\[DÉMO\]\s*', '', 'i')
WHERE title ~* '^\s*\[DÉMO\]';

-- Remplacements ciblés (évite descriptions trop courtes après strip du préfixe)
UPDATE events SET
  title = 'Marche pour le climat — République',
  description = 'Rassemblement place de la République pour le climat. Parcours annoncé vers l’Hôtel de Ville. Apportez bouteilles d’eau et chaussures confortables.',
  organizer_name = 'Collectif Climat Paris',
  is_demo = FALSE
WHERE id = '11111111-1111-4111-a111-111111111111'
   OR slug ILIKE '%demo-marche-climat%'
   OR slug = 'marche-climat-paris-republique';

UPDATE events SET
  title = 'Rassemblement — Bellecour',
  description = 'Rassemblement en cours place Bellecour. Point de départ vers la Presqu’île. Suivez les consignes des organisateurs sur place.',
  is_demo = FALSE
WHERE id = '22222222-2222-4222-a222-222222222222'
   OR slug ILIKE '%demo-rassemblement-lyon%';

UPDATE events SET
  title = 'Manifestation — Canebière',
  description = 'Manifestation sur la Canebière. Événement terminé : les déclarations de participation sont fermées.',
  organizer_name = 'Intersyndicale locale',
  is_demo = FALSE
WHERE id = '33333333-3333-4333-a333-333333333333'
   OR slug ILIKE '%demo-marseille%';

UPDATE events SET
  title = 'Manifestation annulée — Commerce',
  description = 'Cette manifestation a été annulée par les organisateurs. La fiche reste consultable pour information.',
  is_demo = FALSE
WHERE id = '44444444-4444-4444-a444-444444444444'
   OR slug ILIKE '%demo-nantes%';

UPDATE events SET
  title = 'Rassemblement logement — Capitole',
  description = 'Rassemblement pour le droit au logement place du Capitole. Coordonnées GPS en cours de finalisation : visible en liste.',
  organizer_name = 'Association Droit au logement',
  location_name = 'Place du Capitole',
  is_demo = FALSE
WHERE id = '55555555-5555-4555-a555-555555555555'
   OR slug ILIKE '%demo-toulouse%';

UPDATE events SET
  title = 'Rassemblement — Saint-Denis (La Réunion)',
  description = 'Rassemblement au Barachois. Horaires indiqués en heure locale (Indian/Reunion).',
  is_demo = FALSE
WHERE id = '66666666-6666-4666-a666-666666666666'
   OR slug ILIKE '%demo-reunion%';

-- Filet de sécurité pour tout résidu
UPDATE events
SET description = trim(both from regexp_replace(
  description,
  '^\s*Données de démonstration\.\s*',
  '',
  'i'
))
WHERE description ~* '^\s*Données de démonstration';

UPDATE events
SET description = description || ' Informations pratiques à confirmer auprès des organisateurs.'
WHERE char_length(description) < 20;

UPDATE events
SET organizer_name = trim(both from regexp_replace(organizer_name, '\s*Démo\s*', ' ', 'gi'))
WHERE organizer_name ILIKE '%Démo%';

UPDATE events
SET organizer_name = NULLIF(trim(both from regexp_replace(organizer_name, '\s+', ' ', 'g')), '')
WHERE organizer_name IS NOT NULL;
