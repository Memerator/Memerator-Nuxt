<template>
  <v-card
      :title="author"
      :subtitle="timestamp"
      :text="comment"
      variant="tonal"
      :loading="loading"
  ></v-card>
</template>

<script lang="ts">
import {defineComponent} from 'vue'

export default defineComponent({
  name: "MemeComment",

  props: {
    author: {
      type: String,
      required: true
    },
    comment: {
      type: String,
      required: true
    },
    timestamp: {
      type: String,
      required: true
    },
    loading: {
      type: Boolean,
      default: false
    }
  }
})
</script>

<style scoped>

</style>
