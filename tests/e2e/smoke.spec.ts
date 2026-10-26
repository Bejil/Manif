import { expect, test } from '@playwright/test'

test('accueil affiche le titre et la recherche', async ({ page }) => {
  await page.goto('/')
  await expect(page.getByRole('heading', { level: 1 })).toContainText(/manifestations/i)
  await expect(page.locator('#search-q')).toBeVisible()
})

test('fiche manifestation accessible depuis la liste', async ({ page }) => {
  await page.goto('/')
  const link = page.locator('#agenda a[href^="/manifestations/"]').first()
  await expect(link).toBeVisible({ timeout: 15_000 })
  await link.click()
  await expect(page.getByRole('heading', { level: 1 })).toBeVisible()
  await expect(page.getByRole('heading', { name: /Soutenir ou participer/i })).toBeVisible()
})

test('guide du manifestant', async ({ page }) => {
  await page.goto('/guide')
  await expect(page.getByRole('heading', { level: 1 })).toContainText(/Guide du/i)
})
