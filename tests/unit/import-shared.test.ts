import { describe, expect, it } from 'vitest'
import {
  categorize,
  cleanPlainText,
  decodeHtmlEntities,
  ensureDescription,
  isMilitant,
  parseFrenchDate,
  parseRssItems,
} from '../../server/services/importers/shared'

describe('import shared helpers', () => {
  it('détecte un signal militant', () => {
    expect(isMilitant('Manifestation contre le racisme')).toBe(true)
    expect(isMilitant('Atelier cuisine vegan')).toBe(false)
  })

  it('catégorise climat / droits', () => {
    expect(categorize('Marche climat')).toBe('climat')
    expect(categorize('Rassemblement Palestine')).toBe('droits')
  })

  it('allonge les descriptions trop courtes', () => {
    const d = ensureDescription('Gap - Marche climat', 'Marche climat', 'Gap', 'https://example.com')
    expect(d.length).toBeGreaterThanOrEqual(20)
  })

  it('parse une date française', () => {
    const d = parseFrenchDate('samedi 14 novembre 2026 à 15h')
    expect(d).not.toBeNull()
    expect(d!.getUTCFullYear()).toBe(2026)
    expect(d!.getUTCMonth()).toBe(10)
  })

  it('parse des items RSS', () => {
    const xml = `<?xml version="1.0"?><rss><channel>
      <item><title>Test manif</title><link>https://ex.test/1</link><description>Desc assez longue pour passer</description></item>
    </channel></rss>`
    const items = parseRssItems(xml)
    expect(items).toHaveLength(1)
    expect(items[0]!.title).toBe('Test manif')
    expect(items[0]!.link).toContain('ex.test')
  })

  it('décode les entités HTML numériques et nommées', () => {
    expect(decodeHtmlEntities('libert&#233;')).toBe('liberté')
    expect(decodeHtmlEntities('&#xE9;galit&#233;')).toBe('égalité')
    expect(decodeHtmlEntities('&eacute;&agrave;&ccedil;')).toBe('éàç')
    expect(decodeHtmlEntities('&amp;amp;')).toBe('&')
  })

  it('nettoie HTML + entités en texte brut', () => {
    expect(cleanPlainText('<p>Manifestation &#233;galit&#233;</p>')).toBe('Manifestation égalité')
    expect(cleanPlainText('&lt;b&gt;Greve&lt;/b&gt;')).toBe('Greve')
    expect(cleanPlainText('Solidarit&eacute; <br/> demain')).toBe('Solidarité\ndemain')
  })
})
