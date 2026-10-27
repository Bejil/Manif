<script setup lang="ts">
withDefaults(defineProps<{
  eventId: string
  title: string
  cityName: string
  shareUrl: string
  /** Affiche le lien calendrier (événement daté) */
  showCalendar?: boolean
  /** Style pour hero sombre */
  dark?: boolean
}>(), {
  showCalendar: true,
  dark: false,
})

defineEmits<{
  report: []
}>()
</script>

<template>
  <div class="flex flex-wrap items-start gap-2">
    <EventShareMenu
      :title="title"
      :city-name="cityName"
      :url="shareUrl"
      :button-class="dark
        ? '!border-[#FFFCF4]/50 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10 hover:!border-[#FFFCF4]'
        : undefined"
    />
    <a
      v-if="showCalendar"
      :href="`/api/events/${eventId}/calendar`"
    >
      <UiButton
        variant="outline"
        type="button"
        :class="dark
          ? '!border-[#FFFCF4]/50 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10 hover:!border-[#FFFCF4]'
          : undefined"
      >
        <BrandIcon name="calendar" :size="16" />
        Calendrier
      </UiButton>
    </a>
    <UiButton
      variant="outline"
      type="button"
      :class="dark
        ? '!border-[#FFFCF4]/50 !bg-transparent !text-[#FFFCF4] hover:!bg-white/10 hover:!border-[#FFFCF4]'
        : undefined"
      @click="$emit('report')"
    >
      Signaler
    </UiButton>
  </div>
</template>
