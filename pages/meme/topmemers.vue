<template>
  <main>
    <h1 id="fix">Top 10 Memes</h1>

    <v-row>
      <v-col>
        <h2>1d Top Memers</h2>
        <p>These memers have the best meme score for the past day.</p>
        <v-table theme="dark" density="compact">
          <thead>
          <tr>
            <th>Rank</th>
            <th>User</th>
            <th>Score</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="ranked in topMemers['1d']">
            <td>
              <span style="align: center;">{{ ranked.rank }}</span>
            </td>
            <td>
              <a :href="`/profile/${ranked.user.username}`" :style="`color: #${ranked.user.pro.name_color || 'ffffff'}`">
                {{ ranked.user.username }}
              </a> <i v-if="ranked.user.perks.verified" class="fas fa-badge-check text-blue" />
            </td>
            <td>{{ ranked.score }}</td>
          </tr>
          </tbody>
        </v-table>
      </v-col>
      <v-col>
        <h2>7d Top Memers</h2>
        <p>These memers have the best meme score for the past week.</p>
        <v-table theme="dark" density="compact">
          <thead>
          <tr>
            <th>Rank</th>
            <th>User</th>
            <th>Score</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="ranked in topMemers['7d']">
            <td>
              <span style="align: center;">{{ ranked.rank }}</span>
            </td>
            <td>
              <a :href="`/profile/${ranked.user.username}`" :style="`color: #${ranked.user.pro.name_color || 'ffffff'}`">
                {{ ranked.user.username }}
              </a> <i v-if="ranked.user.perks.verified" class="fas fa-badge-check text-blue" />
            </td>
            <td>{{ ranked.score }}</td>
          </tr>
          </tbody>
        </v-table>
      </v-col>
      <v-col>
        <h2>1mo Top Memers</h2>
        <p>These memers have the best meme score for the past month.</p>
        <v-table theme="dark" density="compact">
          <thead>
          <tr>
            <th>Rank</th>
            <th>User</th>
            <th>Score</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="ranked in topMemers['1mo']">
            <td>
              <span style="align: center;">{{ ranked.rank }}</span>
            </td>
            <td>
              <a :href="`/profile/${ranked.user.username}`" :style="`color: #${ranked.user.pro.name_color || 'ffffff'}`">
                {{ ranked.user.username }}
              </a> <i v-if="ranked.user.perks.verified" class="fas fa-badge-check text-blue" />
            </td>
            <td>{{ ranked.score }}</td>
          </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>
  </main>
</template>

<script lang="ts">
import {defineComponent} from 'vue'
import type {TopMemers} from "~/types/stats";

export default defineComponent({
  name: "topmemers",

  async setup() {
    let topMemers: TopMemers
    await $fetch<TopMemers>(`/api/meme/topmemers`).then((res) => {
      topMemers = res
    })

    return { topMemers }
  }
})
</script>

<style scoped>

</style>
