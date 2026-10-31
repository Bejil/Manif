import { DateTime } from 'luxon'
import type { EventRecord } from '#shared/types/event'
import { buildLongEventDescription } from '#shared/content/event-descriptions'
import { createEventSlug } from '#shared/utils/slug'

/**
 * Jeu d’événements de démarrage (mock / seed).
 * Inclut un cluster dense autour de Paris pour tester la carte.
 */
export function buildDemoEvents(now = DateTime.utc()): EventRecord[] {
  const mk = (
    partial: Omit<EventRecord, 'id' | 'slug' | 'createdAt' | 'updatedAt' | 'publishedAt' | 'countryCode' | 'isDemo' | 'viewCount'> & {
      id?: string
      slug?: string
      viewCount?: number
    },
  ): EventRecord => {
    const id = partial.id ?? cryptoRandom(partial.title + partial.cityName + (partial.startAt ?? 'tba'))
    const slug = partial.slug ?? createEventSlug(partial.title, partial.cityName, partial.startAt)
    const ts = now.toISO()!
    return {
      ...partial,
      id,
      slug,
      countryCode: 'FR',
      createdAt: ts,
      updatedAt: ts,
      publishedAt: ts,
      isDemo: false,
      locationRevealAt: partial.locationRevealAt ?? null,
      imageUrls: partial.imageUrls ?? [],
      videoUrls: partial.videoUrls ?? [],
      viewCount: partial.viewCount ?? (Number.parseInt(id.replace(/\D/g, '').slice(0, 4) || '12', 10) % 400) + 8,
    }
  }

  const paris = (days: number, hour: number) =>
    now.setZone('Europe/Paris').plus({ days }).set({
      hour,
      minute: 0,
      second: 0,
      millisecond: 0,
    })

  /** Débuté il y a 1 h, fin dans 8 h — reste « en cours » longtemps après un seed */
  const lyonOngoingStart = now.setZone('Europe/Paris').minus({ hours: 1 })
  const marseillePast = now.setZone('Europe/Paris').minus({ days: 3 }).set({
    hour: 10,
    minute: 0,
    second: 0,
    millisecond: 0,
  })
  const nantesCancelled = paris(10, 15)
  const strasbourgPostponed = paris(12, 14)
  const reunionUpcoming = now.setZone('Indian/Reunion').plus({ days: 4 }).set({
    hour: 9,
    minute: 30,
    second: 0,
    millisecond: 0,
  })
  const guadeloupeUpcoming = now.setZone('America/Guadeloupe').plus({ days: 6 }).set({
    hour: 16,
    minute: 0,
    second: 0,
    millisecond: 0,
  })
  const lilleToday = now.setZone('Europe/Paris').plus({ hours: 4 }).set({
    second: 0,
    millisecond: 0,
  })
  const bordeauxPast = now.setZone('Europe/Paris').minus({ days: 14 }).set({
    hour: 18,
    minute: 0,
    second: 0,
    millisecond: 0,
  })

  // Points proches à Paris (République / Bastille / Nation / Belleville…) pour clusters
  const parisCluster: Array<{
    title: string
    locationName: string
    lat: number
    lng: number
    days: number
    hour: number
    category: EventRecord['category']
    /** heures avant début ; null = immédiat ; future = masqué */
    revealHoursBefore?: number | null
  }> = [
    { title: 'Marche pour le climat — République', locationName: 'Place de la République', lat: 48.8676, lng: 2.3631, days: 5, hour: 14, category: 'climat' },
    { title: 'Rassemblement jeunesse — République', locationName: 'Place de la République (angle Magenta)', lat: 48.8682, lng: 2.3640, days: 5, hour: 15, category: 'education' },
    { title: 'Veillée citoyenne — Temple', locationName: 'Place de la République / Temple', lat: 48.8670, lng: 2.3648, days: 6, hour: 18, category: 'droits' },
    { title: 'Marche solidaire — Bastille', locationName: 'Place de la Bastille', lat: 48.8532, lng: 2.3691, days: 4, hour: 11, category: 'social' },
    { title: 'Rassemblement logement — Bastille', locationName: 'Colonne de Juillet', lat: 48.8530, lng: 2.3694, days: 4, hour: 14, category: 'logement' },
    { title: 'Cortège — Nation', locationName: 'Place de la Nation', lat: 48.8483, lng: 2.3958, days: 7, hour: 14, category: 'travail' },
    { title: 'Assemblée ouverte — Oberkampf', locationName: 'Parvis métro Oberkampf', lat: 48.8644, lng: 2.3723, days: 3, hour: 17, category: 'autre' },
    { title: 'Marche santé — Belleville', locationName: 'Parvis de Belleville', lat: 48.8722, lng: 2.3768, days: 8, hour: 10, category: 'sante' },
    { title: 'Rassemblement — Goncourt', locationName: 'Place Sainte-Marthe', lat: 48.8710, lng: 2.3685, days: 2, hour: 19, category: 'social' },
    { title: 'Cortège — Gare de Lyon', locationName: 'Parvis Gare de Lyon', lat: 48.8448, lng: 2.3735, days: 9, hour: 12, category: 'travail' },
    // Lieu connu en base mais masqué jusqu’à J-2
    { title: 'Point de départ secret — Est', locationName: 'Place de la République', lat: 48.8676, lng: 2.3631, days: 12, hour: 14, category: 'climat', revealHoursBefore: 48 },
    // Lieu masqué jusqu’à J-1 (coords présentes en base)
    { title: 'Rendez-vous — rive droite', locationName: 'Place de la Bastille', lat: 48.8532, lng: 2.3691, days: 6, hour: 10, category: 'droits', revealHoursBefore: 24 },
  ]

  const events: EventRecord[] = parisCluster.map((p) => {
    const start = paris(p.days, p.hour)
    const startIso = start.toUTC().toISO()!
    const revealAt = p.revealHoursBefore
      ? start.minus({ hours: p.revealHoursBefore }).toUTC().toISO()!
      : null
    return mk({
      title: p.title,
      description: buildLongEventDescription({
        title: p.title,
        cityName: 'Paris',
        locationName: p.locationName,
        category: p.category,
        tone: p.revealHoursBefore ? 'hidden_location' : 'default',
      }),
      category: p.category,
      cityName: 'Paris',
      postalCode: '75011',
      localityCode: '75111',
      timezone: 'Europe/Paris',
      locationName: p.locationName,
      latitude: p.lat,
      longitude: p.lng,
      locationRevealAt: revealAt,
      startAt: startIso,
      endAt: start.plus({ hours: 3 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: null,
      sourceUrl: null,
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: null,
    })
  })

  events.push(
    mk({
      title: 'Rassemblement — Bellecour',
      description: buildLongEventDescription({
        title: 'Rassemblement — Bellecour',
        cityName: 'Lyon',
        locationName: 'Place Bellecour',
        category: 'social',
        tone: 'ongoing',
      }),
      category: 'social',
      cityName: 'Lyon',
      postalCode: '69002',
      localityCode: '69382',
      timezone: 'Europe/Paris',
      locationName: 'Place Bellecour',
      latitude: 45.7578,
      longitude: 4.8320,
      locationRevealAt: null,
      startAt: lyonOngoingStart.toUTC().toISO()!,
      endAt: lyonOngoingStart.plus({ hours: 9 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: null,
      sourceUrl: 'https://example.org/rassemblement-lyon',
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Manifestation — Canebière',
      description: buildLongEventDescription({
        title: 'Manifestation — Canebière',
        cityName: 'Marseille',
        locationName: 'La Canebière',
        category: 'travail',
        tone: 'past',
      }),
      category: 'travail',
      cityName: 'Marseille',
      postalCode: '13001',
      localityCode: '13201',
      timezone: 'Europe/Paris',
      locationName: 'La Canebière',
      latitude: 43.2965,
      longitude: 5.3800,
      locationRevealAt: null,
      startAt: marseillePast.toUTC().toISO()!,
      endAt: marseillePast.plus({ hours: 2 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: 'Intersyndicale locale',
      sourceUrl: null,
      sourceVerificationStatus: 'unconfirmed',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Manifestation annulée — Commerce',
      description: buildLongEventDescription({
        title: 'Manifestation annulée — Commerce',
        cityName: 'Nantes',
        locationName: 'Place du Commerce',
        category: 'education',
        tone: 'cancelled',
      }),
      category: 'education',
      cityName: 'Nantes',
      postalCode: '44000',
      localityCode: '44109',
      timezone: 'Europe/Paris',
      locationName: 'Place du Commerce',
      latitude: 47.2133,
      longitude: -1.5555,
      locationRevealAt: null,
      startAt: nantesCancelled.toUTC().toISO()!,
      endAt: null,
      endIsEstimated: true,
      organizerName: null,
      sourceUrl: 'https://example.org/nantes-commerce',
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: 'cancelled',
    }),
    mk({
      title: 'Marche reportée — Place Kléber',
      description: buildLongEventDescription({
        title: 'Marche reportée — Place Kléber',
        cityName: 'Strasbourg',
        locationName: 'Place Kléber',
        category: 'droits',
        tone: 'postponed',
      }),
      category: 'droits',
      cityName: 'Strasbourg',
      postalCode: '67000',
      localityCode: '67482',
      timezone: 'Europe/Paris',
      locationName: 'Place Kléber',
      latitude: 48.5839,
      longitude: 7.7455,
      locationRevealAt: null,
      startAt: strasbourgPostponed.toUTC().toISO()!,
      endAt: null,
      endIsEstimated: true,
      organizerName: null,
      sourceUrl: null,
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: 'postponed',
    }),
    // Lieu connu côté organisateurs, coords pas encore saisies + révélation différée
    mk({
      title: 'Rassemblement logement — Capitole',
      description: buildLongEventDescription({
        title: 'Rassemblement logement — Capitole',
        cityName: 'Toulouse',
        locationName: 'Place du Capitole',
        category: 'logement',
        tone: 'hidden_location',
      }),
      category: 'logement',
      cityName: 'Toulouse',
      postalCode: '31000',
      localityCode: '31555',
      timezone: 'Europe/Paris',
      locationName: 'Place du Capitole',
      latitude: 43.6045,
      longitude: 1.4440,
      locationRevealAt: paris(7, 11).minus({ hours: 24 }).toUTC().toISO()!,
      startAt: paris(7, 11).toUTC().toISO()!,
      endAt: null,
      endIsEstimated: true,
      organizerName: 'Association Droit au logement',
      sourceUrl: null,
      sourceVerificationStatus: 'unconfirmed',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Rassemblement — Saint-Denis (La Réunion)',
      description: buildLongEventDescription({
        title: 'Rassemblement — Saint-Denis (La Réunion)',
        cityName: 'Saint-Denis',
        locationName: 'Barachois',
        category: 'droits',
      }),
      category: 'droits',
      cityName: 'Saint-Denis',
      postalCode: '97400',
      localityCode: '97411',
      timezone: 'Indian/Reunion',
      locationName: 'Barachois',
      latitude: -20.8789,
      longitude: 55.4481,
      locationRevealAt: null,
      startAt: reunionUpcoming.toUTC().toISO()!,
      endAt: reunionUpcoming.plus({ hours: 2 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: null,
      sourceUrl: 'https://example.org/reunion-barachois',
      sourceVerificationStatus: 'cross_checked',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Marche pacifique — Pointe-à-Pitre',
      description: buildLongEventDescription({
        title: 'Marche pacifique — Pointe-à-Pitre',
        cityName: 'Pointe-à-Pitre',
        locationName: 'Place de la Victoire',
        category: 'social',
      }),
      category: 'social',
      cityName: 'Pointe-à-Pitre',
      postalCode: '97110',
      localityCode: '97120',
      timezone: 'America/Guadeloupe',
      locationName: 'Place de la Victoire',
      latitude: 16.2410,
      longitude: -61.5330,
      locationRevealAt: null,
      startAt: guadeloupeUpcoming.toUTC().toISO()!,
      endAt: null,
      endIsEstimated: true,
      organizerName: 'Collectif Caraïbe',
      sourceUrl: null,
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Rassemblement — Grand Place',
      description: buildLongEventDescription({
        title: 'Rassemblement — Grand Place',
        cityName: 'Lille',
        locationName: 'Grand Place',
        category: 'sante',
      }),
      category: 'sante',
      cityName: 'Lille',
      postalCode: '59000',
      localityCode: '59350',
      timezone: 'Europe/Paris',
      locationName: 'Grand Place',
      latitude: 50.6370,
      longitude: 3.0635,
      locationRevealAt: null,
      startAt: lilleToday.toUTC().toISO()!,
      endAt: lilleToday.plus({ hours: 2 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: null,
      sourceUrl: 'https://example.org/lille-grand-place',
      sourceVerificationStatus: 'cross_checked',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Rassemblement — Quinconces',
      description: buildLongEventDescription({
        title: 'Rassemblement — Quinconces',
        cityName: 'Bordeaux',
        locationName: 'Place des Quinconces',
        category: 'autre',
        tone: 'past',
      }),
      category: 'autre',
      cityName: 'Bordeaux',
      postalCode: '33000',
      localityCode: '33063',
      timezone: 'Europe/Paris',
      locationName: 'Place des Quinconces',
      latitude: 44.8455,
      longitude: -0.5740,
      locationRevealAt: null,
      startAt: bordeauxPast.toUTC().toISO()!,
      endAt: bordeauxPast.plus({ hours: 3 }).toUTC().toISO()!,
      endIsEstimated: false,
      organizerName: null,
      sourceUrl: null,
      sourceVerificationStatus: 'unconfirmed',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    // Dates à confirmer — visibles dans « À venir »
    mk({
      title: 'Marche interprofessionnelle — date à confirmer',
      description: buildLongEventDescription({
        title: 'Marche interprofessionnelle — date à confirmer',
        cityName: 'Paris',
        locationName: 'Place de la République',
        category: 'travail',
        tone: 'tba',
      }),
      category: 'travail',
      cityName: 'Paris',
      postalCode: '75001',
      localityCode: '75101',
      timezone: 'Europe/Paris',
      locationName: 'Place de la République',
      latitude: 48.8676,
      longitude: 2.3631,
      locationRevealAt: null,
      startAt: null,
      endAt: null,
      endIsEstimated: true,
      organizerName: null,
      sourceUrl: null,
      sourceVerificationStatus: 'source_provided',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
    mk({
      title: 'Rassemblement climat — date à venir',
      description: buildLongEventDescription({
        title: 'Rassemblement climat — date à venir',
        cityName: 'Lyon',
        locationName: 'Place Bellecour',
        category: 'climat',
        tone: 'tba',
      }),
      category: 'climat',
      cityName: 'Lyon',
      postalCode: '69002',
      localityCode: '69382',
      timezone: 'Europe/Paris',
      locationName: 'Place Bellecour',
      latitude: 45.7578,
      longitude: 4.8320,
      locationRevealAt: null,
      startAt: null,
      endAt: null,
      endIsEstimated: true,
      organizerName: 'Collectif Climat Lyon',
      sourceUrl: null,
      sourceVerificationStatus: 'unconfirmed',
      publicationStatus: 'published',
      eventStatusOverride: null,
    }),
  )

  return events
}

function cryptoRandom(seed: string): string {
  let h1 = 0x811c9dc5
  let h2 = 0x811c9dc5 ^ 0xdeadbeef
  for (let i = 0; i < seed.length; i++) {
    const c = seed.charCodeAt(i)
    h1 = Math.imul(h1 ^ c, 0x01000193) >>> 0
    h2 = Math.imul(h2 ^ (c + i), 0x01000193) >>> 0
  }
  const hex = (h1.toString(16).padStart(8, '0') + h2.toString(16).padStart(8, '0')
    + (h1 ^ h2).toString(16).padStart(8, '0')
    + ((h1 + h2) >>> 0).toString(16).padStart(8, '0')).slice(0, 32)
  return `${hex.slice(0, 8)}-${hex.slice(8, 12)}-4${hex.slice(13, 16)}-a${hex.slice(17, 20)}-${hex.slice(20, 32)}`
}
