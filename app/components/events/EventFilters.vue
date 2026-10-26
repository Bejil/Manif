<script setup lang="ts">
import { EVENT_CATEGORIES } from '#shared/constants/categories'

withDefaults(defineProps<{
  /** Affiche le filtre publication (admin) */
  showPublication?: boolean
  /** Préfixe d’id pour éviter les collisions */
  idPrefix?: string
}>(), {
  showPublication: false,
  idPrefix: 'filter',
})

const q = defineModel<string>('q', { default: '' })
const category = defineModel<string>('category', { default: '' })
const statuses = defineModel<string[]>('statuses', {
  default: () => ['upcoming', 'ongoing'],
})
const publication = defineModel<string>('publication', { default: '' })

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
</script>

<template>
  <div class="space-y-4 rounded-[8px] border border-[#DDDAD3] bg-white p-4 shadow-soft sm:p-5">
    <div class="relative">
      <label :for="`${idPrefix}-q`" class="sr-only">Rechercher une manifestation</label>
      <span class="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-[#636363]" aria-hidden="true">
        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35M11 18a7 7 0 100-14 7 7 0 000 14z"/></svg>
      </span>
      <input
        :id="`${idPrefix}-q`"
        v-model="q"
        type="search"
        placeholder="Ville, titre, thème…"
        class="min-h-[48px] w-full rounded-[4px] border border-[#636363] bg-white py-3 pl-11 pr-4 font-medium text-[#111111] placeholder:text-[#636363] focus:border-[#6735B6] focus:outline-none focus:ring-[3px] focus:ring-[#6735B6]/30"
      >
    </div>

    <div>
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

    <div class="grid gap-4 sm:grid-cols-2">
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
  </div>
</template>
