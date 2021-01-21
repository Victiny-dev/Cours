var express = require('express')
var http = require('http')
const fs = require('fs');

var app = express();
app.set('view engine', 'pug');
app.set('views', 'views/');

var server = http.createServer(app);

var dinos = JSON.parse(fs.readFileSync('dinos.json'));

app.use('/images', express.static('static'));

app.get('/', (req, res) => {
	let specimen = req.query.specimen;
	if (dinos[specimen]) {
		var locals = dinos[specimen];
		res.render("fiche", locals);
	} else {
		res.sendStatus(404);
	}
});

	
server.listen(3000, function() {
	console.log("Serveur démarré");
});

