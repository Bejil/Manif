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
  manifestations: {
    title: "Manifestations — Agenda et carte | Manif'",
    description:
      "Recherchez et filtrez les manifestations en France : liste synchronisée avec la carte, informations pratiques, soutien et participation sans compte.",
  },
  mesManifestations: {
    title: "Mes manifestations — Soutiens et participations | Manif'",
    description:
      "Retrouvez sur cet appareil les manifestations que vous soutenez ou auxquelles vous participez. Filtrez et triez sans compte.",
  },
  proposer: {
    title: "Proposer une manifestation — Manif'",
    description:
      "Ajoutez une manifestation pacifique à l'agenda Manif'. Vérification par e-mail, modération humaine, publication sans compte public.",
  },
  guide: {
    title: "Guide du manifestant — Préparer une manifestation en France | Manif'",
    description:
      "Comment préparer une journée de manifestation : trajet, équipement, respect, droits, urgences et bons réflexes. Guide pratique Manif', sans conseil juridique.",
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
    title: "FAQ Manif' — Agenda des manifestations, compte, confidentialité",
    description:
      "Comment utiliser Manif' : trouver une manifestation en France, proposer un événement, comptage citoyen, confidentialité, neutralité et signalement. Réponses claires.",
  },
  soutenir: {
    title: "Soutenir Manif' — Contribuer à un projet citoyen indépendant",
    description:
      "Découvrez comment contribuer au développement et au fonctionnement de Manif', une plateforme indépendante pour découvrir et partager les manifestations en France.",
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

/**
 * FAQ publique (page /faq + extrait accueil + JSON-LD FAQPage).
 * Réponses en prose naturelle, orientées questions réelles / SEO.
 * Séparer les paragraphes avec \\n\\n.
 */
export const FAQ_ITEMS = [
  {
    q: 'Faut-il créer un compte pour utiliser Manif\' ?',
    a: 'Non. Manif\' est conçu pour être consulté sans inscription ni profil public. Vous pouvez parcourir l\'agenda des manifestations en France, ouvrir une fiche, localiser un rassemblement sur la carte et lire les informations pratiques sans créer de compte.\n\nVous pouvez aussi indiquer un soutien ou une participation déclarée depuis une fiche, toujours sans inscription. Seule la proposition d\'un nouvel événement demande un e-mail de vérification : il sert uniquement à confirmer que la proposition est sérieuse, et il n\'est jamais affiché publiquement.',
  },
  {
    q: 'Manif\' est-il politiquement engagé ?',
    a: 'Non. Manif\' est un outil d\'information citoyen, indépendant et neutre. Notre rôle est de rendre visibles des manifestations pacifiques et licites, pas d\'approuver ni de condamner les revendications affichées.\n\nToute cause légale peut être proposée, à condition que le rassemblement soit présenté comme pacifique et que les informations essentielles (lieu, horaire, source) soient suffisamment claires pour la modération. La publication n\'équivaut jamais à un soutien éditorial de Manif\'.',
  },
  {
    q: 'Comment trouver une manifestation près de chez soi ?',
    a: 'Depuis la page d\'accueil de Manif\', vous consultez l\'agenda des prochaines manifestations et la carte interactive. Filtrez par ville, date ou thématique pour repérer un rassemblement à proximité, puis ouvrez la fiche pour le lieu de rendez-vous, l\'horaire, l\'organisateur et le lien vers la source.\n\nLes informations sont mises à jour au fur et à mesure des publications et des corrections. Avant de vous déplacer, vérifiez toujours la fiche et, si possible, la communication de l\'organisateur : un parcours ou une heure peut encore évoluer.',
  },
  {
    q: 'Comment sont choisis les événements publiés ?',
    a: 'Chaque proposition passe d\'abord par une vérification d\'e-mail, puis par une modération humaine. Nous regardons la clarté des informations (titre, description, ville, lieu, date et heure, source) et le caractère pacifique et licite du rassemblement annoncé.\n\nManif\' n\'est pas un annuaire exhaustif de toutes les mobilisations en France : nous publions ce qui a été proposé et validé. Si une fiche est incomplète, erronée ou hors cadre, elle peut être refusée, corrigée ou retirée après signalement.',
  },
  {
    q: 'Que mesurent les compteurs « Soutiens » et « Participations déclarées » ?',
    a: 'Ce sont deux indicateurs citoyens volontaires, affichés séparément sur chaque fiche. Un « soutien » signifie que vous approuvez la cause ou l\'appel, sans nécessairement être présent le jour J. Une « participation déclarée » indique votre intention d\'être là, ou votre présence, selon ce que vous choisissez de déclarer.\n\nCes compteurs ne remplacent ni un comptage officiel de foule, ni une estimation médiatique, ni les chiffres des organisateurs ou des autorités. Ils ne doivent pas être additionnés : ce sont deux gestes distincts, utiles pour donner un ordre de grandeur de l\'intérêt citoyen autour d\'un événement.',
  },
  {
    q: 'Mes données sont-elles anonymes ?',
    a: 'Manif\' minimise les données collectées et n\'ouvre pas de compte public : pas de profil visible, pas de fil d\'activité, pas de réseau social. Pour limiter les doublons de soutien ou de participation, un jeton local lié à la manifestation peut être utilisé sur votre appareil, sans constituer un profil transversal entre tous les événements.\n\nL\'absence de nom affiché n\'équivaut pas à un anonymat juridique absolu. Selon le contexte (connexion, appareil, signalement, obligation légale), certaines données techniques peuvent exister côté hébergeur ou service. Le détail figure sur la page Confidentialité, avec vos droits d\'accès et d\'effacement.',
  },
  {
    q: 'Puis-je retirer mon soutien ou ma participation ?',
    a: 'Oui. Depuis la fiche de la manifestation concernée, vous pouvez annuler séparément votre soutien et votre participation déclarée. Chaque action est indépendante : retirer l\'une ne retire pas automatiquement l\'autre.\n\nVous pouvez aussi demander l\'effacement de vos déclarations pour cet événement via le parcours prévu sur la fiche ou en contactant l\'équipe. L\'objectif est de garder le contrôle sur un geste volontaire, sans parcours de compte compliqué.',
  },
  {
    q: 'Comment proposer une manifestation sur Manif\' ?',
    a: 'Ouvrez la page « Proposer », puis renseignez les informations essentielles : titre, description, catégorie, ville, lieu de rendez-vous, date et heure de début, et si possible une source (site, tract, réseau de l\'organisateur). Plus la fiche est précise, plus la modération est rapide.\n\nConfirmez ensuite votre e-mail sous 24 heures. Après examen, la manifestation pourra apparaître dans l\'agenda et sur la carte. Vous n\'avez pas besoin d\'un compte public pour suivre la suite : l\'e-mail sert à la vérification et, le cas échéant, aux échanges de modération.',
  },
  {
    q: 'Qui peut proposer une manifestation ? Faut-il être organisateur ?',
    a: 'Toute personne peut proposer un événement, qu\'elle soit organisatrice, relais local ou simple citoyenne disposant d\'informations fiables. L\'important est de fournir des éléments vérifiables et de ne pas inventer un lieu, une date ou une affiliation.\n\nSi vous n\'êtes pas l\'organisateur, indiquez clairement la source et évitez de présenter Manif\' comme le canal officiel du cortège. La modération peut demander une précision ou refuser une proposition trop floue, trompeuse ou non pacifique.',
  },
  {
    q: 'Manif\' couvre-t-il toute la France ?',
    a: 'Oui, Manif\' est pensé pour l\'ensemble du territoire français : grandes villes, communes et mobilisations locales. L\'agenda et la carte permettent de repérer des manifestations à Paris comme ailleurs, dès lors qu\'elles ont été proposées et publiées.\n\nLa densité des fiches dépend des contributions. Si votre ville manque d\'événements, vous pouvez en proposer un ou partager Manif\' auprès des collectifs qui organisent des rassemblements pacifiques.',
  },
  {
    q: 'Quelle est la différence entre Manif\' et les réseaux sociaux ?',
    a: 'Les réseaux sociaux mélangent souvent appels, commentaires, publicités et algorithmes. Manif\' se concentre sur un agenda structuré : date, lieu, carte, informations pratiques et indicateurs citoyens, avec une modération avant publication.\n\nL\'objectif n\'est pas de remplacer les pages d\'organisateurs, mais de faciliter la découverte et le repérage géographique des manifestations, sans créer de compte public ni de fil d\'actualité personnalisé.',
  },
  {
    q: 'Comment signaler une erreur, une fiche obsolète ou un contenu problématique ?',
    a: 'Sur une fiche publiée, utilisez le parcours de signalement prévu pour indiquer une erreur de lieu ou d\'horaire, une manifestation annulée ou reportée, une information trompeuse, ou un contenu hors cadre. Vous pouvez aussi écrire via la page Contact.\n\nLes signalements aident à maintenir un agenda fiable. Selon le cas, la fiche pourra être corrigée, reportée, annulée, dépubliée ou retirée après examen.',
  },
  {
    q: 'Manif\' est-il gratuit ? Y a-t-il de la publicité ?',
    a: 'Oui, consulter l\'agenda, proposer un événement et utiliser les compteurs citoyens est gratuit. Manif\' ne diffuse pas de publicité ciblée et ne monétise pas vos données personnelles.\n\nLe service peut être soutenu par des dons volontaires. Un don n\'achète ni mise en avant d\'événement, ni traitement prioritaire de modération, ni avantage éditorial : il contribue uniquement au fonctionnement de l\'outil.',
  },
  {
    q: 'Les informations d\'une fiche sont-elles officielles ?',
    a: 'Non. Manif\' republie et structure des informations proposées puis modérées, à titre informatif. La source de l\'appel (organisateur, collectif, page publique) reste la référence pour le parcours définitif, les consignes de sécurité et les éventuels changements de dernière minute.\n\nQuand une URL source est disponible sur la fiche, consultez-la avant de vous déplacer. En cas de doute entre deux horaires ou deux lieux, privilégiez la communication la plus récente de l\'organisateur.',
  },
  {
    q: 'Puis-je utiliser Manif\' sur mobile ?',
    a: 'Oui. Le site est conçu pour être lu sur téléphone comme sur ordinateur : liste des manifestations, fiche détaillée, carte et actions de soutien ou de participation. Vous pouvez aussi enregistrer la page ou partager un lien de fiche pour la faire circuler.\n\nAucun téléchargement d\'application n\'est obligatoire pour consulter l\'agenda. L\'essentiel reste accessible depuis le navigateur, sans créer de compte.',
  },
] as const
