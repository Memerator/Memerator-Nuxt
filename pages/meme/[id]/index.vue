<template>
  <main v-if="meme">
    <h1>Meme Information</h1>
    <v-row>
      <v-col>
        <p v-if="meme.disabled">
          <i>This meme is disabled, but since you own it you can still view it!</i>
        </p>

        <h2>Author</h2>
        [pfp]
        <a :style="`color: #${meme.author.pro.name_color}`" :href="`/profile/${meme.author.username}`">
          {{ meme.author.username }}
        </a> <i v-if="meme.author.perks.verified" class="fas fa-badge-check text-blue" />

        <h2>Age Rating</h2>
        {{ meme.age }}

        <h2>Caption</h2>
        <span id="caption">
          {{ meme.caption }}

<!--          <a v-if="false" onclick="bruh()"><i class="fas fa-edit"></i></a>-->
        </span>

        <p v-if="false /* if contest */">
          <span class="heading">Contest</span>
          <br/>
          This meme is a part of a contest
        </p>

        <h2>Submitted</h2>
        {{ meme.timestamp }}

        <h2>Ratings</h2>
        <p v-if="meme.rating.total === 0">No one has rated this meme yet!</p>
        <!--        <div class="ratings">-->
        <!--          <span class="empty-stars"></span>-->
        <!--          <span class="full-stars" :style="`width: ${meme.rating.average * 20}%`"></span>-->
        <!--        </div>-->
        <p>
          {{ meme.rating.average }} average from {{ meme.rating.total }} meme reviewers.
        </p>

        <!--        <% (0..4).each do |num| %>-->
        <!--        <div class="side">-->
        <!--          <div><%= t('.x_star', star: 5 - num) %></div>-->
        <!--        </div>-->
        <!--        <div class="middle">-->
        <!--          <div class="bar-container">-->
        <!--            <div class="bar-<%= 5 - num %>" style="width: <%= @per[4 - num] / @per.sum.to_f * 100 %>%;"></div>-->
        <!--          </div>-->
        <!--        </div>-->
        <!--        <div class="side right">-->
        <!--          <div><%= @per[4 - num] %></div>-->
        <!--        </div>-->
        <!--        <% end %>-->

        <h2>Actions</h2>
        <v-btn id="copyurl" color="cyan" data-clipboard-text="meme.url" class="mr-1">Share</v-btn>
        <!--        <% if @ownsmeme %>-->
        <NuxtLink v-if="isAuthor" :href="`/meme/${meme.memeid}/ocr`" class="mr-1">
          <v-btn color="grey">OCR</v-btn>
        </NuxtLink>
        <NuxtLink v-if="isAuthor" :href="`/meme/${meme.memeid}/transfer`" class="mr-1">
          <v-btn color="primary">Transfer</v-btn>
        </NuxtLink>
        <v-btn v-if="!meme.disabled && isAuthor" @click="disableMeme" color="red" class="mr-1">Disable</v-btn>
        <v-btn v-if="meme.disabled && isAuthor" @click="enableMeme" color="green" class="mr-1">Enable</v-btn>
        <NuxtLink v-if="isAuthor && meme.author.perks.pro" :href="`/meme/${meme.memeid}/ratings`" class="mr-1">
          <v-btn color="warning">Ratings</v-btn>
        </NuxtLink>
        <NuxtLink v-if="true" :href="`https://mods.memerator.me/meme/${meme.memeid}`" class="mr-1">
          <v-btn color="green">Manage</v-btn>
        </NuxtLink>
        <!--        <% end %>-->
        <!--        <% if !@ownsmeme && !@user.nil? %>-->
        <!--        <% if Report.where(user_id: session[:id], meme_id: @id).count > 0 %>-->
        <!--        <button class="btn btn-danger" type="button" id="dgergergesges" data-bs-toggle="modal" data-bs-target="#reportmodal">Report</button>-->
        <!--        <div id="reportmodal" class="modal fade" tabindex="-1" role="dialog">-->
        <!--          <div class="modal-dialog" role="document">-->
        <!--            <div class="modal-content">-->
        <!--              <div class="modal-header">-->
        <!--                <h5 class="modal-title"><%= t('just_letting_you_know') %></h5>-->
        <!--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
        <!--              </div>-->
        <!--              <div class="modal-body">-->
        <!--                <p><%= t('.already_reported') %></p>-->
        <!--              </div>-->
        <!--              <div class="modal-footer">-->
        <!--                <button type="button" class="btn btn-info" data-bs-dismiss="modal"><%= t('okay') %></button>-->
        <!--              </div>-->
        <!--            </div>-->
        <!--          </div>-->
        <!--        </div>-->
        <!--        <% else %>-->
        <!--        <a href="/meme/<%= @id %>/report"><button class="btn btn-danger"><%= t('report') %></button></a>-->
        <!--        <% end %>-->
        <!--        <% end %>-->

        <!--        <hr />-->

        <!--        <h3><%= t('.rate_this_meme') %></h3>-->
        <!--        <% if @loggedin %>-->
        <!--        <% if @user.can_rate? && @user.email_status == 2 %>-->
        <!--        <%= your = @meme.rating_for(@user.id) || 0; nil%>-->
        <!--        <% (1..5).each do |i| %>-->
        <!--        <% unless your == i %>-->
        <!--        <form id="<%= @meme['id'] %>form<%= i %>" action="/meme/<%= @meme['id'] %>/rate" method="post" hidden>-->
        <!--          <%= hidden_field_tag :authenticity_token, form_authenticity_token %>-->
        <!--          <%= hidden_field_tag :redirect_to, request.url %>-->
        <!--          <input hidden id='<%= @meme['id'] %>form<%= i %>scroll' name='scroll_to' value='' />-->
        <!--          <input hidden class="form-control-range" name="rating" value="<%= i %>" />-->
        <!--        </form>-->
        <!--        <% end %>-->
        <!--        <% end %>-->

        <!--        <p id="stars">-->
        <!--          <% (1..5).each do |i| %>-->
        <!--          <span id="<%= @meme['id'] %><%= i %>" onmouseover="change('<%= @meme['id'] %>', <%= i %>)" onclick="document.getElementById('<%= @meme['id'] %>form<%= i %>scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= @meme['id'] %>form<%= i %>').submit()" class="fa fa-star <%= 'checked' if your >= i %>"></span>-->
        <!--          <% end %>-->

        <!--          <% if your > 0 %><br /><%= t('.current_rating', rating: your) %><% end %>-->
        <!--        </p>-->
        <!--        <p id="<%= @meme['id'] %>info" hidden>-->
        <!--          <i><%= t('.click_to_rate') %></i>-->
        <!--        </p>-->
        <!--        <% else %>-->
        <!--        <p>Uh oh! You don't have permission to rate memes! Contact <a href="/support">support</a> if you think this is a mistake.</p>-->
        <!--        <% end %>-->
        <!--        <% else %>-->
        <!--        <p><%= t('.sign_in_to_rate') %></p>-->
        <!--        <% end %>-->
      </v-col>

      <v-col xl="8">
        <NuxtImg :src="meme.url" style="width: 100%"/>
      </v-col>
    </v-row>

    <hr/>

    <v-row>
      <v-col>
        <h2 v-if="commentsLoading">Loading Comments...</h2>
        <h2 v-else>Comments - {{ comments.length }}</h2>

        <leave-a-comment-button class="mb-3" :disabled="commentsLoading" />

        <meme-comment v-for="comment in comments" class="mt-3"
                      :comment="comment.content" :author="comment.author.username" :timestamp="comment.timestamp.toString()">
        </meme-comment>

        <!--        <% if @user.nil? %>-->
        <!--        <p><%= t('.sign_in_to_comment') %></p>-->
        <!--        <% elsif !@user.can_comment? || @user.email_status < 2 %>-->
        <!--        <p>Uh oh! You don't have permission to leave a comment! Is this a mistake? Contact <a href="/support">support</a>!</p>-->
        <!--        <% else %>-->
        <!--        <p><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#comment_meme"><%= t('.leave_comment') %></button></p>-->
        <!--        <% end %>-->

        <!--        <% @comments.each_with_index do |e, i| %>-->
        <!--        <%= render partial: 'comment', locals: { e: e, options: true, i: i } %>-->
        <!--        <% if !@user.nil? && (e.user_id == @user.id || @meme.user_id == @user.id || Owners.include?(@user.id)) %>-->
        <!--        <div id="delete_comment_<%= i %>" class="modal fade" tabindex="-1" role="dialog">-->
        <!--          <div class="modal-dialog" role="document">-->
        <!--            <div class="modal-content">-->
        <!--              <div class="modal-header">-->
        <!--                <h5 class="modal-title"><%= t('.delete_comment') %></h5>-->
        <!--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
        <!--              </div>-->
        <!--              <div class="modal-body">-->
        <!--                <p><%= t('.delete_comment_confirmation') %></p>-->
        <!--                <%= render partial: 'comment', locals: { e: e, options: false, i: i } %>-->
        <!--              </div>-->
        <!--              <div class="modal-footer">-->
        <!--                <button type="button" class="btn btn-info" data-bs-dismiss="modal">Cancel</button>-->
        <!--                <form action="/meme/<%= @id %>/comment/<%= e.id %>/delete" method="post">-->
        <!--                  <%= hidden_field_tag :authenticity_token, form_authenticity_token %>-->
        <!--                  <button type="submit" class="btn btn-danger"><%= t('delete') %></button>-->
        <!--                </form>-->
        <!--              </div>-->
        <!--            </div>-->
        <!--          </div>-->
        <!--        </div>-->
        <!--        <% end %>-->
        <!--        <% end %>-->
        <!--      </div>-->

        <!--      <% unless @user.nil? %>-->
        <!--      <div id="comment_meme" class="modal fade" tabindex="-1" role="dialog">-->
        <!--        <div class="modal-dialog" role="document">-->
        <!--          <div class="modal-content">-->
        <!--            <div class="modal-header">-->
        <!--              <h5 class="modal-title"><%= t('.leave_comment') %></h5>-->
        <!--              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
        <!--            </div>-->
        <!--            <div class="modal-body">-->
        <!--              <form id="responseform" action="/meme/<%= @id %>/comment" method="post">-->
        <!--                <%= hidden_field_tag :authenticity_token, form_authenticity_token %>-->
        <!--                <h3><%= t('response') %></h3>-->
        <!--                <input type="text" class="form-control" id="response" name="response" aria-describedby="captionHelp" placeholder="<%= t('.enter_response') %>">-->
        <!--              </form>-->
        <!--            </div>-->
        <!--            <div class="modal-footer">-->
        <!--              <button form="responseform" id="responsebutton" type="submit" class="btn btn-success"><%= t('submit') %></button>-->
        <!--              <button type="button" class="btn btn-info" data-bs-dismiss="modal"><%= t('close') %></button>-->
        <!--            </div>-->
        <!--          </div>-->
        <!--        </div>-->
        <!--      </div>-->
        <!--      <% end %>-->
      </v-col>
    </v-row>

    <!--    <script>-->
    <!--      var clipboard = new ClipboardJS('#copyurl');-->
    <!--      clipboard.on('success', function(e) {-->
    <!--        document.getElementById('copyurl').innerHTML = 'Copied URL';-->
    <!--        document.getElementById('copyurl').setAttribute('class', 'btn btn-success');-->
    <!--      })-->
    <!--      clipboard.on('error', function(e) {-->
    <!--        document.getElementById('copyurl').innerHTML = 'Copy Errored :(';-->
    <!--        document.getElementById('copyurl').setAttribute('class', 'btn btn-danger');-->
    <!--      })-->
    <!--      $('form').submit(function(){-->
    <!--        $(this).find('button[type=submit]').prop('disabled', true);-->
    <!--        $(this).find('button[type=submit]').html('Submitting...');-->
    <!--      });-->
    <!--      function bruh() {-->
    <!--        document.getElementById("caption").hidden = true;-->
    <!--        document.getElementById("captionform").hidden = false;-->
    <!--      }-->
    <!--      function unbruh() {-->
    <!--        document.getElementById("caption").hidden = false;-->
    <!--        document.getElementById("captionform").hidden = true;-->
    <!--      }-->
    <!--    </script>-->
  </main>
  <main v-else>
    <h1>Meme not found</h1>
    <p>Sorry, we couldn't find the meme you were looking for.</p>
  </main>
