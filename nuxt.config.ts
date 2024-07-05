// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  runtimeConfig: {
    memeratorApiKey: process.env.MEMERATOR_API_KEY,

    public: {},
  },

  app: {
    head: {
      link: [],
      script: [{
        src: 'https://kit.fontawesome.com/99eae2971f.js',
        crossorigin: 'anonymous'
      }]
    }
  },

  experimental: {
    asyncContext: true
  },

  modules: [
    "@pinia/nuxt",
    "@nuxt/image",
    "@vueuse/nuxt",
    'vuetify-nuxt-module'
  ]
})
