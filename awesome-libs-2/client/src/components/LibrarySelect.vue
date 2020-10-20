<!-- eslint-disable -->
<template>
	<v-container>
		<v-row justify="center">
			<v-col
				v-for="lib in libraries"
				:key="lib"
				cols="auto"
			>
				<v-card
					elevation="24"
					class="mx-auto my-12"
      				width=375
					height=550
				>
					<!--
					<v-row class="justify-center">
						<v-img
							max-width="200"
							:src="require('../assets/lib_placeholder.png')"
						></v-img>
					</v-row>
					-->

					<v-row class="justify-center">
						<img
							src="../assets/lib_placeholder.png"
							alt="Placeholder"
						>
					</v-row>

					<v-card-title class="justify-center"> {{ lib.name }} </v-card-title>

					<v-card-text>
						<v-row
							align="center"
							class="mx-0"
						>
							<v-rating
								:value="4.5"
								color="amber"
								dense
								half-increments
								readonly
								size="14"
							></v-rating>
					
							<div class="grey--text ml-4">
								TBI: Ratings
							</div>
						</v-row>
			
						<div class="my-4 subtitle-1">
							Description
						</div>
				
						<div>Insert description</div>
					</v-card-text>

					<v-divider class="mx-4"></v-divider>

					<v-card-text>
						<div class="my-4 subtitle-1">
							<a :href="lib.url">{{getURLLabel(lib.url)}}</a>
						</div>
					</v-card-text>					

					<v-row
              			align="center"
              			justify="center"
            		>
						<v-btn @click="selectLibrary(lib)">Show more</v-btn>
					</v-row>
          		</v-card>
        	</v-col>
      	</v-row>
			<!--
			<v-layout wrap align-center>
				<v-flex xs12 sm6 d-flex>
					<v-select v-model="selectedLibrary" :items="libraries" item-text="name" label="Select a library" persistent-hint return-object single-line></v-select>
				</v-flex>
				<v-btn rounded block color="blue darken-3" dark large @click="selectCategory()">CONTINUE</v-btn>
			</v-layout>
			-->
	</v-container>
</template>

<!-- TODO: This should display all available libraries in a card layout -->

<script>
/* eslint-disable */
	import LibsService from '@/services/LibsService'
  export default {
    name: 'LibrarySelect',
    data: () => ({
			libraries: [],
			imageURLs: [],
			selectedLibrary: null
    }),
    methods: {
			selectLibrary(lib) {
				this.$router.push('/' + this.$route.params.language + '/' + this.$route.params.category + '/' + lib.fqn);
			},
			async getLibraries(language, category) {
				const response = await LibsService.getLibraries(language, category);
				this.libraries = response.data;
				console.log(this.libraries);
			},
			getImageURLs() {
				for (var i = 0; i < this.libraries.length; i++) {
					this.getImageURL(i);
				}
			},
			getImageURL(index) {
				// TODO: Change the field name of the JSON object when it is actually implemented

				var lib = this.libraries[index];
				if (!lib.hasOwnProperty("imageURL") || lib.imageURL == null) {
					lib.imageURL = '../assets/lib_placeholder.png'; //'https://github.ncsu.edu/engr-csc-sdc/2020FallTeam03/blob/master/assets/lib_placeholder.png?raw=true';
				} else {
					return lib.imageURL;
				}
			},
			getURLLabel(url) {
				return (url.includes("github") ? "github" : "website");
			}
		},
		mounted() {
			this.getLibraries(this.$route.params.language, this.$route.params.category);
			this.getImageURLs();
		}
  	}
</script>