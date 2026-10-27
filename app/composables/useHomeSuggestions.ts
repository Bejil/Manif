import type { EventPublic } from '#shared/types/event'

const SUGGESTION_COUNT = 5

function department(postalCode: string | null | undefined) {
  const digits = (postalCode || '').replace(/\D/g, '')
  if (digits.length < 2) return ''
  // DOM/TOM : 97x
  if (digits.startsWith('97') || digits.startsWith('98')) return digits.slice(0, 3)
  return digits.slice(0, 2)
}

function scoreCandidate(candidate: EventPublic, seeds: EventPublic[]) {
  let score = 0
  const cityNorm = candidate.cityName.trim().toLowerCase()
  const dept = department(candidate.postalCode)
  for (const seed of seeds) {
    if (candidate.category === seed.category) score += 3
    if (cityNorm && cityNorm === seed.cityName.trim().toLowerCase()) score += 4
    const seedDept = department(seed.postalCode)
    if (dept && seedDept && dept === seedDept) score += 2
  }
  return score
}

/**
 * Suggestions home : 5 événements à venir, proches des manifs
 * que l’utilisateur soutient ou auxquelles il participe.
 */
export function useHomeSuggestions() {
  const { engagedIds, refresh } = useMyEngagements()

  onMounted(() => {
    refresh()
  })

  const seedParams = computed(() => {
    if (!engagedIds.value.length) return null
    return {
      ids: engagedIds.value.join(','),
      statuses: 'upcoming,ongoing,past,cancelled,postponed',
      page: 1,
      pageSize: Math.min(200, Math.max(engagedIds.value.length, 1)),
    }
  })

  const { data: seedData } = useFetch<{ items: EventPublic[] }>(
    () => (seedParams.value ? '/api/events' : null),
    {
      query: seedParams,
      watch: [seedParams],
      server: false,
      lazy: true,
      default: () => ({ items: [] }),
    },
  )

  const { data: upcomingData, pending } = useFetch<{ items: EventPublic[] }>(
    () => (engagedIds.value.length ? '/api/events' : null),
    {
      query: {
        statuses: 'upcoming',
        page: 1,
        pageSize: 120,
      },
      watch: [engagedIds],
      server: false,
      lazy: true,
      default: () => ({ items: [] }),
    },
  )

  const suggestions = computed(() => {
    const engaged = new Set(engagedIds.value)
    if (!engaged.size) return [] as EventPublic[]

    const seeds = (seedData.value?.items ?? []).filter(e => engaged.has(e.id))
    const pool = (upcomingData.value?.items ?? []).filter(
      e => e.displayStatus === 'upcoming' && !engaged.has(e.id),
    )

    const ranked = pool
      .map(e => ({ e, score: seeds.length ? scoreCandidate(e, seeds) : 0 }))
      .sort((a, b) => {
        if (b.score !== a.score) return b.score - a.score
        const da = a.e.startAt || ''
        const db = b.e.startAt || ''
        return da.localeCompare(db) || a.e.title.localeCompare(b.e.title, 'fr')
      })
      .map(x => x.e)

    return ranked.slice(0, SUGGESTION_COUNT)
  })

  const visible = computed(
    () => engagedIds.value.length > 0 && suggestions.value.length > 0,
  )

  return {
    suggestions,
    visible,
    pending,
  }
}
