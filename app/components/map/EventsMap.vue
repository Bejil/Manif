<script setup lang="ts">
import type { EventMapPoint } from '#shared/types/event'

const props = defineProps<{
  points: EventMapPoint[]
  selectedId?: string | null
  /** Ids d’événements soutenus / participés (surlignage carte) */
  engagedIds?: string[]
  supportedIds?: string[]
  participatingIds?: string[]
}>()

const emit = defineEmits<{
  select: [id: string]
}>()

const config = useRuntimeConfig()
const rootEl = ref<HTMLElement | null>(null)
const mapEl = ref<HTMLElement | null>(null)
const mapError = ref<string | null>(null)
const mapReady = ref(false)

const ENGAGED_PARTICIPATE = '#D1271C'
const ENGAGED_SUPPORT = '#6735B6'

type MaplibreModule = typeof import('maplibre-gl')
let maplibregl: MaplibreModule | null = null
let map: import('maplibre-gl').Map | null = null
let resizeObserver: ResizeObserver | null = null
let prevSelectedId: string | null = null
/** Au-delà de clusterMaxZoom (12) : plus aucun regroupement */
const UNCLUSTERED_ZOOM = 13
let focusToken = 0

function setSelectedFeatureState(id: string | null | undefined, force = false) {
  if (!map || !mapReady.value) return
  const next = id ?? null
  if (prevSelectedId && (force || prevSelectedId !== next)) {
    try {
      map.setFeatureState({ source: 'events', id: prevSelectedId }, { selected: false })
    }
    catch { /* source pas encore prêt */ }
  }
  if (next) {
    try {
      map.setFeatureState({ source: 'events', id: next }, { selected: true })
    }
    catch { /* point encore clusterisé */ }
  }
  prevSelectedId = next
}

function isPointUnclusteredOnMap(id: string): boolean {
  if (!map) return false
  return map.queryRenderedFeatures({ layers: ['unclustered'] })
    .some(f => String(f.properties?.id) === String(id))
}

async function clusterContainsFeature(
  source: import('maplibre-gl').GeoJSONSource,
  clusterId: number,
  featureId: string,
): Promise<boolean> {
  try {
    const leaves = await source.getClusterLeaves(clusterId, Infinity, 0)
    return leaves.some(l => String(l.properties?.id) === String(featureId))
  }
  catch {
    return false
  }
}

/** Zoom minimal pour que le point sorte de tous les clusters (calcul sans animer). */
async function resolveUnclusterZoom(
  source: import('maplibre-gl').GeoJSONSource,
  featureId: string,
): Promise<number> {
  if (!map) return UNCLUSTERED_ZOOM

  const clusters = map.querySourceFeatures('events', {
    filter: ['has', 'point_count'],
  })

  // Cluster racine = celui qui contient la feature avec le plus de points
  let currentId: number | null = null
  let bestCount = -1
  for (const cluster of clusters) {
    const clusterId = cluster.properties?.cluster_id as number | undefined
    if (clusterId == null) continue
    const count = Number(cluster.properties?.point_count ?? 0)
    if (count <= bestCount) continue
    if (await clusterContainsFeature(source, clusterId, featureId)) {
      currentId = clusterId
      bestCount = count
    }
  }

  if (currentId == null) return UNCLUSTERED_ZOOM

  let zoom = await source.getClusterExpansionZoom(currentId)

  for (let depth = 0; depth < 12; depth++) {
    let children: GeoJSON.Feature[] = []
    try {
      children = await source.getClusterChildren(currentId)
    }
    catch {
      break
    }

    let nextId: number | null = null
    for (const child of children) {
      if (!child.properties?.cluster) continue
      const childId = child.properties.cluster_id as number
      if (await clusterContainsFeature(source, childId, featureId)) {
        nextId = childId
        break
      }
    }
    if (nextId == null) break

    currentId = nextId
    try {
      zoom = Math.max(zoom, await source.getClusterExpansionZoom(currentId))
    }
    catch {
      break
    }
  }

  return Math.min(Math.max(zoom, map.getZoom()), UNCLUSTERED_ZOOM)
}

function flyToAsync(options: import('maplibre-gl').FlyToOptions): Promise<void> {
  return new Promise((resolve) => {
    if (!map) {
      resolve()
      return
    }
    map.once('moveend', () => resolve())
    map.flyTo(options)
  })
}

