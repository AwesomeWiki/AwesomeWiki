<template>
    <v-card
      elevation="24"
      class="mx-auto my-12"
      min-width=750
      min-height=1250
    >
      <v-card-title class="justify-center"> {{ this.$route.params.library }} </v-card-title>
      <v-col>
        <v-card-text>
          <a :href="lib.url"> {{ getURLLabel(lib.url) }} </a>
          <div><b>Extended description: </b> {{ lib.metadata.info.description }}</div><br>
          <div><b>Keywords: </b>{{ lib.metadata.info.keywords }} </div><br>
          <div><b>Classifiers: </b>{{ JSON.stringify(lib.metadata.info.classifiers) }}</div><br>
          <div><b>Summary: </b>{{ lib.metadata.info.summary }}</div><br>
          <div><b>Version: </b>{{ lib.metadata.info.version }}</div><br>
          <div><b>License: </b>{{ lib.metadata.info.license }} </div><br>
          <div><b>Author: </b>{{ lib.metadata.info.author }}</div><br>
          <div><b>Author email: </b>{{ lib.metadata.info.author_email }}</div><br>
          <div><b>Download link: </b>{{ lib.metadata.info.download_url }}</div><br>
          <div><b>Home page: </b>{{ lib.metadata.info.home_page }} </div><br>
          <div><b>Package URL: </b>{{ lib.metadata.info.package_url }}</div><br>
          <div><b>Project URL: </b>{{ lib.metadata.info.project_url }}</div><br>
          <div><b>Release URL: </b>{{ lib.metadata.info.release_url}}</div><br>
        </v-card-text>
      </v-col>
      <v-col>
        <v-row>
          <v-expansion-panels focusable inset>
            <v-expansion-panel>
              <v-expansion-panel-header>Articles</v-expansion-panel-header>
              <v-expansion-panel-content
                v-for="a in articles"
                :key="a"
                cols="auto"
              >
                <a :href="a.url" target="_blank">{{ a.title }}</a>
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </v-col>
    </v-card>
</template>

<script>
  import LibsService from '@/services/LibsService'
  export default {
    name: 'Library',
    data: () => ({
      lib     : null,
      articles: null
    }),
    methods: {
      async getLibInfo(language, category, library) {
        const response1 = await (LibsService.getLibInfo(language, category, library));
        this.lib        = response1.data;
        const response2 = await (LibsService.getArticles(language, category, library));
        this.articles   = response2.data;
      },
			getURLLabel(url) {
				return (url.includes("github") ? "github" : "website");
			}
    },
    mounted() {
      this.getLibInfo(this.$route.params.language, this.$route.params.category, this.$route.params.library);
    }
  }
</script>
