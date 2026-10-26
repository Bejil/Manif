/**
 * Fuseau IANA approximatif par département / territoire (France).
 * Ne pas supposer Europe/Paris pour l'outre-mer.
 */
const OVERSEAS: Record<string, string> = {
  '971': 'America/Guadeloupe',
  '972': 'America/Martinique',
  '973': 'America/Cayenne',
  '974': 'Indian/Reunion',
  '975': 'America/Miquelon',
  '976': 'Indian/Mayotte',
  '977': 'Pacific/Tahiti', // Saint-Barthélemy (approx)
  '978': 'America/St_Barthelemy',
  '986': 'Pacific/Wallis',
  '987': 'Pacific/Tahiti',
  '988': 'Pacific/Noumea',
}

export function timezoneFromPostalOrCity(
  postalCode: string | null | undefined,
  cityName?: string,
): string {
  if (postalCode && postalCode.length >= 3) {
    const prefix = postalCode.slice(0, 3)
    if (OVERSEAS[prefix]) return OVERSEAS[prefix]
    // Corse reste Europe/Paris
  }

  const city = (cityName || '').toLowerCase()
  if (/guadeloupe|pointe-à-pitre|basse-terre/.test(city)) return 'America/Guadeloupe'
  if (/martinique|fort-de-france/.test(city)) return 'America/Martinique'
  if (/guyane|cayenne/.test(city)) return 'America/Cayenne'
  if (/réunion|reunion|saint-denis/.test(city) && /réunion|reunion/.test(city)) {
    return 'Indian/Reunion'
  }
  if (/mayotte|mamoudzou/.test(city)) return 'Indian/Mayotte'
  if (/nouvelle-calédonie|nouméa|noumea/.test(city)) return 'Pacific/Noumea'
  if (/polynésie|papeete|tahiti/.test(city)) return 'Pacific/Tahiti'

  return 'Europe/Paris'
}
