import { describe, expect, it } from 'vitest'
import {
  isHttpsMediaUrl,
  normalizeMediaUrls,
  resolveVideoEmbed,
} from '../../shared/utils/media'

describe('media utils', () => {
  it('accepte uniquement des URL HTTPS valides', () => {
    expect(isHttpsMediaUrl('https://cdn.example.com/a.jpg')).toBe(true)
    expect(isHttpsMediaUrl('http://cdn.example.com/a.jpg')).toBe(false)
    expect(isHttpsMediaUrl('ftp://x')).toBe(false)
    expect(isHttpsMediaUrl('')).toBe(false)
  })

  it('normalise et déduplique les listes', () => {
    expect(normalizeMediaUrls([
      'https://a.example/1.jpg',
      'https://a.example/1.jpg',
      'http://bad',
      'https://a.example/2.jpg',
    ], 8)).toEqual([
      'https://a.example/1.jpg',
      'https://a.example/2.jpg',
    ])
  })

  it('détecte YouTube et Vimeo', () => {
    const yt = resolveVideoEmbed('https://www.youtube.com/watch?v=dQw4w9WgXcQ')
    expect(yt.kind).toBe('youtube')
    if (yt.kind === 'youtube') {
      expect(yt.embedUrl).toContain('youtube-nocookie.com/embed/dQw4w9WgXcQ')
    }
    const vim = resolveVideoEmbed('https://vimeo.com/123456789')
    expect(vim.kind).toBe('vimeo')
    const file = resolveVideoEmbed('https://cdn.example.com/clip.mp4')
    expect(file.kind).toBe('file')
  })
})
