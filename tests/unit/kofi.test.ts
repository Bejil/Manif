import { describe, expect, it } from 'vitest'
import {
  extractKofiUsernameFromUrl,
  isValidKofiUrl,
  isValidKofiUsername,
  normalizeKofiUrl,
  resolveKofiConfig,
} from '../../shared/utils/kofi'

describe('kofi url', () => {
  it('accepte une URL HTTPS ko-fi.com', () => {
    expect(isValidKofiUrl('https://ko-fi.com/manif')).toBe(true)
    expect(isValidKofiUrl('https://www.ko-fi.com/manif')).toBe(true)
    expect(normalizeKofiUrl(' https://ko-fi.com/manif ')).toBe('https://ko-fi.com/manif')
  })

  it('refuse les URL invalides', () => {
    expect(isValidKofiUrl('')).toBe(false)
    expect(isValidKofiUrl('http://ko-fi.com/manif')).toBe(false)
    expect(isValidKofiUrl('https://ko-fi.com/')).toBe(false)
    expect(isValidKofiUrl('https://paypal.me/x')).toBe(false)
    expect(normalizeKofiUrl('not-a-url')).toBeNull()
  })

  it('extrait le username', () => {
    expect(extractKofiUsernameFromUrl('https://ko-fi.com/manif')).toBe('manif')
    expect(isValidKofiUsername('manif')).toBe(true)
    expect(isValidKofiUsername('a')).toBe(false)
  })

  it('résout la config depuis username ou URL', () => {
    expect(resolveKofiConfig({ username: 'manif' })).toEqual({
      username: 'manif',
      pageUrl: 'https://ko-fi.com/manif',
    })
    expect(resolveKofiConfig({ url: 'https://ko-fi.com/manif' })?.username).toBe('manif')
    expect(resolveKofiConfig({})).toBeNull()
  })
})
