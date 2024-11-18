<template>
  <v-row>
    <v-col v-if="profile?.avatar !== ''" sm="1">
      <v-avatar :image="profile?.avatar" size="65" />
    </v-col>
    <v-col>
      <h1 id="fix" style="margin-bottom: 0px; overflow: auto;">
        <span :style="`color: #${profile?.pro?.name_color ?? '000000'}`">{{ profile?.username }}</span>
        <i v-if="profile?.perks.verified" class="fas fa-badge-check text-blue" style="margin-left: 10px" />
      </h1>
      <div style="margin-top: 0px; color: #aaaaaa;">
        <span v-if="profile?.perks.founder"><i class="fas fa-user-graduate" style="color: red;"/> Memerator Founder<br></span>
        <span v-if="profile?.perks.staff"><i class="fas fa-toolbox" style="color: orange;"/> Memerator Team Member<br></span>
        <span v-if="profile?.perks.pro"><img src="/pro.svg" height="20px" style="margin-bottom: -5px">
          Subscriber since {{ profile?.pro?.since }}<br>
        </span>
        <span v-if="profile?.perks.translator"><i class="fas fa-language" style="color: blue;"/> Translator<br></span>
        <span v-if="profile?.perks.service">
          <i class="fas fa-tools" style="color: purple;"/> This account is managed by Memerator.
          <PageLink href="/support/faq#service" color="grey">What's this?</PageLink><br>
        </span>
<!--        <% unless @follows.nil? }}-->
<!--        {{ t('follows_you') }}<br/>-->
<!--        <% end }}-->
<!--        <% unless @followyknow.nil? }}-->
<!--        {{ @youknow }} followers you know<br/>-->
<!--        <% end }}-->
        <span class="foll">
        {{ profile?.stats.followers }} <page-link :href="`/profile/${username}/followers`" color="grey">Followers</page-link> ·
        {{ profile?.stats.following }} <page-link :href="`/profile/${username}/following`" color="grey">Following</page-link><br>
        </span>
      </div>
<!--      <% if @user && !profile.service? && @user != profile }}-->
<!--      <% if following?(@user.id, profile.id) }}-->
<!--      <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#follow">{{ t('following') }}</button>-->
<!--      {{ content_for :description do }}-->
<!--      {{ t('meme.profile.really_unfollow') }}-->
<!--      <% end }}-->
<!--      {{ content_for :footer do }}-->
<!--      {{ button_to "Unfollow", "/profile/#{profile.id}/unfollow", method: :post, class: "btn btn-success" }}-->
<!--      <button id="cancelbutton" type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close">{{ t('cancel') }}</button>-->
<!--      <% end }}-->
<!--      {{ render partial: 'layouts/modal', locals: { id: "follow" } }}-->
<!--      <% elsif !@user.can_follow? || @user.email_status < 2 }}-->
<!--      {{ content_for :description do }}-->
<!--      <p>Uh oh! You don't have permission to follow users! Contact <a href="/support">support</a> if you think this-->
<!--        is a mistake.</p>-->
<!--      <% end }}-->
<!--      {{ content_for :footer do }}-->
<!--      <button type="button" class="btn btn-info" data-bs-dismiss="modal">{{ t('okay') }}</button>-->
<!--      <% end }}-->
<!--      {{ render partial: 'layouts/modal', locals: { id: "edit_meme" } }}-->

<!--      <button id="edit_button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#edit_meme">{{ t('follow') }}</button>-->
<!--      <% else }}-->
<!--      {{ button_to t('follow'), "/profile/#{profile.id}/follow", method: :post, class: "btn btn-primary" }}-->
<!--      <% end }}-->
<!--      <% end }}-->
<!--    </div>-->
<!--  </div>-->
  <div class="row">
    <div class="col">
      <span class="heading">Bio</span>
      <p v-if="profile?.bio === ''">
        <i>No Bio Set</i>
      </p>
      <p v-else style="overflow: auto">
        {{ profile?.bio }}
      </p>
    </div>
  </div>

<!--  <% unless profile.service? }}-->
  <h2>Memes</h2>
  <div v-if="(profile?.memes?.length ?? 0) > 0" id="memes" class="grid">
    <profile-memes-gallery v-if="profile?.memes" :memes="profile?.memes" />
  </div>
  <p v-else>This user does not have any memes!</p>
<!--  <% end }}-->

<!--  <% if @user == profile && @disabled.length > 0 }}-->
<!--  <h3>{{ t('meme.mymemes.disabled_meme') }}</h3>-->

<!--  <div id="disabled" class="row">-->
<!--    <% @disabled.each do |e| }}-->
<!--    <div class="col" style="padding: 10px 10px 10px 10px;">-->
<!--      <div class="embed-responsive">-->
<!--        <a class="clearfix" href="/meme/{{ e[0] }}">-->
<!--          {{ image_tag e[1], class: 'image', style: 'border-radius: 12px; max-height: 175px', lazy: true }}-->
<!--        </a>-->
<!--      </div>-->
    </v-col>
<!--    <% end }}-->
  </v-row>
<!--  <% end }}-->
</template>

<script setup lang="ts">
import type {ProfileUsernameResponse} from "~/server/api/profile/[username]";

metaTags("#{profile.username}'s Profile", "#{profile.bio}")

const route = useRoute()
const username = route.params.username

const { data: profile } = await useFetch<ProfileUsernameResponse>(`/api/profile/${username}`, {
  lazy: true,
})

// if (error) {
//   // show error
//   showError({
//     statusCode: error.value?.statusCode,
//     message: error.value?.message
//   })
// }
</script>

<style scoped>
.grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-gap: 20px;
  align-items: center;
  justify-items: center;
}

.grid img {
  box-shadow: 2px 2px 6px 0px rgba(0, 0, 0, 0.3);
  max-width: 100%;
}
</style>
