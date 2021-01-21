var http = require('http');
var tableBuilder = require('table-builder');
var request = require('request');

var app = http.createServer(function(req, res) {

  let cp = req.url.substring(1);
  console.log(cp);

    request(`https://geo.api.gouv.fr/communes?codePostal=${cp}&fields=nom,population&format=json`, function(error, response, body) {

    console.log(body); 

    var table = new tableBuilder({'border': '1'})
    .setHeaders({'nom':'Commune', 'population':'Population'})
    .setData(JSON.parse(body))
    .render();
    
    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
    res.write(table);
    res.end();
  });
});

app.listen(3000);
