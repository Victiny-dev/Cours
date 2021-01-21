var http = require('http');
var fs = require('fs');
var dateFormat = require('dateformat');
var table = require('table');


var connexions = []

var app = http.createServer(function(req, res) {
    
  if (req.url == '/display') {
    // Affichage des connexions
    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    if (connexions.length > 0) res.write(table.table(connexions));    
  }
  else if (req.url == '/save') {
    // Ecriture dans un fichier
    res.writeHead(418, {'Content-Type': 'text/plain'});
    fs.writeFile('horodates.json', JSON.stringify(connexions), function(err) {
      if (err) return console.log(err); else console.log('saved');
    });
  } 
  else {
    res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
    if (req.url.indexOf('svp')>-1) {
      res.write(JSON.stringify({status:0, message:'avec plaisir'}));
    } else {
      res.write(JSON.stringify({status:-1, message:'et le mot magique ?'}));
    }
    let now = dateFormat(new Date(), "dd/m/yy \à h:MM:ss");
    connexions.push([now, req.url]);
  }
  res.end();
});

app.listen(3000);
