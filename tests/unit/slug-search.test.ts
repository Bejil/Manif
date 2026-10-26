import { describe, expect, it } from 'vitest'
import { createEventSlug, ensureUniqueSlug } from '../../shared/utils/slug'
import { matchesSearch, normalizeSearchText, titleSimilarity } from '../../shared/utils/search'

describe('slug', () => {
  it('génère un slug lisible', () => {
    const slug = createEventSlug('Marche pour le Climat', 'Paris', '2026-06-15T12:00:00Z')
    expect(slug).toContain('marche')
    expect(slug).toContain('paris')
    expect(slug).toContain('2026-06-15')
  })

  it('assure l\'unicité', () => {
    const existing = new Set(['a', 'a-2'])
    expect(ensureUniqueSlug('a', existing)).toBe('a-3')
  })
})

describe('search', () => {
  it('ignore accents et casse', () => {
    expect(normalizeSearchText('Été')).toBe('ete')
    expect(matchesSearch('Saint-Denis', 'saint denis')).toBe(true)
    expect(matchesSearch('Réunion', 'reunion')).toBe(true)
  })

  it('mesure une similarité de titres', () => {
    expect(titleSimilarity('Marche climat Paris', 'Marche climat Paris')).toBe(1)
    expect(titleSimilarity('Marche climat', 'Marche pour le climat')).toBeGreaterThan(0.4)
  })
})
