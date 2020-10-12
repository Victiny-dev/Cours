(*CODE 
TYPE
EXEMPLE POUR FONCTIONS (JEUX,COMPORTEMENT)*)


let troncature = fun x-> int_of_float(x) ;; (* float -> int*)
troncature (43.6) ;; (* => int : 43 *) 

let decimale = fun x-> abs_float(x) -. abs_float(float_of_int(int_of_float(x))) ;; (*float -> float*)
decimale (77.7) ;; (* => float : 0.7*)
decimale (-77.7) ;; (* => float : 0.7*)

let partieEntière = fun x-> if x-.(float_of_int(int_of_float(x)))>=0.0 then int_of_float(x) else int_of_float(x) -1 ;; (*float -> int *)
partieEntière(77.7) ;; (* => int : 77 *)
partieEntière(-77.7) ;; (* => int : -78*)
partieEntière(-77.0) ;; (* => int : -77*)

let plus_proche_entier = fun x-> partieEntière(x+.0.5) ;; (*float -> int *)
plus_proche_entier(77.7) ;; (* => int : 78*)
plus_proche_entier(-77.7) ;; (* => int : -78 *)

let arrondi = fun x-> float_of_int(plus_proche_entier(x*.100.0))/.100.0 ;; (*float -> float*)
arrondi(77.777);; (* => float : 77.77*)
arrondi(-77.777) ;; (* => float : -77.78 *)

let franc_en_euros = fun x-> x*.6.55957 ;; (*float -> float*)
franc_en_euros(1.0);; (* => float : 6.55957*)
franc_en_euros(7.77);; (* => float : 50.9678589*)

let heures = fun x-> int_of_float(x);;(* float -> int*)
heures (12.3) ;; (* => int : 12 *) 

let minutes = fun x-> plus_proche_entier(decimale(x)*.100.0) ;; (*float -> int*)
minutes (12.43) ;; (* => int : 43*)
minutes (13.15) ;; (* => int : 15*)

let quelle_heure_est_il = fun x->
      let h = heures(x) in 
      let m = minutes(x) in
      let hs = if h=12 then "Midi " else 
           if h=24 then "Minuit " else string_of_int(h) in 
      let ms = if m=0 then "pile." else string_of_int(m) in 
      "Il est "^hs ^ms ;; (* float-> string*)
      
quelle_heure_est_il(12.42);; (* => string="Il est Midi 42" *)

let heures2 = fun (*int => string*)
12 -> "Midi "
|24 -> "Minuit "
|x-> string_of_int(x) ;;

heures2(12) (* => string ="Midi"*)

let minutes2 = fun (* int => string *)
 0 -> "pile"
 |15->"et quart"
 |30->"et demi"
 |x->string_of_int(x)^" ";;
 
let quelle_heure_est_il2 = fun x->
    "Il est : "^heures2(heures(x))^minutes2(minutes(x)) ;;
  
let reel = fun (a,b,x) -> let max = 
      float_of_int (if a>b then a else b)in max+.decimale (x) ;; (* int * int * float -> float*)
      
reel(4, 5, -4.123) ;; (* => float = 5.123*)

let chiffre = fun x -> int_of_float(decimale(float_of_int(x)/.10.0)*.10.0) ;; (* int -> int *)
chiffre ( -123456 ) ;;  (* => int = 6 *)  
chiffre ( -123456 ) ;;  (* => int = 6 *)    

let echange = fun (n,p) -> let E = n-chiffre(n) in 
               if n>0 then E+chiffre(p) else E-chiffre(p);;   
               
