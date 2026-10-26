<script setup lang="ts">
import { MAX_EVENT_IMAGES, MAX_EVENT_VIDEOS, isHttpsMediaUrl } from '#shared/utils/media'

const imageUrls = defineModel<string[]>('imageUrls', { required: true })
const videoUrls = defineModel<string[]>('videoUrls', { required: true })

const props = withDefaults(defineProps<{
  /** Jeton Turnstile requis pour l’upload public (ignoré côté admin). */
  turnstileToken?: string
  allowUpload?: boolean
}>(), {
  turnstileToken: '',
  allowUpload: true,
})

const imageDraft = ref('')
const videoDraft = ref('')
const uploadError = ref<string | null>(null)
const uploading = ref(false)
const dragOver = ref(false)
const fileInput = ref<HTMLInputElement | null>(null)
const dragDepth = ref(0)

const uploadDisabled = computed(
  () => uploading.value || imageUrls.value.length >= MAX_EVENT_IMAGES,
)

const dropHint = computed(() => {
  if (uploading.value) return 'Envoi en cours…'
  if (imageUrls.value.length >= MAX_EVENT_IMAGES) {
    return `Limite atteinte (${MAX_EVENT_IMAGES} images)`
  }
  return 'Glissez-déposez une image ici'
})

function addImageUrl() {
  const url = imageDraft.value.trim()
  if (!isHttpsMediaUrl(url)) {
    uploadError.value = 'URL d’image HTTPS invalide'
    return
  }
  if (imageUrls.value.includes(url)) {
    uploadError.value = 'Cette image est déjà ajoutée'
    return
  }
  if (imageUrls.value.length >= MAX_EVENT_IMAGES) {
    uploadError.value = `Maximum ${MAX_EVENT_IMAGES} images`
    return
  }
  imageUrls.value = [...imageUrls.value, url]
  imageDraft.value = ''
  uploadError.value = null
}

function addVideoUrl() {
  const url = videoDraft.value.trim()
  if (!isHttpsMediaUrl(url)) {
    uploadError.value = 'URL de vidéo HTTPS invalide (YouTube, Vimeo, fichier…)'
    return
  }
  if (videoUrls.value.includes(url)) {
    uploadError.value = 'Cette vidéo est déjà ajoutée'
    return
  }
  if (videoUrls.value.length >= MAX_EVENT_VIDEOS) {
    uploadError.value = `Maximum ${MAX_EVENT_VIDEOS} vidéos`
    return
  }
  videoUrls.value = [...videoUrls.value, url]
  videoDraft.value = ''
  uploadError.value = null
}

function removeImage(url: string) {
  imageUrls.value = imageUrls.value.filter(u => u !== url)
}

function removeVideo(url: string) {
  videoUrls.value = videoUrls.value.filter(u => u !== url)
}

function openFilePicker() {
  if (uploadDisabled.value) return
  fileInput.value?.click()
}

function onFileChange(ev: Event) {
  const input = ev.target as HTMLInputElement
  const file = input.files?.[0]
  input.value = ''
  if (file) void uploadFile(file)
}

function onDragEnter(ev: DragEvent) {
  ev.preventDefault()
  if (uploadDisabled.value) return
  dragDepth.value += 1
  dragOver.value = true
}

function onDragLeave(ev: DragEvent) {
  ev.preventDefault()
  dragDepth.value = Math.max(0, dragDepth.value - 1)
  if (dragDepth.value === 0) dragOver.value = false
}

function onDragOver(ev: DragEvent) {
  ev.preventDefault()
  if (ev.dataTransfer) ev.dataTransfer.dropEffect = uploadDisabled.value ? 'none' : 'copy'
}

function onDrop(ev: DragEvent) {
  ev.preventDefault()
  dragDepth.value = 0
  dragOver.value = false
  if (uploadDisabled.value) return
  const file = ev.dataTransfer?.files?.[0]
  if (file) void uploadFile(file)
}

async function uploadFile(file: File) {
  if (!file.type.startsWith('image/')) {
    uploadError.value = 'Déposez une image (JPEG, PNG, WebP ou GIF)'
    return
  }
  if (imageUrls.value.length >= MAX_EVENT_IMAGES) {
    uploadError.value = `Maximum ${MAX_EVENT_IMAGES} images`
    return
  }
  uploading.value = true
  uploadError.value = null
  try {
    const body = new FormData()
    body.append('file', file)
    if (props.turnstileToken) body.append('turnstileToken', props.turnstileToken)
    const res = await $fetch<{ url: string }>('/api/media/upload', {
      method: 'POST',
      body,
    })
    if (!imageUrls.value.includes(res.url)) {
      imageUrls.value = [...imageUrls.value, res.url]
    }
  }
  catch (e: unknown) {
    const err = e as { data?: { statusMessage?: string } }
    uploadError.value = err?.data?.statusMessage || 'Upload impossible'
  }
  finally {
    uploading.value = false
  }
}
</script>

