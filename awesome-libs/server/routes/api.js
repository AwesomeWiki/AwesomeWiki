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
router.get('/categories', (req, res) => {

  // Get posts from the mock api
  // This should ideally be replaced with a service that connects to MongoDB
  axios.get(`${API}/posts`)
    .then(placeholder => {
      res.status(200).json(placeholder.data);
    })
    .catch(error => {
      res.status(500).send(error)
    });
});

module.exports = router;