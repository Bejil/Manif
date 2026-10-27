-- Imports multi-sources (AMI, Démosphère, manifs.fr, ManifRadar, Mobilizon)

CREATE TABLE IF NOT EXISTS import_runs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  status TEXT NOT NULL
    CHECK (status IN (
      'pending', 'running', 'scraped', 'applying', 'completed', 'failed', 'cancelled'
    ))
    DEFAULT 'pending',
  mode TEXT NOT NULL
    CHECK (mode IN ('draft', 'published'))
    DEFAULT 'published',
  sources TEXT[] NOT NULL DEFAULT '{}',
  options JSONB NOT NULL DEFAULT '{}'::jsonb,
  progress JSONB NOT NULL DEFAULT '{}'::jsonb,
  stats JSONB NOT NULL DEFAULT '{}'::jsonb,
  error_message TEXT,
  actor_id TEXT,
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_import_runs_created ON import_runs (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_import_runs_status ON import_runs (status);

CREATE TABLE IF NOT EXISTS import_candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  run_id UUID NOT NULL REFERENCES import_runs(id) ON DELETE CASCADE,
  source TEXT NOT NULL,
  source_url TEXT NOT NULL,
  external_id TEXT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  city_name TEXT NOT NULL,
  postal_code TEXT,
  location_name TEXT NOT NULL,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  start_at TIMESTAMPTZ,
  end_at TIMESTAMPTZ,
  end_is_estimated BOOLEAN NOT NULL DEFAULT TRUE,
  organizer_name TEXT,
  timezone TEXT NOT NULL DEFAULT 'Europe/Paris',
  payload JSONB NOT NULL DEFAULT '{}'::jsonb,
  status TEXT NOT NULL
    CHECK (status IN (
      'pending', 'duplicate', 'ready', 'applied', 'skipped', 'error'
    ))
    DEFAULT 'pending',
  match_event_id UUID REFERENCES events(id) ON DELETE SET NULL,
  applied_event_id UUID REFERENCES events(id) ON DELETE SET NULL,
  error_message TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT import_candidates_run_source_url UNIQUE (run_id, source_url)
);

CREATE INDEX IF NOT EXISTS idx_import_candidates_run ON import_candidates (run_id);
CREATE INDEX IF NOT EXISTS idx_import_candidates_status ON import_candidates (run_id, status);
CREATE INDEX IF NOT EXISTS idx_import_candidates_source_url ON import_candidates (source_url);

-- Dédoublonnage global pratique
CREATE INDEX IF NOT EXISTS idx_events_source_url ON events (source_url)
  WHERE source_url IS NOT NULL;