<template>
  <div class="space-y-6">
    <div>
      <p class="text-sm font-bold text-[#111111]">Images</p>
      <p class="mt-1 text-xs text-[#454545]">
        Liens HTTPS (affiche, photo) ou fichier JPEG/PNG/WebP/GIF — max {{ MAX_EVENT_IMAGES }}, 2&nbsp;Mo par fichier.
      </p>

      <ul v-if="imageUrls.length" class="mt-3 grid gap-3 sm:grid-cols-2">
        <li
          v-for="url in imageUrls"
          :key="url"
          class="overflow-hidden rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA]"
        >
          <img :src="url" alt="" class="aspect-video w-full object-cover bg-[#DDDAD3]" loading="lazy">
          <div class="flex items-start justify-between gap-2 p-2">
            <a
              :href="url"
              class="break-all text-xs text-[#6735B6] hover:underline"
              target="_blank"
              rel="noopener noreferrer"
            >{{ url }}</a>
            <button
              type="button"
              class="shrink-0 text-xs font-bold text-[#AD291F] hover:underline"
              @click="removeImage(url)"
            >
              Retirer
            </button>
          </div>
        </li>
      </ul>

      <div
        v-if="allowUpload"
        class="relative mt-4 w-full"
      >
        <input
          ref="fileInput"
          type="file"
          class="sr-only"
          accept="image/jpeg,image/png,image/webp,image/gif"
          :disabled="uploadDisabled"
          @change="onFileChange"
        >
        <button
          type="button"
          class="group relative flex w-full flex-col items-center justify-center gap-3 rounded-[8px] border-2 border-dashed px-6 py-10 text-center transition duration-150 ease-out focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#6735B6] disabled:cursor-not-allowed disabled:opacity-55 motion-reduce:transition-none"
          :class="dragOver
            ? 'border-[#6735B6] bg-[#F0E8FC] shadow-soft'
            : 'border-[#DDDAD3] bg-[#FFFCF4] hover:border-[#6735B6] hover:bg-[#F0E8FC]/60'"
          :disabled="uploadDisabled"
          :aria-busy="uploading"
          @click="openFilePicker"
          @dragenter="onDragEnter"
          @dragleave="onDragLeave"
          @dragover="onDragOver"
          @drop="onDrop"
        >
          <span
            class="flex h-14 w-14 items-center justify-center rounded-[4px] bg-[#111111] text-[#FFFCF4] transition group-hover:bg-[#6735B6]"
            :class="dragOver ? '!bg-[#6735B6]' : ''"
            aria-hidden="true"
          >
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 16V4" />
              <path d="M7 9l5-5 5 5" />
              <path d="M4 20h16" />
            </svg>
          </span>
          <span class="space-y-1">
            <span class="block font-bold text-[#111111]">
              {{ dropHint }}
            </span>
            <span class="block text-sm text-[#454545]">
              <template v-if="!uploadDisabled">
                ou <span class="font-semibold text-[#6735B6] underline-offset-2 group-hover:underline">parcourir vos fichiers</span>
              </template>
              <template v-else-if="uploading">
                Merci de patienter…
              </template>
              <template v-else>
                Retirez une image pour en ajouter une autre.
              </template>
            </span>
          </span>
          <span class="text-xs font-semibold uppercase tracking-[0.14em] text-[#636363]">
            JPEG · PNG · WebP · GIF · 2 Mo max
          </span>
        </button>
      </div>

      <div class="mt-4 flex flex-col gap-2 sm:flex-row sm:items-end">
        <div class="min-w-0 flex-1">
          <UiInput
            id="media-image-url"
            v-model="imageDraft"
            label="Ou coller un lien d’image"
            type="url"
            placeholder="https://…"
            @keydown.enter.prevent="addImageUrl"
          />
        </div>
        <UiButton type="button" variant="outline" :disabled="!imageDraft.trim()" @click="addImageUrl">
          Ajouter le lien
        </UiButton>
      </div>
    </div>

    <div>
      <p class="text-sm font-bold text-[#111111]">Vidéos</p>
      <p class="mt-1 text-xs text-[#454545]">
        Liens HTTPS YouTube, Vimeo ou fichier vidéo — max {{ MAX_EVENT_VIDEOS }}.
        Pas d’upload de fichier vidéo (limites techniques) : hébergez-le puis collez l’URL.
      </p>

      <ul v-if="videoUrls.length" class="mt-3 space-y-2">
        <li
          v-for="url in videoUrls"
          :key="url"
          class="flex items-start justify-between gap-3 rounded-[4px] border border-[#DDDAD3] bg-white px-3 py-2"
        >
          <a
            :href="url"
            class="break-all text-sm font-semibold text-[#6735B6] hover:underline"
            target="_blank"
            rel="noopener noreferrer"
          >{{ url }}</a>
          <button
            type="button"
            class="shrink-0 text-xs font-bold text-[#AD291F] hover:underline"
            @click="removeVideo(url)"
          >
            Retirer
          </button>
        </li>
      </ul>

      <div class="mt-3 flex flex-col gap-2 sm:flex-row sm:items-end">
        <div class="min-w-0 flex-1">
          <UiInput
            id="media-video-url"
            v-model="videoDraft"
            label="Lien de vidéo"
            type="url"
            placeholder="https://youtube.com/… ou https://…"
            @keydown.enter.prevent="addVideoUrl"
          />
        </div>
        <UiButton type="button" variant="outline" :disabled="!videoDraft.trim()" @click="addVideoUrl">
          Ajouter le lien
        </UiButton>
      </div>
    </div>

    <p v-if="uploadError" class="text-sm text-[#AD291F]" role="alert">{{ uploadError }}</p>
  </div>
</template>
