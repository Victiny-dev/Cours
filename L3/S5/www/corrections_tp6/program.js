fs = require('fs');
figlet = require('figlet');
table = require('table');

continents = [
  {nom: 'Afrique', population: 1340 },
  {nom: 'Amérique', population: 800 },
  {nom: 'Asie', population: 4641 },
  {nom: 'Europe', population: 747 },
  {nom: 'Océanie', population: 42 }
]

let pop = 0;
continents.forEach(function(c) {
  console.log(c.nom);
  pop += c.population;
});
console.log(`population mondiale : ${pop} Mhabs`);

/* ------------------------------------ */

rawData = fs.readFileSync('data.js');
var data = JSON.parse(rawData);

figlet('Démographie', function(err, result) {
  if (err) {
    console.log(err);  
  } else {
    console.log(result);
    console.log(table.table(data));
  }
});

