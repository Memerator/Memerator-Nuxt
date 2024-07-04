// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  runtimeConfig: {
    memeratorApiKey: process.env.MEMERATOR_API_KEY,

    public: {},
  },

  modules: [
    "@pinia/nuxt",
    "@nuxt/image",
    "@vueuse/nuxt",
    'vuetify-nuxt-module'
  ]
})
