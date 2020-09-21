<template>
  <v-container>

    <v-spacer></v-spacer>

    <v-row class="text-center">
      <v-col cols="12">
        <v-img
          :src="require('../assets/logo.svg')"
          class="my-3"
          contain
          height="200"
        />
      </v-col>
    </v-row>

    <v-row class="mb-2">

      <h1 class="display-2 font-weight-bold mb-3">
        I am a 
      </h1>

      <v-layout wrap align-center>
        <v-flex xs12 sm6 d-flex>
          <v-select v-model="selectedItem" :items="items" item-text="title" label="Select a language" persistent-hint return-object single-line></v-select>
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
  export default {
    name: 'LanguageSelect',

    // TODO: Add a getLanguages() function that is called in :items="getLanguages()" to return an array of languages to choose from

    data: () => ({
      items: [
        { title: 'javascript' },
        { title: 'python' }
      ],
      selectedItem: null
    }),
    methods: {
      selectLanguage() {
        this.$router.push('/languages/' + this.selectedItem.title);
      }
    }
  }
</script>
