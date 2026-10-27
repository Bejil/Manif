# Configurer Ko-fi (contributions)

Manif' charge le **widget flottant officiel Ko-fi** (`overlay-widget.js`)
et propose des liens vers `/soutenir`.

## Variables

```bash
NUXT_PUBLIC_KOFI_USERNAME=manif
NUXT_PUBLIC_KOFI_AMOUNTS=1,5,10
```

Sans username / URL valide : pas de widget, boutons désactivés sur `/soutenir`.

`NUXT_PUBLIC_KOFI_AMOUNTS` sert aux suggestions affichées sur `/soutenir`
(1 / 5 / 10 € par défaut). Les montants du panneau Ko-fi se règlent
dans le compte Ko-fi.

## Côté compte Ko-fi (recommandé)

1. Ko-fi → **Settings → Payment**
2. Mode **Tip** (plutôt que « Buy me a coffee » seul)
3. Définir le prix unitaire / les suggestions de montants à **1, 5 et 10**
4. Devise **EUR**

Le « placeholder 5 € » vient souvent du **prix unitaire café** encore à 5 €
dans Payment Settings — à baisser à 1 € si besoin.

## Identité

```bash
NUXT_PUBLIC_LEGAL_EDITOR_NAME=Prénom Nom
```

## Ce que Manif' ne fait pas

- Pas d’API / webhook / table de paiements
- Pas de collecte de données bancaires
- Pas de lien entre un paiement et un soutien / une participation citoyenne
