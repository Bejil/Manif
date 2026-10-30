import type { EventPublic } from '../types/event'

function abs(siteUrl: string, pathOrUrl: string): string {
  const base = siteUrl.replace(/\/$/, '')
  if (/^https?:\/\//i.test(pathOrUrl)) return pathOrUrl
  return `${base}${pathOrUrl.startsWith('/') ? pathOrUrl : `/${pathOrUrl}`}`
}

export function organizationJsonLd(siteUrl: string) {
  const base = siteUrl.replace(/\/$/, '')
  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: "Manif'",
    url: base,
    logo: abs(base, '/brand/manif.logo.svg'),
    email: 'contact@manif.info',
    description:
      "Agenda citoyen des manifestations en France — neutre, sans compte public, sans publicité ciblée.",
  }
}

export function websiteJsonLd(siteUrl: string) {
  const base = siteUrl.replace(/\/$/, '')
  return {
    '@context': 'https://schema.org',
    '@type': 'WebSite',
    name: "Manif'",
    url: base,
    inLanguage: 'fr-FR',
    potentialAction: {
      '@type': 'SearchAction',
      target: {
        '@type': 'EntryPoint',
        urlTemplate: `${base}/manifestations?q={search_term_string}`,
      },
      'query-input': 'required name=search_term_string',
    },
  }
}

export function breadcrumbJsonLd(
  siteUrl: string,
  items: Array<{ name: string, path: string }>,
) {
  const base = siteUrl.replace(/\/$/, '')
  return {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: items.map((item, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: item.name,
      item: abs(base, item.path),
    })),
  }
}

/** Schema.org Event pour une fiche manifestation. */
export function eventJsonLd(siteUrl: string, event: EventPublic) {
  const base = siteUrl.replace(/\/$/, '')
  const url = abs(base, `/manifestations/${event.slug}`)
  const image = event.imageUrls?.[0]
    ? abs(base, event.imageUrls[0])
    : abs(base, `/api/og/event/${event.slug}`)

  const statusMap: Record<string, string> = {
    upcoming: 'https://schema.org/EventScheduled',
    ongoing: 'https://schema.org/EventScheduled',
    postponed: 'https://schema.org/EventPostponed',
    cancelled: 'https://schema.org/EventCancelled',
    past: 'https://schema.org/EventScheduled',
  }

  const place: Record<string, unknown> = {
    '@type': 'Place',
    name: event.locationRevealed && event.locationName
      ? event.locationName
      : event.cityName,
    address: {
      '@type': 'PostalAddress',
      addressLocality: event.cityName,
      postalCode: event.postalCode || undefined,
      addressCountry: event.countryCode || 'FR',
    },
  }
  if (event.mapLatitude != null && event.mapLongitude != null) {
    place.geo = {
      '@type': 'GeoCoordinates',
      latitude: event.mapLatitude,
      longitude: event.mapLongitude,
    }
  }

  const data: Record<string, unknown> = {
    '@context': 'https://schema.org',
    '@type': 'Event',
    name: event.title,
    description: event.description.replace(/\s+/g, ' ').trim().slice(0, 5000),
    url,
    image: [image],
    eventStatus: statusMap[event.displayStatus] || 'https://schema.org/EventScheduled',
    eventAttendanceMode: 'https://schema.org/OfflineEventAttendanceMode',
    location: place,
    inLanguage: 'fr-FR',
    isAccessibleForFree: true,
  }

  if (event.startAt) data.startDate = event.startAt
  if (event.endAt) data.endDate = event.endAt
  if (event.organizerName) {
    data.organizer = {
      '@type': 'Organization',
      name: event.organizerName,
    }
  }
  if (event.sourceUrl) {
    data.sameAs = [event.sourceUrl]
  }

  // Aide les moteurs sans inventer de billetterie
  data.offers = {
    '@type': 'Offer',
    price: 0,
    priceCurrency: 'EUR',
    availability: 'https://schema.org/InStock',
    url,
  }

  return data
}
