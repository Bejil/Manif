<script setup lang="ts">
import { DateTime } from 'luxon'
import type { DisplayEventStatus } from '#shared/constants/statuses'

export interface AgendaEventItem {
  id: string
  slug: string
  title: string
  cityName: string
  startAt: string | null
  displayStatus: DisplayEventStatus
  timezone?: string
}

const props = defineProps<{
  events: AgendaEventItem[]
  month: string
  pending?: boolean
  selectedId?: string | null
}>()

const emit = defineEmits<{
  'update:month': [value: string]
  select: [id: string]
}>()

const { isSupported, isParticipating, isEngaged } = useMyEngagements()

const WEEKDAYS = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']

function eventChipClass(ev: AgendaEventItem) {
  if (ev.id === props.selectedId) return 'bg-[#F7F2FC] ring-1 ring-[#9C6EE8]'
  if (isParticipating(ev.id)) return 'bg-[#FDEDEB] text-[#97251B] ring-1 ring-[#D1271C]/35'
  if (isSupported(ev.id)) return 'bg-[#F0E8FC] text-[#4D257D] ring-1 ring-[#6735B6]/35'
  return 'hover:bg-[#F7F2FC]'
}

function eventDotClass(ev: AgendaEventItem) {
  if (isParticipating(ev.id)) return 'bg-[#D1271C]'
  if (isSupported(ev.id)) return 'bg-[#6735B6]'
  return statusDot[ev.displayStatus]
}

const monthDt = computed(() => {
  const d = DateTime.fromISO(`${props.month}-01`, { zone: 'Europe/Paris' })
  return d.isValid ? d.startOf('month') : DateTime.now().setZone('Europe/Paris').startOf('month')
})

const monthLabel = computed(() =>
  monthDt.value.setLocale('fr').toFormat('LLLL yyyy'),
)

const todayKey = computed(() =>
  DateTime.now().setZone('Europe/Paris').toISODate(),
)

function eventDayKey(ev: AgendaEventItem): string | null {
  if (!ev.startAt) return null
  const zone = ev.timezone || 'Europe/Paris'
  const d = DateTime.fromISO(ev.startAt, { setZone: true }).setZone(zone)
  return d.isValid ? d.toISODate() : null
}

function eventTimeLabel(ev: AgendaEventItem): string {
  if (!ev.startAt) return ''
  const zone = ev.timezone || 'Europe/Paris'
  const d = DateTime.fromISO(ev.startAt, { setZone: true }).setZone(zone)
  if (!d.isValid) return ''
  return d.setLocale('fr').toFormat('HH:mm')
}

const eventsByDay = computed(() => {
  const map = new Map<string, AgendaEventItem[]>()
  for (const ev of props.events) {
    const key = eventDayKey(ev)
    if (!key) continue
    const list = map.get(key) || []
    list.push(ev)
    map.set(key, list)
  }
  for (const [, list] of map) {
    list.sort((a, b) => (a.startAt || '').localeCompare(b.startAt || ''))
  }
  return map
})

interface DayCell {
  key: string
  day: number
  inMonth: boolean
  isToday: boolean
  events: AgendaEventItem[]
}

const cells = computed((): DayCell[] => {
  const start = monthDt.value
  // Luxon: weekday 1 = Monday … 7 = Sunday
  const pad = start.weekday - 1
  const gridStart = start.minus({ days: pad })
  const out: DayCell[] = []
  for (let i = 0; i < 42; i++) {
    const d = gridStart.plus({ days: i })
    const key = d.toISODate()!
    out.push({
      key,
      day: d.day,
      inMonth: d.month === start.month,
      isToday: key === todayKey.value,
      events: eventsByDay.value.get(key) || [],
    })
  }
  // Trim trailing empty week if last week is all next month and empty
  const lastWeek = out.slice(35)
  if (lastWeek.every(c => !c.inMonth && !c.events.length)) {
    return out.slice(0, 35)
  }
  return out
})

function shiftMonth(delta: number) {
  emit('update:month', monthDt.value.plus({ months: delta }).toFormat('yyyy-MM'))
}

function goToday() {
  emit('update:month', DateTime.now().setZone('Europe/Paris').toFormat('yyyy-MM'))
}

