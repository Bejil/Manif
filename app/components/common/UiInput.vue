<script setup lang="ts">
defineProps<{
  id: string
  label: string
  modelValue: string
  type?: string
  required?: boolean
  hint?: string
  error?: string
  autocomplete?: string
  placeholder?: string
  maxlength?: number
  min?: string
  max?: string
}>()

defineEmits<{ 'update:modelValue': [value: string] }>()
</script>

<template>
  <div class="space-y-1.5">
    <label :for="id" class="block text-sm font-bold text-[#111111]">
      {{ label }}
      <span v-if="required" class="text-[#AD291F]" aria-hidden="true">*</span>
    </label>
    <input
      :id="id"
      :type="type || 'text'"
      :value="modelValue"
      :required="required"
      :autocomplete="autocomplete"
      :placeholder="placeholder"
      :maxlength="maxlength"
      :min="min"
      :max="max"
      :aria-invalid="error ? 'true' : undefined"
      :aria-describedby="error ? `${id}-error` : hint ? `${id}-hint` : undefined"
      class="min-h-[48px] w-full rounded-[4px] border-2 border-[#DDDAD3] bg-white px-3.5 py-2.5 text-[#111111] placeholder:text-[#636363] focus:border-[#6735B6] focus:outline-none focus:ring-2 focus:ring-[#9C6EE8]/35"
      @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
    >
    <p v-if="hint && !error" :id="`${id}-hint`" class="text-xs text-[#454545]">{{ hint }}</p>
    <p v-if="error" :id="`${id}-error`" class="text-xs text-[#AD291F]" role="alert">{{ error }}</p>
  </div>
</template>
