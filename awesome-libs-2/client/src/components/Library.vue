<!-- eslint-disable -->
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
          <div v-if="lib != null">
            <a :href="lib.url" target="_blank"> {{ getURLLabel(lib.url) }} </a><br><br>
            <!-- Display javascript library metadata -->
            <div v-if="$route.params.language == 'javascript'">
              <div><b>Author: </b>{{ lib.metadata.author.name }}</div><br>
              <div><b>Author email: </b>{{ lib.metadata.author.email }}</div><br>
              <div><b>Description: </b>{{ lib.metadata.description }}</div><br>
              <div><b>Version: </b>{{ lib.metadata['dist-tags'].latest }}</div><br>
              <div><b>License: </b>{{ lib.metadata.license }}</div><br>
              <div><b>Keywords: </b>{{ JSON.stringify(lib.metadata.keywords) }}</div><br>
              <div v-if="lib.metadata.homepage != ''"><a :href="lib.metadata.homepage" target="_blank"><b>Home Page</b></div><br>
              <div v-if="lib.metadata.bugs != ''"><a :href="lib.metadata.bugs" target="_blank"><b>Bugs</b></div><br>
            </div>
            <!-- Display python library metadata -->
            <div v-if="$route.params.language == 'python'">
              <div><b>Author: </b>{{ lib.metadata.info.author }}</div><br>
              <div><b>Author email: </b>{{ lib.metadata.info.author_email }}</div><br>
              <div><b>Summary: </b>{{ lib.metadata.info.summary }}</div><br>
              <div><b>Version: </b>{{ lib.metadata.info.version }}</div><br>
              <div><b>License: </b>{{ lib.metadata.info.license }} </div><br>
              <div><b>Extended description: </b> {{ lib.metadata.info.description }}</div><br>
              <div><b>Keywords: </b>{{ lib.metadata.info.keywords }} </div><br>
              <div><b>Classifiers: </b>{{ JSON.stringify(lib.metadata.info.classifiers) }}</div><br>
              <div v-if="lib.metadata.info.download_url != ''"><a :href="lib.metadata.info.download_url" target="_blank"><b>Download link</b></a></div><br>
              <div v-if="lib.metadata.info.home_page != ''"><a :href="lib.metadata.info.home_page" target="_blank"><b>Home page</b></a></div><br>
              <div v-if="lib.metadata.info.package_url != ''"><a :href="lib.metadata.info.package_url" target="_blank"><b>Package URL</b></a></div><br>
              <div v-if="lib.metadata.info.project_url != ''"><a :href="lib.metadata.info.project_url" target="_blank"><b>Project URL</b></a></div><br>
              <div v-if="lib.metadata.info.release_url != ''"><a :href="lib.metadata.info.release_url" target="_blank"><b>Release URL</b></a></div><br>
            </div>
          </div>
        </v-card-text>
      </v-col>
      <v-col>
        <v-row v-if="articles != null && articles.length > 0">
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
        <v-row v-else justify="center" align="center">
          No articles found! :(
        </v-row>
      </v-col>
    </v-card>
</template>

<script>
/* eslint-disable */
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
