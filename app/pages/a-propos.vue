<script setup lang="ts">
import { SEO } from '#shared/content/seo'

useSiteSeo({
  title: SEO.aPropos.title,
  description: SEO.aPropos.description,
  path: '/a-propos',
})
</script>

<template>
  <div>
    <PageHero>
      <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#9C6EE8]">À propos</p>
      <h1 class="mf-display mf-h2 mt-3 max-w-3xl">
        Une plateforme pour voir,<br>
        localiser et compter
      </h1>
      <p class="mt-4 max-w-2xl text-lg text-[#FFFCF4]/75">
        L’outil citoyen qui rassemble l’agenda des manifestations en France —
        sans compte, sans publicité ciblée, sans parti pris.
      </p>
    </PageHero>

    <div class="container-page py-10">
      <div>
        <div class="prose-manif">
          <h2>Notre rôle</h2>
          <p>
            Manif' aide chacune et chacun à découvrir les rassemblements organisés en France métropolitaine
            et ultramarine, à les situer sur une carte, et à participer à un comptage citoyen volontaire.
            Nous fournissons un outil d’information : nous ne soutenons ni ne condamnons les revendications légales affichées.
          </p>

          <h2>Ce à quoi nous nous engageons</h2>
          <ul>
            <li><strong>Neutralité</strong> — ouvert aux manifestations pacifiques et licites, sans favoritisme politique ou religieux.</li>
            <li><strong>Simplicité</strong> — pas de compte public pour consulter, soutenir ou déclarer une participation.</li>
            <li><strong>Transparence</strong> — les compteurs sont des déclarations volontaires, jamais présentés comme un recensement officiel.</li>
            <li><strong>Sobriété des données</strong> — pas de tracking publicitaire, pas de profil transversal entre événements.</li>
            <li><strong>Gratuité</strong> — le service reste accessible à toutes et tous.</li>
          </ul>

          <h2>Comment ça fonctionne</h2>
          <p>
            Les fiches publiées passent par une vérification e-mail du proposant, puis une modération humaine.
            Sur chaque fiche, vous pouvez soutenir le mouvement et/ou déclarer votre participation — deux actions indépendantes.
          </p>
          <p>
            Pour le détail des indicateurs :
            <NuxtLink to="/comptage">comment fonctionne le comptage</NuxtLink>.
          </p>

          <h2>Ce que Manif' n’est pas</h2>
          <ul>
            <li>Ni un réseau social, ni un chat.</li>
            <li>Ni un dispositif d’alerte ou de suivi d’incidents en temps réel.</li>
            <li>Ni une estimation physique de foule ou un comptage officiel.</li>
          </ul>
        </div>

        <div class="mt-10 flex flex-wrap gap-3">
          <NuxtLink to="/">
            <UiButton>Voir l’agenda</UiButton>
          </NuxtLink>
          <NuxtLink to="/proposer">
            <UiButton variant="outline">Proposer une manifestation</UiButton>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>
