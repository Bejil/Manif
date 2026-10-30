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

- **Accueil** — carte interactive (MapLibre), suggestions (personnalisées si engagements locaux, sinon prochaines manifs), blocs d’explication soutien / participation
- **Agenda** (`/manifestations`) — liste filtrable (ville, date, statut, catégorie), synchronisée avec la carte
- **Fiche événement** — infos, médias, partage, export ICS, signalement, soutien / participation
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
- **Événements** — liste, édition, publication / dépublication, suppression, actions groupées
- **Imports multi-sources** — scrape → préparation (géocode BAN) → écriture (brouillons ou publication auto)
- **Propositions** — modération, modifications demandées, historique
- **Alertes e-mail** — suivi des abonnements (actifs / en attente / désinscrits), suppression
- **Signalements** — traitement des remontées publiques

### Technique & ops

- Cron quotidien **06:00 UTC** (≈ 07h Paris en hiver) : import puis digests d’alertes
- Géocodage **BAN** (api-adresse.data.gouv.fr)
- E-mails **Resend** (ou mock console en dev)
- Antibot **Cloudflare Turnstile**
- Carte **MapLibre** + tuiles OpenFreeMap (configurable)

---

## Stack

- **Nuxt 4** · Vue 3 · TypeScript · Tailwind CSS
- **Nitro** API · **PostgreSQL** (Supabase, service role)
- **MapLibre GL** · Zod · Vitest · Playwright (prévu)

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
