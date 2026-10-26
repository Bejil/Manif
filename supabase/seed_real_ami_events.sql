-- Manif' — événements RÉELS issus de agendamilitant.org (Île-de-France)
-- Généré le 2026-10-26T22:14:35.303736+01:00 — horizon 60 jours — 44 événements
-- Descriptions factuelles + lien source. Vérifiez les conditions de réutilisation AMI.
-- Idempotent partiel : ignore si slug déjà présent.

DELETE FROM events WHERE slug LIKE 'ami-%' AND source_url LIKE 'https://www.agendamilitant.org/%';

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'e6bdb22c-7d53-4dd3-b1d4-7631303f111c',
  'ami-attentat-raciste-a-trappes-appel-a-rassemblement-2026-10-26-2',
  'Attentat raciste à Trappes. Appel à rassemblement',
  'A 18h place de la République ce lundi 26 octobre à Paris, et dans toutes les villes de France ! Macron, après son beau discours sur la nécessité de lutter contre le racisme, ne va tout de même pas interdire ce rassemblement ? Texte de l''appel unitaire Voir aussi Europalestine',
  'droits',
  'Paris',
  '75010',
  'FR', 'Europe/Paris',
  'Place de la République (Paris)',
  NULL, NULL, NULL,
  '2026-10-26T17:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Attentat-raciste-a-Trappes-Appel-a-rassemblement.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9c938d4a-9bc1-4dbe-892a-2d0542017b31',
  'ami-excuser-ou-punir-rencontre-avec-amelie-bescont-2026-10-26-3',
  'Excuser ou punir. Rencontre avec Amélie Bescont',
  'À partir de l''analyse d''une série de controverses scientifiques qui, depuis la naissance de la pénalité libérale, ont marqué la réflexion portant sur le sort des femmes justiciables, cet ouvrage réinterroge les principaux arguments qui ont légitimé le traitement différentiel de leurs illégalismes. A l''aune d''une perspective féministe et intersectionnelle, il revient sur les réponses que les savoirs sur le crime produits depuis lors ont apporté aux interrogations suivantes : les femmes constituent-elles des sujets pénaux comme les autres ? Dans quelle mesure peuvent-elles être reconnues responsables de leurs crimes ? Quelle incidence les caractéristiques associées à leur sexe, à leur genre, mais aussi à leur ethnicité, leur classe sociale, leur âge ou leur orientation sexuelle, doivent-elles avoir sur la nature des relations que les pouvoirs (para-)pénaux entretiennent avec elles ? Et enfin, les progrès en matière d''égalité nous enjoignent-ils désormais à calquer le traitement judiciaire et pénal des femmes sur celui des hommes ? En retraçant cet itinéraire intellectuel, cet ouvrage met à jour les racines épistémiques des arguments mobilisés actuellement dans le débat public qui ent',
  'droits',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-10-26T18:00:00Z'::timestamptz,
  '2026-10-26T21:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Excuser-ou-punir-Rencontre-avec-Amelie-Bescont.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f5428e3a-08d4-49e6-811d-605fd2a1409e',
  'ami-ag-acte-iii-objectif-virons-les-fachos-2026-10-27-5',
  'AG Acte III. Objectif : virons les fachos',
  'Nous appelons à nous mobiliser massivement contre les événements des fascistes pour la "remigration" (= déportation) qui ont lieu les 30-31 octobre et 1er novembre à Paris. Lycéen.nes, étudiant.es, collectifs de sans papiers, travailleur.euses, syndicats, partis, collectifs de quartier, antifas, féministes, queers, pour la Palestine, handi.es... montrons aux fascistes que l''unité de notre classe est plus forte que leur poison raciste. Nous sommes toustes des enfants d''immigré.es ! Rendez-vous le mardi 27 octobre à 19h à la Bourse du travail de Paris pour organiser la mobilisation ! Signez l''appel',
  'climat',
  'Paris',
  '75010',
  'FR', 'Europe/Paris',
  'Bourse du travail Rue du Château d''Eau',
  NULL, NULL, NULL,
  '2026-10-27T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/AG-Acte-III-Objectif-virons-les-fachos-8851.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '13035e8d-27d0-432c-a0b0-b8dbb3262e1d',
  'ami-la-nature-nous-manque-t-elle-encore-conference-philosophique-de-paul-klotz-2026-10-27-6',
  'La nature nous manque-t-elle encore ? Conférence philosophique de Paul Klotz',
  'La sensibilité à la nature : le moyen inexploré de réussir la bifurcation écologique. Parmi toutes les anesthésies que nous avons décrites précédemment, c''est dans le rapport à la nature que l''appauvrissement est le plus lourd de conséquences. En quarante ans, la surface des espaces artificialisés a augmenté de 72%. La population d''oiseaux dans les espaces agricoles a diminué de 60%. Des générations entières grandissent sans expérience directe du vivant. Or, moins on expérimente la nature, moins on la préserve. Les travaux en psychologie environnementalement le montrent : faute de référence sensible, les atteintes à l''environnement deviennent tolérables. Chacun sous-estime la destruction qui se déroule sous ses yeux, parce que sa propre mémoire du vivant est déjà appauvrie. Les politiques environnementales échouent à créer l''adhésion parce qu''elles s''adressent à des individus dont le lien sensible à la nature a déjà été sectionné. Renouer avec la nature est une condition politique de la bifurcation. Réservation conseillée. Places limitées. Le bar est ouvert avant et après la rencontre : venez prendre un verre et prolonger la discussion avec l''invité·e.',
  'autre',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-10-27T18:30:00Z'::timestamptz,
  '2026-10-27T21:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/La-nature-nous-manque-t-elle-encore-Conference-philosophique-de-Paul-Klotz.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd367e4d9-d9ce-4daa-8eaa-7be6128cfeb2',
  'ami-rencontre-autour-du-livre-ce-pays-est-a-nous-tous-2026-10-27-7',
  'Rencontre autour du livre "Ce pays est à nous tous"',
  'Komla Elolo Djiakpo sera l''invité de la librairie le mardi 27 octobre à 19h30 pour discuter de l''ouvrage auquel il a contribué « Ce pays est à nous tous » aux éditions Burn-août. Il sera accompagné d''une membre de l''association Survie et la rencontre sera animée par Pierre Tenne. Présentation de l''ouvrage par la maison d''édition : En 2024, l''Assemblée nationale togolaise adopte, sans consulter les Togolais·es, une nouvelle constitution et décrète la Ve république. C''est une véritable dictature, celle de la dynastie Gnassingbé qui, depuis presque 60 ans, réprime les aspirations de ce peuple à vivre libre et dignement. Le coup d''État constitutionnel de 2024 permet à Faure Gnassingbé de garder le pouvoir au Togo. En 2025, le peuple togolais se soulève face à cette décision inique et s''insurge pour faire chuter le régime. Ce livre est à la fois un témoignage de ce soulèvement, de ces suites et un voeu pour l''avenir du Togo. Voir aussi Le Monte en l''air',
  'travail',
  'Paris',
  '75020',
  'FR', 'Europe/Paris',
  'Le Monte en l’air 2',
  NULL, NULL, NULL,
  '2026-10-27T18:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Rencontre-autour-du-livre-Ce-pays-est-a-nous-tous.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0da5fee5-21be-4c78-b2e2-b7ebf0b70f88',
  'ami-taf-a-la-recherche-du-proletariat-perdu-rencontre-avec-paul-martel-2026-10-28-9',
  'Taf, à la recherche du prolétariat perdu, rencontre avec Paul Martel',
  'Il n''y a pas que les bourgeois qui échappent au travail, certains prolétaires en ont même fait une devise : « Ne travaillez jamais ! » et c''est une toute autre aventure. Mais que se passe-t-il lorsque, après des années à fuir l''aliénation et l''exploitation par la marge, on se retrouve contraint de rejoindre la masse de ceux qui, chaque jour, sont contraints de trimer ? Chômeur à ses heures, ouvrier dès qu''il ne le peut plus, Paul Martel a enquêté. Comment survivre dans un monde où le capitalisme a, pour un temps, tout corrompu et désagrégé ? Le prolétariat diffus peut-il en soi redevenir une menace ? Quels contes et légendes nous faut-il écrire ou réviser pour encore vivre-et-lutter ?',
  'travail',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-10-28T18:00:00Z'::timestamptz,
  '2026-10-28T21:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Taf-a-la-recherche-du-proletariat-perdu-rencontre-avec-Paul-Martel.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '083335d4-0df1-4c99-aaeb-018f8a275a05',
  'ami-soiree-antinucleaire-discussion-repas-spectacles-2026-10-29-10',
  'soirée antinucléaire : discussion/repas/spectacles',
  'AU PROGRAMME : – 17h Ouverture des portes - infokiosque – 17h30 - Discussion et actualités de la lutte à Bure et du projet Cigéo – 18h30 - "Affaires nuisibles : Tarnac" quand l''état transforme une action de sabotage antinucléaire en acte terroriste. Durée : 1h / tout public – 19h30 - Repas vegan – 20h30 - Haute Activité Vie Longue Philippe Bouvet est communicant : son travail, c''est de vous faire rêver avec une poubelle nucléaire géante. Et son travail, il le fait bien. Même quand tout bascule et qu''une livreuse surnaturelle impose sur scène le déchet radioactif en personne, Philippe repousse ses limites et invente l''absurde pour sauver les meubles, les apparences et vous le faire accepter ... Quoi qu''il en coûte. Durée : 1h / conseillé à partir de 12ans Avertissements : morbidité, greenwashing Venons nombreuses pour nous informer, soutenir les collectifs en lutte là-bas, et affirmer haut et fort que le nucléaire est une énergie coloniale, impérialiste, militaire et destructrice jusqu''à l''infini. C''est ni vert, ni ici, ni ailleurs ! – > Par contre c''est par là pour trembler ensemble : La Parole Errante 9, rue François Debergue M° Croix de Chavaux (prévoir du cash)',
  'climat',
  'Montreuil',
  '93100',
  'FR', 'Europe/Paris',
  'La Parole Errante 9',
  NULL, NULL, NULL,
  '2026-10-29T16:00:00Z'::timestamptz,
  '2026-10-29T21:00:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Soiree-antinucleaire-Discussion-repas-spectacles.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7b496386-845d-4b03-adf6-8075ede6592b',
  'ami-lancement-de-la-bd-pause-croissance-avec-sophie-bourlet-2026-10-29-11',
  'Lancement de la BD « Pause croissance » avec Sophie Bourlet',
  'A l''occasion de la sortie de la BD « Pause croissance : A la recherche du bonheur intérieur brut », nous recevons Sophie Bourlet le jeudi 29 octobre à 19h. A la croisée du récit satirique et du traité d''économie, Sophie Bourlet et Nicola Gobbi signent une BD aussi savant qu''hilarante. Accompagnés par la sociologue Dominique Méda et l''économiste Timothée Parrique, ils explorent les utopies et alternatives concrètes. Sophie Bourlet est autrice et journaliste indépendante diplômée en économie, elle travaille notamment sur les questions d''inégalités et d''environnement pour différents médias, dont RFI, Mediapart et Alternatives Économiques. Voir aussi librairie Utopia',
  'travail',
  'Paris',
  '75005',
  'FR', 'Europe/Paris',
  'Librairie Utopia 1 rue Frédéric Sauton',
  NULL, NULL, NULL,
  '2026-10-29T18:00:00Z'::timestamptz,
  '2026-10-29T19:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Lancement-de-la-BD-Pause-croissance-avec-Sophie-Bourlet.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0cec2935-5305-4396-bb32-47671b1017f3',
  'ami-economie-de-guerre-lancement-du-livre-de-loic-fournil-2026-10-29-12',
  'Economie de guerre. Lancement du livre de Loïc Fournil',
  'La politique « d''économie de guerre » lancée par Emmanuel Macron ne consiste pas uniquement à produire plus d''armes. C''est un projet de société qui va toucher l''ensemble de la population. Basé sur une lecture attentive des documents officiels, ce livre alerte sur les dangers de la militarisation de nos existences et donne des pistes d''action pour enrayer la course à la guerre. Loïc Fournil est enseignant et syndicaliste. Un sentiment d''impuissance aurait pu s''emparer de lui face à la marche vers l''abîme et au climat anxiogène actuel, mais il a choisi de militer au sein de plusieurs organisations antimilitaristes.',
  'droits',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-10-29T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Economie-de-guerre-Lancement-du-livre-de-Loic-Fournil.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ced4896d-d264-4422-bbfa-05d1cc247da7',
  'ami-projection-du-film-maximum-tolerated-dose-2026-10-29-13',
  'Projection du film ‘Maximum Tolerated Dose’',
  'Rendez-vous le jeudi 29 octobre pour une projection du film "Maximum Tolerated Dose". Présentation du film (1h30, anglais sous-titré français) : Maximum Tolerated Dose traite de l''expérimentation animale en retraçant la vie et le parcours d''humains et de non-humains qui en ont fait l''expérience directe. Le film donne la parole à ceux qui ont tourné le dos à ces pratiques après y avoir participé, à ceux qui libèrent les animaux, à ceux qui en prennent soin dans leur foyer ou en sanctuaires. Comment en arrive-t-on à participer à ce système et même à le justifier ? Comment le quitter une fois qu''on s''y est engagé ? Quelles réparations possibles pour ses victimes, quelle autre vie peut-on leur offrir une fois sorties des laboratoires ? Le film contient des passages qui peuvent êtres difficiles - pas d''image gore à proprement parler, mais des descriptions et des images d''animaux en souffrance physique et psychologique. Suite à la projection, nous échangerons sur le sujet. L''entrée est à prix libre (gratuité comprise) et sans inscription. Sur place il y aura aussi un infokiosque et un bar 100% vegan Quand ? Le jeudi 29 octobre à 19h. Où ? Au Baranoux, 78, rue Compans, Paris 19ème. Dans l',
  'climat',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Le Baranoux 78 Rue Compans',
  NULL, NULL, NULL,
  '2026-10-29T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Projection-du-film-Maximum-Tolerated-Dose-8807.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '0f96dfd7-0cdc-4963-928d-180a061f3c6d',
  'ami-rencontre-avec-gerard-haddad-sur-le-theme-violence-et-politique-ujfp-2026-10-29-14',
  'Rencontre avec Gérard Haddad sur le thème ‘Violence et politique’  (UJFP)',
  'Dans cet ouvrage, Gérard Haddad prolonge ses travaux antérieurs sur le complexe de Caïn, cette rivalité fraternelle originaire, matrice de la violence, qui dépasse et reconfigure le cadre du complexe d''Œdipe, trop souvent central dans la tradition psychanalytique. Comment penser cette violence face au génocide à Gaza ? Gérard Haddad est psychiatre, psychanalyste et essayiste, lauréat 2026 du prix Ibn Khaldoun pour la science et la paix de l''UNESCO. Voir aussi UJFP',
  'droits',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'CICP - Centre International de Culture Populaire 21 ter',
  NULL, NULL, NULL,
  '2026-10-29T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Rencontre-avec-Gerard-Haddad-sur-le-theme-Violence-et-politique-UJFP.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'b13338c3-4e59-471d-8363-3a31f09dbb58',
  'ami-festival-alimenterre-2026-projection-debat-sur-le-film-etre-s-vivants-2026-10-30-16',
  'Festival ALIMENTERRE 2026. Projection-débat sur le film ’Être(s) vivants’',
  'Le festival ALIMENTERRE a vu le jour en 2007 dans un cinéma parisien. Depuis, il est devenu un événement international sur l''alimentation durable et solidaire organisé chaque année du 15 octobre au 30 novembre. Autour d''une sélection de films documentaires, il amène les citoyens à s''informer et comprendre les enjeux agricoles et alimentaires en France et dans le monde, afin qu''ils participent à la co-construction de systèmes alimentaires durables et solidaires et au droit à l''alimentation. Le 30 octobre, nous projetterons et discuterons du film "Être(s) vivants" dont vous trouverez le synopsis ci-dessous. Amenez de quoi alimenter un apéritif partagé ! Synopsis Ce film retrace les réflexions d''un groupe d''éleveurs et d''éleveuses et de bergers et bergères qui exercent leur métier avec conviction mais ressentent comme une gêne, un caillou dans la chaussure. Les protagonistes ont échangé entre eux, avec d''autres éleveurs et avec d''autres professionnels accompagnés par le Civam Empreinte. Pourquoi exercer cette activité souvent mal connue, parfois décriée, qui implique des gestes loin d''être anodins au contact de la vie, de la mort, et des humeurs des corps animaux ? Comment répondre au',
  'climat',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Le champ des possibles 93',
  NULL, NULL, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Festival-ALIMENTERRE-2026-Projection-debat-sur-le-film-Etre-s-vivants-8679.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '72acf4e7-fdd5-46f5-abb3-23e01ed83927',
  'ami-arpentage-du-livre-mondes-post-capitalistes-2026-10-30-17',
  'Arpentage du livre ‘Mondes post-capitalistes’',
  'Il est temps de rouvrir le futur et de faire mentir l''adage selon lequel il serait plus facile d''imaginer la fin du monde que la fin du capitalisme. Ce livre prend acte de l''échec catastrophique des projets dits "communistes" du XXe siècle comme des menaces pesant sur l''habitabilité de la terre et la survie des espèces. Ce faisant, il cherche à aller au-delà d''une critique du capitalisme restée impuissante et souvent éloignée des enjeux écologiques. Il étend, de ce fait, notre compréhension du capitalisme bien au-delà des questions économiques, qui ont considérablement restreint l''analyse et le débat. Le dépassement du capitalisme ne peut se concevoir sans une redéfinition de nos manières de vivre, de coexister, de nous relier aux autres vivants et de donner sens à nos existences. En s''intéressant aussi bien aux rêves qu''aux psychés postcapitalistes, aux matériaux qu''aux techniques, à la mort qu''aux religions, aux conflits et à la guerre qu''aux fêtes et aux rituels, à l''éducation qu''aux échelles d''organisation de la vie sociale, à l''amour qu''aux arts ou à la famille qu''aux genres ou à la monnaie, ce livre contribue à façonner non pas un programme, encore moins une doctrine, mais un',
  'climat',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-10-30T18:00:00Z'::timestamptz,
  '2026-10-30T21:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Arpentage-du-livre-Mondes-post-capitalistes.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '20a71ffd-2e1e-4c9b-aed1-b96fe171f15c',
  'ami-reunion-publique-soutien-au-peuple-palestinien-2026-10-31-19',
  'Réunion publique, soutien au peuple palestinien',
  'L''Afps Paris-Sud et le Collectif Unitaire de soutien au peuple palestinien appellent à une réunion publique le samedi 31 octobre 2026 à 14h00 à la Maison de la Vie Associative et Citoyenne 13e - 31 rue Bobillot - Paris 13e pour développer du thème ci-après : – Post-octobre 2023 : la question palestinienne à l''épreuve des guerres régionales – Quel devenir pour la Palestine, le Liban, la Syrie, l''Iran... pays menacés par l''expansionnisme israélien et l''impérialisme états-unien ?',
  'travail',
  'Paris',
  '75013',
  'FR', 'Europe/Paris',
  'Maison de la Vie Associative et Citoyenne du 13e 31',
  NULL, NULL, NULL,
  '2026-10-31T13:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Reunion-publique-soutien-au-peuple-palestinien.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'de347b9c-65b9-4e98-8216-fee209290ad9',
  'ami-education-populaire-independance-souverainete-alimentaire-a-la-reunion-2026-10-31-21',
  'Education Populaire. Indépendance, Souveraineté alimentaire à la Réunion',
  'Samedi 24 octobre au CICP. Ka Ubuntu vous invite à une présentation et un échange sur la souveraineté alimentaire à La Réunion.',
  'education',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'CICP - Centre International de Culture Populaire 21 ter',
  NULL, NULL, NULL,
  '2026-10-31T15:00:00Z'::timestamptz,
  '2026-10-31T17:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Education-Populaire-Independance-souverainete-alimentaire-a-la-Reunion.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'fc745846-510b-484e-af77-dd814a852ffc',
  'ami-club-de-lecture-queer-et-feministe-tws-2026-11-03-23',
  'Club de lecture queer et féministe (TWS)',
  'L''association The Witches'' Society propose son club de lecture queer et féministe le mardi 3 novembre 2026, de 18h30 à 20h30, à la Maison de la Vie Associative et Citoyenne du 13e arrondissement, 31, rue Bobillot, Paris 13e, près de la place d''Italie. Au programme : une heure de lecture en silence (Silent Book Club), suivie d''une heure d''échanges autour des lectures personnelles et des idées de chacun·e. Un rendez-vous mensuel pour partager des perspectives queer et féministes et se retrouver autour des livres. Participation gratuite. Inscription ici Voir aussi The Witches'' Society Voir aussi Paris.fr',
  'droits',
  'Paris',
  '75013',
  'FR', 'Europe/Paris',
  'Maison de la Vie Associative et Citoyenne du 13e 31',
  NULL, NULL, NULL,
  '2026-11-03T17:30:00Z'::timestamptz,
  '2026-11-03T19:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Club-de-lecture-queer-et-feministe-TWS-8613.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '649d25ca-7f92-4499-96a5-ebb8d967c635',
  'ami-rencontre-discussion-avec-nicolas-rouille-autour-du-sahara-occidental-2026-11-03-24',
  'Rencontre-discussion avec Nicolas Rouillé autour du Sahara occidental',
  'Venez échanger avec Nicolas Rouillé autour de son livre "Laâyoune, en attendant" (Anarchasis) dans une discussion autour des Sahraouis et de leur indépendance. Le livre : Daha, Maalouma, Otman et leurs camarades terminent l''année au lycée Tanmiya de Laâyoune, au Sahara occidental. L''humiliation infligée à l''un d''entre eux par un professeur marocain au prétexte de ses origines sahraouies les tire de leur torpeur et les renvoie brutalement à leur condition de colonisés. Au rythme des matchs de foot de la Coupe d''Afrique des nations, terrain d''affrontements géopolitiques, la petite bande d''amis prépare sa riposte. Déjouant l''ombre portée d''un passé qui voudrait les condamner à la résignation, la prison ou l''exil, ils cherchent leur route dans un temps suspendu, dans l''attente d''une lointaine indépendance.',
  'droits',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Librairie Envie de lire 16 Rue Gabriel Péri',
  NULL, NULL, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Rencontre-discussion-avec-Nicolas-Rouille-autour-du-Sahara-occidental.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '90e5775f-56cc-4d96-a395-cc7b9edc711f',
  'ami-rencontre-avec-noemie-merleau-ponty-2026-11-03-25',
  'Rencontre avec Noémie Merleau-Ponty',
  'Depuis près d''un demi-siècle, la procréation médicalement assistée a permis la naissance de plus de 10 millions d''enfants. À l''heure où l''infertilité progresse et où les enjeux démographiques s''invitent dans le débat public, cette pratique ne relève pas seulement de la médecine : elle mêle les trajectoires les plus intimes avec des enjeux de société. À partir d''une enquête menée au sein d''une clinique de PMA, Noémie Merleau-Ponty retrace les parcours de patientes confrontées à l''attente, aux échecs ou à l''exil médical. En suivant chaque jour le travail de biologistes et techniciennes, de la ponction ovocytaire jusqu''au transfert embryonnaire, l''autrice dévoile les coulisses de l''aide aux personnes engagées dans un projet parental. Un récit vivant où ces lieux habituellement fermés au public apparaissent comme des espaces éminemment humains, habités par les espoirs de celles et ceux qui les traversent. Noémie Merleau-Ponty est anthropologue au CNRS, spécialiste de la reproduction, de l''infertilité, de la baisse de la natalité et de la bioéthique. Ses recherches, menées en France, en Inde et au Royaume-Uni, croisent l''anthropologie avec les études des sciences et des techniques fémin',
  'droits',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Rencontre-avec-Noemie-Merleau-Ponty.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cb455103-cc8f-4ec1-b43d-c31921646b62',
  'ami-soiree-debat-le-syndicalisme-et-les-fronts-populaires-en-1936-regards-croises-es-2026-11-03-26',
  'Soirée-débat. Le syndicalisme et les Fronts populaires en 1936, regards croisés Espagne-France',
  'L''union syndicale Solidaires organise une soirée débat sur le syndicalisme et les Fronts populaires en France et en Espagne, avec les interventions de Ludivine Batigny et Ramon Pino.',
  'travail',
  'Paris',
  '75010',
  'FR', 'Europe/Paris',
  'Union syndicale Solidaires 31',
  NULL, NULL, NULL,
  '2026-11-03T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Soiree-debat-Le-syndicalisme-et-les-Fronts-populaires-en-1936-regards-croises.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '26e01281-b083-4a73-a6bc-84ce1d46357f',
  'ami-manifestation-pour-les-crevettes-2026-11-04-27',
  'Manifestation pour les crevettes',
  'Environ 440 milliards de crevettes sont tuées chaque année dans des élevages, soit près de 14 000 chaque seconde. Beaucoup de crevettes meurent asphyxiées hors de l''eau ou plongées vivantes dans un bain d''eau glacée. Pour des animaux capables de ressentir la douleur, ce sont des pratiques d''une grande cruauté. Mais leur souffrance est soigneusement invisibilisée par l''industrie, et presque personne n''a conscience des horreurs qu''on leur fait subir. On demande aux chaînes de supermarchés de cesser de vendre des crevettes mortes par suffocation et d''imposer l''étourdissement électrique avant abattage. Partout en Europe, des collectifs se battent pour pousser Lidl à mettre fin à ces pratiques. La France rejoint le mouvement ! Le 4 novembre, on se rend devant le siège de Lidl pour porter la voix des crevettes : tu nous rejoins ? Les crevettes ont besoin de l''énergie de toustes : tout le monde est bienvenu-e, quel que soit ton niveau d''engagement militant ou animaliste. RDV le mercredi 4 novembre à 11h, à Châtenay-Malabry. C''est tout près de la gare RER B La croix de Berny et du T10. Inscris-toi ici pour recevoir toutes les infos (ça nous aidera à savoir combien de personnes attendre et ',
  'climat',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'siège de Lidl 35 Avenue Sully Prudhomme',
  NULL, NULL, NULL,
  '2026-11-04T10:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Manifestation-pour-les-crevettes-8849.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'f89a58ea-fa6f-4ade-ae76-2aee197ef4ca',
  'ami-ia-et-production-robotique-pour-le-meilleur-ou-pour-le-pire-un-debat-propose-par-2026-11-04-29',
  'IA et production robotique, pour le meilleur ou pour le pire ? Un débat proposé par Décroissance IDF',
  'Alors que les preuves s''accumulent sur l''impact massif de l''intelligence artificielle sur le marché du travail, le gouvernement, tout comme les partis dits d''opposition, continuent de regarder ailleurs. Cécité volontaire ? Une utilisation socialement bénéfique de l''IA productive est-elle concevable ? Sur le versant pessimiste, ne faut-il redouter l''avènement d''un techno-féodalisme ? Problématisation présentée par Alain Véronèse. Suivie par questions, contradictions débat. Une soirée info/débat proposée par Décroissance Idf. Voir sur OC Paris',
  'climat',
  'Paris',
  '75012',
  'FR', 'Europe/Paris',
  'Maison de la vie associative et citoyenne 12e 181',
  NULL, NULL, NULL,
  '2026-11-04T17:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/IA-et-production-robotique-pour-le-meilleur-ou-pour-le-pire-Un-debat-propose-8804.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '35bc3482-14f4-4399-9235-946478621af0',
  'ami-gouverner-pour-dominer-autrui-par-luc-foisneau-2026-11-04-30',
  'Gouverner, pour dominer autrui ? Par Luc Foisneau',
  'Si l''État a cherché à utiliser à son service les techniques du gouvernement, il n''est pas vrai de dire que les arts de gouverner n''existent que pour l''État. On pourra s''interroger sur les multiples formes que ces arts ont pu prendre depuis les premiers traités de la raison d''État en Italie jusqu''aux algorithmes qui gouvernent aujourd''hui nos vies. N''y aurait-il pas un projet propre à ces arts de gouverner et à celles et ceux qui s''en prévalent ? Comment peut-on comprendre les politiques qui font de la domination sur autrui le but ultime des arts de gouverner. L''actualité nous donne maints exemples de cette pensée du gouvernement, mais il n''est pas vrai qu''elle est une invention récente. En partant de Machiavel, nous essaierons de nous repérer parmi les formes diverses qu''a pu prendre la pensée de la raison d''État.',
  'autre',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-11-04T18:30:00Z'::timestamptz,
  '2026-11-04T21:00:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Gouverner-pour-dominer-autrui-Par-Luc-Foisneau.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd75ce030-9741-4c27-b7ab-411e755741d0',
  'ami-penser-demain-3-resister-a-l-ia-bsurde-2026-11-05-31',
  'Penser Demain #3 : Résister à l’IA-bsurde',
  'Pour cette nouvelle édition de « Penser Demain », les Soulèvements de la Terre - IDF vous convient à une soirée dédiée à la lutte contre l''intelligence artificielle. Face à la vague de l''IA, soi-disant inévitable et qui menace de nous submerger, nous pouvons résister. Refusons la submersion annoncée et mobilisons-nous contre chaque projet destructeur qui y contribue, en Île-de-France et ailleurs ! Au programme : ateliers, stands, et table-rondes. Dès 18h, venez participer à l''atelier de migration numérique organisé par Tribe-X pour vous débarrasser de l''emprise des géants de la tech et vous informer sur des pratiques numériques alternatives, libres et open-source. La soirée se poursuivra avec deux tables rondes. La première, intitulée « Le prix de l''IA : extractivisme, spéculation, exploitation », décortiquera la chaîne de production de l''IA pour exposer ses conséquences matérielles (accaparement des ressources économiques, destruction des terres, exploitation des travailleur.euses du clic...). La seconde, intitulée « Tout contrôler : impérialisme, technofascisme, IAgriculture », portera sur les usages de l''IA et le projet politique qu''elle soutient. Nous analyserons son rôle dans ',
  'climat',
  'Paris',
  '75020',
  'FR', 'Europe/Paris',
  'Le Cirque électrique Place du maquis du Vercors',
  NULL, NULL, NULL,
  '2026-11-05T17:00:00Z'::timestamptz,
  '2026-11-05T22:59:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Penser-Demain-3-Resister-a-l-IA-bsurde.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'bf545554-4845-4b19-a2bd-d61746a677b7',
  'ami-discussion-autour-du-livre-au-jour-le-jour-2026-11-06-33',
  'Discussion autour du livre ‘Au jour le jour’',
  'Que serait une histoire à la hauteur de celles et ceux qui la vivent et la font, loin du mythe des "grands hommes" s''arrogeant la "paternité de la nation" ? Le collectif d''historiennes "Genre et classes populaires" nous en donne une précieuse illustration grâce à son formidable livre "Au jour le jour". Celui-ci nous plonge dans la vie discrète des classes populaires pour mieux nous en révéler la quotidienneté des rapports de domination et leur contestation à bas bruit. Avec les co-autrices Anaïs Albert, Anne Jusseaume, Fanny Gallot et Clyde Plumauzille, venez découvrir l''ouvrage (La Découverte, 2026) et débattre des leçons que nous pouvons en tirer sur notre actualité contemporaine.',
  'travail',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Librairie Envie de lire 16',
  NULL, NULL, NULL,
  '2026-11-06T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Discussion-autour-du-livre-Au-jour-le-jour.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5e206721-419b-4228-a5e9-cea1b7832688',
  'ami-cine-leon-projection-rencontre-2026-11-06-34',
  'Ciné Léon (projection-rencontre)',
  'Projection de "La FoRêT Est A NouS", un film documentaire d''Anne Faisandier Dans le cadre d''un Docu près de chez Vous, proposé par Addoc (l''Association des cinéastes documentaristes) Synopsis : « Que se passe-t-il en forêt morvandelle ? C''est quoi ces alignements de bois noirs, ces champs de RUINES... ? Je décide de mener l''enquête et, grâce à quatre militants, je découvre la LUTTE qui se joue ici pour la défense de la forêt. Tous différents, leur engagement s''enracine et se déploie, à la façon des ARBRES, comme quatre branches ou quatre racines de la lutte. Ils m''aident à comprendre. Je ne me rendais pas compte à quel point j''aimais la forêt : NOTRE FORÊT. » (Anne Faisandier) Suivi d''une rencontre en présence de la réalisatrice Anne Faisandier ... et de la traditionnelle auberge espagnole pour partager ensemble nos boissons et petits plats. Voir aussi Le Ciné Léon Voir aussi Centre Mercoeur',
  'climat',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'MJC Mercoeur 5 Cité Souzy',
  NULL, NULL, NULL,
  '2026-11-06T19:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Cine-Leon-Projection-rencontre-8809.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9ce09516-b6b7-4405-87eb-27949f1e46c8',
  'ami-conference-debat-sur-le-climat-et-les-energies-2026-11-07-35',
  'Conférence débat sur le climat et les énergies',
  'Big Conférence sur le Climat : "Et si on vous expliquait que l''effet de serre est bon pour la planète ?" Les rapports entre les énergies, le climat et les conséquences et les actions à mener Avec l''Association Avenir Climatique, AC Au Chalet de la transition écologique 40, rue René Hamon 94 800 Villejuif métro Paul Vaillant Couturier entrée libre sur inscription : SELdeVillejuif @ gmail.com',
  'climat',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Chalet de la transition écologique 40',
  NULL, NULL, NULL,
  '2026-11-07T13:00:00Z'::timestamptz,
  '2026-11-07T16:00:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Conference-debat-sur-le-climat-et-les-energies-8830.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'a7d66c40-da44-45dd-babf-399064e030a4',
  'ami-l-inventaire-n-16-rencontre-avec-l-equipe-de-la-redaction-2026-11-07-36',
  'L’Inventaire n°16. Rencontre avec l’équipe de la rédaction',
  'La revue L''Inventaire publie son numéro annuel et sa seizième livraison - toujours et uniquement imprimée, toujours pour ceux qui rejettent l''injustice sociale et la soumission, la vie mutilée et l''insignifiance, l''irresponsabilité et la laideur que produit la civilisation industrielle avancée. Et parmi eux, à ceux qui n''ont pas renoncé à la discussion argumentée et l''examen critique. Au menu, notamment : relativiser la part du progrès médical dans l''allongement de l''espérance de vie ; raconter et penser une maternité contre la tentation nihiliste, ou un féminisme qui refuse la dépossession ; penser l''inscription de la politique d''extermination nazie dans la modernité industrielle. « Le propos n''est pas ici de nier absolument les apports de la médecine, mais de critiquer le bien-fondé de son développement illimité : cette perspective de progrès infini ne sert qu''à légitimer la société industrielle dans son ensemble. La fuite en avant médicale ne supprimera ni la mort, ni la souffrance, ni la maladie ; elle crée et créera encore son lot d''effets négatifs (iatrogénie et obstination déraisonnable), et elle ne pourra se poursuivre que sous une forme de plus en plus inégalitaire du fait',
  'climat',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'Librairie Quilombo 23 Rue Voltaire',
  NULL, NULL, NULL,
  '2026-11-07T19:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/L-Inventaire-no16-Rencontre-avec-l-equipe-de-la-redaction.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'c108ff34-2c02-4f58-b9cd-9137e6daec1e',
  'ami-cours-de-droit-du-travail-sur-le-cdi-2026-11-09-38',
  'Cours de droit du travail sur le CDI',
  'Ce cours portera sur le contrat à durée indéterminée (CDI) et sera donné par Florian GIVORD, inspecteur du travail. Il est proposé par l''association STOP PRECARITE. Il aura lieu à la Bourse du travail située 3, rue du Château d''Eau 75010 PARIS (métro République) dans la salle "Francisco Ferrer". Venez nombreuses et nombreux !',
  'travail',
  'Paris',
  '75010',
  'FR', 'Europe/Paris',
  'Bourse du travail Paris (Château d’eau) 3',
  NULL, NULL, NULL,
  '2026-11-09T17:30:00Z'::timestamptz,
  '2026-11-09T19:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Cours-de-droit-du-travail-sur-le-CDI.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'acfb32fb-bd66-4253-8a7b-6101a1cf7361',
  'ami-peut-il-encore-y-avoir-une-deliberation-collective-de-qualite-2026-11-10-39',
  'Peut-il encore y avoir une délibération collective de qualité ?',
  '2e séance du séminaire grand-public "Accumulations et accélérations : Le totalitarisme informatique IV" avec Alexandre Basquin, sénateur du Nord (PCF), auteur de "Numérique : Stop à l''exploitation ! Itinéraire d''un sénateur dans le monde des algorithmes", Le Temps des cerises 2026 Voir aussi Accumulations et accélérations',
  'climat',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'Le Maltais Rouge 40 Rue de Malte',
  NULL, NULL, NULL,
  '2026-11-10T17:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Peut-il-encore-y-avoir-une-deliberation-collective-de-qualite.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7967423e-7924-4957-a3a9-b6eebf37e17b',
  'ami-armer-la-non-violence-rencontre-avec-nathalie-achard-2026-11-10-41',
  'Armer la non-violence, Rencontre avec Nathalie Achard',
  'La non-violence traverse une crise de crédibilité : récupérée, figée en dogme, elle est souvent devenue un argument pour désarmer les luttes plutôt qu''un outil pour les mener. Activiste et formatrice, Nathalie Achard entend lui rendre sa puissance de transformation. Pour cela, elle regarde en face ses limites et les privilèges qu''elle suppose, et plaide pour une non-violence à la fois radicale et pragmatique : qui fait place à la colère, qui distingue se protéger et punir, et qui accepte le conflit sans le réduire à un jugement moral. Voir aussi : Librairie Le Delta',
  'autre',
  'Paris',
  '75006',
  'FR', 'Europe/Paris',
  'Librairie Le Delta 1',
  NULL, NULL, NULL,
  '2026-11-10T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Armer-la-non-violence-Rencontre-avec-Nathalie-Achard.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6f0a7f71-6635-496c-90aa-4f332131673a',
  'ami-aprem-antimilitariste-2026-11-11-42',
  'Aprèm’ Antimilitariste',
  'Le Collectif contre la militarisation de la jeunesse vous invite le mercredi 11 novembre 2026 ! Événement Antimilitariste Prix libre (entrée / repas et boissons) ; prévoir du cash 14h-18h30 : Ateliers : – Éducation à la paix – Création graphique – Arpentage de la loi Blanchet – Lecture de livres jeunesse et discussion (pour différentes tranches d''âge) – Présentation de la Cartographie Armée-Jeunesse – Chorale – Jeux collectifs et collaboratifs – etc Goûter crêpes Table Ronde Avec intervenantes et discussion Repas avant ou après la table ronde Fin à 21h30 Ouvert à toustes, tous les âges Le lieu est accessible PMR Voir aussi sur Mastodon',
  'droits',
  'Montreuil',
  '93100',
  'FR', 'Europe/Paris',
  'La Parole Errante 9',
  NULL, NULL, NULL,
  '2026-11-11T12:30:00Z'::timestamptz,
  '2026-11-11T20:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Aprem-Antimilitariste.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '9943d7b3-7eff-4aeb-8b57-9921a3215332',
  'ami-y-a-pas-de-nous-sans-toit-2026-11-12-43',
  'Y’a Pas de Nous Sans TOIT',
  'Carré de Baudouin avec l''Association DALO jeudi 12 novembre à 19h Y''a Pas de Nous Sans TOIT Le droit au logement : existant, insuffisant et saboté Plus de 4 millions de personnes sont victimes de mal logement, plus de 330 000 personnes sont sans domicile fixe ! A minima 2000 enfants naissent, vivent et meurent sur les trottoirs de France ! En 2024, 855 personnes sont mortes à la rue, parmi elles, 31 enfants ! « Le logement c''est le point de départ ! Alors on attend quoi pour faire de cette question une priorité ? » Et si le "Nous" commençait par un TOIT ? Ce n''est pas une simple conférence. C''est une claque douce, un mélange explosif d''humour, de lucidité et de colère constructive. Dans « Y''a pas de Nous Sans TOIT », Sofi nous embarque dans une conférence gesticulée où les mots frappent juste et où les idées dérangent... pour mieux réveiller. On y parle de solidarité, d''engagement, de vivre-ensemble, et de tout ce qu''on a parfois appris à oublier. Entre récit personnel et analyse politique Entre rire et inconfort Entre prise de conscience et envie d''agir Cette conférence gesticulée pose une question simple mais essentielle : peut-on vraiment faire société sans prendre soin les un·e',
  'education',
  'Paris',
  '75020',
  'FR', 'Europe/Paris',
  'Le Carré de Baudouin 121',
  NULL, NULL, NULL,
  '2026-11-12T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Y-a-Pas-de-Nous-Sans-TOIT-8605.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '781baab7-ee3d-4cf1-9167-e1f581ce0b2d',
  'ami-discussion-avec-rob-grams-sur-son-livre-bourgeois-gaze-2026-11-12-44',
  'Discussion avec Rob Grams sur son livre Bourgeois Gaze',
  'Le cinéma, art populaire par excellence, est dominé par une minorité sociale : la bourgeoisie. Héritiers de milieux favorisés, enfants d''artistes ou de grands patrons, ce sont eux qui fabriquent l''essentiel des récits, décident quels personnages existent à l''écran et comment ils sont représentés. À l''instar du male gaze, Rob Grams propose le concept de "bourgeois gaze" : une manière de filmer le monde depuis une position sociale dominante qui se prétend universelle, marquée par le mépris de classe, un centrisme moralisateur, un rapport hors-sol à la ruralité et une surreprésentation des thématiques bourgeoises. En analysant à la fois des films emblématiques de ce regard et un système de production socialement homogène, nourri par le népotisme et l''entre-soi, Bourgeois Gaze interroge : Quelles voix, quels imaginaires émergeraient si l''art n''était pas monopolisé par une seule classe ? Quelle richesse de récits nous est volée ? Et quelles oeuvres parviennent, malgré tout, à ouvrir des brèches ?',
  'travail',
  'Ivry-Sur-Seine',
  '94200',
  'FR', 'Europe/Paris',
  'Librairie Envie de lire 16',
  NULL, NULL, NULL,
  '2026-11-12T18:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Discussion-avec-Rob-Grams-sur-son-livre-Bourgeois-Gaze.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6c3650bf-c843-435a-8ab6-e2f69e0cc249',
  'ami-discussion-noyer-l-urgence-dans-l-urgence-intervenir-pour-que-rien-ne-change-2026-11-13-45',
  'Discussion : Noyer l’urgence dans l’urgence, intervenir pour que rien ne change',
  'Avec le collectif Terrain Vague La bibliothèque a été tout de suite enthousiaste à la lecture des textes de Terrain Vague, d''abord parce que c''est rare que des acteurs des luttes proposent un retour critique sur la pratique dans laquelle ils ont été investis, et que ce retour soit porteur de perspectives émancipatrices et subversives. Ensuite parce que cette question du chantage à l''urgence qui se met en place à partir du moment où l''humanitaire et le caritatif s''emparent de situations qui devraient devenir des champs de lutte nous semble effectivement cruciale. Que ce soit dans le cadre des luttes autour de la question des frontières et des papiers, ou sur la question du logement, nombreux sont les exemples de comment les humanitaires, trop souvent considérés comme juste inoffensifs par certains radicaux, minent toute possibilité de subversion et occupent toute une énergie de la révolte à faire des repas et gérer des logements, complétant ainsi en réalité les rouages de l''État en colmatant ses insuffisances dans la même logique. Sur cette question comme sur d''autres, rien de tel que l''expérience récente et son analyse critique pour raviver ces discussions désespérément urgentes, à',
  'autre',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Les Fleurs arctiques 45',
  NULL, NULL, NULL,
  '2026-11-13T18:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Discussion-Noyer-l-urgence-dans-l-urgence-intervenir-pour-que-rien-ne-change.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'd463476e-2817-4f3a-bc92-6a276aad1678',
  'ami-fete-des-10-ans-de-la-legal-team-paris-idf-2026-11-14-46',
  'Fête des 10 ans de la Legal Team Paris IDF',
  '10 ANS DE LEGAL TEAM PARIS : ON FÊTE ÇA ! La Legal Team Paris, issue de la coordination anti-répression IDF, fête ses 10 ans et vous donne rendez-vous le 14 novembre 2026, à la Parole Errante, Montreuil, de 14h à minuit. Notez la date, invitez vos amix et préparez-vous : on fête 10 ans de luttes, de solidarité et d''anti-répression... et on se prépare à la bagarre pour les 10 prochaines années ! L''après-midi : on s''entraîne et on s''outille ! Ateliers d''anti-répression, confection de cagoules, boxe, danse... de quoi apprendre, transmettre, bouger et se préparer collectivement. Le soir : place à la fête ! Des concerts pour tous les goûts, des DJ sets et de quoi danser jusqu''à minuit. Toute la journée et toute la soirée, la super équipe du Barcredi sera derrière le bar, avec et sans alcool. Et les Tabliers Volants nous régaleront de crêpes et autres mets délicieux, à prix libre. Et parce qu''un anniversaire, ça se fête entre amix : plein de collectifs engagés dans différentes luttes seront aussi de la partie avec leurs stands. Plus d''infos et programme complet très bientôt. D''ici là : bloquez votre 14 novembre ! 10 ans de Legal Team Paris - 10 ans à fêter, et la suite à préparer. Rendez',
  'droits',
  'Montreuil',
  '93100',
  'FR', 'Europe/Paris',
  'La Parole Errante 9',
  NULL, NULL, NULL,
  '2026-11-14T13:00:00Z'::timestamptz,
  '2026-11-14T22:59:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Fete-des-10-ans-de-la-Legal-Team-Paris-IDF.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'cea7e462-221a-4781-9237-918f028934eb',
  'ami-cine-debat-laissez-nous-les-cles-2026-11-17-47',
  'Ciné-débat : Laissez-nous les clés !',
  'Pour le Mois de l''Économie sociale et solidaire (ESS), la Chambre régionale de l''ESS d''Île-de-France et le réseau régional des Tiers-lieux et Communs A+ c''est mieux vous invitent à un Ciné-débat autour du film "Laissez-nous les clés" ! Venez (re)découvrir et échanger autour de cette initiative inspirante et des multiples enjeux qu''elle recouvre ! "Laissez-nous les clés" : En 2021, après la liquidation judiciaire d''un McDonald''s des Quartiers Nord de Marseille, Kamel Guemari - dernier employé resté sur place - transforme le lieu en espace de solidarité collective : l''Après M. Pendant un an, la caméra suit de l''intérieur cette expérimentation sociale inédite, entre distributions alimentaires, projet de coopérative citoyenne, menaces d''expulsion de McDonald''s et enjeux politiques. Tourné au plus près des protagonistes, "Laissez-nous les clés" capture les débats, les doutes, et la puissance d''agir de citoyen·nes qui réinventent la propriété collective, défient le pouvoir des multinationales et ouvrent les possibles de l''autogestion. Voir aussi Forms Voir aussi la Chambre régionale de l''ESS d''Île-de-France',
  'climat',
  'Paris',
  '75020',
  'FR', 'Europe/Paris',
  'Wikivillage 8',
  NULL, NULL, NULL,
  '2026-11-17T17:00:00Z'::timestamptz,
  '2026-11-17T19:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Cine-debat-Laissez-nous-les-cles.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '6bae0bd8-e63d-4a25-9683-980ca253fe5d',
  'ami-vernissage-photo-mais-est-ce-que-t-avais-dit-non-violences-sexistes-et-sexuelles-2026-11-17-48',
  'Vernissage photo ’Mais est-ce que t’avais dit non ?’ Violences sexistes et sexuelles',
  'À l''occasion des mobilisations du 25 novembre contre les violences faites aux femmes, The Witches'' Society vous invite au vernissage de l''exposition photo « Mais est-ce que t''avais dit non ? », consacrée à la victimisation secondaire. Après avoir subi des violences, certaines phrases entendues peuvent marquer durablement et constituer de nouvelles violences : paroles qui minimisent les faits, mettent en doute la parole ou font porter la culpabilité aux personnes qui les ont subies. À travers la photographie, cette exposition propose d''ouvrir le dialogue et de nourrir la lutte contre les violences sexistes et sexuelles (VSS). Les photographies sont accompagnées de créations réalisées lors d''ateliers d''art exutoire. Vernissage : mardi 17 novembre 2026, de 19 h à 20 h. Lieu : Maison de la Vie Associative et Citoyenne (MVAC) du 13e arrondissement, 31 rue Bobillot, 75013 Paris. L''exposition est présentée du 17 au 25 novembre. Entrée gratuite, ouverte à toutes et tous. Inscription recommandée Contact : contact@thewitchessociety.fr Organisateur : The Witches'' Society Voir aussi sur Paris.fr',
  'droits',
  'Paris',
  '75013',
  'FR', 'Europe/Paris',
  'Maison de la Vie Associative et Citoyenne du 13e 31',
  NULL, NULL, NULL,
  '2026-11-17T18:00:00Z'::timestamptz,
  '2026-11-17T19:00:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Vernissage-photo-Mais-est-ce-que-t-avais-dit-non-Violences-sexistes-et-8672.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '7e69fd78-a9ec-4a3c-a80a-c10868687e1c',
  'ami-etre-femme-en-zone-de-conflit-regards-croises-en-palestine-en-rdc-et-en-ukraine-2026-11-21-51',
  'Être femme en zone de conflit. Regards croisés en Palestine, en RDC et en Ukraine',
  'À l''occasion de la Journée Internationale pour l''Élimination de la Violence à l''Égard des Femmes, les associations AFPS Val-d''Oise, APEO et Solidarité Ukraine 95, ont le plaisir de vous inviter à la table ronde : « Être femme en zone de conflit : regards croisés en Palestine, en République Démocratique du Congo et en Ukraine, pour briser le cycle des violences ». Qu''il s''agisse de la Palestine, de l''Ukraine ou de la RDC, les contextes géopolitiques diffèrent, mais les mécanismes de déshumanisation et l''utilisation du corps des femmes comme « champ de bataille » présentent de tragiques similitudes. Animée par la journaliste Nadia Hathroubi-Saf-Saf (Le Courrier de l''Atlas), cette rencontre croisera témoignages de terrain et analyses juridiques autour de deux grands axes : – Partie 1 : « Quand le quotidien devient un combat : Femmes, santé et urgence humanitaire » – Partie 2 : « Le corps comme champ de bataille : briser le silence, exiger la justice ». Gratuit - Inscription obligatoire',
  'droits',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Office de tourisme de Cergy-Pontoise - Porte du Vexin Place de la Piscine',
  NULL, NULL, NULL,
  '2026-11-21T13:00:00Z'::timestamptz,
  '2026-11-21T16:00:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Etre-femme-en-zone-de-conflit-Regards-croises-en-Palestine-en-RDC-et-en-Ukraine.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '5f292fbc-22f1-4ffb-a030-3ddceb9a1aa9',
  'ami-demontage-judiciaire-l-affaire-adriano-sofri-2026-11-22-52',
  'Démontage judiciaire. L’affaire Adriano Sofri',
  'Ce démontage s''attaque à une des grandes affaires liées à la répression du « mai rampant » italien, cette vague insurrectionnelle de la fin des années soixante qui s''est étendue en Italie sur une dizaine d''année et a connu une répression massive, avec certains moments particulièrement mis en lumière comme le « procès Sofri ». En 1990, les prévenus Adriano Sofri, Giorgio Pietrostefani et Ovidio Bompressi, tous d''anciens membres du groupe opéraïste Lotta Continua, actif à partir de 1969, sont déclarés coupables de l''assassinat le 17 mai 1972 du commissaire Luigi Calabresi, que les aires subversives considèrent comme responsable du « suicide » par défenestration de Pinelli, militant anarchiste, lors de son interrogatoire dans le cadre de l''affaire de la Piazza Fontana (1969). L''accusation se construit essentiellement sur la base des aveux de Leonardo Marino, lui aussi ex membre de Lotta Continua, qui bénéficiera du statut de repenti. Sofri et Pietrostefani auraient commandité la mort de Calabresi, tandis que Marino affirme avoir conduit Bompressi, le tireur, au lieu de l''assassinat. Comme beaucoup des procès de l''époque, celui-ci a donné lieu à une épopée judiciaire avec appel, cassat',
  'droits',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Les Fleurs arctiques 45',
  NULL, NULL, NULL,
  '2026-11-22T15:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Demontage-judiciaire-L-affaire-Adriano-Sofri-8651.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '77883d02-d159-42de-bdc7-363394793e1f',
  'ami-discussion-new-age-religions-2-0-et-arriere-monde-2026-11-27-56',
  'Discussion. New Age, religions 2.0 et arrière-monde',
  'Discussion autour de la brochure « Une Critique du New Age », en présence de son auteur Si la critique de la religion est déjà bien balisée dans le corpus anti-autoritaire - même si l''on pourrait en douter tant les complaisances à son propos y sont désormais légion - il n''en est pas de même de la critique du New Age. Depuis les années 60, les courants New Age ont pourtant le vent en poupe. Les raisons de s''en inquiéter sont nombreuses tant les gourous impliqués dans des affaires d''abus de faiblesses, de violences physiques, mentales et sexuelles ne se comptent plus ainsi que, par exemple, les retards de prise en charge médicale, la mise en danger d''enfants dans le cadre de campagne anti-vax et de façon plus globale leur diffusion d''idéologies réactionnaires - sexisme, racisme, eugénisme, etc. La pénétration du new age dans les thèses révolutionnaires semble aussi être à la mode ; pensons à la publication du livre "Pas de capitulation spirituelle" publié récemment aux éditions Tumult, à certaines envolées lyriques clairement New Age dans la brochure anti-civilisationnelle Takakia, à l''usage d''un certain vitalisme dans les critiques de la médecine, etc. Il nous faut donc prendre à br',
  'autre',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Les Fleurs arctiques 45',
  NULL, NULL, NULL,
  '2026-11-27T18:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Discussion-New-Age-religions-2-0-et-arriere-monde.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '29e5df60-64e2-4ea3-97ac-05170631954f',
  'ami-formation-a-la-regulation-non-violente-des-conflits-2026-11-28-57',
  'Formation à la régulation non-violente des conflits',
  'Le Mouvement pour une alternative non-violente propose une formation à la régulation non-violente des conflits sur un week-end les 28 et 29/11 à Montreuil (93 100), métro Mairie de Montreuil (L9). En famille, au sein d''une association, avec les voisins ou les collègues de travail, les désaccords sont inévitables. On peut en faire des déclarations de guerre, des conflits larvés, ou bien, à force de subir en silence... des trous dans l''estomac ! À moins que vous ne souhaitiez transformer les conflits en une opportunité de progrès. À l''occasion de ces deux journées, nous vous proposerons des exercices permettant d''acquérir des outils pratiques et simples d''analyse de situations conflictuelles, visant à établir de justes distances et des relations plus apaisées, que vous soyez impliqué·e·s dans la situation conflictuelle ou une tierce personne. Programme des deux journées : – Notion de conflit (qu''est-ce que c''est ?) – Positionnement face au conflit (comment réagit-on face à un conflit ?) – Les composantes de la communication (faits, ressentis, jugements) – Le rôle des émotions et des besoins – La régulation des conflits – Expérimentation pratique, mises en situations Les inscriptions ',
  'education',
  'Montreuil',
  NULL,
  'FR', 'Europe/Paris',
  'Mundo-M 47',
  NULL, NULL, NULL,
  '2026-11-28T08:40:00Z'::timestamptz,
  '2026-11-29T16:30:00Z'::timestamptz,
  FALSE,
  NULL,
  'https://www.agendamilitant.org/Formation-a-la-regulation-non-violente-des-conflits-8819.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'ab36010e-7123-4aaa-b2b8-8474f5366cc4',
  'ami-les-ia-risquent-elles-effectivement-de-s-emanciper-de-la-tutelle-humaine-et-de-t-2026-12-08-58',
  'Les IA risquent-elles effectivement de s’émanciper de la tutelle humaine et de tyranniser la société ?',
  '3e séance du séminaire grand-public "Accumulations et accélérations : Le totalitarisme informatique IV" avec Cédric Sauviat, polytechnicien, co-auteur d''"Intelligence artificielle : La nouvelle barbarie", préface Matthew Crawford, Éd. du Rocher 2019 Voir aussi Accumulations et accélérations',
  'climat',
  'Paris',
  '75011',
  'FR', 'Europe/Paris',
  'Le Maltais Rouge 40 Rue de Malte',
  NULL, NULL, NULL,
  '2026-12-08T17:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Les-IA-risquent-elles-effectivement-de-s-emanciper-de-la-tutelle-humaine-et-de.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  '4b52424f-530f-4ffd-981b-d00d868e71e3',
  'ami-cinematec-projection-debat-de-la-resistance-a-la-resilience-2026-12-10-59',
  'CinémaTec. Projection-débat ‘De la résistance à la résilience’',
  'Dix ans après, Marie-Monique Robin et son équipe retournent à Ungersheim ! Ce film raconte le chemin parcouru depuis le rejet d''un projet « Pierre et Vacances », pourtant soutenu par tous les élus de la région, jusqu''à la reconnaissance de l''exemplarité du village, qui inspire aujourd''hui l''agglomération de Mulhouse et bien au-delà. – Autonomie énergétique (électricité, chauffage) – Autonomie alimentaire renforcée : régie agricole avec 4 maraîchers municipaux, épicerie solidaire dans un bâtiment à énergie positive – Un exemple remarquable de biodiversité grâce aux arbres et haies plantés – Aucune hausse d''impôts depuis 2003 ! Marie-Monique Robin, sera présente pour animer le débat et répondre à vos questions. Journaliste d''investigation, réalisatrice et écrivaine, Marie-Monique Robin est reconnue pour ses documentaires et enquêtes sur des sujets comme les dérives des multinationales (notamment Monsanto), les menaces sur la biodiversité, les pandémies et les alternatives écologiques. Elle a reçu plusieurs distinctions, dont le prix Albert-Londres en 1995 et le prix norvégien Rachel Carson en 2009. TEC (Transition écologique Châtenay-Malabry) est une association de châtenaisiens d''ho',
  'climat',
  'Paris',
  NULL,
  'FR', 'Europe/Paris',
  'Centre Protestant 36 rue Jean Longuet',
  NULL, NULL, NULL,
  '2026-12-10T19:00:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/CinemaTec-Projection-debat-De-la-resistance-a-la-resilience-8770.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

