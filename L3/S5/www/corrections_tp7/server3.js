var express = require('express')
var http = require('http')
const fs = require('fs');

var app = express();
app.set('view engine', 'pug');
app.set('views', 'views/');

var server = http.createServer(app);

app.get('/userin', (req, res) => {
	var locals = {
		username: req.query.username,
		firstTime: false
	};
	res.render("index", locals);
});

	
server.listen(3000, function() {
	console.log("Serveur démarré");
});

