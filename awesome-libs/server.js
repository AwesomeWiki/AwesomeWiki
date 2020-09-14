var http					= require('http');
var express 			= require('express');
var bodyparser		= require('body-parser');
var path          = require('path');

// Get our API routes
const api = require('./server/routes/api');

var app 			= express();

// Middleware
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: false }));

// Tell server to look for static files (html, css, etc.) in /public subdirectory
app.use(express.static(path.join( __dirname, 'dist/awesome-libs')));

// Set our api routes
app.use('/api', api);

// Catch all other routes and return the index file (must be defined after any other routes)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist/awesome-libs/index.html'));
});

// Set port
app.set('port', process.env.PORT || 3000);

// Start app
app.listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'))
})