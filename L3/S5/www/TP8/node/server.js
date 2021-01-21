const express = require('express')
const app = express();
const http = require('http').createServer(app);
const MongoClient = require('mongodb').MongoClient;

const url_db = 'mongodb://mongodb:27017';

app.set('views engine','pug');
app.set('views','views/');

app.get('/', (req, res) => {
    MongoClient.connect(url_db, function(err, db) {
        var dbo = db.db("test");
        dbo.collection("users").find({}).toArray(function(err, result) {
            if (err) throw err;
            res.render('index',{username:"sucepute"});
            db.close();
        });
    });
});

http.listen(3000, () => {
    console.log('listening on *:3000');
});