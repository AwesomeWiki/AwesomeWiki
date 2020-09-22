/* eslint-disable */
import Api from '@/services/Api'

export default {
	getLanguages() {
		return Api().get('languages');
	}
}

/* Usage */
// AuthenticationService.register({
// 	email 		: 'testing@gmail.com',
// 	password 	: '123456'
// })