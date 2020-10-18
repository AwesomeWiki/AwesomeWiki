<template>
	<v-container>
		<div>Language selected: {{ this.$route.params.language }}</div>

		<v-layout wrap align-center>
			<v-flex xs12 sm6 d-flex>
				<v-select v-model="selectedCategory" :items="categories" item-text="name" label="Select a category" persistent-hint return-object single-line></v-select>
			</v-flex>
			<v-btn rounded block color="blue darken-3" dark large @click="selectCategory()">CONTINUE</v-btn>
		</v-layout>

	</v-container>
</template>

<!-- TODO: This should display all available categories in a card layout -->

<script>
	import LibsService from '@/services/LibsService'
  export default {
    name: 'CategorySelect',

    data: () => ({
			categories: [],
			selectedCategory: null
    }),
    methods: {
			async getCategories(language) {
				const response = await LibsService.getCategories(language);
				this.categories = response.data;
			},
			selectCategory() {
				this.$router.push('/' + this.$route.params.language + '/' + this.selectedCategory.slug + '/libraries');
			}
		},
		mounted() {
			this.getCategories(this.$route.params.language);
		}
  }
</script>