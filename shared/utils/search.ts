/** Normalise pour recherche insensible à la casse et aux accents */
export function normalizeSearchText(value: string): string {
  return value
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, ' ')
    .trim()
    .replace(/\s+/g, ' ')
}

export function matchesSearch(
  haystack: string,
  needle: string,
): boolean {
  if (!needle.trim()) return true
  return normalizeSearchText(haystack).includes(normalizeSearchText(needle))
}

/** Similarité simple pour détection de doublons (titres) */
export function titleSimilarity(a: string, b: string): number {
  const na = normalizeSearchText(a)
  const nb = normalizeSearchText(b)
  if (!na || !nb) return 0
  if (na === nb) return 1
  if (na.includes(nb) || nb.includes(na)) return 0.85

  const tokensA = new Set(na.split(/\s+/).filter(Boolean))
  const tokensB = new Set(nb.split(/\s+/).filter(Boolean))
  let intersection = 0
  for (const t of tokensA) {
    if (tokensB.has(t)) intersection++
  }
  const union = tokensA.size + tokensB.size - intersection
  return union === 0 ? 0 : intersection / union
}
