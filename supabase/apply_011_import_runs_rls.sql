-- À exécuter dans le SQL Editor Supabase si la migration CLI n’est pas utilisée.
ALTER TABLE IF EXISTS import_runs ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS import_candidates ENABLE ROW LEVEL SECURITY;
