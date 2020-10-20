const express = require('express');
const router = express.Router();

// declare axios for making http requests
const axios = require('axios');

/* GET api listing. */
router.get('/', (req, res) => {

  res.send('api works');
	
});

// Get all languages
router.get('/languages', (req,res) => {

  var test_url = 'http://localhost:8081/languages.json';
  var url      = 'http://localhost/core/languages';

  // core app api call
  axios.get(url)
    .then(languages => {
      res.status(200).json(languages.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
  // end api call

});

// Get all categories for a given language
router.get('/:language/categories', (req, res) => {

  var language = req.params.language;

  var url      = 'http://localhost/core/' + language + '/categories';
  
  // core app api call
  axios.get(url)
    .then(categories => {
      res.status(200).json(categories.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
  // end api call

});

// Get all libraries for a given category
router.get('/:language/:category/libraries', (req,res) => {

	var language = req.params.language;
  var category = req.params.category;

  var url = 'http://localhost/core/' + language + '/category/' + category;

  // core app api call
  axios.get(url)
    .then(cat => {
      res.status(200).json(cat.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
	// end api call

});

// Get details about a specific library
router.get('/:language/:category/:library', (req,res) => {

	var language = req.params.language;
	var category = req.params.category;
  var library  = req.params.library;
  
  var url = 'http://localhost/core/' + language + '/' + library;

  // core app api call
  axios.get(url)
    .then(lib => {
      res.status(200).json(lib.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
	// end api call

});

// Get articles for a language + library
router.get('/:language/:category/:library/articles', (req,res) => {

  var language  = req.params.language;
  var library   = req.params.library;

  var url = 'http://localhost/core/' + language + '/' + library + '/articles';

  // core app api call
  axios.get(url)
    .then(articles => {
      res.status(200).json(articles.data);
    })
    .catch(error => {
      res.status(500).send(error);
  });
  //end api call

});

module.exports = router;