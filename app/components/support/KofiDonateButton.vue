<script setup lang="ts">
import { resolveKofiConfig } from '#shared/utils/kofi'

/**
 * Bouton « Supporter Manif' » aligné sur le sticky Ko-fi :
 * même look, ouvre le widget overlay (pas de nouvel onglet).
 */
const props = withDefaults(defineProps<{
  label?: string
  color?: string
}>(), {
  label: "Supporter Manif'",
  color: '#794bc4',
})

const CUP_SRC = 'https://storage.ko-fi.com/cdn/logomarkLogo.png'

const config = useRuntimeConfig()
const kofi = computed(() => resolveKofiConfig({
  username: String(config.public.kofiUsername || ''),
  url: String(config.public.kofiUrl || ''),
}))

const { openKofiOverlayWhenReady } = useKofiOverlay()

function onClick() {
  openKofiOverlayWhenReady()
}
</script>

<template>
  <button
    v-if="kofi"
    type="button"
    class="kofi-donate-button"
    :style="{ backgroundColor: color }"
    @click="onClick"
  >
    <img
      :src="CUP_SRC"
      alt=""
      width="39"
      height="39"
      class="kofiimg"
      decoding="async"
    >
    <span class="kofitext">{{ label }}</span>
  </button>
</template>
