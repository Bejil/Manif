-- Cohérence RLS : les tables d’import étaient sans RLS alors que events/submissions
-- l’avaient. Accès uniquement via service_role (bypass), comme le reste du schéma.

ALTER TABLE IF EXISTS import_runs ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS import_candidates ENABLE ROW LEVEL SECURITY;

-- Pas de politiques publiques : Nitro doit utiliser la clé service_role.
