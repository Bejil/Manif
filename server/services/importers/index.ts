import type { ImportSourceId } from '#shared/constants/import-sources'
import type { ImportScrapedEvent } from '#shared/types/import'
import { scrapeAmi } from './ami'
import { demosphereBatches, scrapeDemosphereHosts } from './demosphere'
import { scrapeManifsFr } from './manifs-fr'
import { scrapeManifRadar } from './manifradar'
import { scrapeMobilizonXr } from './mobilizon'

export interface ImportWorkUnit {
  id: string
  source: ImportSourceId
  label: string
  run: () => Promise<ImportScrapedEvent[]>
}

export function buildImportWorkUnits(
  sources: ImportSourceId[],
  options: { militantOnly?: boolean, maxPerSource?: number },
): ImportWorkUnit[] {
  const units: ImportWorkUnit[] = []
  const opts = {
    militantOnly: options.militantOnly !== false,
    maxPerSource: options.maxPerSource,
  }

  for (const source of sources) {
    if (source === 'ami') {
      units.push({
        id: 'ami',
        source: 'ami',
        label: 'Agenda Militant Indépendant',
        run: () => scrapeAmi(opts),
      })
    }
    else if (source === 'manifs') {
      units.push({
        id: 'manifs',
        source: 'manifs',
        label: 'Manifs.fr',
        run: () => scrapeManifsFr(opts),
      })
    }
    else if (source === 'manifradar') {
      units.push({
        id: 'manifradar',
        source: 'manifradar',
        label: 'ManifRadar',
        run: () => scrapeManifRadar(opts),
      })
    }
    else if (source === 'mobilizon_xr') {
      units.push({
        id: 'mobilizon_xr',
        source: 'mobilizon_xr',
        label: 'Mobilizon XR',
        run: () => scrapeMobilizonXr(opts),
      })
    }
    else if (source === 'demosphere') {
      const batches = demosphereBatches(5)
      batches.forEach((hosts, i) => {
        units.push({
          id: `demosphere:${i}`,
          source: 'demosphere',
          label: `Démosphère lot ${i + 1}/${batches.length} (${hosts.join(', ')})`,
          run: () => scrapeDemosphereHosts(hosts, opts),
        })
      })
    }
  }
  return units
}

export { demosphereBatches }
