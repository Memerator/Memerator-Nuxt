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
    <tbody v-if="!stats">
    <tr>
      <td colspan="2">Loading...</td>
    </tr>
    </tbody>
    <tbody v-else>
    <tr>
      <td>Memes</td>
      <td>{{ stats.memes }}</td>
    </tr>
    <tr>
      <td>Ratings</td>
      <td>{{ stats.ratings }}</td>
    </tr>
    <tr>
      <td>Unique Memers</td>
      <td>{{ stats.unique_memers }}</td>
    </tr>
    <tr>
      <td>Users</td>
      <td>{{ stats.website_users }}</td>
    </tr>
    </tbody>
  </v-table>
</template>

<script setup lang="ts">
import type {Stats} from "~/types/stats";
import {metaTags} from "~/utils/meta";

metaTags("Site Statistics", "View the site stats here!");

const { data: stats } = await useFetch<Stats>('/api/stats', {
  lazy: true,
})
</script>

<style scoped>

</style>
