<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
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

      <!--
      <v-btn
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
        text
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>mdi-open-in-new</v-icon>
        -->

      <span class="group pa-2">
        <v-icon v-ripple="{ center: true }" @click="home">mdi-home</v-icon>
      </span>
    </v-app-bar>

    <!-- Where routed views are rendered -->
    <v-main>
      <router-view></router-view>
    </v-main>
    
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
.v-main {
    width: 100%;
    height: 100%;
    background: url('../src/assets/stripe-bg-highres.png') center center;
    background-repeat: repeat;
    background-size: contain;
    background-color: white;
  }
</style>