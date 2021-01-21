const express = require('express')
const http = require('http')
const fs = require('fs')

var app = express();

var server = http.createServer(app);

app.use('/ressources', express.static('static'));

app.get('/', (req, res) => {
	res.sendFile('./rps7.html', { root : __dirname});
});

let rules = JSON.parse(fs.readFileSync('rules.json'));

app.get('/fight', (req, res) => {
	
	let player = req.query.player;
	let cpu = req.query.cpu;
	if (player == cpu) {
		res.json({outcome:0});
	} else if (rules[player][cpu]) {
		res.json({outcome:1, message:rules[player][cpu]});
	} else {
		res.json({outcome:-1, message:rules[cpu][player]});		
	}
});
	
server.listen(3000, function() {
	console.log("Game on!");
});

