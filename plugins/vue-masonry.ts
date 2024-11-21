import {VueMasonryPlugin} from 'vue-masonry'

// noinspection JSUnresolvedReference
export default defineNuxtPlugin((context) => {
    context.vueApp.use(VueMasonryPlugin);
});
