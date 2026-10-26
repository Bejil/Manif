<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger' | 'outline' | 'violet' | 'red' | 'mist'
  size?: 'sm' | 'md' | 'lg'
  type?: 'button' | 'submit' | 'reset'
  disabled?: boolean
  block?: boolean
}>(), {
  variant: 'primary',
  size: 'md',
  type: 'button',
  disabled: false,
  block: false,
})

const variants: Record<string, string> = {
  primary: 'bg-[#111111] text-[#FFFCF4] hover:-translate-y-0.5 hover:shadow-lift',
  secondary: 'bg-[#111111] text-[#FFFCF4] hover:-translate-y-0.5',
  violet: 'bg-[#6735B6] text-white hover:brightness-110 hover:-translate-y-0.5',
  red: 'bg-[#D1271C] text-white hover:brightness-110 hover:-translate-y-0.5',
  mist: 'bg-[#6735B6] text-white hover:brightness-110 hover:-translate-y-0.5',
  ghost: 'bg-transparent text-[#111111] hover:bg-[#F4F1EA]',
  danger: 'bg-[#AD291F] text-white hover:brightness-95',
  outline: 'border-2 border-[#111111] bg-transparent text-[#111111] hover:bg-[#111111] hover:text-[#FFFCF4]',
}

const sizes: Record<string, string> = {
  sm: 'min-h-[40px] px-4 py-2 text-sm rounded-[4px]',
  md: 'min-h-[48px] px-5 py-3 text-sm rounded-[4px]',
  lg: 'min-h-[52px] px-6 py-3.5 text-base rounded-[4px]',
}
</script>

<template>
  <button
    :type="type"
    :disabled="disabled"
    class="inline-flex items-center justify-center gap-2.5 font-bold tracking-tight transition duration-150 ease-out disabled:cursor-not-allowed disabled:opacity-45 disabled:hover:translate-y-0 motion-reduce:transform-none"
    :class="[variants[variant], sizes[size], block && 'w-full']"
  >
    <slot />
  </button>
</template>
