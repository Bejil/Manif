<script setup lang="ts">
import { EVENT_CATEGORIES } from '#shared/constants/categories'

const props = withDefaults(defineProps<{
  /** Affiche le filtre publication (admin) */
  showPublication?: boolean
  /** Affiche le filtre statut (admin / mes manifs) */
  showStatuses?: boolean
  /** Affiche le tri date / thème (dans le formulaire) */
  showSort?: boolean
  /** Bouton « Rechercher » : les critères ne s’appliquent qu’au clic / Entrée */
  manualSubmit?: boolean
  /** Liens vers pages villes (SEO) */
  popularCities?: Array<{ name: string, slug: string }>
  /** Préfixe d’id pour éviter les collisions */
  idPrefix?: string
}>(), {
  showPublication: false,
  showStatuses: false,
  showSort: false,
  manualSubmit: false,
  popularCities: () => [],
  idPrefix: 'filter',
})

const emit = defineEmits<{
  search: []
}>()

const q = defineModel<string>('q', { default: '' })
const category = defineModel<string>('category', { default: '' })
const statuses = defineModel<string[]>('statuses', {
  default: () => ['upcoming', 'ongoing'],
})
const publication = defineModel<string>('publication', { default: '' })
/** `date` (défaut) ou `category` (thème) */
const sort = defineModel<'date' | 'category'>('sort', { default: 'date' })

const statusOptions = [
  { id: 'ongoing', label: 'En cours' },
  { id: 'upcoming', label: 'À venir' },
  { id: 'past', label: 'Terminées' },
  { id: 'cancelled', label: 'Annulées' },
  { id: 'postponed', label: 'Reportées' },
]

function toggleStatus(id: string) {
  if (statuses.value.includes(id)) {
    statuses.value = statuses.value.filter(s => s !== id)
  }
  else {
    statuses.value = [...statuses.value, id]
  }
}

function submit() {
  emit('search')
}

function onFormSubmit(e: Event) {
  e.preventDefault()
  if (props.manualSubmit) submit()
}
</script>

<template>
  <form
    class="space-y-4 rounded-[8px] border border-[#DDDAD3] bg-white p-4 shadow-soft sm:p-5"
    @submit="onFormSubmit"
  >
    <div v-if="showStatuses">
      <p class="mb-2 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">Statut</p>
      <div class="flex flex-wrap gap-2">
        <button
          v-for="opt in statusOptions"
          :key="opt.id"
          type="button"
          class="rounded-[3px] px-3.5 py-2 text-sm font-bold transition"
          :class="statuses.includes(opt.id)
            ? 'bg-[#111111] text-[#FFFCF4]'
            : 'bg-[#F4F1EA] text-[#111111] hover:bg-[#DDDAD3]'"
          :aria-pressed="statuses.includes(opt.id)"
          @click="toggleStatus(opt.id)"
        >
          {{ opt.label }}
        </button>
      </div>
    </div>

    <div
      class="grid gap-4"
      :class="manualSubmit
        ? 'sm:grid-cols-[minmax(0,1.2fr)_minmax(0,1fr)_auto]'
        : 'sm:grid-cols-2'"
    >
      <div>
        <label :for="`${idPrefix}-q`" class="mb-2 block text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
          Localisation
        </label>
        <div class="relative">
          <span class="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-[#636363]" aria-hidden="true">
            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
          </span>
          <input
            :id="`${idPrefix}-q`"
            v-model="q"
            type="search"
            placeholder="Ville, titre…"
            class="min-h-[48px] w-full rounded-[4px] border border-[#636363] bg-white py-3 pl-11 pr-4 font-medium text-[#111111] placeholder:text-[#636363] focus:border-[#6735B6] focus:outline-none focus:ring-[3px] focus:ring-[#6735B6]/30"
          >
        </div>
      </div>

      <div>
        <label :for="`${idPrefix}-category`" class="mb-2 block text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
          Catégorie
        </label>
        <select
          :id="`${idPrefix}-category`"
          v-model="category"
          class="min-h-[48px] w-full rounded-[4px] border border-[#636363] bg-white px-3.5 py-2.5 text-sm font-semibold"
        >
          <option value="">Toutes</option>
          <option v-for="c in EVENT_CATEGORIES" :key="c.id" :value="c.id">{{ c.label }}</option>
        </select>
      </div>

      <div v-if="manualSubmit" class="flex items-end">
        <UiButton type="submit" class="min-h-[48px] w-full sm:w-auto" aria-label="Rechercher">
          <svg class="size-5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.25" d="M21 21l-4.35-4.35M11 18a7 7 0 100-14 7 7 0 000 14z" />
          </svg>
          <span>Rechercher</span>
        </UiButton>
      </div>
    </div>

    <div v-if="popularCities.length" class="pt-1">
      <p class="mb-2 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
        Villes populaires
      </p>
      <div class="flex flex-wrap gap-2">
        <NuxtLink
          v-for="c in popularCities"
          :key="c.slug"
          :to="`/manifestations/ville/${c.slug}`"
          class="rounded-[4px] border border-[#DDDAD3] bg-[#FFFCF4] px-2.5 py-1.5 text-xs font-bold text-[#111111] transition hover:border-[#9C6EE8] hover:text-[#6735B6]"
        >
          {{ c.name }}
        </NuxtLink>
      </div>
    </div>

    <div
      v-if="showSort || showPublication"
      class="grid gap-4"
      :class="showSort && showPublication ? 'sm:grid-cols-2' : ''"
    >
      <div v-if="showSort">
        <label :for="`${idPrefix}-sort`" class="mb-2 block text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
          Trier par
        </label>
        <select
          :id="`${idPrefix}-sort`"
          v-model="sort"
          class="min-h-[48px] w-full rounded-[4px] border border-[#636363] bg-white px-3.5 py-2.5 text-sm font-semibold"
        >
          <option value="date">Date</option>
          <option value="category">Thème</option>
        </select>
      </div>

      <div v-if="showPublication">
        <label :for="`${idPrefix}-publication`" class="mb-2 block text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
          Publication
        </label>
        <select
          :id="`${idPrefix}-publication`"
          v-model="publication"
          class="min-h-[48px] w-full rounded-[4px] border border-[#636363] bg-white px-3.5 py-2.5 text-sm font-semibold"
        >
          <option value="">Toutes</option>
          <option value="published">Publié</option>
          <option value="draft">Brouillon</option>
          <option value="unpublished">Dépublié</option>
        </select>
      </div>
    </div>
  </form>
</template>
