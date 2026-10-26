-- Demandes d'effacement / journal minimal (sans exposer de profils)
CREATE TABLE IF NOT EXISTS erasure_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  -- Empreinte du jeton uniquement (pas le jeton en clair)
  event_scoped_token_digest TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('processed', 'not_found')) DEFAULT 'processed',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_erasure_event ON erasure_requests (event_id, created_at DESC);

ALTER TABLE erasure_requests ENABLE ROW LEVEL SECURITY;

-- Index recherche titre (activer pg_trgm si disponible)
DO $$
BEGIN
  CREATE EXTENSION IF NOT EXISTS pg_trgm;
  CREATE INDEX IF NOT EXISTS idx_events_title_trgm ON events USING gin (title gin_trgm_ops);
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'pg_trgm non disponible — index trigram ignoré';
END $$;
