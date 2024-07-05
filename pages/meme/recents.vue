<template>
  <main>
    <h1 id="fix">Recent Memes</h1>
    <p>Total Memes: {{ memes.length }} memes!</p>

    <p>Showing memes {{ low }} to {{ high }}</p>

    <div class="mb-3">
      <v-btn :disabled="page < 2" color="primary" @click="fetchMemes(page - 1)"><i class="fas fa-arrow-circle-left"></i> Previous</v-btn>
      <v-btn :disabled="noMoreMemes" color="primary" @click="fetchMemes(page + 1)"><i class="fas fa-arrow-circle-right"></i> Next</v-btn>
    </div>

    <!--    <div v-if="showAds" class="p-4 bg-body-secondary rounded-3">-->
    <!--      <h4 id="fix" style="overflow: hidden;">-->
    <!--        Memerator Ads <i class="fas fa-badge-check text-blue fa-2x" />-->
    <!--      </h4>-->
    <!--      <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>-->
    <!--      <ins class="adsbygoogle" style="display:block" data-ad-format="fluid" data-ad-layout-key="-6t+ed+2i-1n-4w" data-ad-client="ca-pub-1430288436761120" data-ad-slot="9984593315"></ins>-->
    <!--      <script>-->
    <!--        (adsbygoogle = window.adsbygoogle || []).push({});-->
    <!--      </script>-->
    <!--    </div>-->


    <!-- center the card -->
    <v-row>
      <v-col v-for="meme in memes" :key="meme.memeid">
        <v-card>
          <NuxtImg :src="meme.url" class="card-img-top" alt="..." />
          <v-card-title>{{ meme.author.username }}</v-card-title>
          <v-card-subtitle>{{ meme.timestamp }}</v-card-subtitle>
          <v-card-text>{{ meme.caption }}</v-card-text>
          <v-card-text>Rating: {{ meme.rating.average }} average from {{ meme.rating.total }} reviewers.</v-card-text>
          <v-card-actions>
            <PageLink :href="`/meme/${meme.memeid}`">View Meme</PageLink>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>

    <PageLink v-if="page < 2" class="btn btn-primary disabled" href="#"><i class="fas fa-arrow-circle-left"></i>
      Previous
    </PageLink>
    <PageLink v-else class="btn btn-primary" :href="`/meme/recents?page=${page - 1}`"><i
        class="fas fa-arrow-circle-left"></i> Previous
    </PageLink>

    <PageLink v-if="noMoreMemes" class="btn btn-primary disabled" href="#"><i class="fas fa-arrow-circle-right"></i>
      Next
    </PageLink>
    <PageLink class="btn btn-primary" :href="`/meme/recents?page=${page + 1}`"><i class="fas fa-arrow-circle-right"></i>
      Next
    </PageLink>
  </main>
</template>

<script lang="ts">
import {defineComponent} from 'vue'
import type {Meme} from "~/types/meme";

export default defineComponent({
  name: "recents",

  async setup() {
    const route = useRoute()
    // check query param
    const page = parseInt((route.query.page || 1).toString())

    const memes: Meme[] = []
    let noMoreMemes = false
    await $fetch<Meme[]>(`/api/meme/recents?page=${page}`).then((res) => {
      if (res.length < 25) {
        noMoreMemes = true
      }

      for (const meme of res) {
        if (meme.disabled) continue

        memes.push(meme)
      }
    })

    const low = (page - 1) * 25 + 1
    const high = page * 25

    // debug stuff
    const showAds = false;

    return {memes, showAds, low, high, page, noMoreMemes}
  },

  watch: {
    // memes deeply
    memes: {
      handler() {
        console.log("Memes changed!")
      },
      deep: true
    }
  },

  methods: {
    async fetchMemes(page: Number) {
      console.log("Fetching memes with page: " + page)

      const res = await $fetch<Meme[]>(`/api/meme/recents?page=${page}`)
      if (res.length < 25) {
        this.noMoreMemes = true
      }

      // remove memes from the array WITHOUT doing = []
      this.memes.splice(0, this.memes.length)

      for (const meme of res) {
        if (meme.disabled) continue

        this.memes.push(meme)
      }

      // refresh the page

      this.page = page
      // update browser url
      this.$router.push(`/meme/recents?page=${page}`)
    }
  }
})
</script>

<style scoped>

</style>
