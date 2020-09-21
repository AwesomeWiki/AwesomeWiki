<template>
	<v-container>
		<div>Language selected: {{this.$route.params.language}}<br> 
         Category selected: {{ this.$route.params.category}}<br>
         Library selected: {{ this.$route.params.library }}</div>
	</v-container>
</template>

<script>
  export default {
    name: 'Library',

    data: () => ({
      
    }),
    methods: {

    }

  }
</script>