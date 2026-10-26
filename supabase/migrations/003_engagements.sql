-- Remplace le modèle intentions/présences par soutiens + participations déclarées
-- Migration non destructive depuis `participations`.

CREATE TABLE IF NOT EXISTS engagements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  event_scoped_token_digest TEXT NOT NULL,
  supports_at TIMESTAMPTZ,
  participates_at TIMESTAMPTZ,
  participation_kind TEXT
    CHECK (participation_kind IS NULL OR participation_kind IN ('planned', 'during')),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT engagements_unique_token UNIQUE (event_id, event_scoped_token_digest),
  CONSTRAINT engagements_has_declaration CHECK (
    supports_at IS NOT NULL OR participates_at IS NOT NULL
  ),
  CONSTRAINT engagements_kind_consistency CHECK (
    (participates_at IS NULL AND participation_kind IS NULL)
    OR (participates_at IS NOT NULL AND participation_kind IS NOT NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_engagements_event ON engagements (event_id);

-- Copie depuis l'ancienne table si elle existe encore
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'participations'
  ) THEN
    INSERT INTO engagements (
      id, event_id, event_scoped_token_digest,
      supports_at, participates_at, participation_kind, updated_at
    )
    SELECT
      id,
      event_id,
      event_scoped_token_digest,
      NULL, -- anciens modèles : pas de notion de soutien
      COALESCE(intended_at, attended_at),
      CASE
        WHEN intended_at IS NOT NULL AND (attended_at IS NULL OR intended_at <= attended_at)
          THEN 'planned'
        WHEN attended_at IS NOT NULL THEN 'during'
        ELSE 'planned'
      END,
      updated_at
    FROM participations
    WHERE intended_at IS NOT NULL OR attended_at IS NOT NULL
    ON CONFLICT (event_id, event_scoped_token_digest) DO NOTHING;

    -- Conserve l'ancienne table en archive (renommée) — pas de DROP destructif
    ALTER TABLE IF EXISTS participations RENAME TO participations_legacy_archive;
  END IF;
EXCEPTION WHEN duplicate_table THEN
  RAISE NOTICE 'participations_legacy_archive existe déjà';
END $$;

ALTER TABLE engagements ENABLE ROW LEVEL SECURITY;
