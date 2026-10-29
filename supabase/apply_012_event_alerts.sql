-- À exécuter dans le SQL Editor Supabase si la migration CLI n’est pas utilisée.

CREATE TABLE IF NOT EXISTS event_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL,
  location_label TEXT NOT NULL,
  latitude DOUBLE PRECISION NOT NULL
    CHECK (latitude BETWEEN -90 AND 90),
  longitude DOUBLE PRECISION NOT NULL
    CHECK (longitude BETWEEN -180 AND 180),
  radius_km INTEGER NOT NULL
    CHECK (radius_km IN (5, 10, 25, 50, 100)),
  status TEXT NOT NULL
    CHECK (status IN ('pending', 'active', 'unsubscribed'))
    DEFAULT 'pending',
  confirm_token_digest TEXT,
  unsubscribe_token_digest TEXT NOT NULL,
  confirmed_at TIMESTAMPTZ,
  unsubscribed_at TIMESTAMPTZ,
  last_notified_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT event_alerts_email_unique UNIQUE (email)
);

CREATE INDEX IF NOT EXISTS idx_event_alerts_status ON event_alerts (status);
CREATE INDEX IF NOT EXISTS idx_event_alerts_confirm ON event_alerts (confirm_token_digest)
  WHERE confirm_token_digest IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_event_alerts_unsub ON event_alerts (unsubscribe_token_digest);

ALTER TABLE event_alerts ENABLE ROW LEVEL SECURITY;
