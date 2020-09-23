<template>
	<v-container>
		<div>Language selected: {{this.$route.params.language}}<br> 
         Category selected: {{ this.$route.params.category}}<br>
         Library selected: {{ this.$route.params.library }}<br>
         {{ this.info.description }}</div>
	</v-container>
</template>

<script>
  import LibsService from '@/services/LibsService'
  export default {
    name: 'Library',
    data: () => ({
      info: {
        description: null
      },
    }),
    methods: {
      async getLibInfo(language, category, library) {
        const response = await (LibsService.getLibInfo(language, category, library));
        this.info.description = response.data.desc;
      }
    },
    mounted() {
      this.getLibInfo(this.$route.params.language, this.$route.params.category, this.$route.params.library);
    }
  }
</script>