// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    "@pinia/nuxt",
    "@nuxt/image",
    "@vueuse/nuxt",
    'vuetify-nuxt-module'
  ]
})
