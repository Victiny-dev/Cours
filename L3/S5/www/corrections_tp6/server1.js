var http = require('http');

var app = http.createServer(function(req, res) {
    
    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    res.write('Ce serveur ne sait rien dire d\'autre que cela.');
    res.end();
});  

var app = http.createServer(function(req, res) {
    
    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
    res.write('<h1>Bravo</h1>');
    res.write('<p>Ce serveur sait désormais retourner une réponse en HTML</p>');
    res.end();
});  


var retour = {
  retCode: 0,
  retClass: 'success',
  message: 'Ce serveur sait aussi envoyer des données JSON !'    
}

var app = http.createServer(function(req, res) {
    
    res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
    res.write(JSON.stringify(retour));
    res.end();
});  

app.listen(3000);






