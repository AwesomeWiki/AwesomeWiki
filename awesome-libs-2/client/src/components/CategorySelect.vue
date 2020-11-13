<!-- eslint-disable -->
<template>
  <v-container>
    <!-- <div>I am a {{ this.$route.params.language }} programmer looking for a library to help me with </div> -->
    <v-row justify="center">
      <v-col v-for="cat in categories" :key="cat" cols="auto">
        <div
          class="zoom"
          @mouseover="mouseover(cat.i)"
          @mouseleave="mouseleave(cat.i)"
        >
          <v-card
            elevation="24"
            width="300"
            height="300"
            v-ripple="{ center: true }"
            @click="goToCat(cat)"
          >

            <v-card-title align="center" justify="center"> {{ cat.name }} </v-card-title>

          </v-card>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
/* eslint-disable */
import LibsService from "@/services/LibsService";
export default {
  name: "CategorySelect",

  data: () => ({
    categories: [],
    selectedCategory: null,
    imageURLs: [],
    clickedLink: false,
    hover: false,
  }),
  methods: {
    async getCategories(language) {
      const response = await LibsService.getCategories(language);
      this.categories = response.data;

      for (var i = 0; i < this.categories.length; i++) {
        this.categories[i].i = i;
      }
    },
    selectCategory(cat) {
      this.$router.push(
        "/" + this.$route.params.language + "/" + cat.slug + "/libraries"
      );
    },
    getImageURLs() {
      for (var i = 0; i < this.categories.length; i++) {
        this.getImageURL(i);
      }
    },
    getImageURL(index) {
      // TODO: Change the field name of the JSON object when it is actually implemented

      var cat = this.categories[index];
      if (!cat.hasOwnProperty("imageURL") || cat.imageURL == null) {
        cat.imageURL = "../assets/lib_placeholder.png";
      } else {
        return cat.imageURL;
      }
    },
    getURLLabel(url) {
      return url.includes("github") ? "github" : "website";
    },
    goToCat(cat) {
      console.log("clicked");
      if (!this.clickedLink) {
        console.log("navigating to cat");
        this.selectCategory(cat);
      } else {
        this.clickedLink = false;
      }
    },
    mouseover(n) {
      if (!this.hover) {
        document.getElementsByClassName("zoom")[
          n
        ].style.zIndex = this.categories.length;
        this.hover = true;
      }
    },
    mouseleave(n) {
      document.getElementsByClassName("zoom")[n].style.zIndex = 0;
      this.hover = false;
    },
  },
  mounted() {
    this.getCategories(this.$route.params.language);
    this.getImageURLs();
  },
};
</script>

<style>
.zoom {
  position: relative;
  padding: 50px;
  background-color: transparent;
  transition: transform 0.2s; /* Animation */
  width: 375px;
  height: 450px;
  margin: 0 auto;
}

.zoom:hover {
  transform: scale(
    1.25
  ); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
}
</style>