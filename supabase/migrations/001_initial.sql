-- Manif' — schéma initial PostgreSQL
-- Exécuter via Supabase SQL editor ou CLI supabase db push

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ---------------------------------------------------------------------------
-- events
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL CHECK (char_length(title) BETWEEN 5 AND 160),
  description TEXT NOT NULL CHECK (char_length(description) BETWEEN 20 AND 5000),
  category TEXT NOT NULL,
  city_name TEXT NOT NULL,
  postal_code TEXT,
  locality_code TEXT,
  country_code TEXT NOT NULL DEFAULT 'FR',
  timezone TEXT NOT NULL,
  location_name TEXT NOT NULL,
  latitude DOUBLE PRECISION CHECK (latitude IS NULL OR (latitude BETWEEN -90 AND 90)),
  longitude DOUBLE PRECISION CHECK (longitude IS NULL OR (longitude BETWEEN -180 AND 180)),
  start_at TIMESTAMPTZ NOT NULL,
  end_at TIMESTAMPTZ,
  end_is_estimated BOOLEAN NOT NULL DEFAULT TRUE,
  organizer_name TEXT,
  source_url TEXT,
  source_verification_status TEXT NOT NULL
    CHECK (source_verification_status IN ('cross_checked', 'source_provided', 'unconfirmed')),
  publication_status TEXT NOT NULL
    CHECK (publication_status IN ('draft', 'published', 'unpublished'))
    DEFAULT 'draft',
  event_status_override TEXT
    CHECK (event_status_override IS NULL OR event_status_override IN ('cancelled', 'postponed')),
  is_demo BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  published_at TIMESTAMPTZ,
  CONSTRAINT events_end_after_start CHECK (end_at IS NULL OR end_at > start_at),
  CONSTRAINT events_coords_pair CHECK (
    (latitude IS NULL AND longitude IS NULL)
    OR (latitude IS NOT NULL AND longitude IS NOT NULL)
  )
);

CREATE INDEX idx_events_publication_start ON events (publication_status, start_at);
CREATE INDEX idx_events_category ON events (category);
CREATE INDEX idx_events_city ON events (city_name);
CREATE INDEX idx_events_published_at ON events (published_at DESC NULLS LAST);

-- Recherche textuelle : activer pg_trgm puis décommenter l'index ci-dessous
-- CREATE EXTENSION IF NOT EXISTS pg_trgm;
-- CREATE INDEX idx_events_title_trgm ON events USING gin (title gin_trgm_ops);
CREATE INDEX idx_events_title_lower ON events (lower(title));

-- ---------------------------------------------------------------------------
-- event_submissions
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS event_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  city_name TEXT NOT NULL,
  location_name TEXT NOT NULL,
  start_at TIMESTAMPTZ NOT NULL,
  end_at TIMESTAMPTZ,
  organizer_name TEXT,
  source_url TEXT,
  practical_info TEXT,
  proposer_email TEXT NOT NULL,
  verification_status TEXT NOT NULL
    CHECK (verification_status IN ('pending', 'verified', 'expired'))
    DEFAULT 'pending',
  verification_token_digest TEXT,
  verification_expires_at TIMESTAMPTZ,
  moderation_status TEXT NOT NULL
    CHECK (moderation_status IN (
      'awaiting_verification',
      'pending_moderation',
      'approved',
      'rejected'
    ))
    DEFAULT 'awaiting_verification',
  rejection_reason TEXT,
  published_event_id UUID REFERENCES events(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_submissions_moderation ON event_submissions (moderation_status, created_at DESC);
CREATE INDEX idx_submissions_email_created ON event_submissions (proposer_email, created_at DESC);

-- ---------------------------------------------------------------------------
-- participations (données sensibles — accès service role uniquement)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS participations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  event_scoped_token_digest TEXT NOT NULL,
  intended_at TIMESTAMPTZ,
  attended_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT participations_unique_token UNIQUE (event_id, event_scoped_token_digest),
  CONSTRAINT participations_has_declaration CHECK (
    intended_at IS NOT NULL OR attended_at IS NOT NULL
  )
);

CREATE INDEX idx_participations_event ON participations (event_id);

-- ---------------------------------------------------------------------------
-- event_reports
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS event_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  reason TEXT NOT NULL,
  details TEXT NOT NULL,
  status TEXT NOT NULL
    CHECK (status IN ('open', 'in_progress', 'resolved', 'dismissed'))
    DEFAULT 'open',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ,
  admin_note TEXT
);

CREATE INDEX idx_reports_status ON event_reports (status, created_at DESC);

-- ---------------------------------------------------------------------------
-- admin_audit
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admin_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id UUID NOT NULL,
  actor_id TEXT NOT NULL,
  metadata JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_admin_audit_created ON admin_audit (created_at DESC);

-- ---------------------------------------------------------------------------
-- RLS : aucune table exposée au client public via PostgREST
-- Accès uniquement via service role côté Nitro
-- ---------------------------------------------------------------------------
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE participations ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_audit ENABLE ROW LEVEL SECURITY;

-- Pas de politiques publiques : le service role bypass RLS.
-- Si une clé anon est utilisée un jour, elle ne verra rien sans politique explicite.
