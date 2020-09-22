var http					= require('http');
var express 			= require('express');
var bodyparser		= require('body-parser');
var path          = require('path');
var morgan				= require('morgan');
var cors					= require('cors');

// API routes
const api = require('./routes/api');

var app 			= express();

// Express middleware set up
app.use(morgan('combined'));		// Logger
app.use(cors());								// Cross origin request support
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: false }));

// TODO: Get express app to serve vue app

// Tell server to look for static files (html, css, json, etc.) in /public subdirectory
app.use(express.static(path.join(__dirname, 'public'))); // Has dummy data
//app.use(express.static(path.join(__dirname, '../../client/public')));

// Mount for api routes
app.use('/api', api);

// Catch all other routes and return the index file (must be defined after any other routes)
app.get('*', (req, res) => {
	//res.sendFile(path.join(__dirname, '../../client/public/index.html'));
});

// Set port
app.set('port', process.env.PORT || 8081);

// Start app
app.listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'))
})