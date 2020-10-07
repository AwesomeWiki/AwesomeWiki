const express = require('express');
const router = express.Router();

// declare axios for making http requests
const axios = require('axios');

/* GET api listing. */
router.get('/', (req, res) => {

  res.send('/ endpoint hit');
	
});

// Get all languages
router.get('/languages', (req,res) => {

  var test_url = 'http://localhost:8081/languages.json';
  var url      = 'http://localhost/core/languages';

  axios.get(test_url)
    .then(languages => {
      res.status(200).json(languages.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });

});

// Get all categories for a given language
router.get('/:language/categories', (req, res) => {

  var language = req.params.language;

  var test_url = 'http://localhost:8081/' + language + '.json';
  var url      = 'http://localhost/core/' + language + '/categories';
  
  axios.get(url)
    .then(categories => {
      res.status(200).json(categories.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });

});

// Get all libraries for a given category
router.get('/:language/:category/libraries', (req,res) => {

	var language = req.params.language;
	var category = req.params.category;

  // Mock api call
  axios.get('http://localhost:8081/' + category + '.json')
    .then(cat => {
      res.status(200).json(cat.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
	// End mock api call

});

// Get details about a specific library
router.get('/:language/:category/:library', (req,res) => {

	var language = req.params.language;
	var category = req.params.category;
	var library  = req.params.library;

  // Mock api call
  axios.get('http://localhost:8081/' + library + '.json')
    .then(lib => {
      res.status(200).json(lib.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
	// End mock api call

});

module.exports = router;