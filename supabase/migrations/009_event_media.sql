-- Manif' — médias d’événement (URLs images / vidéos)
-- L’URL source (source_url) existe déjà sur events et event_submissions.

ALTER TABLE events
  ADD COLUMN IF NOT EXISTS image_urls TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS video_urls TEXT[] NOT NULL DEFAULT '{}';

ALTER TABLE event_submissions
  ADD COLUMN IF NOT EXISTS image_urls TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS video_urls TEXT[] NOT NULL DEFAULT '{}';

COMMENT ON COLUMN events.image_urls IS 'URLs HTTPS d’images (liens ou fichiers uploadés)';
COMMENT ON COLUMN events.video_urls IS 'URLs HTTPS de vidéos (YouTube, Vimeo, fichier, etc.)';
COMMENT ON COLUMN event_submissions.image_urls IS 'URLs HTTPS d’images proposées';
COMMENT ON COLUMN event_submissions.video_urls IS 'URLs HTTPS de vidéos proposées';

-- Bucket Storage public pour les uploads d’images (service_role contourne RLS).
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'event-media',
  'event-media',
  true,
  2097152,
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
)
ON CONFLICT (id) DO UPDATE SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;
