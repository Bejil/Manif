/** Flag runtime Nuxt (booléen ou chaîne env). */
export function isFlagEnabled(value: unknown): boolean {
  if (value === false || value === 'false' || value === 0 || value === '0') return false
  if (value === true || value === 'true' || value === 1 || value === '1') return true
  // Défaut MVP : actif si non défini
  return value == null || value === ''
}
