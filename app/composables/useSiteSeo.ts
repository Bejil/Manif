type MaybeRefOrGetter<T> = T | (() => T)

function resolve<T>(value: MaybeRefOrGetter<T>): T {
  return typeof value === 'function' ? (value as () => T)() : value
}

/**
 * SEO page publique : title/description, OG absolus, canonical, JSON-LD optionnel.
 */
export function useSiteSeo(options: {
  title: MaybeRefOrGetter<string>
  description: MaybeRefOrGetter<string>
  path: MaybeRefOrGetter<string>
  ogImage?: MaybeRefOrGetter<string | undefined>
  robots?: MaybeRefOrGetter<string | undefined>
  jsonLd?: MaybeRefOrGetter<Record<string, unknown> | Array<Record<string, unknown>> | null | undefined>
}) {
  const config = useRuntimeConfig()

  const siteUrl = computed(() =>
    String(config.public.siteUrl || 'https://manif.info').replace(/\/$/, ''),
  )

  function toAbsolute(pathOrUrl: string): string {
    if (/^https?:\/\//i.test(pathOrUrl)) return pathOrUrl
    const path = pathOrUrl.startsWith('/') ? pathOrUrl : `/${pathOrUrl}`
    return `${siteUrl.value}${path}`
  }

  const canonical = computed(() => toAbsolute(resolve(options.path)))
  const defaultOg = computed(() => toAbsolute('/brand/og-default.jpg'))
  const ogImage = computed(() => {
    const custom = options.ogImage ? resolve(options.ogImage) : undefined
    return custom ? toAbsolute(custom) : defaultOg.value
  })

  useSeoMeta({
    title: () => resolve(options.title),
    description: () => resolve(options.description),
    ogTitle: () => resolve(options.title),
    ogDescription: () => resolve(options.description),
    ogUrl: () => canonical.value,
    ogImage: () => ogImage.value,
    ogType: 'website',
    twitterCard: 'summary_large_image',
    twitterTitle: () => resolve(options.title),
    twitterDescription: () => resolve(options.description),
    twitterImage: () => ogImage.value,
    robots: () => (options.robots ? resolve(options.robots) : undefined),
  })

  useHead(() => {
    const scripts: Array<{ type: string, children: string }> = []
    const ld = options.jsonLd ? resolve(options.jsonLd) : null
    if (ld) {
      const blocks = Array.isArray(ld) ? ld : [ld]
      for (const block of blocks) {
        scripts.push({
          type: 'application/ld+json',
          children: JSON.stringify(block),
        })
      }
    }
    return {
      link: [{ rel: 'canonical', href: canonical.value }],
      script: scripts,
    }
  })

  return { siteUrl, canonical, ogImage, toAbsolute }
}
