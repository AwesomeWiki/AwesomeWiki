<template>
	<v-container>
		<div>Language selected: {{this.$route.params.language}} <br> Category selected: {{ this.$route.params.category}}</div>
			<v-layout wrap align-center>
				<v-flex xs12 sm6 d-flex>
					<v-select v-model="selectedLibrary" :items="getLibraries(this.$route.params.language, this.$route.params.category)" item-text="title" label="Select a library" persistent-hint return-object single-line></v-select>
				</v-flex>
				<v-btn rounded block color="blue darken-3" dark large @click="selectCategory()">CONTINUE</v-btn>
			</v-layout>
		</v-container>
</template>

<script>

  export default {
    name: 'LibrarySelect',

    data: () => ({
      jsCategory1Libs: [
        { title: 'jslib1' },
        { title: 'jslib2' }
			],
			jsCategory2Libs: [
        { title: 'jslib3' },
        { title: 'jslib4' }
			],
			pyCategory1Libs: [
        { title: 'pylib1' },
        { title: 'pylib2' }
			],
			pyCategory2Libs: [
        { title: 'pylib3' },
        { title: 'pylib4' }
			],
			selectedLibrary: null
    }),
    methods: {
			selectCategory() {
				this.$router.push('/' + this.$route.params.language + '/' + this.$route.params.category + '/libraries/' + this.selectedLibrary.title);
			},
			getLibraries(language, category) {
				// TODO: replace dummy data with express server api call
				var libraries = [];
				if (language=='javascript')
					if (category=='jscat1')
						libraries=this.jsCategory1Libs;
					else
						libraries=this.jsCategory2Libs;
				else
					if (category=='pycat1')
						libraries=this.pyCategory1Libs
					else
						libraries=this.pyCategory2Libs
				return libraries;
			}
    }

  }
</script>