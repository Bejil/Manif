<script setup lang="ts">
export interface HistoryChange {
  field: string
  label: string
  before: string
  after: string
}

export interface HistoryItem {
  id: string
  action: string
  label: string
  detail: string | null
  changes?: HistoryChange[] | null
  actorId: string
  createdAt: string
}

defineProps<{
  items: HistoryItem[]
  title?: string
}>()

function formatWhen(iso: string) {
  try {
    return new Date(iso).toLocaleString('fr-FR', {
      dateStyle: 'short',
      timeStyle: 'short',
    })
  }
  catch {
    return iso
  }
}

function truncate(s: string, max = 280) {
  const t = s.trim()
  if (t.length <= max) return t
  return `${t.slice(0, max)}…`
}
</script>

<template>
  <section class="rounded-[8px] border border-[#DDDAD3] bg-white p-4">
    <p class="text-xs font-bold uppercase tracking-[0.16em] text-[#D1271C]">
      {{ title || 'Historique' }}
    </p>
    <ul v-if="items.length" class="mt-4 space-y-0">
      <li
        v-for="(entry, i) in items"
        :key="entry.id"
        class="relative border-l-2 border-[#DDDAD3] pl-4 pb-4 last:pb-0"
        :class="i === 0 ? 'border-[#9C6EE8]' : ''"
      >
        <span
          class="absolute -left-[5px] top-1.5 size-2 rounded-full"
          :class="i === 0 ? 'bg-[#6735B6]' : 'bg-[#DDDAD3]'"
          aria-hidden="true"
        />
        <p class="text-sm font-bold text-[#111111]">{{ entry.label }}</p>
        <p class="mt-0.5 text-xs text-[#636363]">
          {{ formatWhen(entry.createdAt) }}
          <span v-if="entry.actorId"> · {{ entry.actorId }}</span>
        </p>

        <ul v-if="entry.changes?.length" class="mt-2 space-y-2">
          <li
            v-for="change in entry.changes"
            :key="change.field"
            class="rounded-[4px] bg-[#F4F1EA] px-3 py-2 text-sm text-[#454545]"
          >
            <p class="font-bold text-[#111111]">{{ change.label }}</p>
            <p class="mt-1">
              <span class="text-xs font-semibold uppercase tracking-wide text-[#636363]">Avant</span>
              <span class="mt-0.5 block whitespace-pre-wrap">{{ truncate(change.before) }}</span>
            </p>
            <p class="mt-2">
              <span class="text-xs font-semibold uppercase tracking-wide text-[#636363]">Après</span>
              <span class="mt-0.5 block whitespace-pre-wrap">{{ truncate(change.after) }}</span>
            </p>
          </li>
        </ul>

        <p
          v-else-if="entry.detail"
          class="mt-2 whitespace-pre-wrap rounded-[4px] bg-[#F4F1EA] px-3 py-2 text-sm text-[#454545]"
        >
          {{ entry.detail }}
        </p>
      </li>
    </ul>
    <p v-else class="mt-3 text-sm text-[#636363]">
      Aucune entrée pour le moment.
    </p>
  </section>
</template>
