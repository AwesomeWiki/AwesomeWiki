import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import router from './router'

Vue.config.productionTip = false

new Vue({
  vuetify,
  router, // By injecting the router, we can access the router from any component with this.$router and the current route with this.$route
  render: h => h(App)
}).$mount('#app')
