# Revue de confidentialité — Manif'

**Statut produit (MVP) :** collecte d’engagements (soutiens + participations déclarées) **activée**
par décision de l’éditeur (`NUXT_PUBLIC_PARTICIPATION_ENABLED=true`), avec consentement informatif
avant déclaration.

**Ce document ne constitue pas une certification de conformité RGPD.**
Une validation par juriste / DPO reste recommandée avant une audience large.

## Décisions produit retenues

| Sujet | Décision MVP |
|---|---|
| Base participation | Consentement (case à cocher avant 1ʳᵉ déclaration) |
| Compte participant | Aucun |
| Suivi transversal | Aucun (jeton scoped événement) |
| IP dans engagements | Non |
| Activation | Flag env `PARTICIPATION_ENABLED` |
| Éditeur | Manif' — contact@manif.info |

## Traitements

| Traitement | Finalité | Données | Base (MVP) |
|---|---|---|---|
| Consultation agenda | Information | Logs techniques minimaux | Intérêt légitime |
| Proposition d'événement | Modération | Contenu + e-mail proposant | Intérêt légitime / mesures précontractuelles |
| Vérification e-mail | Anti-abus | E-mail + jeton hashé | Nécessité du traitement |
| Soutien / participation | Comptage citoyen | Empreinte jeton, timestamps, kind | Consentement |
| Signalements | Qualité éditoriale | Motif + texte | Intérêt légitime |
| Auth admin | Sécurité | Identifiants admin | Intérêt légitime |

## Sous-traitants

- Supabase (PostgreSQL, Auth)
- Hébergeur SSR du déploiement (à nommer précisément au go-live)
- Resend (si configuré)
- Cloudflare Turnstile
- Tuiles cartographiques (OpenFreeMap / OSM)

## Durées (opérationnelles)

- Propositions refusées : 90 jours
- E-mails proposants après publication : 12 mois max
- Engagements individuels : purge / agrégation ~30 jours après clôture
- Signalements : 12 mois
- Audit admin : 24 mois

## Risques résiduels acceptés pour le MVP

1. Art. 9 potentiel (opinions) — atténué par consentement + minimisation, non éliminé
2. Pseudonymisation ≠ anonymisation
3. Corrélation navigateur / foyer
4. Adresse postale éditeur encore « sur demande » — à compléter pour une publication institutionnelle

## Checklist (suivi)

- [x] Information claire avant déclaration (UI)
- [x] Consentement explicite (case à cocher)
- [x] Retrait / effacement (UI + API erase)
- [x] Page confidentialité + contact
- [x] Mentions légales renseignées (provisoires)
- [ ] Revue juriste externe (recommandée)
- [ ] AIPD formelle si audience significative
- [ ] Adresse postale éditeur complète
- [ ] Hébergeur SSR nommé précisément après choix d’hébergement