/** Un seul vol fluide jusqu’au point, hors regroupement. */
async function focusPointOnMap(id: string) {
  if (!map || !mapReady.value) return
  const point = props.points.find(p => p.id === id)
  if (!point) return

  const token = ++focusToken
  const center: [number, number] = [point.longitude, point.latitude]
  const source = map.getSource('events') as import('maplibre-gl').GeoJSONSource

  setSelectedFeatureState(id)

  if (isPointUnclusteredOnMap(id)) {
    await flyToAsync({ center, duration: 500, essential: true })
    if (token !== focusToken) return
    setSelectedFeatureState(id, true)
    return
  }

  const resolved = await resolveUnclusterZoom(source, id)
  if (token !== focusToken || !map) return

  // Une seule animation fluide (marge légère pour être hors cluster)
  const targetZoom = Math.min(resolved + 0.35, UNCLUSTERED_ZOOM)

  await flyToAsync({
    center,
    zoom: targetZoom,
    duration: 850,
    essential: true,
    curve: 1.35,
    speed: 1.2,
  })

  if (token !== focusToken) return
  setSelectedFeatureState(id, true)
}

const statusColor: Record<string, string> = {
  ongoing: '#D1271C',
  upcoming: '#9C6EE8',
  past: '#636363',
  cancelled: '#AD291F',
  postponed: '#805200',
}

function engagementFlag(id: string): 'participate' | 'support' | 'none' {
  if (props.participatingIds?.includes(id)) return 'participate'
  if (props.supportedIds?.includes(id)) return 'support'
  if (props.engagedIds?.includes(id)) return 'support'
  return 'none'
}

function toGeoJson(points: EventMapPoint[]) {
  return {
    type: 'FeatureCollection' as const,
    features: points.map(p => ({
      type: 'Feature' as const,
      properties: {
        id: p.id,
        slug: p.slug,
        title: p.title,
        cityName: p.cityName,
        displayStatus: p.displayStatus,
        mine: engagementFlag(p.id),
      },
      geometry: {
        type: 'Point' as const,
        coordinates: [p.longitude, p.latitude],
      },
    })),
  }
}

async function initMap() {
  if (!import.meta.client || !mapEl.value || map) return

  try {
    maplibregl = await import('maplibre-gl')
    await import('maplibre-gl/dist/maplibre-gl.css')

    // Worker servi en fichier statique (évite le 504 Vite @fs sur le worker prébundle)
    maplibregl.setWorkerUrl(`${window.location.origin}/maplibre-gl-worker.mjs`)

    map = new maplibregl.Map({
      container: mapEl.value,
      style: config.public.mapStyleUrl || 'https://tiles.openfreemap.org/styles/liberty',
      center: [2.5, 46.5],
      zoom: 5,
      attributionControl: true,
    })

    map.addControl(new maplibregl.NavigationControl({ showCompass: false }), 'top-right')

    map.on('error', (e) => {
      console.error('[map]', e.error)
      if (!mapReady.value) {
        mapError.value = 'La carte n\'a pas pu charger les tuiles. La liste reste disponible.'
      }
    })

    map.on('load', () => {
      if (!map) return
      mapError.value = null
      map.addSource('events', {
        type: 'geojson',
        data: toGeoJson(props.points),
        cluster: true,
        clusterMaxZoom: 12,
        clusterRadius: 42,
        promoteId: 'id',
      })

      map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'events',
        filter: ['has', 'point_count'],
        paint: {
          'circle-color': '#111111',
          'circle-radius': ['step', ['get', 'point_count'], 18, 5, 22, 15, 28],
          'circle-opacity': 0.95,
          'circle-stroke-width': 2,
          'circle-stroke-color': '#FFFCF4',
        },
      })

      map.addLayer({
        id: 'cluster-count',
        type: 'symbol',
        source: 'events',
        filter: ['has', 'point_count'],
        layout: {
          'text-field': '{point_count_abbreviated}',
          'text-size': 12,
        },
        paint: { 'text-color': '#ffffff' },
      })

      // Halo sous le point sélectionné
      map.addLayer({
        id: 'unclustered-selected-halo',
        type: 'circle',
        source: 'events',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-radius': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            22,
            0,
          ],
          'circle-color': '#6735B6',
          'circle-opacity': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            0.28,
            0,
          ],
          'circle-stroke-width': 0,
        },
      })

      map.addLayer({
        id: 'unclustered',
        type: 'circle',
        source: 'events',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-color': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            '#6735B6',
            ['==', ['get', 'mine'], 'participate'], ENGAGED_PARTICIPATE,
            ['==', ['get', 'mine'], 'support'], ENGAGED_SUPPORT,
            [
              'match',
              ['get', 'displayStatus'],
              'ongoing', statusColor.ongoing,
              'upcoming', statusColor.upcoming,
              'cancelled', statusColor.cancelled,
              'postponed', statusColor.postponed,
              statusColor.past,
            ],
          ],
          'circle-radius': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            12,
            ['!=', ['get', 'mine'], 'none'],
            11,
            8,
          ],
          'circle-stroke-width': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            3,
            ['!=', ['get', 'mine'], 'none'],
            3,
            2,
          ],
          'circle-stroke-color': [
            'case',
            ['boolean', ['feature-state', 'selected'], false],
            '#FFFCF4',
            ['!=', ['get', 'mine'], 'none'],
            '#111111',
            '#ffffff',
          ],
        },
      })

      map.on('click', 'clusters', async (e) => {
        if (!map || !maplibregl) return
        const features = map.queryRenderedFeatures(e.point, { layers: ['clusters'] })
        const clusterId = features[0]?.properties?.cluster_id
        const source = map.getSource('events') as import('maplibre-gl').GeoJSONSource
        if (clusterId == null) return
        const zoom = await source.getClusterExpansionZoom(clusterId)
        const coordinates = (features[0]!.geometry as GeoJSON.Point).coordinates as [number, number]
        map.easeTo({ center: coordinates, zoom })
      })

      map.on('click', 'unclustered', (e) => {
        const id = e.features?.[0]?.properties?.id as string | undefined
        if (id) emit('select', id)
      })

      map.on('mouseenter', 'clusters', () => { if (map) map.getCanvas().style.cursor = 'pointer' })
      map.on('mouseleave', 'clusters', () => { if (map) map.getCanvas().style.cursor = '' })
      map.on('mouseenter', 'unclustered', () => { if (map) map.getCanvas().style.cursor = 'pointer' })
      map.on('mouseleave', 'unclustered', () => { if (map) map.getCanvas().style.cursor = '' })

      mapReady.value = true
      map.resize()
      setSelectedFeatureState(props.selectedId)
    })
  }
  catch (e) {
    console.error(e)
    mapError.value = 'La carte n\'a pas pu être chargée. La liste reste disponible.'
  }
}

