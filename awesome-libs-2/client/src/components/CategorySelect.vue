<template>
	<v-container>
		<div>Language selected: {{ this.$route.params.language }}</div>

		<v-layout wrap align-center>
			<v-flex xs12 sm6 d-flex>
				<v-select v-model="selectedCategory" :items="getCategories(this.$route.params.language)" item-text="title" label="Select a category" persistent-hint return-object single-line></v-select>
			</v-flex>
			<v-btn rounded block color="blue darken-3" dark large @click="selectCategory()">CONTINUE</v-btn>
		</v-layout>

	</v-container>
</template>

<script>
  export default {
    name: 'CategorySelect',

    data: () => ({
      jsCategories: [
        { title: 'jscat1' },
        { title: 'jscat2' }
			],
			pyCategories: [
				{ title: 'pycat1'},
				{ title: 'pycat2'}
			],
			selectedCategory: null
    }),
    methods: {
			selectCategory() {
				this.$router.push('/' + this.$route.params.language + '/' + this.selectedCategory.title );
			},
			getCategories(language) {
				var categories = [];
				// Change this to an express server query -> query the categories endpoint for a given library
				if (language=='javascript') {
					categories = this.jsCategories;
				} else if (language=='python') {
					categories = this.pyCategories;
				}
				return categories;
			}
    }
  }
</script>