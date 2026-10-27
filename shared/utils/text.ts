/** Aperçu texte pour listes / cartes (espace normalisé). */
export function excerptText(text: string, max = 140): string {
  const raw = (text || '').replace(/\s+/g, ' ').trim()
  if (!raw) return ''
  if (raw.length <= max) return raw
  const cut = raw.slice(0, max)
  const soft = cut.replace(/\s+\S*$/, '').trim()
  return `${soft || cut.trim()}…`
}
