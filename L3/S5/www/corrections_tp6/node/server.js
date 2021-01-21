// le module http est n´ecessaire et devra ˆetre install´e
var http = require("http");

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
// le serveur écoute  sur le port 3000
app.listen(3000);