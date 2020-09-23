/* eslint-disable */
import Api from '@/services/Api'

export default {
	getLanguages() {
		return Api().get('languages');
	},
	getCategories(language) {
		return Api().get('/' + language + '/categories')
	},
	getLibraries(language, category) {
		return Api().get('/' + language + '/' + category + '/libraries')
	},
	getLibInfo(language, category, library) {
		return Api().get('/' + language + '/' + category + '/' + library);
	}
}

/* Usage */
// AuthenticationService.register({
// 	email 		: 'testing@gmail.com',
// 	password 	: '123456'
// })