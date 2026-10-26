import { z } from 'zod'
import { EVENT_CATEGORIES } from '../constants/categories'
import { REPORT_REASONS } from '../constants/statuses'

const categoryIds = EVENT_CATEGORIES.map(c => c.id) as [string, ...string[]]
const reportReasonIds = REPORT_REASONS.map(r => r.id) as [string, ...string[]]

export const eventListQuerySchema = z.object({
  q: z.string().max(200).optional(),
  category: z.enum(categoryIds).optional(),
  statuses: z
    .string()
    .optional()
    .transform((v) => {
      if (!v) return undefined
      return v.split(',').map(s => s.trim()).filter(Boolean)
    }),
  dateFrom: z.string().datetime({ offset: true }).optional().or(z.string().date().optional()),
  dateTo: z.string().datetime({ offset: true }).optional().or(z.string().date().optional()),
  city: z.string().max(120).optional(),
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(30),
})

export const submissionCreateSchema = z.object({
  title: z.string().trim().min(5).max(160),
  description: z.string().trim().min(20).max(5000),
  category: z.enum(categoryIds),
  cityName: z.string().trim().min(2).max(120),
  locationName: z.string().trim().min(2).max(200),
  /** Heures avant le début avant de publier le lieu. Vide / 0 = immédiat. */
  locationRevealHoursBefore: z
    .union([z.coerce.number().int().min(0).max(336), z.literal(''), z.null()])
    .optional()
    .transform((v) => {
      if (v === '' || v == null || v === 0) return null
      return v
    }),
  /** Date à confirmer : laisser vide date + heure */
  date: z
    .string()
    .regex(/^\d{4}-\d{2}-\d{2}$/)
    .optional()
    .or(z.literal('').transform(() => undefined)),
  startTime: z
    .string()
    .regex(/^\d{2}:\d{2}$/)
    .optional()
    .or(z.literal('').transform(() => undefined)),
  endTime: z
    .string()
    .regex(/^\d{2}:\d{2}$/)
    .optional()
    .or(z.literal('').transform(() => undefined)),
  dateToConfirm: z.boolean().optional().default(false),
  organizerName: z.string().trim().max(160).optional(),
  sourceUrl: z
    .string()
    .url()
    .max(500)
    .optional()
    .or(z.literal('').transform(() => undefined)),
  practicalInfo: z.string().trim().max(2000).optional(),
  proposerEmail: z.string().trim().email().max(254),
  turnstileToken: z.string().min(1).optional(),
})

export const submissionVerifySchema = z.object({
  token: z.string().min(20).max(200),
})

export const engagementUpsertSchema = z.object({
  action: z.enum([
    'support',
    'withdraw_support',
    'participate',
    'withdraw_participate',
  ]),
  eventScopedToken: z.string().min(16).max(128),
  turnstileToken: z.string().min(1).optional(),
})

/** @deprecated alias — préférer engagementUpsertSchema */
export const participationUpsertSchema = engagementUpsertSchema


export const reportCreateSchema = z.object({
  reason: z.enum(reportReasonIds),
  /** Vide autorisé ; sinon 10 caractères minimum */
  details: z
    .string()
    .trim()
    .max(2000)
    .default('')
    .refine(v => v.length === 0 || v.length >= 10, {
      message: 'Précisions trop courtes (10 caractères minimum si renseignées)',
    }),
  turnstileToken: z.string().min(1).optional(),
})

export const adminEventPatchSchema = z.object({
  title: z.string().trim().min(5).max(160).optional(),
  description: z.string().trim().min(20).max(5000).optional(),
  category: z.enum(categoryIds).optional(),
  cityName: z.string().trim().min(2).max(120).optional(),
  postalCode: z.string().trim().max(10).nullable().optional(),
  locationName: z.string().trim().min(2).max(200).optional(),
  latitude: z.number().min(-90).max(90).nullable().optional(),
  longitude: z.number().min(-180).max(180).nullable().optional(),
  locationRevealAt: z.string().datetime({ offset: true }).nullable().optional(),
  timezone: z.string().min(1).max(64).optional(),
  startAt: z.string().datetime({ offset: true }).nullable().optional(),
  endAt: z.string().datetime({ offset: true }).nullable().optional(),
  endIsEstimated: z.boolean().optional(),
  organizerName: z.string().trim().max(160).nullable().optional(),
  sourceUrl: z
    .union([z.string().url().max(500), z.literal(''), z.null()])
    .optional()
    .transform(v => (v === '' || v == null ? null : v)),
  publicationStatus: z.enum(['draft', 'published', 'unpublished']).optional(),
  eventStatusOverride: z
    .union([z.enum(['cancelled', 'postponed']), z.literal(''), z.null()])
    .optional()
    .transform(v => (v === '' || v == null ? null : v)),
})
