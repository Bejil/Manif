// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  future: {
    compatibilityVersion: 4,
  },
  devtools: { enabled: true },

  modules: [
    '@nuxtjs/tailwindcss',
    '@vite-pwa/nuxt',
  ],

  // components/common/UiButton.vue → <UiButton> (sans préfixe Common)
  components: [
    { path: '~/components', pathPrefix: false },
  ],

  css: ['~/assets/css/main.css'],


  app: {
    head: {
      htmlAttrs: { lang: 'fr' },
      title: "Manif' — Agenda des manifestations en France",
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content:
            "Trouvez les manifestations près de chez vous, localisez-les sur une carte et participez au comptage citoyen. Neutre, gratuit, sans compte.",
        },
        { name: 'theme-color', content: '#111111' },
        { property: 'og:site_name', content: "Manif'" },
        { property: 'og:locale', content: 'fr_FR' },
        { property: 'og:image', content: '/brand/og-default.svg' },
        { name: 'twitter:card', content: 'summary_large_image' },
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
        { rel: 'apple-touch-icon', href: '/brand/manif.logo.svg' },
        {
          rel: 'preconnect',
          href: 'https://fonts.googleapis.com',
        },
        {
          rel: 'preconnect',
          href: 'https://fonts.gstatic.com',
          crossorigin: '',
        },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Anton&family=Inter:wght@400;500;600;700;800&display=swap',
        },
      ],
    },
  },

  runtimeConfig: {
    // Secrets serveur uniquement
    supabaseServiceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY || '',
    supabaseUrl: process.env.SUPABASE_URL || '',
    resendApiKey: process.env.RESEND_API_KEY || '',
    emailFrom: process.env.EMAIL_FROM || "Manif' <contact@manif.info>",
    turnstileSecretKey:
      process.env.TURNSTILE_SECRET_KEY
      || process.env.TURNSTILE_SECRET
      || '',
    /** Hostnames frontend autorisés (siteverify). Prod : sans localhost. */
    turnstileHostnames:
      process.env.TURNSTILE_HOSTNAMES
      || 'localhost,127.0.0.1',
    participationTokenPepper: process.env.PARTICIPATION_TOKEN_PEPPER || 'dev-pepper-change-me',
    adminSessionSecret: process.env.ADMIN_SESSION_SECRET || 'dev-admin-secret-change-me',
    // Surcharge possible via NUXT_ADMIN_EMAIL / NUXT_ADMIN_PASSWORD (évite le shell)
    adminEmail: process.env.NUXT_ADMIN_EMAIL || process.env.ADMIN_EMAIL || 'contact@manif.info',
    adminPassword:
      process.env.NUXT_ADMIN_PASSWORD
      || process.env.ADMIN_PASSWORD
      || (process.env.NODE_ENV === 'production' ? '' : 'dev-admin-change-me'),
    geocodingProvider: process.env.GEOCODING_PROVIDER || 'ban',
    geocodingApiKey: process.env.GEOCODING_API_KEY || '',
    mapStyleUrl:
      process.env.MAP_STYLE_URL
      || 'https://tiles.openfreemap.org/styles/liberty',
    rateLimitSalt: process.env.RATE_LIMIT_SALT || 'dev-rate-salt',

    public: {
      siteUrl: process.env.NUXT_PUBLIC_SITE_URL || 'https://manif.info',
      siteName: "Manif'",
      tagline: 'L’agenda citoyen des manifestations en France.',
      turnstileSiteKey: process.env.NUXT_PUBLIC_TURNSTILE_SITE_KEY || '',
      mapStyleUrl:
        process.env.NUXT_PUBLIC_MAP_STYLE_URL
        || 'https://tiles.openfreemap.org/styles/liberty',
      mapAttribution:
        process.env.NUXT_PUBLIC_MAP_ATTRIBUTION
        || '© OpenStreetMap © OpenFreeMap',
      donateUrl: process.env.NUXT_PUBLIC_DONATE_URL || '',
      /**
       * Collecte soutien/participation (MVP actif).
       * Opt-out uniquement : NUXT_PUBLIC_ENGAGEMENTS_ENABLED=false
       * Ne pas réutiliser NUXT_PUBLIC_PARTICIPATION_ENABLED (souvent forcé à false dans le shell).
       */
      engagementsEnabled:
        (process.env.NUXT_PUBLIC_ENGAGEMENTS_ENABLED ?? 'true') !== 'false',

      /** Uniquement si explicitement true — sinon toujours Supabase */
      useMockDb: process.env.NUXT_PUBLIC_USE_MOCK_DB === 'true',
      contactEmail: process.env.NUXT_PUBLIC_CONTACT_EMAIL || 'contact@manif.info',
      legalEditorName: process.env.NUXT_PUBLIC_LEGAL_EDITOR_NAME || '',
      legalEditorAddress: process.env.NUXT_PUBLIC_LEGAL_EDITOR_ADDRESS || '',
      legalHostName: process.env.NUXT_PUBLIC_LEGAL_HOST_NAME || '',
      legalHostAddress: process.env.NUXT_PUBLIC_LEGAL_HOST_ADDRESS || '',
      legalHostPhone: process.env.NUXT_PUBLIC_LEGAL_HOST_PHONE || '',
    },
  },

  // Remplace le plugin nesting manquant du module Tailwind
  postcss: {
    plugins: {
      'postcss-nesting': {},
      tailwindcss: {},
      autoprefixer: {},
    },
  },

  nitro: {
    experimental: {
      openAPI: false,
    },
  },


  typescript: {
    strict: true,
    typeCheck: false,
  },

  pwa: {
    registerType: 'autoUpdate',
    manifest: {
      name: "Manif'",
      short_name: "Manif'",
      description: 'Toutes les manifestations. Toutes les voix.',
      theme_color: '#111111',
      background_color: '#FFFCF4',
      display: 'standalone',
      lang: 'fr',
      start_url: '/',
      icons: [
        {
          src: '/icons/icon-192.png',
          sizes: '192x192',
          type: 'image/png',
        },
        {
          src: '/icons/icon-512.png',
          sizes: '512x512',
          type: 'image/png',
        },
      ],
    },
    workbox: {
      navigateFallback: null,
      globPatterns: ['**/*.{js,css,html,png,svg,ico}'],
      mode: 'development',
    },
    client: {
      installPrompt: false,
    },
    devOptions: {
      enabled: false,
    },
  },

  vite: {
    optimizeDeps: {
      // Évite le worker MapLibre prébundle cassé (@fs …/maplibre-gl-worker.mjs → 504)
      exclude: ['maplibre-gl'],
    },
    worker: {
      format: 'es',
    },
  },
})
