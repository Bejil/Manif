<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSeoMeta({
  title: SEO.comptage.title,
  description: SEO.comptage.description,
  ogTitle: SEO.comptage.title,
  ogDescription: SEO.comptage.description,
})
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">Méthodologie</p>
      <h1 class="mf-display mf-h2 mt-3 max-w-3xl">
        Comment fonctionne<br>le comptage ?
      </h1>
      <p class="mt-4 max-w-2xl text-lg text-[#FFFCF4]/75">
        Des indicateurs citoyens, volontaires et transparents —
        pas un recensement officiel de la foule.
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div class="prose-manif">
        <p>
          Sur chaque fiche, Manif' affiche deux compteurs indépendants. Ils reposent sur des déclarations
          faites librement, sans compte. Ils ne remplacent ni une estimation physique, ni un comptage institutionnel.
        </p>

        <h2>Deux indicateurs distincts</h2>
        <ul>
          <li>
            <strong>Soutiens</strong> — personnes qui déclarent soutenir le mouvement ou les revendications,
            sans obligation d’être présentes.
          </li>
          <li>
            <strong>Participations déclarées</strong> — personnes qui indiquent qu’elles vont participer
            ou qu’elles participent, avant ou pendant l’événement.
          </li>
        </ul>
        <p>
          Une même personne peut figurer dans les deux compteurs. Ne les additionnez jamais
          comme s’il s’agissait d’individus distincts.
        </p>
        <p class="text-sm text-[#454545]">
          Ces chiffres reposent sur des déclarations volontaires. Ils ne constituent pas un
          comptage officiel des personnes présentes.
        </p>

        <h2>Quand peut-on déclarer ?</h2>
        <ul>
          <li><strong>Soutien</strong> — avant, pendant et après, tant que la fiche est publiée.</li>
          <li><strong>Participation</strong> — avant (« Je vais participer ») et pendant (« Je participe »).</li>
          <li><strong>Après la fin ou en cas d’annulation</strong> — nouvelle participation fermée ; les déclarations déjà faites restent comptabilisées.</li>
          <li><strong>Report</strong> — les soutiens sont conservés ; les participations doivent être reconfirmées pour la nouvelle date.</li>
        </ul>
        <p>
          Aucune confirmation après l’événement n’est demandée. Un clic sur « Je vais participer »
          enregistre une participation déclarée.
        </p>

        <h2>Protection minimale des doublons</h2>
        <p>
          Un jeton stocké localement par événement limite les doubles déclarations depuis le même navigateur.
          Ce n’est pas un compte, ni un profil transversal, ni une garantie d’unicité absolue.
        </p>

        <h2>Ce que les compteurs ne disent pas</h2>
        <ul>
          <li>Ils ne mesurent pas la présence réelle sur place.</li>
          <li>Ils ne classent pas les causes ni ne prouvent une « mobilisation gagnante ».</li>
          <li>Ils ne remplacent pas les estimations des organisateurs, des médias ou des autorités.</li>
        </ul>
        <div class="mt-10">
          <NuxtLink to="/">
            <UiButton>Retour à l’agenda</UiButton>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>
