-- Compteur de vues de fiche (dénormalisé sur events)

ALTER TABLE events
  ADD COLUMN IF NOT EXISTS view_count INTEGER NOT NULL DEFAULT 0
  CHECK (view_count >= 0);

CREATE OR REPLACE FUNCTION increment_event_views(p_event_id UUID)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  new_count INTEGER;
BEGIN
  UPDATE events
  SET view_count = view_count + 1
  WHERE id = p_event_id
    AND publication_status = 'published'
  RETURNING view_count INTO new_count;

  RETURN COALESCE(new_count, 0);
END;
$$;

REVOKE ALL ON FUNCTION increment_event_views(UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION increment_event_views(UUID) TO service_role;
