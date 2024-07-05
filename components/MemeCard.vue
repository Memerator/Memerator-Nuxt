<template>
  <v-card>
    <h4 id="fix" style="overflow: hidden;">
      <%= e.author.profile_picture(30) %> <a href="/profile/<%= e.author.username %>" style="<%= e.author.custom_name_color(session[:dark_mode]) %>"><%= e.author.username %></a> <%= e.author.verified_image(20) %>
      · <%= (distance_of_time_in_words(e['created_at'], Time.now, include_seconds: true)).gsub('about ', '').gsub(/ hours?/, 'h').gsub(/ seconds?/, 's').gsub(/ days?/, 'd').gsub(/ minutes?/, 'm').gsub(/ months?/, 'mo').gsub('half a', '1').gsub('less than a', '1')
      %>
    </h4>
    <p style="overflow: hidden;"><%= raw e.formatted_caption(e.author) %>
      <% if @loggedin && @user.can_rate? && @user.email_status == 2 %>
      <% unless e.rating_for(@user.id) == 1 %>
      <form id="<%= e['id'] %>form1" action="/meme/<%= e['id'] %>/rate" method="post" hidden>
        <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
        <%= hidden_field_tag :redirect_to, request.url %>
        <input hidden id='<%= e['id'] %>form1scroll' name='scroll_to' value='' />
        <input hidden class="form-control-range" name="rating" value="1" />
      </form>
      <% end %>

      <% unless e.rating_for(@user.id) == 2 %>
      <form id="<%= e['id'] %>form2" action="/meme/<%= e['id'] %>/rate" method="post" hidden>
        <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
        <%= hidden_field_tag :redirect_to, request.url %>
        <input hidden id='<%= e['id'] %>form2scroll' name='scroll_to' value='' />
        <input hidden class="form-control-range" name="rating" value="2" />
      </form>
      <% end %>

      <% unless e.rating_for(@user.id) == 3 %>
      <form id="<%= e['id'] %>form3" action="/meme/<%= e['id'] %>/rate" method="post" hidden>
        <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
        <%= hidden_field_tag :redirect_to, request.url %>
        <input hidden id='<%= e['id'] %>form3scroll' name='scroll_to' value='' />
        <input hidden class="form-control-range" name="rating" value="3" />
      </form>
      <% end %>

      <% unless e.rating_for(@user.id) == 4 %>
      <form id="<%= e['id'] %>form4" action="/meme/<%= e['id'] %>/rate" method="post" hidden>
        <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
        <%= hidden_field_tag :redirect_to, request.url %>
        <input hidden id='<%= e['id'] %>form4scroll' name='scroll_to' value='' />
        <input hidden class="form-control-range" name="rating" value="4" />
      </form>
      <% end %>

      <% unless e.rating_for(@user.id) == 5 %>
      <form id="<%= e['id'] %>form5" action="/meme/<%= e['id'] %>/rate" method="post" hidden>
        <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
        <%= hidden_field_tag :redirect_to, request.url %>
        <input hidden id='<%= e['id'] %>form5scroll' name='scroll_to' value='' />
        <input hidden class="form-control-range" name="rating" value="5" />
      </form>
      <% end %>
      <p>
        <span id="<%= e['id'] %>1" onmouseover="hover1('<%= e['id'] %>')" onclick="document.getElementById('<%= e['id'] %>form1scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= e['id'] %>form1').submit()" class="fa fa-star <%= 'checked' if e.average_rating >= 1 %>" style="font-size: 100%;"></span>
        <span id="<%= e['id'] %>2" onmouseover="hover2('<%= e['id'] %>')" onclick="document.getElementById('<%= e['id'] %>form2scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= e['id'] %>form2').submit()" class="fa fa-star <%= 'checked' if e.average_rating >= 2 %>" style="font-size: 100%;"></span>
        <span id="<%= e['id'] %>3" onmouseover="hover3('<%= e['id'] %>')" onclick="document.getElementById('<%= e['id'] %>form3scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= e['id'] %>form3').submit()" class="fa fa-star <%= 'checked' if e.average_rating >= 3 %>" style="font-size: 100%;"></span>
        <span id="<%= e['id'] %>4" onmouseover="hover4('<%= e['id'] %>')" onclick="document.getElementById('<%= e['id'] %>form4scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= e['id'] %>form4').submit()" class="fa fa-star <%= 'checked' if e.average_rating >= 4 %>" style="font-size: 100%;"></span>
        <span id="<%= e['id'] %>5" onmouseover="hover5('<%= e['id'] %>')" onclick="document.getElementById('<%= e['id'] %>form5scroll').value = document.querySelector('body').getBoundingClientRect().top; document.getElementById('<%= e['id'] %>form5').submit()" class="fa fa-star <%= 'checked' if e.average_rating >= 5 %>" style="font-size: 100%;"></span>
        - <%= e.average_rating.round(2) %><br />Reviewers: <%= e.ratings.count %>
        <% unless e.rating_for(@user.id).nil? %><br />Your current rating: <%= e.rating_for(@user.id) %><br />Comments: <%= e.comments.count %><% end %>
      </p>
      <p id="<%= e['id'] %>info" hidden>
        <i>Click a star to rate this meme!</i>
      </p>
      <% else %>
      <p>
        <span class="fa fa-star <%= 'checked' if e.average_rating >= 1 %>" style="font-size: 100%;"></span>
        <span class="fa fa-star <%= 'checked' if e.average_rating >= 2 %>" style="font-size: 100%;"></span>
        <span class="fa fa-star <%= 'checked' if e.average_rating >= 3 %>" style="font-size: 100%;"></span>
        <span class="fa fa-star <%= 'checked' if e.average_rating >= 4 %>" style="font-size: 100%;"></span>
        <span class="fa fa-star <%= 'checked' if e.average_rating >= 5 %>" style="font-size: 100%;"></span>
        - <%= e.average_rating.round(2) %><br />Reviewers: <%= e.ratings.count %><br />Comments: <%= e.comments.count %>
      </p>
      <% end %>
    </p>
    <a href="/meme/<%= e['id'] %>"><%= image_tag e['url'], style: 'width: 100%;', lazy: true %></a>
  </v-card>
</template>

<script lang="ts">
import {defineComponent} from 'vue'

export default defineComponent({
  name: "MemeCard"
})
</script>

<style scoped>

</style>
