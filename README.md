# Manif'

> **Toutes les manifestations. Toutes les voix.**

L’agenda citoyen des manifestations en France — neutre, sans compte public, sans publicité ciblée.

Site : [manif.info](https://manif.info)

---

## Vision produit

Manif' est un **outil d’information citoyen** pour découvrir, localiser et suivre les manifestations pacifiques et licites en France (métropole et outre-mer).

Il répond à un besoin simple : les appels à manifester sont dispersés (réseaux sociaux, sites d’organisateurs, agendas locaux). Manif' les rassemble dans un **agenda structuré** (date, lieu, carte, infos pratiques) avec une **modération humaine** avant publication.

### Principes

| Principe | Engagement |
|---|---|
| **Neutralité** | Ouvert à toute cause légale et pacifique. Publier ≠ soutenir éditorialement. |
| **Sans compte public** | Consulter, soutenir, déclarer une participation : pas d’inscription ni de profil. |
| **Sobriété des données** | Pas de tracking pub, pas de réseau social, pas de profil transversal entre événements. |
| **Transparence** | Les compteurs sont des *déclarations volontaires*, jamais un recensement officiel. |
| **Gratuité** | Le service reste accessible à toutes et tous. |

### Ce que Manif' n’est pas

- Ni un réseau social, ni un chat
- Ni une alerte d’incidents en temps réel
- Ni un comptage physique de foule ou un dispositif officiel

---

## Démarche

1. **Agenda + carte** — une fiche claire (lieu, horaire, source) et une carte lisible.
2. **Contribution encadrée** — proposition publique → vérification e-mail → modération humaine → publication.
3. **Engagement léger** — soutien et participation déclarée, indépendants, annulables, sans compte.
4. **Agrégation multi-sources** — imports automatisés (AMI, Démosphère, Manifs.fr, ManifRadar, Mobilizon XR) + propositions citoyennes.
5. **Alertes de proximité** — e-mail optionnel (double opt-in) quand une nouvelle manif est publiée près de soi.
6. **Indépendance** — financement citoyen (Ko-fi), stack ouverte, docs de déploiement et confidentialité.

---

## Fonctionnalités

### Public

- **Accueil** — carte interactive (MapLibre), suggestions (personnalisées si engagements locaux, sinon prochaines manifs), inscription alertes, blocs soutien / participation
- **Agenda** (`/manifestations`) — recherche manuelle (localisation + catégorie + bouton Rechercher), **uniquement en cours / à venir**, tri date ou thème, modes liste / agenda / carte, liens **Villes populaires**
- **Pages villes** (`/manifestations/ville/[slug]`) — piliers SEO locaux (ex. manifestations à Paris)
- **Fiche événement** — infos, médias, partage, export ICS, signalement, soutien / participation ; points **en cours** avec pulse radar sur la carte
- **Mes manifestations** — soutiens et participations de *cet appareil* (jeton local)
- **Proposer** — formulaire + confirmation e-mail (24 h) + modération
- **Guide du manifestant** — repères pratiques (pas un conseil juridique)
- **Alertes e-mail** — inscription (lieu BAN + rayon km), double opt-in, digest après l’import quotidien
- **Pages** — à propos, FAQ, comptage / méthodologie, soutenir, contact, mentions, confidentialité

### Engagements (sans compte)

| Action | Règle |
|---|---|
| **Je soutiens** | Avant / pendant / après (fiche publiée) |
| **Je participe** | Avant et pendant uniquement |
| Retrait | Indépendant pour chaque action |
| Antibot | Turnstile à l’engagement ; pas au simple retrait |

Compteurs publics : **soutiens** et **participations déclarées** — jamais additionnés, jamais présentés comme présence réelle.

### Administration (`/admin`)

- Tableau de bord (propositions, événements, signalements, alertes)
- **Événements** — liste, édition, publication / dépublication, suppression, actions groupées, tri date / thème
- **Imports multi-sources** — scrape → préparation (géocode BAN) → écriture (brouillons ou publication auto) ; file = candidats encore en brouillon / dépubliés
- **Propositions** — modération, modifications demandées, historique
- **Alertes e-mail** — suivi des abonnements (actifs / en attente / désinscrits), suppression
- **Signalements** — traitement des remontées publiques

### Technique & ops

- Cron quotidien **06:00 UTC** (≈ 08h Paris en heure d’été) : import puis digests d’alertes
- Géocodage **BAN** (api-adresse.data.gouv.fr)
- E-mails **Resend** (ou mock console en dev)
- Antibot **Cloudflare Turnstile**
- Carte **MapLibre** + tuiles OpenFreeMap (configurable)
- Variables : voir [`.env.example`](.env.example)

---

## SEO & référencement

Objectif : indexation claire des fiches et des intentions locales (« manifestation + ville »).

| Élément | Détail |
|---|---|
| **Meta & canonicals** | `useSiteSeo` sur les pages publiques (title, description, OG/Twitter, `rel=canonical` absolus) |
| **OG images** | Défaut JPEG 1200×630 (`/brand/og-default.jpg`) ; fiches en **PNG** via `/api/og/event/:slug` (sharp) — compatible Facebook / LinkedIn |
| **JSON-LD** | `Organization` + `WebSite` (SearchAction) en layout ; `Event` + `BreadcrumbList` sur chaque fiche ; `FAQPage` sur `/faq` |
| **Sitemap** | `/sitemap.xml` — pages statiques, **pages villes**, fiches publiées (`lastmod`, `priority`) |
| **robots.txt** | Dynamique (`/robots.txt`) — `Disallow` admin / espaces privés ; `Sitemap:` en URL absolue |
| **Pages villes** | `/manifestations/ville/[slug]` + maillage (footer, moteur de recherche « Villes populaires », liens depuis fiches / cartes) |
| **Contenu indexable** | Agenda public limité aux événements **en cours / à venir** ; admin et « mes manifestations » en `noindex` |

Après déploiement : soumettre le sitemap dans [Google Search Console](https://search.google.com/search-console), tester une fiche (Rich Results) et un partage LinkedIn/Facebook.

---

## Stack

- **Nuxt 4** · Vue 3 · TypeScript · Tailwind CSS
- **Nitro** API · **PostgreSQL** (Supabase, service role)
- **MapLibre GL** · Zod · Luxon · sharp (OG PNG)
- **Vitest** · Playwright

Monolithe SSR : pas de microservices. Couches `shared/` (règles pures), `server/` (API + services), `app/` (UI).

---

## Démarrage rapide

```bash
cp .env.example .env
npm install
npm run dev
```

Ouvrir [http://localhost:3000](http://localhost:3000).

Par défaut : **base mock** avec un jeu d’événements de démarrage.

### Admin (dev)

- URL : `/admin`
- E-mail : `ADMIN_EMAIL` / `contact@manif.info`
- Mot de passe : `ADMIN_PASSWORD` ou `dev-admin-change-me` en local

### Production (aperçu)

1. Migrations Supabase `001` → `012` (voir `supabase/migrations/` et `apply_*.sql`)
2. Variables : [`.env.example`](.env.example) + [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)
3. `NUXT_PUBLIC_USE_MOCK_DB=false`, `CRON_SECRET`, Resend, Turnstile, Ko-fi optionnel
4. `NUXT_PUBLIC_SITE_URL=https://manif.info` (canonicals, sitemap, OG)

---

## Scripts

| Commande | Description |
|---|---|
| `npm run dev` | Serveur de développement |
| `npm run build` | Build production |
| `npm run preview` | Prévisualiser le build |
| `npm run test` | Tests unitaires Vitest |
| `npm run test:e2e` | Tests Playwright |

---

## Documentation

| Doc | Contenu |
|---|---|
| [Architecture](docs/ARCHITECTURE.md) | Décisions techniques, couches, sécurité |
| [Spécification fonctionnelle](docs/FUNCTIONAL_SPEC.md) | Parcours et règles métier |
| [Déploiement](docs/DEPLOYMENT.md) | Vercel, Supabase, crons |
| [Confidentialité](docs/PRIVACY_REVIEW.md) | Revue données / engagements |
| [Design system](docs/BRAND_DESIGN_SYSTEM.md) | Identité visuelle |
| [Ko-fi](docs/KOFI.md) | Soutien financier |
| [État](docs/STATUS.md) | Statut MVP |

---

## Licence

À définir par l’éditeur du service (Manif' — contact@manif.info).
