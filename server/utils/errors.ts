import { createError } from 'h3'

export function badRequest(message: string, data?: unknown) {
  return createError({ statusCode: 400, statusMessage: message, data })
}

export function unauthorized(message = 'Non autorisé') {
  return createError({ statusCode: 401, statusMessage: message })
}

export function forbidden(message = 'Accès refusé') {
  return createError({ statusCode: 403, statusMessage: message })
}

export function notFound(message = 'Ressource introuvable') {
  return createError({ statusCode: 404, statusMessage: message })
}

export function conflict(message: string) {
  return createError({ statusCode: 409, statusMessage: message })
}

export function tooManyRequests(message = 'Trop de requêtes') {
  return createError({ statusCode: 429, statusMessage: message })
}

export function serviceUnavailable(message: string) {
  return createError({ statusCode: 503, statusMessage: message })
}

