# Architecture — Manif'

## Vue d'ensemble

Monolithe **Nuxt 4** (SSR + API Nitro). Pas de microservices.

```
Navigateur  →  Nuxt pages (Vue 3)  →  Nitro API  →  PostgreSQL (Supabase)
                                      ↑
                               secrets serveur uniquement
```

## Décisions

| Sujet | Choix | Motif |
|---|---|---|
| Auth admin | Supabase Auth (prod) ou HMAC+env (mock) | Solution éprouvée dès que DB réelle |
| Données | Mock store **ou** Supabase service role | Même API métier |
| Rate limit | Mémoire + Upstash Redis optionnel | Multi-instance prêt |
| OG | SVG dynamique `/api/og/event/:slug` | Partage réseaux |
| Carte | MapLibre + style OpenFreeMap configurable | Compatible, sans clé obligatoire |
| Géocodage | API Adresse (BAN) | France, gratuit, licence adaptée |
| Engagements | Feature flag `NUXT_PUBLIC_ENGAGEMENTS_ENABLED` | Soutien + participation ; blocage juridique possible |
| E-mail | Resend ou mock console | Pas de faux succès silencieux |

## Couches

- `shared/` — types, schémas Zod, règles métier pures (testables)
- `server/services/` — persistance et intégrations
- `server/api/` — HTTP, validation, rate limit, Turnstile
- `app/` — UI, pages, composables

## Sécurité

- Clé service Supabase jamais exposée au client
- RLS activée sans politiques publiques
- E-mails proposants absents des réponses publiques
- Jetons d’engagement : empreinte SHA-256 + pepper serveur (scoped événement)
- Pas d'IP dans la table `engagements`

## Limites assumées V1

- Rate limit en mémoire (remplacer par Redis en multi-instance)
- Auth admin par variables d'environnement (prévoir Supabase Auth / OIDC)
- Persistance engagements/submissions en mock et Supabase (`engagements`, migration 003)
