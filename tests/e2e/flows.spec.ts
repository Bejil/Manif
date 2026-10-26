import { expect, test } from '@playwright/test'

test.describe('parcours principaux', () => {
  test('filtres et fiche', async ({ page }) => {
    await page.goto('/')
    await page.getByRole('button', { name: 'Terminées' }).click()
    await expect(page.getByText(/résultat/i)).toBeVisible({ timeout: 15_000 })
    const link = page.getByRole('link', { name: /\[DÉMO\]/ }).first()
    await link.click()
    await expect(page.getByRole('heading', { level: 1 })).toBeVisible()
    await expect(page.getByRole('button', { name: 'Partager' })).toBeVisible()
  })

  test('télécharge un ICS', async ({ page, request }) => {
    await page.goto('/')
    const link = page.getByRole('link', { name: /\[DÉMO\]/ }).first()
    await link.click()
    await expect(page.getByRole('heading', { level: 1 })).toBeVisible()
    const href = await page.locator('a[href*="/calendar"]').first().getAttribute('href')
    expect(href).toBeTruthy()
    const res = await request.get(href!)
    expect(res.ok()).toBeTruthy()
    const body = await res.text()
    expect(body).toContain('BEGIN:VCALENDAR')
    expect(body).toContain('BEGIN:VEVENT')
  })

  test('proposer une manifestation (mock e-mail)', async ({ page }) => {
    await page.goto('/proposer')
    await page.locator('#title').fill('Manifestation test E2E locale')
    await page.locator('#description').fill('Description suffisamment longue pour passer la validation du formulaire de proposition.')
    await page.locator('#city').fill('Dijon')
    await page.locator('#location').fill('Place de la Libération')
    await page.locator('#date').fill('2027-06-01')
    await page.locator('#start').fill('14:00')
    await page.locator('#email').fill('e2e@example.com')
    await page.getByRole('button', { name: 'Envoyer la proposition' }).click()
    await expect(page.getByText(/Vérifiez votre e-mail/i)).toBeVisible({ timeout: 15_000 })
  })

  test('admin refuse sans session', async ({ request }) => {
    const res = await request.get('/api/admin/dashboard')
    expect(res.status()).toBe(401)
  })

  test('admin login et modération', async ({ page }) => {
    await page.goto('/admin')
    await page.locator('#admin-email').fill('contact@manif.info')
    await page.locator('#admin-password').fill('dev-admin-change-me')
    await page.getByRole('button', { name: 'Se connecter' }).click()
    await expect(page.getByRole('heading', { name: 'Tableau de bord' })).toBeVisible({ timeout: 15_000 })
  })

  test('soutien et participation si activés', async ({ page }) => {
    await page.goto('/')
    const link = page.getByRole('link', { name: /Bellecour|climat|Grand Place|Réunion|Capitole/i }).first()
    await expect(link).toBeVisible({ timeout: 15_000 })
    await link.click()
    const consent = page.getByRole('checkbox')
    if (await consent.isVisible()) {
      await consent.check()
    }
    const supportBtn = page.getByRole('button', { name: 'Je soutiens le mouvement' })
    await expect(supportBtn).toBeVisible({ timeout: 10_000 })
    await supportBtn.click()
    await expect(page.getByRole('button', { name: /Soutien enregistré/ })).toBeVisible({ timeout: 10_000 })

    const participateBtn = page.getByRole('button', { name: /Je vais participer|Je participe/ })
    if (await participateBtn.isVisible()) {
      await participateBtn.click()
      await expect(page.getByRole('button', { name: /Participation déclarée/ })).toBeVisible({ timeout: 10_000 })
    }
  })
})