</template>

<script lang="ts">
import type {Meme} from "~/types/meme";
import type {Comment} from "~/types/comment";

import {defineComponent} from 'vue'
import type {UseSeoMetaInput} from "@unhead/schema";

export default defineComponent({
  name: "MemeView",

  async setup() {

    const route = useRoute()
    const id = route.params.id

    let meme: Meme;
    await $fetch<Meme>(`/api/meme/${id}`).then((res) => {
      meme = res
    })

    useSeoMeta({
      title: `Meme Viewing ${meme.memeid} - Memerator`,
      ogImage: {
        secureUrl: meme.url,
        url: meme.url,
        alt: meme.caption,
      },
      description: `${meme.caption} by ${meme.author.username} for Memerator`,
      ogDescription: `${meme.caption} by ${meme.author.username} for Memerator`,
      articleAuthor: meme.author.username,
      // keywords: meme.ocr
      author: meme.author.username
    } as UseSeoMetaInput);

    const memeisreal = true // check if null

// TODO: render markdown
//     redner = Redcarpet::Render::HTML.new(escape_html: true, no_images: true, no_styles: true, no_links: true, prettify: true)
// const markdown = meme.caption
// const no_markdown = meme.caption

    if (!memeisreal) {
      let show = false
      let dontshowreason = "Meme doesn't exist!"
    }
//
// if @meme.dmca?
//     @show = false
//     @dontshowreason = "Meme unavailable due to DMCA takedown!"
//   return
// end
//
// @author = @meme.author
// @ownsmeme = @author.id == session[:id]
//
// if @user.nil? && @meme.mature?
//     @show = false
//     @dontshowreason = 'Meme is marked as Mature! You must create an account and select "Mature" as your Meme Age Rating to view this meme.'
// return
// end
//
// unless @meme.approved?
//     @show = false
//     @dontshowreason = 'Meme is not yet approved!'
// return
// end
//
// if !@user.nil? && !@user.staff?
// if @meme.disabled? && @meme.author != @user
// @show = false
// @dontshowreason = 'Meme is disabled!'
// return
// end
//
// if @meme.mature? && @meme.author != @user && @user.age != 4
// @show = false
// @dontshowreason = 'Meme is marked as Mature! You must manually enable Mature memes in appearance settings.'
// return
// end
//
// if @meme.teen? && @meme.author != @user && @user.age < 2
// @show = false
// @dontshowreason = 'Meme is marked as Teen! You must manually enable Teen memes in appearance settings.'
// return
// end
// end
//
// @caption = @meme.formatted_caption
//
// @comments = @meme.comments
// unless @comments.empty?
//     author_ids = @comments.map(&:user_id).uniq
//
// profiles = User.where(id: author_ids).to_a
// @profiles = {}
// profiles.each do |profile|
// @profiles[profile.id] = profile
// end
// end
//
// @contest = @meme.contest
// @realm = @meme.realm
//
// @per = []
//
// if @meme.rated?
//     (1..5).each do |e|
// @per[e - 1] = @meme.rating_numbers.count(e)
// end
// end


    const comments = [] as Comment[]

    const isAuthor = true;


    return { meme, comments, isAuthor }
  },

  mounted() {
    this.retrieveComments()
  },

  data() {
    return {
      commentsLoading: true,
    }
  },

  methods: {
    retrieveComments() {
      // retrieve comments
      console.log("Retrieving comments")
      this.commentsLoading = true

      $fetch<Comment[]>(`/api/meme/${this.meme.memeid}/comments`).then((res) => {
        this.comments = res
        this.commentsLoading = false
      })
    },

    disableMeme() {
      // disables meme
      console.log("Disabling meme")
      this.meme.disabled = true
    },

    enableMeme() {
      // disables meme
      console.log("Enabling meme")
      this.meme.disabled = false
    }
  }
})


/*
<title>Meme Viewing (<%= @id %>) - Memerator</title>
    <meta property="og:image:secure_url" content="<%= @meme.url %>">
    <meta property="og:image" content="<%= @meme.url %>" />
    <meta property="og:image:alt" content="<%= @meme.caption %>" />
    <meta property="og:description" content="<%= @meme.caption %> by <%= @author.username %> for Memerator" />
    <meta name="description" content="<%= @meme.ocr %> - <%= @meme.caption %> by <%= @author.username %> for Memerator" itemprop="description">
    <meta property="article:author" content="<%= @author.username %>">
    <meta name="keywords" content="<%= @meme.ocr %>" itemprop="keywords">
    <meta name="author" content="<%= @author.username %>" itemprop="author">
    <meta property="og:updated_time" content="<%= @meme.created_at %>">
    <meta name="medium" content="image" />
    <meta property="twitter:image" content="<%= @meme.url %>">
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:title" content="Memerator">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.0/clipboard.min.js">
 */

// const meme = get meme from database
</script>

<style scoped>

</style>