function refreshGeoJson() {
  if (!map || !mapReady.value) return
  const source = map.getSource('events') as import('maplibre-gl').GeoJSONSource | undefined
  source?.setData(toGeoJson(props.points))
  nextTick(() => setSelectedFeatureState(props.selectedId, true))
}

watch(() => props.points, () => refreshGeoJson(), { deep: true })
watch(
  () => [props.engagedIds, props.supportedIds, props.participatingIds] as const,
  () => refreshGeoJson(),
  { deep: true },
)

watch(() => props.selectedId, (id) => {
  if (!map || !mapReady.value) return
  if (!id) {
    setSelectedFeatureState(null)
    return
  }
  void focusPointOnMap(id)
})

onMounted(async () => {
  await nextTick()
  await initMap()
  if (rootEl.value && typeof ResizeObserver !== 'undefined') {
    resizeObserver = new ResizeObserver(() => {
      map?.resize()
    })
    resizeObserver.observe(rootEl.value)
  }
})

onBeforeUnmount(() => {
  resizeObserver?.disconnect()
  resizeObserver = null
  map?.remove()
  map = null
})

function locateMe() {
  if (!map || !navigator.geolocation) return
  navigator.geolocation.getCurrentPosition(
    (pos) => {
      map?.easeTo({
        center: [pos.coords.longitude, pos.coords.latitude],
        zoom: 10,
      })
    },
    () => {},
    { enableHighAccuracy: false, timeout: 8000 },
  )
}
</script>

<template>
  <div
    id="carte"
    ref="rootEl"
    class="map-shell"
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
      role="application"
      aria-label="Carte des manifestations"
    />
    <div class="absolute bottom-3 left-3 z-10 flex flex-col gap-2">
      <button
        type="button"
        class="rounded-[4px] bg-[#111111] px-3.5 py-2 text-xs font-bold text-[#FFFCF4] shadow-lift transition hover:-translate-y-0.5 motion-reduce:transform-none"
        @click="locateMe"
      >
        Autour de moi
      </button>
      <p class="max-w-[13rem] rounded-[4px] bg-white/95 px-2.5 py-1.5 text-[10px] leading-snug text-[#454545] shadow-soft">
        Position facultative, non stockée. {{ config.public.mapAttribution }}
      </p>
    </div>
  </div>
</template>
