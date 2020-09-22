<template>
	<v-container>
		<div>Language selected: {{this.$route.params.language}} <br> Category selected: {{ this.$route.params.category}}</div>
			<v-layout wrap align-center>
				<v-flex xs12 sm6 d-flex>
					<v-select v-model="selectedLibrary" :items="libraries" item-text="title" label="Select a library" persistent-hint return-object single-line></v-select>
				</v-flex>
				<v-btn rounded block color="blue darken-3" dark large @click="selectCategory()">CONTINUE</v-btn>
			</v-layout>
		</v-container>
</template>

<!-- TODO: This should display all available libraries in a card layout -->

<script>
	import LibsService from '@/services/LibsService'
  export default {
    name: 'LibrarySelect',
    data: () => ({
			libraries: [],
			selectedLibrary: null
    }),
    methods: {
			selectCategory() {
				this.$router.push('/' + this.$route.params.language + '/' + this.$route.params.category + '/' + this.selectedLibrary.title);
			},
			async getLibraries(language, category) {
				const response = await LibsService.getLibraries(language, category);
				this.libraries = response.data;
			}
		},
		mounted() {
			this.getLibraries(this.$route.params.language, this.$route.params.category)
		}
  }
</script>