INSERT INTO events (
  id, slug, title, description, category, city_name, postal_code, country_code, timezone,
  location_name, latitude, longitude, location_reveal_at,
  start_at, end_at, end_is_estimated, organizer_name, source_url,
  source_verification_status, publication_status, event_status_override,
  is_demo, published_at, created_at, updated_at
) VALUES (
  'dc5cd691-b662-4c73-9e3a-690e951ac753',
  'ami-discussion-la-perspective-anti-autoritaire-et-l-enfance-2026-12-11-60',
  'Discussion : La perspective anti-autoritaire et l’enfance',
  '"Cependant, avec la conception et la naissance, les parents n''ont pas seulement donné la vie à leurs enfants ; ils les ont en même temps introduits dans un monde. En les éduquant, ils assument la responsabilité de la vie et du développement de l''enfant, mais aussi celle de la continuité du monde. Ces deux responsabilités ne coïncident aucunement et peuvent même entrer en conflit. En un certain sens, cette responsabilité du développement de l''enfant va contre le monde : l''enfant a besoin d''être tout particulièrement protégé et soigné pour éviter que le monde puisse le détruire. Mais ce monde aussi a besoin d''une protection qui l''empêche d''être dévasté et détruit par la vague des nouveaux venus qui déferle sur lui à chaque nouvelle génération. [...] Dans la mesure où l''enfant ne connaît pas encore le monde, on doit l''y introduire petit à petit ; dans la mesure où il est nouveau, on doit veiller à ce que cette chose nouvelle mûrisse en s''insérant dans le monde tel qu''il est. Cependant, de toute façon, vis-à-vis des jeunes, les éducateurs font ici figure d''un monde dont, bien qu''eux-mêmes ne l''aient pas construit, ils doivent assumer la responsabilité, même si, secrètement ou ouverteme',
  'autre',
  'Paris',
  '75019',
  'FR', 'Europe/Paris',
  'Les Fleurs arctiques 45',
  NULL, NULL, NULL,
  '2026-12-11T18:30:00Z'::timestamptz,
  NULL,
  TRUE,
  NULL,
  'https://www.agendamilitant.org/Discussion-La-perspective-anti-autoritaire-et-l-enfance.html',
  'source_provided', 'published', NULL,
  FALSE, now(), now(), now()
);

SELECT count(*) AS ami_events FROM events WHERE slug LIKE 'ami-%';