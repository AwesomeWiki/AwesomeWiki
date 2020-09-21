const express = require('express');
const router = express.Router();

// declare axios for making http requests
const axios = require('axios');
const API = 'https://jsonplaceholder.typicode.com';

/* GET api listing. */
router.get('/', (req, res) => {
  res.send('api works');
});

// Get all categories for a given language
router.get('/categories/:prglang', (req, res) => {

  var prglang = req.params.prglang;

  console.log("Express API GET request with programming language: " + prglang);

  // Mock api call. In final app, this will get from the core application's database
  axios.get(`${API}/posts`)
    .then(placeholder => {
      res.status(200).json(placeholder.data);
    })
    .catch(error => {
      res.status(500).send(error)
  });
  // End mock api call

});

module.exports = router;