const express = require('express')
const app = express();
const http = require('http').createServer(app);
const MongoClient = require('mongodb').MongoClient;
const url_db = 'mongodb://mongodb:27017';

app.set('view engine', 'pug');
app.set('views', 'views/');


app.get('/', (req, res) => {
  MongoClient.connect(url_db, function(err, db) {
	var dbo = db.db("test");
	dbo.collection("users").find({}).toArray(function(err, result) {
	  if (err) throw err;
	  console.log(result);
	  res.render("userpage", {users:result});
	  db.close();
	});
  });
});

app.get('/addUser', function(req, res) {
  MongoClient.connect(url_db, function(err, db) {
	var dbo = db.db("test");
	var obj = { username: req.query.username, admin: req.query.admin=="on"};
	dbo.collection("users").insertOne(obj, function(err, result) {
		if (err) throw err;
		res.json({status:0, message:'insert successful'});
		db.close();
	});
  });
});

http.listen(3000, () => {
  console.log('listening on *:3000');
});

