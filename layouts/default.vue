<template>
  <v-app id="inspire">
    <v-app-bar :flat="true" theme="dark">
      <v-container class="mx-auto d-flex align-center justify-center">
        <v-avatar class="me-4 " color="grey-darken-1" size="32" />

        <navbar-item name="Home" href="/" :current-path="useRoute().path" />

        <nav-dropdown name="Memes">
          <nav-dropdown-item v-if="loggedIn" name="Following Memes" fa-icon="fas fa-check" href="/meme/following" />
          <nav-dropdown-item v-if="loggedIn" name="Submit Meme" fa-icon="fas fa-pen" href="/meme/submit" />
          <nav-dropdown-item name="Recent Memes" fa-icon="far fa-clock" href="/meme/recents" />
          <nav-dropdown-item name="Top Memes" fa-icon="fas fa-trophy" href="/meme/top" />
          <nav-dropdown-item name="Top Memers" fa-icon="fas fa-award" href="/meme/topmemers" />
        </nav-dropdown>

        <nav-dropdown name="Extra">
          <nav-dropdown-item name="Site Stats" fa-icon="fas fa-chart-area" href="/stats" />
          <nav-dropdown-item name="API" fa-icon="fas fa-cogs" href="/api/auth" />
          <nav-dropdown-item name="Staff" fa-icon="fas fa-user-tie" href="/staff" />
          <nav-dropdown-item name="Bugs & Feedback" fa-icon="fas fa-bug" href="https://github.com/Memerator/Memerator-Nuxt" />
          <nav-dropdown-item name="Partners" fa-icon="fas fa-handshake" href="/partners" />
          <nav-dropdown-item name="Updates" fa-icon="fas fa-exclamation" href="/updates" />
          <nav-dropdown-item name="Discord Bot" fa-icon="fas fa-robot" href="/discordbot" />
        </nav-dropdown>

        <v-spacer />

        <v-responsive max-width="160" class="align-right">
<!--          <nav-dropdown v-if="user" name="You">-->
<!--            <nav-dropdown-item name="Profile" fa-icon="fas fa-user" href="/profile/me" />-->
<!--            <v-divider />-->
<!--            <nav-dropdown-item name="Settings" fa-icon="fas fa-cog" href="/settings/profile" />-->
<!--            <v-divider />-->
<!--            <nav-dropdown-item name="GitHub" fa-icon="fab fa-github" href="https://github.com/Chew/ChessTools" />-->
<!--            <nav-dropdown-item name="Logout" fa-icon="fas fa-sign-out-alt" @click="logout" />-->
<!--          </nav-dropdown>-->
<!--          <navbar-item v-else name="Login" href="/login" />-->
        </v-responsive>
      </v-container>
    </v-app-bar>

    <v-main id="main">
      <v-container>
        <v-row>
          <v-col v-if="isSettings" :cols="isMobile ? 12 : 3">
            <v-sheet rounded="lg" class="bg-grey-lighten-2">
              <v-list rounded="lg" class="bg-grey-lighten-2">
<!--                <nav-dropdown-item name="Profile" fa-icon="fas fa-user" href="/settings/profile" theme="dark" />-->
<!--                <nav-dropdown-item name="Integrations" fa-icon="fas fa-link" href="/settings/integrations" theme="dark" />-->
              </v-list>
            </v-sheet>
          </v-col>

          <v-col :cols="isSettings ? (isMobile ? 12 : 9) : 12">
            <v-sheet min-height="70vh" rounded="lg" class="p-2 bg-grey-lighten-2">
              <slot />
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
// import NavbarItem from '~/components/NavbarItem.vue'
// import { useSupabaseClient } from '#imports'

// const theme = useTheme()

// function toggleTheme() {
//   theme.global.name.value = theme.global.current.value.dark ? 'light' : 'dark'
// }

// const user = useSupabaseUser().value
import NavbarItem from "~/components/NavbarItem.vue";

const loggedIn = false

const route = useRoute()

let isMobile = ref(false)
const isSettings = ref(route.path.includes('settings'))

if (process.browser) {
  isMobile = ref(window.innerWidth < 768)

  // watch for window resize
  window.addEventListener('resize', () => {
    isMobile.value = window.innerWidth < 768
  })
}

// watch for route changes
watch(() => route.path, () => {
  isSettings.value = route.path.includes('settings')
})

async function logout() {
  // await useSupabaseClient().auth.signOut()

  window.location.reload()
}
</script>

<!--suppress CssUnusedSymbol -->
<style>
:root {
  --background-color: #fabc4d;
}

.p-2 {
  padding: 0.5rem!important;
}

.align-right {
  text-align: right!important;
}

body, #main {
  background-color: var(--background-color);
}

.v-application, .v-navigation-drawer {
  background: unset!important;
}

.v-application__wrap {
  min-height: unset!important;
}

.nav-link {
  /*noinspection All*/
  color: var(--bs-nav-link-color)!important;
}

.nav-link.active {
  /*noinspection All*/
  color: var(--bs-navbar-active-color)!important;
}
</style>
