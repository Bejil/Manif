# Déploiement — Manif'

## Prérequis

- Node.js 22+ (LTS recommandé)
- Compte Supabase (production)
- Domaine + HTTPS
- Cloudflare Turnstile (antibot)
- (Optionnel) Resend, URL de dons

## Configuration Supabase

1. Créer un projet PostgreSQL
2. Exécuter les migrations `supabase/migrations/001` → `006` dans l’ordre (SQL Editor)
3. Optionnel : `supabase/seed.sql` (événements de démarrage — remplacer par de vraies données en prod)
4. Copier `SUPABASE_URL` + `SUPABASE_SERVICE_ROLE_KEY` dans les secrets serveur
5. Vérifier que RLS est actif et qu'aucune politique publique n'expose `engagements` / e-mails
6. Mettre `NUXT_PUBLIC_USE_MOCK_DB=false`

Dates à confirmer (`start_at` nullable) : migration `006_optional_start_at.sql`,
ou script tout-en-un `supabase/apply_006_tba.sql`.

## Variables

Voir `.env.example`. Secrets critiques :

- `SUPABASE_SERVICE_ROLE_KEY`
- `PARTICIPATION_TOKEN_PEPPER`
- `ADMIN_SESSION_SECRET`
- `ADMIN_PASSWORD` (fort)
- `RESEND_API_KEY` / Turnstile

## E-mail

1. Créer un domaine authentifié chez Resend (SPF/DKIM)
2. `EMAIL_FROM=Manif' <contact@manif.info>` (domaine `manif.info` authentifié chez Resend)
3. Sans clé : les e-mails sont journalisés en console (`[email:mock]`)

## Carte

Par défaut OpenFreeMap Liberty. Pour un autre fournisseur MapLibre-compatible :

```
NUXT_PUBLIC_MAP_STYLE_URL=...
NUXT_PUBLIC_MAP_ATTRIBUTION=...
```

Respecter les conditions d'utilisation et l'attribution.

## Géocodage

`GEOCODING_PROVIDER=ban` (API Adresse). Usage raisonnable ; pas de clé. Pour un volume élevé, prévoir un fournisseur alternatif et sa clé.

## Auth admin

- **Mode mock** (`USE_MOCK_DB=true`) : `ADMIN_EMAIL` + `ADMIN_PASSWORD` (ou `dev-admin-change-me` en dev) + cookie HMAC.
- **Mode Supabase** (`USE_MOCK_DB=false`) : login via **Supabase Auth** (`signInWithPassword`). Créer l’utilisateur dans le dashboard Auth ; restreindre avec `ADMIN_EMAIL` (ou `ADMIN_ALLOW_ANY=true`, déconseillé). Activer MFA côté Supabase recommandé en production.

## Hébergement — Vercel (recommandé)

Nuxt 4 / Nitro est détecté automatiquement : **pas de `vercel.json` requis**. Build = `nuxt build` (SSR).

### 1. Mettre le code sur GitHub

```bash
cd ~/Desktop/Manif
git init
git add .
git commit -m "Initial commit — Manif'"
# Créer un repo privé sur github.com, puis :
git remote add origin https://github.com/<toi>/manif.git
git branch -M main
git push -u origin main
```

Ne jamais committer `.env` (déjà dans `.gitignore`).

### 2. Créer le projet Vercel

1. [vercel.com/new](https://vercel.com/new) → Import du repo GitHub
2. Framework : **Nuxt** (auto)
3. Build Command : `nuxt build` (défaut) — **pas** `nuxt generate`
4. Node.js : **22.x** ou **24.x** (Settings → General → Node.js Version)
5. Deploy (le premier build peut échouer tant que les env ne sont pas là)

### 3. Variables d’environnement (Production)

Vercel → Project → **Settings → Environment Variables**. Coller au minimum :

| Variable | Valeur prod |
|---|---|
| `NUXT_PUBLIC_SITE_URL` | `https://manif.info` |
| `NUXT_PUBLIC_CONTACT_EMAIL` | `contact@manif.info` |
| `NUXT_PUBLIC_USE_MOCK_DB` | `false` |
| `NUXT_PUBLIC_ENGAGEMENTS_ENABLED` | `true` (ou `false` si pas encore validé) |
| `SUPABASE_URL` + `NUXT_SUPABASE_URL` | URL projet Supabase (les deux) |
| `SUPABASE_SERVICE_ROLE_KEY` + `NUXT_SUPABASE_SERVICE_ROLE_KEY` | **service_role** / `sb_secret_…` — jamais la clé anon |
| `PARTICIPATION_TOKEN_PEPPER` | chaîne longue aléatoire |
| `ADMIN_SESSION_SECRET` | chaîne longue aléatoire |
| `RATE_LIMIT_SALT` | chaîne aléatoire |
| `NUXT_ADMIN_EMAIL` / `ADMIN_EMAIL` | `contact@manif.info` |
| `NUXT_ADMIN_PASSWORD` / `ADMIN_PASSWORD` | mot de passe fort |
| `NUXT_PUBLIC_TURNSTILE_SITE_KEY` | site key |
| `TURNSTILE_SECRET_KEY` | secret |
| `TURNSTILE_HOSTNAMES` | `manif.info,www.manif.info` |
| `EMAIL_FROM` | `Manif' <contact@manif.info>` |
| `RESEND_API_KEY` | si e-mails activés |
| Mentions légales | `NUXT_PUBLIC_LEGAL_*` |

Puis **Redeploy** (Deployments → ⋮ → Redeploy).

### 4. Domaine `manif.info`

1. Vercel → Project → **Settings → Domains** → ajouter `manif.info` (+ `www` si voulu)
2. Chez ton registrar DNS :
   - apex : enregistrements **A** / **ALIAS** indiqués par Vercel, **ou** nameservers Vercel
   - `www` : **CNAME** → `cname.vercel-dns.com` (valeur exacte affichée dans Vercel)
3. Attendre la validation HTTPS (souvent quelques minutes)

### 5. Après le DNS

- Turnstile : domaines `manif.info` / `www.manif.info` sur le widget Cloudflare
- Resend : SPF/DKIM pour `manif.info`
- Supabase Auth : créer l’utilisateur `contact@manif.info` (login admin en mode Supabase)
- Tester : home, `/proposer`, engagement, `/admin`, signalement

### Alternative CLI

```bash
npm i -g vercel
vercel          # preview
vercel --prod   # production
```

## Hébergement — Node standalone (autre hôte)

```bash
npm ci
npm run build
node .output/server/index.mjs
```

## Domaine

- Site : `https://manif.info` (`NUXT_PUBLIC_SITE_URL`)
- Contact / admin : `contact@manif.info`
- Turnstile : ajouter `manif.info` (et `www` si utilisé) aux domaines du widget Cloudflare
- En prod : `TURNSTILE_HOSTNAMES=manif.info,www.manif.info` (sans localhost)

## Checklist go-live

- [ ] DNS `manif.info` → hébergeur + HTTPS
- [ ] Mentions légales complètes
- [ ] `PRIVACY_REVIEW.md` validé
- [ ] `PARTICIPATION_ENABLED=false` sauf validation
- [ ] Seed de démarrage remplacé ou vidé
- [ ] Turnstile actif (domaine `manif.info` enregistré)
- [ ] Resend : domaine `manif.info` (SPF/DKIM) + `EMAIL_FROM`
- [ ] Rate limits adaptés (Redis si multi-instance)
- [ ] Sauvegarde PostgreSQL
- [ ] Monitoring erreurs serveur
