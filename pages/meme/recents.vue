<template>
  <main>
    <h1 id="fix">Recent Memes</h1>
    <p>Total Memes: {{ data?.total }} memes!</p>

    <p>Showing memes {{ data?.min }} to {{ data?.max }}</p>

    <div class="mb-3">
      <v-btn :disabled="page < 2" color="primary" @click="page -= 1"><i class="fas fa-arrow-circle-left"/> Previous</v-btn>
      <v-btn :disabled="noMoreMemes" color="primary" @click="page += 1"><i class="fas fa-arrow-circle-right"/> Next</v-btn>
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

    <v-card v-for="meme in data?.memes" :key="meme.id" class="mb-10">
      <PageLink :href="`/meme/${meme.id}`"><NuxtImg :src="meme.url" class="card-img-top" alt="..." style="width: 100%" /></PageLink>
      <v-card-text>{{ meme.caption }}</v-card-text>
      <v-card-actions>
        <v-list-item class="w-100">
          <template #prepend>
            <v-avatar v-if="meme.author.avatar" :image="meme.author.avatar" />
          </template>

          <v-list-item-title>
            <page-link :href="`/profile/${meme.author.username}`">{{ meme.author.username }}</page-link>
          </v-list-item-title>
          <v-list-item-subtitle>{{ new Date(meme.created_at).toLocaleString() }}</v-list-item-subtitle>

          <template #append>
            <div class="justify-self-end">
              <v-icon class="me-1" icon="mdi-star" />
              {{ meme.ratings.average ?? "No" }} average, {{ meme.ratings.total }} ratings
            </div>
          </template>
        </v-list-item>
      </v-card-actions>
    </v-card>

    <div class="mb-3">
      <v-btn :disabled="page < 2" color="primary" @click="page -= 1"><i class="fas fa-arrow-circle-left"/> Previous</v-btn>
      <v-btn :disabled="noMoreMemes" color="primary" @click="page += 1"><i class="fas fa-arrow-circle-right"/> Next</v-btn>
    </div>
  </main>
</template>

<script setup lang="ts">
import type {RecentMemeResponse} from "~/server/api/meme/recents";

const route = useRoute()
const page = ref(parseInt((route.query.page || 1).toString()))

// debug stuff
// const showAds = false;

const noMoreMemes = ref(false)

const { data } = await useFetch<RecentMemeResponse>('/api/meme/recents', {
  query: {
    page
  },
})
</script>

<style scoped>

</style>
