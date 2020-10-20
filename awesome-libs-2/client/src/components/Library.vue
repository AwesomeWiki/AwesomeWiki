<template>
	<v-container>
		<div>Language selected: {{this.$route.params.language}}<br> 
         Category selected: {{ this.$route.params.category}}<br>
         Library selected: {{ this.$route.params.library }}<br>
         {{ this.info.url }}
         <v-col
            v-for="a in articles"
            :key="a"
            cols="auto"
          >
          <div>{{ a.title }}</div>
          <div>{{ a.url }}</div>
          </v-col>
    </div>
	</v-container>
</template>

<script>
  import LibsService from '@/services/LibsService'
  export default {
    name: 'Library',
    data: () => ({
      info    : null,
      articles: null
    }),
    methods: {
      async getLibInfo(language, category, library) {
        const response1 = await (LibsService.getLibInfo(language, category, library));
        this.info       = response1.data;
        const response2 = await (LibsService.getArticles(language, category, library));
        this.articles   = response2.data;
        console.log(this.info);
        console.log(this.articles);
      }
    },
    mounted() {
      this.getLibInfo(this.$route.params.language, this.$route.params.category, this.$route.params.library);
    }
  }
</script>