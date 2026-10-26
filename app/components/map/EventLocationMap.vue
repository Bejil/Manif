<script setup lang="ts">
const props = withDefaults(defineProps<{
  latitude: number
  longitude: number
  label?: string
  /** Zoom initial (ville ≈ 11, lieu ≈ 14) */
  zoom?: number
}>(), {
  zoom: 14,
})

const config = useRuntimeConfig()
const rootEl = ref<HTMLElement | null>(null)
const mapEl = ref<HTMLElement | null>(null)
const mapError = ref<string | null>(null)
const mapReady = ref(false)

let maplibregl: typeof import('maplibre-gl') | null = null
let map: import('maplibre-gl').Map | null = null
let marker: import('maplibre-gl').Marker | null = null
let resizeObserver: ResizeObserver | null = null

function centerLngLat(): [number, number] {
  return [Number(props.longitude), Number(props.latitude)]
}

function placeMarker(lngLat: [number, number]) {
  if (!map || !maplibregl) return
  if (marker) {
    marker.setLngLat(lngLat)
    return
  }
  const el = document.createElement('div')
  el.setAttribute('aria-hidden', 'true')
  Object.assign(el.style, {
    width: '22px',
    height: '22px',
    borderRadius: '50% 50% 50% 0',
    background: '#6735B6',
    border: '3px solid #FFFCF4',
    boxShadow: '0 2px 8px rgb(17 17 17 / 35%)',
    transform: 'rotate(-45deg)',
  })
  marker = new maplibregl.Marker({ element: el, anchor: 'bottom' })
    .setLngLat(lngLat)
    .addTo(map)
}

function scheduleResize() {
  if (!map) return
  requestAnimationFrame(() => {
    map?.resize()
    requestAnimationFrame(() => map?.resize())
  })
}

async function initMap() {
  if (!import.meta.client || !mapEl.value || map) return

  const lngLat = centerLngLat()
  if (!Number.isFinite(lngLat[0]) || !Number.isFinite(lngLat[1])) {
    mapError.value = 'Coordonnées invalides pour afficher la carte.'
    return
  }

  try {
    maplibregl = await import('maplibre-gl')
    await import('maplibre-gl/dist/maplibre-gl.css')
    maplibregl.setWorkerUrl(`${window.location.origin}/maplibre-gl-worker.mjs`)

    map = new maplibregl.Map({
      container: mapEl.value,
      style: config.public.mapStyleUrl || 'https://tiles.openfreemap.org/styles/liberty',
      center: lngLat,
      zoom: props.zoom,
      attributionControl: true,
    })

    map.addControl(new maplibregl.NavigationControl({ showCompass: false }), 'top-right')

    map.on('error', (e) => {
      console.error('[event-map]', e.error)
      if (!mapReady.value) {
        mapError.value = 'La carte n\'a pas pu charger les tuiles.'
      }
    })

    map.on('load', () => {
      if (!map) return
      mapError.value = null
      mapReady.value = true
      placeMarker(lngLat)
      scheduleResize()
      // Conteneur parfois encore en layout après ClientOnly
      setTimeout(() => scheduleResize(), 100)
      setTimeout(() => scheduleResize(), 400)
    })
  }
  catch (e) {
    console.error(e)
    mapError.value = 'La carte n\'a pas pu être chargée.'
  }
}

watch(
  () => [props.latitude, props.longitude, props.zoom] as const,
  () => {
    if (!map) return
    const lngLat = centerLngLat()
    if (!Number.isFinite(lngLat[0]) || !Number.isFinite(lngLat[1])) return
    map.easeTo({ center: lngLat, zoom: props.zoom, duration: 0 })
    placeMarker(lngLat)
  },
)

onMounted(async () => {
  await nextTick()
  await initMap()
  if (rootEl.value && typeof ResizeObserver !== 'undefined') {
    resizeObserver = new ResizeObserver(() => map?.resize())
    resizeObserver.observe(rootEl.value)
  }
})

onBeforeUnmount(() => {
  resizeObserver?.disconnect()
  resizeObserver = null
  marker?.remove()
  marker = null
  map?.remove()
  map = null
})
</script>

<template>
  <div
    ref="rootEl"
    class="map-shell !h-[280px] md:!h-[360px]"
    :aria-label="label || 'Carte du lieu'"
  >
    <div
      v-if="mapError"
      class="absolute inset-0 z-10 flex items-center justify-center bg-[#FFFCF4]/95 p-6 text-center text-sm text-[#454545]"
    >
      {{ mapError }}
    </div>
    <div
      ref="mapEl"
      class="absolute inset-0 h-full w-full"
      role="img"
      :aria-label="label || 'Carte du lieu de la manifestation'"
    />
    <p class="pointer-events-none absolute bottom-3 left-3 z-10 max-w-[14rem] rounded-[4px] bg-white/95 px-2.5 py-1.5 text-[10px] leading-snug text-[#454545] shadow-soft">
      {{ config.public.mapAttribution }}
    </p>
  </div>
</template>
