export function useShare() {
  async function share(input: { title: string, text: string, url: string }) {
    if (import.meta.client && typeof navigator !== 'undefined' && navigator.share) {
      try {
        await navigator.share(input)
        return { method: 'native' as const }
      }
      catch (e) {
        if ((e as Error).name === 'AbortError') return { method: 'cancelled' as const }
      }
    }
    if (import.meta.client && navigator.clipboard) {
      await navigator.clipboard.writeText(input.url)
      return { method: 'clipboard' as const }
    }
    return { method: 'failed' as const }
  }

  return { share }
}
