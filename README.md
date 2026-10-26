# Manif'

> L’agenda citoyen des manifestations en France.

Plateforme citoyenne indépendante pour découvrir les manifestations en France, les localiser sur une carte et participer à un comptage citoyen — sans compte public.

## Stack

- Nuxt 4 · Vue 3 · TypeScript · Tailwind CSS
- Nitro API · PostgreSQL (Supabase) · MapLibre GL
- Zod · Vitest · Playwright (prévu) · PWA

## Démarrage rapide

```bash
cp .env.example .env
npm install
npm run dev
```

Ouvrir [http://localhost:3000](http://localhost:3000).

Par défaut : **base mock** avec un jeu d’événements de démarrage (traités comme des données normales).

### Participation (dev)

Dans `.env` :

```
NUXT_PUBLIC_PARTICIPATION_ENABLED=true
```

En production : **laisser `false`** jusqu'à validation de `docs/PRIVACY_REVIEW.md`.

### Admin

- URL : `/admin`
- E-mail : `contact@manif.info` (ou `ADMIN_EMAIL`)
- Mot de passe : `dev-admin-change-me` si `ADMIN_PASSWORD` non défini (dev uniquement)

## Scripts

| Commande | Description |
|---|---|
| `npm run dev` | Serveur de développement |
| `npm run build` | Build production |
| `npm run preview` | Prévisualiser le build |
| `npm run test` | Tests unitaires Vitest |
| `npm run test:e2e` | Tests Playwright |

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Spécification fonctionnelle](docs/FUNCTIONAL_SPEC.md)
- [Revue confidentialité](docs/PRIVACY_REVIEW.md)
- [Déploiement](docs/DEPLOYMENT.md)
- Variables : [`.env.example`](.env.example)

## État du MVP

Voir la section « Fonctionnalités » dans le résumé de livraison du dépôt / conversation Cursor.

## Licence

À définir par l'éditeur du service.
