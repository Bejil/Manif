<script setup lang="ts">
defineProps<{
  id: string
  label: string
  modelValue: string
  options: Array<{ value: string, label: string }>
  required?: boolean
  error?: string
}>()

defineEmits<{ 'update:modelValue': [value: string] }>()
</script>

<template>
  <div class="space-y-1.5">
    <label :for="id" class="block text-sm font-bold text-[#111111]">
      {{ label }}
      <span v-if="required" class="text-[#AD291F]" aria-hidden="true">*</span>
    </label>
    <select
      :id="id"
      :value="modelValue"
      :required="required"
      :aria-invalid="error ? 'true' : undefined"
      class="min-h-[48px] w-full rounded-[4px] border-2 border-[#DDDAD3] bg-white px-3.5 py-2.5 text-[#111111] focus:border-[#6735B6] focus:outline-none focus:ring-2 focus:ring-[#9C6EE8]/35"
      @change="$emit('update:modelValue', ($event.target as HTMLSelectElement).value)"
    >
      <option
        v-for="opt in options"
        :key="opt.value"
        :value="opt.value"
      >
        {{ opt.label }}
      </option>
    </select>
    <p v-if="error" class="text-xs text-[#AD291F]" role="alert">{{ error }}</p>
  </div>
</template>
