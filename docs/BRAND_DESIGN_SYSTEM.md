# Manif' — Identité & design system

**Version :** 2.0 (kit charte 25 oct. 2026)  
**Sources de vérité :** `manif_charte_graphique_design_system/MANIF_CHARTE_GRAPHIQUE_DESIGN_SYSTEM.md` + `manif.tokens.css`  
**Maquette visuelle :** `manif_styleguide.html` (référence, non intégrée en iframe)

## Concept

**L’affiche devient une interface.** Typographie monumentale (Anton), bandeaux colorés, contrastes marqués, compositions éditoriales — sans sacrifier lisibilité ni ergonomie produit.

**Signature :** Toutes les manifestations. Toutes les voix.

**Neutralité :** violet et rouge sont des codes de marque, jamais des marqueurs politiques ou religieux.

## Tokens

Fichier applicatif : `app/assets/css/manif.tokens.css` (importé dans `main.css`).

| Token | Hex | Usage |
|---|---|---|
| `--mf-ink` | `#111111` | Texte, boutons principaux |
| `--mf-paper` | `#FFFCF4` | Fond principal |
| `--mf-violet` | `#9C6EE8` | Surlignages, accents identité |
| `--mf-violet-deep` | `#6735B6` | Boutons violet, liens |
| `--mf-red` | `#D1271C` | Dates, « en cours », CTA participation |
| `--mf-gray-*` | … | Surfaces, bordures, textes secondaires |

Tailwind (`tailwind.config.js`) : `ink`, `paper`, `violet`, `red` + alias legacy `night`/`coral`/`mist` pour transition.

## Typographie

| Rôle | Famille | Règle |
|---|---|---|
| Display | **Anton** | Titres monumentaux, capitales via `.mf-display` / `.font-display` |
| Interface | **Inter** | Corps, formulaires, UI |

Classes utilitaires : `.mf-h1` / `.mf-h2` / `.mf-h3`, `.mf-strip`, `.mf-count`.

Ne pas utiliser Anton pour paragraphes, formulaires ou textes longs.

## Logo & assets

| Fichier | Usage |
|---|---|
| `public/brand/manif.logo.svg` | Symbole « bandeaux de voix » (violet / ivoire / rouge sur noir) |
| `public/brand/manif.icons.svg` | Sprite pictogrammes (`#mf-voices`, `#mf-map`, …) |
| `public/favicon.svg` | Favicon (= logo) |
| `public/brand/og-default.jpg` | Open Graph (1200×630) |

Composants : `<BrandLogo />`, `<BrandIcon name="support" />`, `<HighlightedText tone="violet|red" />`.

## Illustrations

Sources **unDraw** ([undraw.co](https://undraw.co)), téléchargées dans `public/illustrations/` et recolorées en `#9C6EE8`.

| Fichier | undraw | Usage |
|---|---|---|
| `hero-poster.svg` | online-community | Hero homepage |
| `hero-gathering.svg` | people | Variante |
| `discover-map.svg` | map | Section carte |
| `support.svg` | appreciate-it | Soutien |
| `participate.svg` | group-hangout | Participation |
| `share.svg` | sharing-ideas | Partage |
| `propose.svg` | forms | Proposer |
| `guide-prep.svg` | guidelines | Guide |
| `empty-events.svg` | empty | État vide |
| `error.svg` | page-not-found | Erreur |

Composant : `<ManifIllustration name="hero-poster" />`

## Composants UI

- `UiButton` — primary (noir), violet (soutien), red (participation), outline, ghost
- `StatusBadge` — À venir (violet wash) / En cours (rouge wash) / …
- `EventCard` — barre violette, date rouge, compteurs séparés
- `EventFilters` — recherche + filtres statut / catégorie
- `ParticipationPanel` — double compteur + actions indépendantes
- `EmptyState`, formulaires `UiInput` / `UiTextarea` / `UiSelect`

## Cartographie

- À venir : `#9C6EE8`
- En cours : `#D1271C`
- Terminée : `#636363`
- Clusters : noir `#111111` + trait ivoire

La couleur ne code jamais une opinion politique.

## Règles métier préservées

- Soutien ≠ participation ; libellés « Je soutiens le mouvement » / « Je vais participer » / « Je participe »
- Compteurs jamais additionnés ni présentés comme présence vérifiée
- Participation fermée après la fin

## Ressources manquantes / hors kit

- Aucune PNG d’aperçu (`apercu_hero_16_9.png`, etc.) dans le dossier fourni — direction reprise du MD + styleguide HTML + tokens.
- Photo immersive de foule : non intégrée (droits non confirmés). Remplacée par `hero-poster.svg`.
- Pour un hero photo ultérieur : fournir une image sous licence adaptée + attribution.

## Accessibilité

- Focus visible (`--mf-focus`)
- Contrastes AA pour textes UI
- `prefers-reduced-motion` sur animations d’entrée
- Petit texte blanc interdit sur violet clair

## Fichiers clés modifiés

- `app/assets/css/manif.tokens.css`, `main.css`, `tailwind.config.js`, `nuxt.config.ts`
- `app/components/brand/*`, `common/*`, `events/*`, `participation/*`, `map/EventsMap.vue`
- Pages publiques : `index`, `manifestations/[slug]`, `guide`, `proposer`, `faq`, `comptage`, `a-propos`, `soutenir`, `error.vue`
