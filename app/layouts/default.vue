<template>
  <div class="flex min-h-screen flex-col">
    <AppHeader />
    <main id="contenu-principal" class="flex-1">
      <slot />
    </main>
    <AppFooter />
    <ClientOnly>
      <KofiOverlayWidget />
      <AlertSignupModal />
    </ClientOnly>
  </div>
</template>
