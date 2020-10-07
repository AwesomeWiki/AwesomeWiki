import axios from 'axios'

export default () => {
	return axios.create({
		//baseURL : `http://localhost:8081/api/`
		baseURL : window.location.origin + '/api/'
	});
}