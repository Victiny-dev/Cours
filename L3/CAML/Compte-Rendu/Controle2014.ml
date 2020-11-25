(*Contrôle continu n°3 : Les Listes*)

(*long : calcule le nombre de cartes d'un jeu de cartes.*)
let rec long = fun 
(_::l) -> 1+long(l)
|a->0 ;;
long([1;2;3;4]);; (* int = 4*)

(*nbCoul : à un jeu de cartes et une couleur associe le nombre
de cartes de cette couleur dans le jeu. *)
let rec nbCoul = fun 
(a::l,coul) -> let cartcoul,val=a in if cartcoul=coul then 1 + nbCoul(l,coul) else nbCoul(l,coul)
|(a,_)-> 0 ;; 
nbCoul(main,"pique") ;;(*int = 3*)

(*inverse : retourne qui inverse l'ordre des cartes d'un jeu*)
let inverse = fun (l) -> rev(l) ;;

let rec retourne = fun 
(a::l) -> retourne(l)@[a] 
|[] -> [] ;;

(*distribue : à partir d'un jeu de
carte construit un quadruplet de jeux de cartes obtenu en
distribuant une à une les cartes du jeu initial.*)
let rec distribue = fun
(a::b::c::d::l) -> let (l1,l2,l3,l4) = distribue(l) in a::l1,b::l2,c::l3,d::l4
|([]) -> [],[],[],[] ;;

(*range : filtre qui étant donnés une carte et un
quadruplet de jeux de cartes (les piques, les cœurs, les carreaux et les trèfles dans cet
ordre), range la carte dans le bon paquet.*)
let range = fun 
(("pique",x),l1,l2,l3,l4) ->x::l1,l2,l3,l4
|(("coeur",x),l1,l2,l3,l4) ->l1,x::l2,l3,l4 
|(("carreau",x),l1,l2,l3,l4) -> l1,l2,x::l3,l4
|(("trefle",x),l1,l2,l3,l4) -> l1,l2,l3,x::l4 ;;

(*triCoul : partir d'un jeu, construit les quatre listes des valeurs
des piques, cœurs, carreaux, trèfles.*)
let rec triCoul = fun 
(a::l) -> let (l1,l2,l3,l4) = triCoul(l) in range(a,l1,l2,l3,l4) 
|([]) -> [],[],[],[] ;;

(* insère : insère un entier à sa place dans une liste triée*)
let rec insert = fun 
(x,a::l) -> if x<=a then x::a::l else a::insert(x,l)
|(x,[]) -> [x] ;;

let rec tri = fun 
[a] -> [a]
|(a::l) -> insert(a,tri(l)) ;;

let triCartes = fun (l)->
let (l1,l2,l3,l4) = triCoul(l) 
  in tri(l1),tri(l2),tri(l3),tri(l4) ;;
triCartes(main) ;;(*int list * int list * int list * int list =
                    [7; 10; 11], [7; 11], [10], [8; 11]*)

(* passe : étant donnés un entier p et deux jeux l1 et l2, fait
passer les p premières cartes de l1 en tête de l2*)                
let rec passe = fun 
(0,l1,l2) ->l1,l2 
|(p,x::l1,l2) -> passe(p-1,l1,x::l2) ;;
passe(2,[1;2;3;4],[5;6;7;8]) ;;(*int list * int list = [3; 4], [2; 1; 5; 6; 7; 8] *)

(*coupe : permetde couper un jeu de carte en deux. (On devra
sûrement utiliser les fonctions passe et long)*)
let coupe = fun (l) -> passe(long(l)/2,l,[]) ;;
coupe(main) ;;
(*(string * int) list * (string * int) list =
 ["coeur", 7; "carreau", 10; "pique", 10; "pique", 11],
 ["trefle", 11; "coeur", 11; "pique", 7; "trefle", 8]*)

let rec riffle = fun 
(a::l1,b::l2) -> a::b::riffle(l1,l2)
|(l1,l2) -> l1@l2 ;;


let rec shuffle = fun
(1,l) -> riffle(coupe(l)) ;;
|(n,l) -> shuffle(n-1,riffle(coupe(l)));;

