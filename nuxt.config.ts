// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: {
    enabled: true,

    timeline: {
      enabled: true
    }
  },

  ssr: false,

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

  plugins: [
    { src: '~/plugins/vue-masonry', mode: 'client' }
  ],

  modules: [
    "@pinia/nuxt",
    "@nuxt/image",
    "@vueuse/nuxt",
    'vuetify-nuxt-module',
    "@nuxt/eslint",
    "@prisma/nuxt"
  ],

  compatibilityDate: "2024-11-12"
})
