<template>
  <v-dialog max-width="500">
    <template v-slot:activator="{ props: activatorProps }">
      <v-btn
          v-bind="activatorProps"
          color="primary"
          text="Leave a Comment"
          variant="tonal"
          :disabled="disabled"
      ></v-btn>
    </template>

    <template v-slot:default="{ isActive }">
      <v-card title="Leave a Comment">
        <v-textarea label="Comment"></v-textarea>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
              text="Close Dialog"
              @click="isActive.value = false"
          ></v-btn>
          <v-btn color="success">Submit</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script lang="ts">
import {defineComponent} from 'vue'

export default defineComponent({
  name: "LeaveACommentButton",

  props: {
    disabled: {
      type: Boolean,
      default: false
    }
  }
})
</script>

<style scoped>

</style>
