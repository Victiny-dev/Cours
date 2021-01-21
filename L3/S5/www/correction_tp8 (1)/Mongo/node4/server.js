var express = require('express')
var app = express();
var http = require('http').createServer(app);

var MongoClient = require('mongodb').MongoClient;

const url_db = 'mongodb://mongodb:27017';

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/books.html');
});

app.get('/books', (req, res) => {

  // Connect to the db
  MongoClient.connect(url_db, function(err, db) {
    var q = req.query.queryTitle;
	console.log("Querying for "+q);
    if(err) throw err;
    var dbo = db.db("test");
	try {
		dbo.collection("books").find({ "title" : { $regex : new RegExp(q, "i") }}).toArray(function(err, result) {
		  if (err) throw err;
		  console.log("Found "+result.length+" matches");
		  res.send(result);
		  db.close();
		});
	} catch (e) {
		console.log("Caractère spécial non pris en charge");
		res.send([]);
	}
  });

});

http.listen(3000, () => {
	console.log('listening on *:3000');
});