let memevaleur = fun (a,b,c) -> a = b & a=c ;; (* 'a * 'a * 'a -> bool*)
memevaleur(1,1,1);;(* bool = true*)
memevaleur(0,1,1);;(* bool = false*)

let eg1diff = fun (a,b,c) -> (a=b) & (b<>c) ;; (* 'a * 'a * 'a -> bool*)
eg1diff(1,1,0) ;; (* bool = true *)
eg1diff(2,2,2) ;; (* bool = false *)
eg1diff(1,2,3) ;; (* bool = false *)


let compar = fun (a,b,c) -> (a<b) & (b<c) ;;  (* 'a * 'a * 'a -> bool*)

let eg = fun (a,b,c) -> a=b or b=c or c=a ;; (* 'a * 'a * 'a -> bool*)
let uniq2eg = fun (a,b,c) -> if a=b then not(a=c or b=c) else if a=c then not(b=c) else b=c ;; (* 'a * 'a * 'a -> bool*)

let uniq2dif = fun (a,b,c) -> not memevaleur(a,b,c) ;; (* 'a * 'a * 'a -> bool*)
    
let nbsol = fun (a,b,c) -> let delta = b*b -4*a*c in 
                            if delta > 0 then 2 else
                            if delta = 0 then 1 else 0 ;; (*nbsol : int * int * int -> int *)
nbsol(1,4,1) ;;
(*: int = 2 *)
nbsol(1,2,1) ;;
(*: int = 1 *)
nbsol(1,1,1) ;;
(*- : int = 0 *)

let entier = fun (* int -> string*)
0 -> "zero"
|x -> if x mod 2 = 0 then "pair" else "impair" ;;

f(1);; (* string = "impair" *)
f(2);; (* string = "pair" *)
f(0);; (* string = "zero" *)

let point = fun (*) point : float * float -> string = <fun> *)
(0.,0.) -> "Origine"
|(0.,y) -> "Axe des ordonnées"
|(x,0.) -> "Axe des abscisses"
|(x,_) -> "Point du demi plan x "^(if x > 0.0 then ">" else "<")^"0" ;;

point(0.0,0.0);;(*string = "Origine" *)
point(4.0,0.0);; (*string = "Axe des abscisses"*)
point(4.0,1.0);; (*string = "Point du demi plan x > 0" *)
point(-4.0,1.0);; (*string = "Point du demi plan x < 0" *)

let operation = fun  (*)operation : int * int * char -> int = <fun> *)
(x,y,`+`) -> x+y 
|(x,y,`-`) -> x-y
|(x,y,`/`) -> if y=0 then "Non mais OH, pas de division par 0 voyons !!" else x/y
|(x,y,`*`) -> x*y ;;

#operation (1,2,`+`) ;; (*int = 3*)
#operation (1,2,`-`) ;; (*int = -1*)
#operation (1,2,`/`) ;; (*int = 0*)
#operation (1,2,`*`) ;; (*int = 2*)

let prixTTC = fun (x,y) -> x +.  x *. y *. 0.01 ;; 

let prix = fun
"pain" -> (1.05, 5.5)
|"conserve" -> (3.50,7.)
|"disque" -> (12.30,18.6)
|"bijou" -> (356., 33.)
| _ -> failwith("Article indisponible") ;;

prix("Allo?");;(*Exception non rattrapée: Failure "Article indisponible"*)

let sommeAPayer = fun ()

let formule = fun (j,m,p,s) -> j+(48*m-1)/5 + p/4 + p +s/4 - 2*s ;; (*formule : int * int * int * int -> int = <fun>*)
formule(1,2,3,4) ;;(*int = 16*)

let decoupe = fun (a) -> a/100, a mod 100 ;; (*#decoupe : int -> int * int = <fun>*)
decoupe(2014);; (* int * int = 20, 14 *)

let deuxMoisAvant = fun (*deuxMoisAvant : int * int -> int * int = <fun>*)
(1,y) -> (10,y-1)
|(2,y) -> (11,y-1)
|(x,y) -> (x-2,y) ;;

deuxMoisAvant(2,2014) ;;(* int * int = 11, 2013*)

let leJour = fun (*leJour : int -> string = <fun>*)
1 -> "Lundi"
|2 -> "Mardi"
|3 -> "Mercredi"
|4 -> "Jeudi"
|5 -> "Vendredi"
|6 -> "Samedi"
|7 -> "Dimanche" ;;
leJour(1) ;; (*string = "Lundi"*)

let modulo7 = fun (x) -> if x < 0 then (x mod 7) +7 else x mod 7 ;; (*#modulo7 : int -> int = <fun>*)
modulo7(12);;(*: int = 5*)
modulo7(-12);;(* int = 2 *)

let quelJour = fun (a,b,x) -> let (M,A) = deuxMoisAvant(b,x) in (*quelJour : int * int * int -> string = <fun>*)
let (S,P) = decoupe(A) in
let K = formule(a,M,P,S) in
leJour(modulo7(K)) ;;
quelJour(28,6,2000) ;; (*string = "Mercredi" *)



let rec puissance = fun  (*puissance : int * int -> int = <fun>*)
(x,1) -> x
|(_,0) -> 1
|(x,n)->x*puissance(x,n-1);;
puissance(5,5);;(* int = 3125 *)
puissance(5,2);;(* int = 25 *)

let rec repet = fun (*repet : int * int -> int = <fun>*)
(c,1) -> c
|(c,n) -> c + 10*(repet(c,n-1));;
repet(5,5);;(* int = 55555 *)

let rec unChiffre = fun
(0,c) -> true
|(n,c) -> if n mod 10 = c then unChiffre(n/10, c) else false ;;

unChiffre(555555555555558,5) ;; (*bool = false*)
unChiffre(5555555,5) ;;(*bool = true*)