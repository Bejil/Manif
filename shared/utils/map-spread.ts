/**
 * Hash simple et stable → [0, 1). Même id = même offset à chaque rendu.
 */
function hash01(seed: string): number {
  let h = 2166136261
  for (let i = 0; i < seed.length; i++) {
    h ^= seed.charCodeAt(i)
    h = Math.imul(h, 16777619)
  }
  return ((h >>> 0) % 10_000_000) / 10_000_000
}

/**
 * Écarte légèrement les points qui partagent (presque) la même localisation
 * avec un jitter aléatoire mais déterministe (par id), pour un nuage naturel.
 *
 * Retourne une Map id → [longitude, latitude] à afficher.
 */
export function spreadMapCoordinates(
  points: Array<{ id: string; latitude: number; longitude: number }>,
): Map<string, [number, number]> {
  /** ~1 m — regrouper les coords strictement identiques ou quasi. */
  const precision = 5
  /** Rayon max du nuage (~45–80 m selon le nombre). */
  const baseRadiusDeg = 0.0004

  const groups = new Map<string, Array<{ id: string; latitude: number; longitude: number }>>()
  for (const p of points) {
    const key = `${p.latitude.toFixed(precision)},${p.longitude.toFixed(precision)}`
    const bucket = groups.get(key)
    if (bucket) bucket.push(p)
    else groups.set(key, [p])
  }

  const out = new Map<string, [number, number]>()

  for (const group of groups.values()) {
    if (group.length === 1) {
      const p = group[0]!
      out.set(p.id, [p.longitude, p.latitude])
      continue
    }

    const n = group.length
    const lat0 = group.reduce((s, p) => s + p.latitude, 0) / n
    const lng0 = group.reduce((s, p) => s + p.longitude, 0) / n
    const cosLat = Math.max(Math.cos((lat0 * Math.PI) / 180), 1e-6)
    const radius = baseRadiusDeg * (0.85 + Math.log2(n + 1) * 0.35)

    // Placement initial : disque uniforme (√r pour densité plate)
    const placed: Array<{ id: string; dLat: number; dLng: number }> = []
    for (const p of group) {
      const u = hash01(`${p.id}:a`)
      const v = hash01(`${p.id}:b`)
      const angle = u * Math.PI * 2
      const dist = radius * Math.sqrt(0.12 + v * 0.88)
      placed.push({
        id: p.id,
        dLat: dist * Math.sin(angle),
        dLng: (dist * Math.cos(angle)) / cosLat,
      })
    }

    // Léger écartement si deux points restent trop proches
    const minDist = radius * (0.22 + 0.35 / Math.sqrt(n))
    for (let pass = 0; pass < 4; pass++) {
      for (let i = 0; i < placed.length; i++) {
        for (let j = i + 1; j < placed.length; j++) {
          const a = placed[i]!
          const b = placed[j]!
          const dx = (a.dLng - b.dLng) * cosLat
          const dy = a.dLat - b.dLat
          const d = Math.hypot(dx, dy)
          if (d >= minDist || d < 1e-12) continue
          const push = ((minDist - d) / 2) * 0.65
          const nx = dx / d
          const ny = dy / d
          a.dLat += ny * push
          a.dLng += (nx * push) / cosLat
          b.dLat -= ny * push
          b.dLng -= (nx * push) / cosLat
        }
      }
    }

    for (const p of placed) {
      out.set(p.id, [lng0 + p.dLng, lat0 + p.dLat])
    }
  }

  return out
}
