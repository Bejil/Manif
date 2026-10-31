export interface MyProposalEntry {
  submissionId: string
  title: string
  cityName: string
  category?: string
  createdAt: string
}

const INDEX_KEY = 'manif:proposals-index'
const CHANGE_EVENT = 'manif:proposals-changed'
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

const sharedProposals = shallowRef<MyProposalEntry[]>([])
let subscriberCount = 0

function normalizeId(id: string) {
  return id.trim().toLowerCase()
}

function readAll(): MyProposalEntry[] {
  if (!import.meta.client) return []
  try {
    const raw = localStorage.getItem(INDEX_KEY)
    if (!raw) return []
    const parsed = JSON.parse(raw) as unknown
    if (!Array.isArray(parsed)) return []
    const byId = new Map<string, MyProposalEntry>()
    for (const row of parsed) {
      if (!row || typeof row !== 'object') continue
      const r = row as Record<string, unknown>
      const submissionId = typeof r.submissionId === 'string' ? normalizeId(r.submissionId) : ''
      if (!UUID_RE.test(submissionId)) continue
      byId.set(submissionId, {
        submissionId,
        title: typeof r.title === 'string' ? r.title : 'Proposition',
        cityName: typeof r.cityName === 'string' ? r.cityName : '',
        category: typeof r.category === 'string' ? r.category : undefined,
        createdAt: typeof r.createdAt === 'string' ? r.createdAt : new Date().toISOString(),
      })
    }
    return [...byId.values()].sort((a, b) => b.createdAt.localeCompare(a.createdAt))
  }
  catch {
    return []
  }
}

function writeAll(entries: MyProposalEntry[]) {
  if (!import.meta.client) return
  localStorage.setItem(INDEX_KEY, JSON.stringify(entries))
  sharedProposals.value = entries
  window.dispatchEvent(new Event(CHANGE_EVENT))
}

function refreshShared() {
  sharedProposals.value = readAll()
}

/** Enregistre une proposition sur cet appareil (sans compte). */
export function rememberMyProposal(input: {
  submissionId: string
  title: string
  cityName: string
  category?: string
}) {
  if (!import.meta.client) return
  const submissionId = normalizeId(input.submissionId)
  if (!UUID_RE.test(submissionId)) return
  const existing = readAll()
  const prev = existing.find(e => e.submissionId === submissionId)
  const nextTitle = input.title.trim()
  const keepTitle = nextTitle && nextTitle !== 'Ma proposition' && nextTitle !== 'Proposition'
    ? nextTitle
    : (prev?.title || nextTitle || 'Proposition')
  const nextCity = input.cityName.trim() || prev?.cityName || ''
  const rest = existing.filter(e => e.submissionId !== submissionId)
  rest.unshift({
    submissionId,
    title: keepTitle,
    cityName: nextCity,
    category: input.category || prev?.category,
    createdAt: prev?.createdAt || new Date().toISOString(),
  })
  writeAll(rest.slice(0, 50))
}

export function forgetMyProposal(submissionId: string) {
  if (!import.meta.client) return
  const id = normalizeId(submissionId)
  writeAll(readAll().filter(e => e.submissionId !== id))
}

export function useMyProposals() {
  const proposalIds = computed(() => sharedProposals.value.map(p => p.submissionId))
  const hasProposals = computed(() => sharedProposals.value.length > 0)

  function refresh() {
    refreshShared()
  }

  onMounted(() => {
    if (subscriberCount === 0) {
      refreshShared()
      window.addEventListener(CHANGE_EVENT, refreshShared)
      window.addEventListener('storage', refreshShared)
    }
    subscriberCount++
  })

  onBeforeUnmount(() => {
    subscriberCount = Math.max(0, subscriberCount - 1)
    if (subscriberCount === 0 && import.meta.client) {
      window.removeEventListener(CHANGE_EVENT, refreshShared)
      window.removeEventListener('storage', refreshShared)
    }
  })

  return {
    proposals: sharedProposals,
    proposalIds,
    hasProposals,
    refresh,
    remember: rememberMyProposal,
    forget: forgetMyProposal,
  }
}
