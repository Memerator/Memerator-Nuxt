<template>
  <main v-if="loggedIn">
    <h1>Meme Ratings</h1>

    <PageLink :to="`/meme/${id}`">Back to Meme</PageLink>

    <p>Here is your meme's ratings (best to worse).</p>

    <v-table theme="dark" density="comfortable">
      <thead>
      <tr>
        <th>Memer</th>
        <th>Rating</th>
      </tr>
      </thead>
      <tbody v-if="ratings.length === 0">
        <tr>
          <td colspan="2">No one has rated your meme yet! Consider sharing it.</td>
        </tr>
      </tbody>
      <tbody v-else>
      <tr v-for="rating in ratings">
        <td width="80%">
          <a :href="`/profile/${rating.user.username}`" :style="`color: #${rating.user?.pro?.name_color || 'ffffff'}`">{{ rating.user.username }}</a>
          <i v-if="rating.user.perks.verified" class="fas fa-badge-check text-blue ml-1" />
        </td>
        <td width="20%">
          <span v-for="star in 5" :key="star" class="fa fa-star fa-2x" :class="{'text-orange': rating.rating >= star}"></span>
        </td>
      </tr>
      </tbody>
    </v-table>
  </main>
  <main v-else>
    <h1>Not Logged In</h1>
    <p>You must be logged in to view your meme's ratings.</p>
  </main>
</template>

<script lang="ts">
import {defineComponent} from 'vue'
import type {Rating} from "~/types/meme";

export default defineComponent({
  name: "ratings",

  async setup() {
    const route = useRoute()
    const id = route.params.id

    const loggedIn = false
    return { id, loggedIn }

    // let ratings: Rating[];
    // await $fetch<Rating[]>(`/api/meme/${id}/ratings`).then((res) => {
    //   ratings = res
    // })
    //
    // return {
    //   id,
    //   ratings
    // }
  },
})
</script>

<style scoped>

</style>
