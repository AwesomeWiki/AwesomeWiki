var http					= require('http');
var express 			= require('express');
var bodyparser		= require('body-parser');
var path          = require('path');

var app 			= express();

app.set('port', process.env.PORT || 3000);
app.use(express.static(path.join( __dirname, 'dist/awesome-libs'))); // Tell server to look for static files (html, css, etc.) in /public subdirectory
app.use(bodyparser.json());

/*
var server = http.createServer(app)
server.listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'))
})
*/

/* Unless you need to work directly with the http module (socket.io/SPDY/HTTPS), loading it is not required, and the app can be simply started this way: */
app.listen(app.get('port'), function () {
  console.log('Express server listening on port ' + app.get('port'))
})