<script setup lang="ts">
import { resolveVideoEmbed } from '#shared/utils/media'

const props = defineProps<{
  imageUrls: string[]
  videoUrls: string[]
  title: string
}>()

const videos = computed(() => props.videoUrls.map(url => ({ url, embed: resolveVideoEmbed(url) })))
const hasMedia = computed(() => props.imageUrls.length > 0 || props.videoUrls.length > 0)
</script>

<template>
  <section v-if="hasMedia" class="mt-8 space-y-8">
    <div v-if="imageUrls.length">
      <p class="mb-3 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
        {{ imageUrls.length > 1 ? 'Images' : 'Image' }}
      </p>
      <ul class="grid gap-4" :class="imageUrls.length > 1 ? 'sm:grid-cols-2' : ''">
        <li
          v-for="(url, i) in imageUrls"
          :key="url"
          class="overflow-hidden rounded-[4px] border border-[#DDDAD3] bg-[#F4F1EA]"
        >
          <a :href="url" target="_blank" rel="noopener noreferrer" class="block">
            <img
              :src="url"
              :alt="`${title} — image ${i + 1}`"
              class="aspect-video w-full object-cover"
              loading="lazy"
            >
          </a>
        </li>
      </ul>
    </div>

    <div v-if="videos.length">
      <p class="mb-3 text-xs font-bold uppercase tracking-[0.12em] text-[#636363]">
        {{ videos.length > 1 ? 'Vidéos' : 'Vidéo' }}
      </p>
      <ul class="space-y-4">
        <li
          v-for="item in videos"
          :key="item.url"
          class="overflow-hidden rounded-[4px] border border-[#DDDAD3] bg-[#111111]"
        >
          <div v-if="item.embed.kind === 'youtube' || item.embed.kind === 'vimeo'" class="aspect-video">
            <iframe
              :src="item.embed.embedUrl"
              class="h-full w-full"
              title="Vidéo de la manifestation"
              loading="lazy"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowfullscreen
              referrerpolicy="strict-origin-when-cross-origin"
            />
          </div>
          <video
            v-else
            :src="item.embed.src"
            class="aspect-video w-full"
            controls
            preload="metadata"
          />
          <p class="bg-white px-3 py-2">
            <a
              :href="item.url"
              class="break-all text-xs font-semibold text-[#6735B6] hover:underline"
              target="_blank"
              rel="noopener noreferrer"
            >{{ item.url }}</a>
          </p>
        </li>
      </ul>
    </div>
  </section>
</template>
