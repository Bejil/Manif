<script setup lang="ts">
const { open, locationHint, dismiss, markSubscribed } = useAlertPrompt()

function onSuccess() {
  markSubscribed()
}

function onClose() {
  dismiss()
}
</script>

<template>
  <ClientOnly>
    <UiModal
      :open="open"
      title="Recevoir les alertes près de vous ?"
      @close="onClose"
    >
      <p class="mb-4 text-sm text-[#454545]">
        Vous venez de vous engager. Activez une alerte e-mail pour les nouvelles manifestations
        autour de
        <template v-if="locationHint">
          <strong class="text-[#111111]">{{ locationHint }}</strong>
        </template>
        <template v-else>
          votre lieu
        </template>
        — sans créer de compte.
      </p>
      <AlertSignupForm
        id-prefix="modal-alert"
        compact
        :initial-location-label="locationHint"
        @success="onSuccess"
      />
      <template #footer>
        <button
          type="button"
          class="text-sm font-semibold text-[#636363] hover:text-[#111111]"
          @click="dismiss"
        >
          Non merci
        </button>
      </template>
    </UiModal>
  </ClientOnly>
</template>
