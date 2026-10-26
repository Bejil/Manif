# Spécification fonctionnelle (extrait opérationnel)

Voir le prompt maître pour le détail exhaustif. Ce fichier fixe le comportement livré.

## Parcours publics

1. Accueil : recherche + filtres + liste/carte synchronisées
2. Fiche : infos, partage, ICS, signalement, soutien / participation (si flag)
3. Proposer : formulaire → e-mail 24 h → file de modération
4. Guide, pages légales, soutenir, méthodologie de comptage

## Engagements (soutien + participation)

Deux actions indépendantes, sans compte, sans confirmation post-événement.

| Action | Disponibilité | Libellés |
|---|---|---|
| Soutien | Avant / pendant / après (fiche publiée) | « Je soutiens le mouvement » → « Soutien enregistré » |
| Participation | Avant et pendant uniquement | « Je vais participer » / « Je participe » |
| Retrait soutien | Toujours (tant que déclaré) | Annuler le soutien |
| Retrait participation | Tant que la période est ouverte | Annuler la participation |

### Compteurs publics

- **Soutiens** : déclarations de soutien actives
- **Participations déclarées** : déclarations avant ou pendant l’événement

Ne jamais additionner les compteurs. Ne pas utiliser « présences confirmées », « participants présents », « comptage officiel ».

Mention discrète : « Ces chiffres reposent sur des déclarations volontaires. Ils ne constituent pas un comptage officiel des personnes présentes. »

### Règles métier

- Soutenir sans participer, participer sans soutenir, les deux, ou aucun.
- Une participation anticipée reste comptabilisée après la fin ; elle n’est pas transformée en présence vérifiée.
- Annulée : soutien possible si publiée ; participation fermée.
- Reportée : soutiens conservés ; participations invalidées → reconfirmation pour la nouvelle date.

### Données

Table `engagements` : `supports_at`, `participates_at`, `participation_kind` (`planned` | `during`), unicité `(event_id, event_scoped_token_digest)`.

## Administration

Publication manuelle uniquement. Critères de modération identiques pour toutes les manifestations pacifiques et licites.

## Hors V1

Réseau social, chat, comptes publics, GPS participants, push, recommandations personnalisées.
