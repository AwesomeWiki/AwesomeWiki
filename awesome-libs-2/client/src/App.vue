<template>
  <v-app>
    <v-container>

      <!-- Nav bar -->
      <v-app-bar
        app
        color="primary"
        dark
      >

        <!-- Logo -->
        <div class="d-flex align-center">
          <v-img
            alt="AwesomeLibs Logo"
            class="shrink mr-2"
            contain
            src="@/assets/awesome_logo.png"
            transition="scale-transition"
            width="125"
            height="125"
          />
        </div>

        <v-spacer></v-spacer>

        <!-- Home button -->
        <span class="group pa-2">
          <v-icon v-ripple="{ center: true }" @click="home">mdi-home</v-icon>
        </span>

      </v-app-bar>
      
      <!-- Page footer - put awesome list attribution here -->
      <v-footer
          absolute
          class="font-weight-medium"
        >
        <v-col
          class="text-center"
          cols="12"
        >
          <b>awesome-python</b> by <b>Vinta Chen</b> is licensed under <b>CC BY 4.0</b>. 
        </v-col>
      </v-footer>

      <!-- Where routed views are rendered -->
      <v-main>
        <router-view></router-view>
      </v-main>
      
    </v-container>
  </v-app>
</template>

<script>

export default {
  name: 'App',
  components: {
    
  },
  data: () => ({
    
  }),
  methods: {
    home() {
      window.location.replace(window.location.origin + "/#/");
    },
  }
};
</script>

<style>
/* .v-main {
    width: 100%;
    height: 100%;
    background: url('../src/assets/stripe-bg-highres.png') center center;
    background-repeat: repeat;
    background-size: contain;
    background-color: white;
  } */
</style>