const statusDot: Record<DisplayEventStatus, string> = {
  upcoming: 'bg-[#9C6EE8]',
  ongoing: 'bg-[#D1271C]',
  past: 'bg-[#636363]',
  cancelled: 'bg-[#AD291F]',
  postponed: 'bg-[#805200]',
}

const MAX_VISIBLE = 3
</script>

<template>
  <div class="overflow-hidden rounded-[8px] border border-[#DDDAD3] bg-white shadow-soft">
    <div class="flex flex-wrap items-center justify-between gap-3 border-b border-[#DDDAD3] px-4 py-3 md:px-5">
      <div class="flex items-center gap-2">
        <button
          type="button"
          class="inline-flex h-10 w-10 items-center justify-center rounded-[4px] border border-[#DDDAD3] text-[#111111] hover:bg-[#F4F1EA]"
          aria-label="Mois précédent"
          @click="shiftMonth(-1)"
        >
          ‹
        </button>
        <button
          type="button"
          class="inline-flex h-10 w-10 items-center justify-center rounded-[4px] border border-[#DDDAD3] text-[#111111] hover:bg-[#F4F1EA]"
          aria-label="Mois suivant"
          @click="shiftMonth(1)"
        >
          ›
        </button>
        <h2 class="mf-display ml-1 text-xl capitalize text-[#111111] md:text-2xl">
          {{ monthLabel }}
        </h2>
      </div>
      <UiButton size="sm" variant="outline" @click="goToday">
        Aujourd’hui
      </UiButton>
    </div>

    <p v-if="pending" class="px-4 py-6 text-sm text-[#454545]">Chargement de l’agenda…</p>

    <div v-else class="overflow-x-auto">
      <div class="min-w-[640px]">
        <div class="grid grid-cols-7 border-b border-[#DDDAD3] bg-[#F4F1EA]">
          <div
            v-for="wd in WEEKDAYS"
            :key="wd"
            class="px-2 py-2 text-center text-[11px] font-bold uppercase tracking-wide text-[#636363]"
          >
            {{ wd }}
          </div>
        </div>

        <div class="grid grid-cols-7">
          <div
            v-for="cell in cells"
            :key="cell.key"
            class="min-h-[6.5rem] border-b border-r border-[#DDDAD3] p-1.5 last:border-r-0 sm:min-h-[7.5rem] sm:p-2"
            :class="[
              cell.inMonth ? 'bg-white' : 'bg-[#F4F1EA]/50',
              cell.isToday ? 'ring-2 ring-inset ring-[#9C6EE8]' : '',
            ]"
          >
            <div class="mb-1 flex items-center justify-between gap-1">
              <span
                class="inline-flex h-6 min-w-6 items-center justify-center rounded-full px-1 text-xs font-bold"
                :class="cell.isToday
                  ? 'bg-[#6735B6] text-white'
                  : cell.inMonth ? 'text-[#111111]' : 'text-[#636363]'"
              >
                {{ cell.day }}
              </span>
              <span
                v-if="cell.events.length"
                class="text-[10px] font-semibold text-[#636363]"
              >
                {{ cell.events.length }}
              </span>
            </div>

            <ul class="space-y-1">
              <li
                v-for="ev in cell.events.slice(0, MAX_VISIBLE)"
                :key="ev.id"
              >
                <button
                  type="button"
                  class="block w-full truncate rounded-[3px] px-1.5 py-0.5 text-left text-[11px] font-semibold leading-snug text-[#111111]"
                  :class="eventChipClass(ev)"
                  :title="`${ev.title} — ${ev.cityName}${isEngaged(ev.id) ? ' (mon engagement)' : ''}`"
                  @click="emit('select', ev.id)"
                >
                  <span
                    class="mr-1 inline-block h-1.5 w-1.5 shrink-0 rounded-full align-middle"
                    :class="eventDotClass(ev)"
                    aria-hidden="true"
                  />
                  <span v-if="eventTimeLabel(ev)" class="text-[#636363]">{{ eventTimeLabel(ev) }} </span>
                  {{ ev.title }}
                </button>
              </li>
              <li
                v-if="cell.events.length > MAX_VISIBLE"
                class="px-1.5 text-[10px] font-bold text-[#6735B6]"
              >
                +{{ cell.events.length - MAX_VISIBLE }} autre{{ cell.events.length - MAX_VISIBLE > 1 ? 's' : '' }}
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
