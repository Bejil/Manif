<script setup lang="ts">
const props = defineProps<{
  open: boolean
  title: string
}>()

const emit = defineEmits<{ close: [] }>()
const dialog = ref<HTMLDialogElement | null>(null)

watch(() => props.open, async (v) => {
  await nextTick()
  if (!dialog.value) return
  if (v && !dialog.value.open) dialog.value.showModal()
  if (!v && dialog.value.open) dialog.value.close()
})

function onClose() {
  emit('close')
}
</script>

<template>
  <dialog
    ref="dialog"
    class="m-auto max-h-[min(92vh,40rem)] w-[min(calc(100%-1.5rem),28rem)] overflow-y-auto rounded-xl border-0 bg-white p-0 shadow-soft backdrop:bg-brand-deep/40"
    @close="onClose"
  >
    <div class="p-5">
      <div class="flex items-start justify-between gap-3">
        <h2 class="text-lg font-semibold text-brand-deep">{{ title }}</h2>
        <button
          type="button"
          class="shrink-0 rounded-md p-1 text-ink-muted hover:bg-surface-muted hover:text-ink"
          aria-label="Fermer"
          @click="dialog?.close()"
        >
          ✕
        </button>
      </div>
      <div class="mt-4">
        <slot />
      </div>
      <div v-if="$slots.footer" class="mt-6 flex justify-end gap-2">
        <slot name="footer" />
      </div>
    </div>
  </dialog>
</template>
