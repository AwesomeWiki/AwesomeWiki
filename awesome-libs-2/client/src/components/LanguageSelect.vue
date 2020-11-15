<template>
  <v-container>
    <v-spacer></v-spacer>
    <br><br>
    <v-row v-if="languages != null" class="mb-2">
      <h1 class="display-2 font-weight-bold mb-3">
        I am a 
      </h1>

      <v-layout wrap justify-center>
        <v-flex xs12 sm6 d-flex>
          <v-select v-model="selectedItem" :items="languages" item-text="name" label="Select a language" height=70 line-height=58 outlined persistent-hint return-object single-line></v-select>
          <!-- class="display-2 font-weight-bold mb-3" -->
        </v-flex>
        <v-btn rounded block color="blue darken-3" dark large @click="selectLanguage()">CONTINUE</v-btn>
      </v-layout>

      <h1 class="display-2 font-weight-bold mb-3">
        programmer
      </h1>
    </v-row>

  </v-container>
</template>

<script>
  import LibsService from '@/services/LibsService'
  //import axios from 'axios'

  export default {
    name: 'LanguageSelect',
    data: () => ({
      languages: [],
      selectedItem: null
    }),
    methods: {
      async getLanguages() {
        const response = await LibsService.getLanguages();
        this.languages = response.data;
      },
      selectLanguage() {
        this.$router.push('/' + this.selectedItem.slug + '/categories');
      }
    },
    mounted() {
      this.getLanguages();
    }
  }
</script>

<style>
.v-select__selection--comma {
    overflow: visible;
}
</style>