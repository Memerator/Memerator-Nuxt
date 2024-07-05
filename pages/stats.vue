<template>
  <h1 id="fix">Memerator Site Statistics</h1>
  <p>
    Thank you for checking out our statistics!
    We are proud of all of our memes (however we do not own them or take any responsibility) and are especially proud of our statistics.
    You can check them out below.
  </p>

  <v-table theme="dark" density="compact">
    <thead class="table-dark">
    <tr>
      <th>Stat</th>
      <th>Count</th>
    </tr>
    </thead>
    <tbody>
    <tr v-for="(item, index) in statsArray" :key="index">
      <td>{{ item[0] }}</td> <!-- Key -->
      <td>{{ item[1] }}</td> <!-- Value -->
    </tr>
    </tbody>
  </v-table>
</template>

<script lang="ts">
import {defineComponent} from 'vue'
import type {Stats} from "~/types/stats";

export default defineComponent({
  name: "stats",

  setup() {
    useSeoMeta({
      title: 'Site Statistics - Memerator',
      description: 'View the site stats here!',
    })
  },

  data() {
    return {
      stats: {} as Stats
    }
  },

  beforeMount() {
    $fetch<Stats>('/api/stats').then((res) => {
      this.stats = res
    })
  },

  computed: {
    statsArray() {
      return Object.entries(this.stats);
    }
  }
})
</script>

<style scoped>

</style>
