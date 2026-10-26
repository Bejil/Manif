<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.confidentialite.title,
  description: SEO.confidentialite.description,
  ogTitle: SEO.confidentialite.title,
  ogDescription: SEO.confidentialite.description,
})
const config = useRuntimeConfig()
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Légal</p>
      <h1 class="mf-display mf-h2 mt-3">Confidentialité</h1>
      <p class="mt-4 max-w-2xl text-[#FFFCF4]/75">
        Comment Manif' traite vos données : minimisation, transparence, et contrôle de vos déclarations.
      </p>
    </PageHero>

    <div class="container-page py-10">
    <div class="prose-manif">
    <h2>Responsable du traitement</h2>
    <p>
      {{ config.public.legalEditorName || 'Éditeur Manif\'' }} —
      <a :href="`mailto:${config.public.contactEmail}`">{{ config.public.contactEmail }}</a>
    </p>

    <h2>Principes</h2>
    <ul>
      <li>Minimisation des données.</li>
      <li>Pas de compte pour les participants.</li>
      <li>Pas de suivi individualisé entre événements.</li>
      <li>Pas de tracker publicitaire.</li>
      <li>E-mails des proposants strictement privés.</li>
    </ul>

    <h2>Soutiens et participations (comptage citoyen)</h2>
    <p>
      Finalité : compter de façon participative les soutiens et les participations déclarées
      pour chaque manifestation. Les deux actions sont indépendantes.
    </p>
    <p>
      Données : jeton aléatoire stocké dans votre navigateur (par événement), empreinte
      cryptographique dérivée côté serveur, horodatages de soutien et/ou de participation,
      type de participation (`planned` / `during`). Pas d’adresse IP dans la table des engagements.
    </p>
    <p>
      Base retenue pour le MVP : <strong>consentement</strong> recueilli avant la première déclaration
      (case à cocher informative). Les déclarations (soutien comme participation) peuvent révéler
      des opinions ou convictions (données potentiellement sensibles). Les jetons ne constituent
      pas une anonymisation certaine.
    </p>
    <p>
      Conservation : enregistrements individuels pendant la vie de l’événement puis purge / agrégation
      dans un délai indicatif de 30 jours après clôture (voir <code>docs/PRIVACY_REVIEW.md</code>).
    </p>
    <p>
      Retrait : annuler le soutien à tout moment ; annuler la participation tant que la période
      est ouverte ; sinon contact
      <a :href="`mailto:${config.public.contactEmail}`">{{ config.public.contactEmail }}</a>.
    </p>

    <h2>Propositions d’événements</h2>
    <p>
      E-mail du proposant (privé), contenu proposé, jetons de vérification hachés.
      Finalité : anti-abus et modération avant publication.
    </p>

    <h2>Signalements</h2>
    <p>Motif et description, non publiés automatiquement. Finalité : qualité éditoriale.</p>

    <h2>Sous-traitants</h2>
    <ul>
      <li>Supabase (hébergement PostgreSQL / Auth)</li>
      <li>Hébergeur du serveur applicatif (selon déploiement)</li>
      <li>Resend (e-mails, si configuré)</li>
      <li>Cloudflare Turnstile (antibot, si configuré)</li>
      <li>Fournisseur de tuiles cartographiques (OpenFreeMap / OSM par défaut)</li>
    </ul>

    <h2>Vos droits</h2>
    <p>
      Accès, rectification, effacement, limitation, opposition, réclamation auprès de la CNIL.
      Contact :
      <a :href="`mailto:${config.public.contactEmail}`">{{ config.public.contactEmail }}</a>
      ou
      <NuxtLink to="/contact">page Contact</NuxtLink>.
    </p>
    </div>
    </div>
  </div>
</template>
