<script setup lang="ts">
defineProps<{
  id: string
  label: string
  modelValue: string
  required?: boolean
  hint?: string
  error?: string
  rows?: number
  maxlength?: number
}>()

defineEmits<{ 'update:modelValue': [value: string] }>()
</script>

<template>
  <div class="space-y-1.5">
    <label :for="id" class="block text-sm font-bold text-[#111111]">
      {{ label }}
      <span v-if="required" class="text-[#AD291F]" aria-hidden="true">*</span>
    </label>
    <textarea
      :id="id"
      :value="modelValue"
      :required="required"
      :rows="rows || 4"
      :maxlength="maxlength"
      :aria-invalid="error ? 'true' : undefined"
      class="w-full rounded-[4px] border-2 border-[#DDDAD3] bg-white px-3.5 py-2.5 text-[#111111] focus:border-[#6735B6] focus:outline-none focus:ring-2 focus:ring-[#9C6EE8]/35"
      @input="$emit('update:modelValue', ($event.target as HTMLTextAreaElement).value)"
    />
    <p v-if="hint && !error" class="text-xs text-[#454545]">{{ hint }}</p>
    <p v-if="error" class="text-xs text-[#AD291F]" role="alert">{{ error }}</p>
  </div>
</template>
