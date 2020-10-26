<!-- eslint-disable -->
<template>
	<v-container>
		<v-row justify="center">
			<v-col
				v-for="lib in libraries"
				:key="lib"
				cols="auto"
			>
				<div class="zoom" @mouseover="mouseover(lib.i)" @mouseleave="mouseleave(lib.i)">
					<v-card
						elevation="24"
						width=375
						height=550
						v-ripple="{ center: true }"
						@click="goToLib(lib)"
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
								About
							</div>
					
							<!-- TODO: Truncate description up to a certain point; make dividing line, github link, button position all static so even on all cards -->
							<!-- TODO: Make zoomed-in card render on top of others -->
							<!-- TODO: Click on cards to navigate to lib info instead of clicking on a nav button -->

							<div>{{ lib.description }}</div>
							
						</v-card-text>

						<v-divider class="mx-4"></v-divider>

						<v-card-text>
							<div class="my-4 subtitle-1">
								<a :href="lib.url" target="_blank" @click="clickedLink = true">{{ getURLLabel(lib.url) }}</a>
							</div>
						</v-card-text>					

						<v-row
							align="center"
							justify="center"
						>
							<v-btn @click="selectLibrary(lib)">Show more</v-btn>
						</v-row>
					</v-card>
				</div>
        	</v-col>
      	</v-row>
	</v-container>
</template>

<script>
/* eslint-disable */
	import LibsService from '@/services/LibsService'
  export default {
    name: 'LibrarySelect',
    data: () => ({
			libraries: [],
			imageURLs: [],
			selectedLibrary: null,
			clickedLink: false,
			hover: false
    }),
    methods: {
			selectLibrary(lib) {
				this.$router.push('/' + this.$route.params.language + '/' + this.$route.params.category + '/' + lib.fqn);
				//window.location.replace(window.location.origin + "/#/" + this.$route.params.language + '/' + this.$route.params.category + '/' + lib.fqn);
			},
			async getLibraries(language, category) {
				const response = await LibsService.getLibraries(language, category);
				this.libraries = response.data;

				for (var i = 0; i < this.libraries.length; i++) {
					this.libraries[i].i = i;
				}
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
					lib.imageURL = '../assets/lib_placeholder.png';
				} else {
					return lib.imageURL;
				}
			},
			getURLLabel(url) {
				return (url.includes("github") ? "github" : "website");
			},
			goToLib(lib) {
				console.log("clicked");
				if (!this.clickedLink) {
					console.log("navigating to lib");
					this.selectLibrary(lib);
				} else {
					this.clickedLink = false;
				}
			},
			mouseover(n) {
				if (!this.hover) {
					document.getElementsByClassName("zoom")[n].style.zIndex = this.libraries.length;
					this.hover = true;
				}
			},
			mouseleave(n) {
				document.getElementsByClassName("zoom")[n].style.zIndex = 0;
				this.hover = false;
			}
		},
		mounted() {
			this.getLibraries(this.$route.params.language, this.$route.params.category);
			this.getImageURLs();
		}
  	}
</script>

<style>
.zoom {
  position: relative;
  padding: 50px;
  background-color: transparent;
  transition: transform .2s; /* Animation */
  width: 375px;
  height: 550px;
  margin: 0 auto;
}

.zoom:hover {
  transform: scale(1.25); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
}
</style>