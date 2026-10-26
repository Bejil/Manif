/**
 * Méta titles / descriptions — une entrée par page publique.
 * Ton : clair, crédible, sans sur-optimisation.
 */
export const SEO = {
  home: {
    title: "Manif' — Toutes les manifestations. Toutes les voix.",
    description:
      "Consultez la carte des manifestations en France, trouvez les informations pratiques et déclarez votre soutien ou votre participation, sans créer de compte.",
  },
  proposer: {
    title: "Proposer une manifestation — Manif'",
    description:
      "Ajoutez une manifestation pacifique à l'agenda Manif'. Vérification par e-mail, modération humaine, publication sans compte public.",
  },
  guide: {
    title: "Guide du manifestant — Conseils pratiques | Manif'",
    description:
      "Préparez votre journée de manifestation : trajet, équipement, respect et numéros d'urgence. Guide pratique, pas un conseil juridique.",
  },
  aPropos: {
    title: "À propos de Manif' — Plateforme citoyenne indépendante",
    description:
      "Toutes les manifestations. Toutes les voix. Manif' est un outil neutre pour découvrir, localiser et compter les manifestations en France — sans compte public.",
  },
  comptage: {
    title: "Comment fonctionne le comptage citoyen — Manif'",
    description:
      "Soutiens et participations déclarées : deux indicateurs volontaires, indépendants, transparents. Pas un comptage officiel de foule.",
  },
  faq: {
    title: "FAQ — Questions fréquentes | Manif'",
    description:
      "Compte, neutralité, confidentialité, proposition d'événement, comptage citoyen : les réponses utiles pour utiliser Manif'.",
  },
  soutenir: {
    title: "Soutenir Manif' — Financer un outil citoyen gratuit",
    description:
      "Manif' reste gratuit pour tous. Un don volontaire aide à faire vivre le service, sans contrepartie ni favoritisme.",
  },
  contact: {
    title: "Contact et signalement — Manif'",
    description:
      "Une question, une erreur sur une fiche, une demande relative à vos données ? Contactez l'équipe Manif'.",
  },
  confidentialite: {
    title: "Confidentialité — Manif'",
    description:
      "Comment Manif' traite vos données : minimisation, pas de compte public, pas de tracking publicitaire, droits d'accès et d'effacement.",
  },
  mentions: {
    title: "Mentions légales — Manif'",
    description: "Éditeur, hébergeur et informations légales du service Manif'.",
  },
} as const

export const FAQ_ITEMS = [
  {
    q: 'Faut-il créer un compte pour utiliser Manif\' ?',
    a: 'Non. Vous consultez l\'agenda, soutenez une cause ou déclarez une participation sans inscription. Seule la proposition d\'un événement demande un e-mail de vérification, jamais publié.',
  },
  {
    q: 'Manif\' est-il politiquement engagé ?',
    a: 'Non. Manif\' est un outil d\'information neutre. Nous n\'approuvons ni ne condamnons les revendications légales affichées. Toute manifestation pacifique et licite peut être proposée, puis examinée avant publication.',
  },
  {
    q: 'Comment sont choisis les événements publiés ?',
    a: 'Chaque proposition est vérifiée par e-mail puis modérée manuellement. Nous privilégions la clarté des informations (lieu, horaire, source) et le caractère pacifique et licite du rassemblement.',
  },
  {
    q: 'Que mesurent les compteurs « Soutiens » et « Participations déclarées » ?',
    a: 'Ce sont des déclarations volontaires, indépendantes. Un soutien n\'implique pas une présence ; une participation déclarée n\'est pas un comptage officiel de la foule. Les deux ne doivent pas être additionnés.',
  },
  {
    q: 'Mes données sont-elles anonymes ?',
    a: 'Nous minimisons les données et n\'ouvrons pas de compte public. Un jeton local par manifestation limite les doublons, sans profil transversal. L\'absence de nom ne garantit pas un anonymat juridique complet — voir la page Confidentialité.',
  },
  {
    q: 'Puis-je retirer mon soutien ou ma participation ?',
    a: 'Oui. Vous pouvez annuler chaque action séparément depuis la fiche. Vous pouvez aussi demander l\'effacement de vos déclarations pour cet événement.',
  },
  {
    q: 'Comment proposer une manifestation ?',
    a: 'Rendez-vous sur « Proposer », renseignez les informations essentielles, confirmez votre e-mail sous 24 h. Après examen, la fiche pourra être publiée sur l\'agenda et la carte.',
  },
  {
    q: 'Manif\' est-il gratuit ? Y a-t-il de la publicité ?',
    a: 'Oui, le service est gratuit. Aucune publicité ciblée, aucune monétisation des données personnelles. Les dons volontaires aident au fonctionnement, sans avantage fonctionnel.',
  },
] as const
