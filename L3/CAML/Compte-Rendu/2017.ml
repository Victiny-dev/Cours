let secEnHeures = fun (a) -> 
let heures = a / 3600 in
  let minutes = (a-heures*3600)/60 in 
    let secondes = a mod 60 in
      heuresminutes,secondes ;; 

let bissextile = fun (annee) ->
annee mod 4 = 0 & not (annee mod 100 = 0 ) or annee mod 400 = 0 ;;

let rec nextBi = fun (annee) -> 
if bissextile(annee) then annee else nextBi(annee+1) ;;

let nbJoursParMois = fun
4 -> 30 
| 6 -> 30 
| 9 -> 30 
| 10 -> 30
|2 -> 28 
|1 -> 31 
| 3 -> 31 
| 5 -> 31 
| 7 -> 31 
| 8 -> 31 
| 11 -> 31
|12 -> 31
|_ -> failwith("Mois incorrecte") ;;

let dateValide = fun (d,m) ->
m<=12 & d<=nbJoursParMois(m) ;;

let datePasse = fun (d,m) ->
(m=10 & d<=12) or m<10;;

let age = fun (d,m,y) -> 
let annee = 2020 -y in 
annee - if datePasse(d,m) then 0 else 1 ;; 

let rec nbJaux = fun (d,m) ->
if m = 1 then 31 else nbJoursParMois(m) + nbJaux(d,m-1) ;;

let nbJours = fun (d,m) ->
if dateValide(d,m) then d + nbJaux(d,m-1) else failwith("Faut mettre un mois correcte bg");;

let rec dateAux = fun (d,m) -> 
if d > nbJoursParMois(m) then dateAux(d - nbJoursParMois(m) , m+1) else d,m ;;

let date = fun (d) ->
if d>0 then  dateAux(d,1) else failwith("Nope") ;;



