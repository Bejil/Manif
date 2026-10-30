<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSiteSeo({
  title: SEO.guide.title,
  description: SEO.guide.description,
  path: '/guide',
})

const sections = [
  {
    id: 'trouver',
    icon: 'map' as const,
    title: 'Trouver une manifestation',
    lead: 'Avant de préparer votre journée, repérez le bon événement.',
    paragraphs: [
      'Manif\' regroupe un agenda de manifestations en France : date, ville, lieu de rendez-vous, carte et lien vers la source quand il est disponible. Partez d\'une fiche claire plutôt que d\'un simple partage flou sur les réseaux.',
    ],
    items: [
      'Consultez l’agenda et la carte sur Manif\' pour localiser un rassemblement près de chez vous.',
      'Vérifiez la ville, le point de départ, l’horaire de début et, si indiqué, l’heure de fin ou le caractère estimé de la fin.',
      'Ouvrez la source (site, page d’organisateur, tract) pour confirmer le parcours et les consignes du jour.',
      'En cas d’annulation, de report ou de lieu encore à préciser, basez-vous sur le statut affiché sur la fiche et sur la communication la plus récente des organisateurs.',
    ],
  },
  {
    id: 'avant',
    icon: 'calendar' as const,
    title: 'Avant de partir',
    lead: 'Quelques minutes de préparation changent une journée.',
    paragraphs: [
      'Une manifestation dure souvent plus longtemps que prévu : transports saturés, attentes, détours, météo changeante. Anticiper réduit le stress et limite les imprévus.',
    ],
    items: [
      'Relisez la fiche Manif\' le matin même : horaire, lieu de rendez-vous et éventuelles mises à jour.',
      'Consultez la météo et adaptez chaussures, couches et protection (pluie, soleil, froid).',
      'Anticipez le trajet : transports en commun, horaires de retour, accessibilité, alternatives si une station est fermée.',
      'Prévenez un proche de votre participation, du lieu approximatif et de l’heure de retour prévue.',
      'Chargez votre téléphone, notez un point de rendez-vous de repli avec vos ami·es, et gardez de l’eau dès le départ.',
      'Si vous venez avec des enfants ou une personne vulnérable, prévoyez une sortie facile du cortège et un plan B.',
    ],
  },
  {
    id: 'sac',
    icon: 'guide' as const,
    title: 'Dans votre sac',
    lead: 'Léger, utile, adapté à la durée.',
    paragraphs: [
      'L’idée n’est pas de tout emporter, mais d’éviter les manques qui fatiguent : soif, faim, téléphone à plat, pluie soudaine.',
    ],
    items: [
      'Eau en quantité suffisante pour la durée prévue — et un peu plus s’il fait chaud.',
      'Encas simple (fruits secs, barre, sandwich) pour tenir entre deux pauses.',
      'Téléphone chargé et, si possible, batterie externe et câble.',
      'Protection adaptée à la météo : coupe-vent, poncho, casquette, crème solaire selon la saison.',
      'Médicaments personnels nécessaires, et une pièce d’identité si vous choisissez de la porter.',
      'Un peu d’argent liquide ou un moyen de paiement pour un transport de retour imprévu.',
      'Mouchoirs, lingettes ou petit nécessaire de confort ; évitez le superflu qui alourdit.',
    ],
  },
  {
    id: 'habiller',
    icon: 'participate' as const,
    title: 'S’habiller pour marcher',
    lead: 'Confort d’abord, longtemps.',
    paragraphs: [
      'Une manifestation, c’est souvent de la marche, de l’attente et des variations de rythme. Des vêtements confortables valent mieux qu’une tenue spectaculaire mais inadaptée.',
    ],
    items: [
      'Chaussures fermées et adaptées à une longue marche sur bitume ou pavés.',
      'Vêtements selon la saison, idéalement en couches pour ajuster la chaleur.',
      'Protection pluie ou soleil dès le départ si les prévisions sont douteuses.',
      'Évitez ce qui accroche, glisse ou fatigue trop vite (talons, sandales trop ouvertes, sacs trop lourds).',
      'Prévoyez de pouvoir vous reconnaître facilement dans un groupe (foulard, badge, couleur convenue).',
    ],
  },
  {
    id: 'sur-place',
    icon: 'voices' as const,
    title: 'Sur place',
    lead: 'Garder le fil : groupe, consignes, sécurité.',
    paragraphs: [
      'Arriver un peu en avance aide à trouver le point de rendez-vous, rejoindre son groupe et écouter les consignes des organisateurs avant le départ du cortège.',
    ],
    items: [
      'Rejoignez le lieu indiqué sur la fiche ; en cas de doute, suivez la source de l’organisateur plutôt qu’une rumeur de dernière minute.',
      'Restez attentif·ve aux consignes de sécurité et aux changements de parcours annoncés sur place.',
      'Fixez un point de regroupement si vous êtes séparé·e de vos proches.',
      'Hydratez-vous, faites des pauses si besoin, et ne forcez pas au-delà de votre forme du jour.',
      'Photographies et réseaux : respectez les personnes filmées ; demandez avant de publier un visage identifiable, surtout celui d’un mineur.',
    ],
  },
  {
    id: 'respect',
    icon: 'share' as const,
    title: 'Respecter les autres',
    lead: 'Le collectif commence par l’attention.',
    paragraphs: [
      'Une manifestation pacifique repose sur la dignité de chacune et chacun. Le respect n’est pas un détail : il conditionne la sécurité et la lisibilité de l’appel.',
    ],
    items: [
      'Respect des personnes, de leur dignité et de leur diversité.',
      'Respect des biens publics et privés ; aucune dégradation n’est « anodine ».',
      'Attention particulière aux enfants, personnes âgées, personnes en situation de handicap et personnes vulnérables.',
      'Non-violence dans les gestes, les slogans et les interactions.',
      'Respect des consignes de sécurité sur place et des espaces laissés libres pour les secours.',
      'Si une situation dégénère près de vous, éloignez-vous plutôt que d’alimenter la confusion.',
    ],
  },
  {
    id: 'access',
    icon: 'support' as const,
    title: 'Accessibilité et rythme',
    lead: 'Tout le monde ne manifeste pas au même tempo.',
    paragraphs: [
      'Les cortèges peuvent être longs, bruyants et denses. Pensez à celles et ceux pour qui l’accès, la fatigue ou le stress sensoriel changent l’expérience.',
    ],
    items: [
      'Repérez à l’avance les transports accessibles et les sorties possibles du parcours.',
      'Prévoyez des pauses, de l’eau et un moyen de quitter le cortège sans paniquer.',
      'Si vous accompagnez une personne à mobilité réduite, vérifiez le point de départ et les zones plus calmes.',
      'Casques anti-bruit, lunettes de soleil ou masques confortables peuvent aider selon les sensibilités.',
      'Il est légitime de partir plus tôt : la participation n’exige pas de tenir jusqu’à la fin.',
    ],
  },
  {
    id: 'droits',
    icon: 'calendar' as const,
    title: 'Droits et obligations',
    lead: 'Informations générales — pas un conseil juridique.',
    paragraphs: [
      'Le droit de manifestation est un droit encadré. Manif\' rappelle des repères généraux pour s’orienter ; pour une situation personnelle, seuls un·e professionnel·le du droit ou les textes officiels font foi.',
    ],
    items: [
      'Le droit de manifestation est encadré par le droit français ; les modalités (déclaration, lieux, horaires) dépendent du contexte.',
      'Violences, dégradations et certaines entraves sont interdites et peuvent entraîner des poursuites.',
      'Les consignes des forces de l’ordre et des organisateurs sur place doivent être prises au sérieux pour votre sécurité.',
      'Consultez service-public.fr et Légifrance pour les textes et démarches à jour ; ne vous fiez pas aux résumés incomplets circulant en ligne.',
      'Manif\' ne fournit pas d’assistance juridique personnalisée et ne se substitue pas aux organisateurs.',
    ],
  },
  {
    id: 'urgence',
    icon: 'map' as const,
    title: 'En cas de problème',
    lead: 'Priorité à votre sécurité.',
    paragraphs: [
      'Si la situation devient dangereuse ou confuse, l’objectif n’est pas de « tout voir » : c’est de vous mettre à l’abri et d’alerter les secours si besoin.',
    ],
    items: [
      'Éloignez-vous d’une zone dangereuse ; cherchez un espace plus calme ou une sortie latérale.',
      'Contactez les secours si une personne est blessée, en détresse ou menacée.',
      '15 SAMU · 17 police / gendarmerie · 18 pompiers · 112 Europe · 114 sourds et malentendants (SMS, fax, appli).',
      'Prévenez un proche de votre situation dès que vous êtes en sécurité.',
      'Conservez les éléments utiles (heure, lieu approximatif) si un signalement ou un témoignage devient nécessaire plus tard.',
    ],
  },
  {
    id: 'apres',
    icon: 'participate' as const,
    title: 'Après la manifestation',
    lead: 'Revenir, récupérer, garder le lien utile.',
    paragraphs: [
      'Le retour fait partie de la journée : transports chargés, fatigue, hydratation. Prenez le temps de rentrer sereinement.',
    ],
    items: [
      'Hydratez-vous, mangez, reposez-vous ; une longue marche fatigue plus qu’on ne le croit.',
      'Si vous avez déclaré un soutien ou une participation sur Manif\', vous pouvez le retirer plus tard depuis la fiche.',
      'Pour faire connaître un événement à venir, partagez la fiche Manif\' plutôt qu’un extrait incomplet.',
      'Vous avez repéré une erreur sur la fiche (horaire, lieu, annulation) ? Signalez-la pour aider les prochaines personnes.',
      'Si vous organisez une prochaine mobilisation pacifique, proposez-la sur Manif\' avec une source claire.',
    ],
  },
]
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Guide</p>
      <h1 class="mf-display mf-h2 mt-3 max-w-3xl text-[#FFFCF4]">
        Guide du<br>
        <HighlightedText tone="violet">manifestant</HighlightedText>
      </h1>
      <p class="mt-4 max-w-2xl text-[#FFFCF4]/75">
        Préparer une journée de manifestation en France : trouver l’événement,
        s’équiper, rester respectueux·se, connaître les bons réflexes.
        Des repères concrets — pas un avis juridique personnalisé.
      </p>
    </PageHero>

    <div class="container-page space-y-6 py-12 md:py-16">
      <article
        v-for="(section, index) in sections"
        :id="section.id"
        :key="section.id"
        class="grid items-start gap-6 rounded-[8px] border border-[#DDDAD3] bg-white p-6 shadow-soft md:grid-cols-[auto_1fr] md:gap-8 md:p-8"
        :class="index % 2 === 1 ? 'md:bg-[#F0E8FC]/50' : ''"
      >
        <div class="flex h-14 w-14 items-center justify-center rounded-[4px] bg-[#111111] text-[#FFFCF4]">
          <BrandIcon :name="section.icon" :size="28" />
        </div>
        <div>
          <h2 class="mf-display text-2xl text-[#111111] md:text-3xl">
            {{ section.title }}
          </h2>
          <p class="mt-1 text-sm text-[#454545]">{{ section.lead }}</p>
          <div v-if="section.paragraphs?.length" class="mt-3 space-y-2">
            <p
              v-for="(p, pi) in section.paragraphs"
              :key="pi"
              class="text-sm leading-relaxed text-[#111111]"
            >
              {{ p }}
            </p>
          </div>
          <ul class="mt-4 space-y-2 text-[#111111]">
            <li
              v-for="item in section.items"
              :key="item"
              class="flex gap-3 text-sm leading-relaxed"
            >
              <span class="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-[#D1271C]" aria-hidden="true" />
              <span>{{ item }}</span>
            </li>
          </ul>
          <p v-if="section.id === 'droits'" class="mt-4 text-sm text-[#454545]">
            Sources :
            <a href="https://www.service-public.fr" class="font-semibold text-[#6735B6] underline" rel="noopener noreferrer" target="_blank">service-public.fr</a>
            ·
            <a href="https://www.legifrance.gouv.fr" class="font-semibold text-[#6735B6] underline" rel="noopener noreferrer" target="_blank">Légifrance</a>
            · Relecture éditoriale : octobre 2026
          </p>
        </div>
      </article>
    </div>

    <section class="border-t border-[#DDDAD3] bg-[#111111] text-[#FFFCF4]">
      <div class="container-page flex flex-col items-start gap-5 py-12 md:flex-row md:items-center md:justify-between">
        <div>
          <h2 class="mf-display text-2xl md:text-3xl">Prêt·e à consulter l’agenda ?</h2>
          <p class="mt-1 text-sm text-[#FFFCF4]/65">
            Trouvez une manifestation près de chez vous, sur la carte et dans l’agenda Manif'.
          </p>
        </div>
        <div class="flex flex-wrap gap-3">
          <NuxtLink to="/">
            <UiButton variant="red">Voir les manifestations</UiButton>
          </NuxtLink>
          <NuxtLink to="/faq">
            <UiButton
              variant="outline"
              class="!border-[#FFFCF4]/40 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10"
            >
              FAQ
            </UiButton>
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>
