const express = require('express')
const http = require('http')

var app = express();

var server = http.createServer(app);

app.use('/', express.static('website'));

server.listen(3000, function() {
	console.log("Serveur démarré");
});

