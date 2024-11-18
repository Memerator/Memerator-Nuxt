<template>
  <client-only>
    <div v-masonry transition-duration="3s" item-selector=".item" class="masonry-container" column-width="300">
      <div v-for="meme in memes" :key="meme.id" v-masonry-tile class="item">
        <page-link :href="`/meme/${meme.id}`">
          <nuxt-img :src="meme.url" />
        </page-link>
      </div>
    </div>
  </client-only>
</template>

<script setup lang="ts">
// props, memes
import { defineProps } from 'vue'

defineProps<{
  memes: {
    id: string,
    url: string
    created_at: Date
  }[]
}>()
</script>

<style scoped>

</style>
