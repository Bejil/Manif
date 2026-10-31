<script setup lang="ts">
import type { SubmissionModerationStatus } from '#shared/types/submission'
import { categoryLabel } from '#shared/constants/categories'
import { DATE_PENDING_LABEL } from '#shared/utils/event-time'

const props = defineProps<{
  proposal: {
    id: string
    title: string
    cityName: string
    category: string
    startAt: string | null
    moderationStatus: SubmissionModerationStatus
    verificationStatus: string
    rejectionReason: string | null
    event: {
      id: string
      slug: string
      title: string
      cityName: string
      startAt: string | null
      displayStatus: string
      counts: { views: number, supports: number, participations: number }
    } | null
  }
}>()

const { formatDate } = useEventFormat()

const statusMeta: Record<SubmissionModerationStatus, { label: string, class: string }> = {
  awaiting_verification: { label: 'E-mail à confirmer', class: 'bg-[#FFF8E8] text-[#805200]' },
  pending_moderation: { label: 'En modération', class: 'bg-[#F0E8FC] text-[#4D257D]' },
  changes_requested: { label: 'Modifications demandées', class: 'bg-[#FFF8E8] text-[#805200]' },
  approved: { label: 'Publiée', class: 'bg-[#E8F5EF] text-[#206C4D]' },
  rejected: { label: 'Refusée', class: 'bg-[#FDEDEB] text-[#97251B]' },
}

const meta = computed(() => statusMeta[props.proposal.moderationStatus])
const published = computed(() => props.proposal.event)
const href = computed(() => published.value ? `/manifestations/${published.value.slug}` : null)

const dateLabel = computed(() => {
  const start = published.value?.startAt ?? props.proposal.startAt
  if (!start) return DATE_PENDING_LABEL
  return formatDate(start)
})

function fmt(n: number) {
  return n.toLocaleString('fr-FR')
}
</script>

<template>
  <article class="rounded-[8px] border border-[#DDDAD3] border-l-[5px] border-l-[#9C6EE8] bg-white px-3.5 py-2.5">
    <div class="flex flex-wrap items-center gap-x-2 gap-y-1">
      <span class="chip inline-flex items-center" :class="meta.class">
        {{ meta.label }}
      </span>
      <span class="chip inline-flex items-center gap-1 bg-[#F0E8FC] text-[#4D257D]">
        Je propose
      </span>
      <span class="text-[11px] font-semibold uppercase tracking-wide text-[#636363]">
        {{ categoryLabel(proposal.category) }}
      </span>
    </div>

    <p class="mt-1 text-xs font-bold text-[#4D257D]">
      {{ dateLabel }} · {{ published?.cityName || proposal.cityName }}
    </p>

    <h3 class="mt-0.5 text-base font-extrabold leading-snug text-[#111111]">
      <NuxtLink
        v-if="href"
        :to="href"
        class="hover:text-[#6735B6] hover:underline"
      >
        {{ published?.title || proposal.title }}
      </NuxtLink>
      <span v-else>{{ proposal.title }}</span>
    </h3>

    <p
      v-if="proposal.moderationStatus === 'rejected' && proposal.rejectionReason"
      class="mt-1 text-xs text-[#97251B]"
    >
      {{ proposal.rejectionReason }}
    </p>
    <p
      v-else-if="proposal.moderationStatus === 'awaiting_verification'"
      class="mt-1 text-xs text-[#636363]"
    >
      Confirmez l’e-mail reçu pour envoyer la proposition en modération.
    </p>
    <p
      v-else-if="proposal.moderationStatus === 'pending_moderation'"
      class="mt-1 text-xs text-[#636363]"
    >
      En file d’examen — les stats apparaîtront après publication.
    </p>
    <p
      v-else-if="proposal.moderationStatus === 'changes_requested'"
      class="mt-1 text-xs text-[#636363]"
    >
      Des précisions ont été demandées par e-mail.
    </p>

    <div
      v-if="published"
      class="mt-1.5 flex flex-wrap items-center justify-between gap-2"
    >
      <div class="flex flex-wrap gap-1.5 text-[11px] font-bold">
        <span class="inline-flex items-center gap-1 rounded-full border border-[#DDDAD3] px-2 py-0.5 text-[#454545]">
          <BrandIcon name="views" :size="12" />
          {{ fmt(published.counts.views) }}
        </span>
        <span class="inline-flex items-center gap-1 rounded-full border border-[#DDDAD3] px-2 py-0.5 text-[#4D257D]">
          <BrandIcon name="support" :size="12" />
          {{ fmt(published.counts.supports) }}
        </span>
        <span class="inline-flex items-center gap-1 rounded-full border border-[#DDDAD3] px-2 py-0.5 text-[#97251B]">
          <BrandIcon name="participate" :size="12" />
          {{ fmt(published.counts.participations) }}
        </span>
      </div>
      <NuxtLink
        :to="href!"
        class="shrink-0 text-xs font-bold text-[#6735B6] underline-offset-2 hover:underline"
      >
        Voir la fiche&nbsp;>
      </NuxtLink>
    </div>
  </article>
</template>
