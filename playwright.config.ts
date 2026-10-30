import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  testDir: 'tests/e2e',
  fullyParallel: false,
  workers: 1,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  use: {
    baseURL: 'http://127.0.0.1:3000',
    trace: 'on-first-retry',
  },
  projects: [{ name: 'chromium', use: { ...devices['Desktop Chrome'] } }],
  webServer: {
    command: 'node .output/server/index.mjs',
    url: 'http://127.0.0.1:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
    env: {
      ...process.env,
      PORT: '3000',
      HOST: '127.0.0.1',
      NUXT_PUBLIC_USE_MOCK_DB: 'true',
      NUXT_PUBLIC_ENGAGEMENTS_ENABLED: 'true',
      PARTICIPATION_TOKEN_PEPPER: 'e2e-pepper',
      ADMIN_SESSION_SECRET: 'e2e-admin-secret',
      ADMIN_EMAIL: 'contact@manif.info',
      ADMIN_PASSWORD: 'dev-admin-change-me',
    },

  },
})

