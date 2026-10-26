import type { EventCategoryId } from '../constants/categories'

const categoryContext: Record<EventCategoryId, string> = {
  climat:
    'Les organisateurs appellent à accélérer la transition écologique, à défendre la biodiversité et à exiger des politiques publiques à la hauteur de l’urgence climatique.',
  travail:
    'Ce rassemblement s’inscrit dans la défense des droits sociaux, des conditions de travail et du pouvoir d’achat, dans un cadre pacifique et déclaré.',
  social:
    'L’appel met en avant la solidarité, l’accès aux droits et la dignité au quotidien pour les personnes concernées par les politiques locales et nationales.',
  education:
    'Les participants souhaitent défendre l’école publique, les moyens humains et matériels, ainsi que des conditions d’apprentissage dignes pour toutes et tous.',
  logement:
    'Le rassemblement porte sur le droit au logement, la lutte contre les expulsions et l’accès à un habitat abordable et digne.',
  sante:
    'Les organisateurs alertent sur l’accès aux soins, les conditions d’exercice des soignants et le maintien d’un service public de santé de proximité.',
  droits:
    'L’appel défend les libertés fondamentales, l’égalité des droits et le respect de l’État de droit, dans un cadre pacifique.',
  autre:
    'Cette initiative citoyenne vise à rendre visibles des revendications d’intérêt général et à favoriser le débat démocratique dans l’espace public.',
}

/**
 * Génère une description longue et lisible (≈ 700–1200 caractères) pour les fiches.
 */
export function buildLongEventDescription(input: {
  title: string
  cityName: string
  locationName: string
  category: EventCategoryId
  tone?: 'default' | 'ongoing' | 'past' | 'cancelled' | 'postponed' | 'tba' | 'hidden_location'
}): string {
  const tone = input.tone ?? 'default'
  const theme = categoryContext[input.category] ?? categoryContext.autre

  const intro = `${input.title} — rassemblement prévu à ${input.cityName}, autour de ${input.locationName}.`

  const practical = [
    'Informations pratiques : arrivée conseillée en transports en commun ; prévoyez de l’eau, des chaussures confortables et un moyen de rester joignable.',
    'Respectez les consignes des organisateurs et des services d’ordre. Le parcours et les horaires peuvent être précisés le jour même.',
    'Manif’ affiche ces informations à titre informatif : vérifiez toujours auprès des organisateurs ou de la source officielle avant de vous déplacer.',
  ].join(' ')

  let statusNote = ''
  if (tone === 'ongoing') {
    statusNote = ' Le rassemblement est en cours : rejoignez le point de départ indiqué et suivez les indications sur place.'
  }
  else if (tone === 'past') {
    statusNote = ' Cet événement est terminé. La fiche reste consultable pour l’historique ; les déclarations de participation sont fermées.'
  }
  else if (tone === 'cancelled') {
    statusNote = ' Attention : cette manifestation a été annulée par les organisateurs. Ne vous déplacez pas. La fiche reste visible pour information.'
  }
  else if (tone === 'postponed') {
    statusNote = ' Cette marche est reportée. Une nouvelle date sera annoncée ici dès qu’elle sera confirmée. La fiche reste consultable entre-temps.'
  }
  else if (tone === 'tba') {
    statusNote = ' La date précise n’est pas encore confirmée. Surveillez cette fiche : elle sera mise à jour dès que les organisateurs auront annoncé le jour et l’heure.'
  }
  else if (tone === 'hidden_location') {
    statusNote = ' Le lieu précis sera communiqué avant le départ pour des raisons d’organisation. La ville reste indiquée afin de vous situer.'
  }

  const context = [
    theme,
    `À ${input.cityName}, le point de rendez-vous annoncé est ${input.locationName}.`,
    'Des prises de parole, de la documentation et un parcours éventuel peuvent être proposés selon le déroulé prévu par les organisateurs.',
  ].join(' ')

  return `${intro} ${context}${statusNote} ${practical}`
}
