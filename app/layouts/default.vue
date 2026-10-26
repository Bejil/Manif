<template>
  <div class="flex min-h-screen flex-col">
    <AppHeader />
    <main id="contenu-principal" class="flex-1">
      <slot />
    </main>
    <AppFooter />
  </div>
</template>
