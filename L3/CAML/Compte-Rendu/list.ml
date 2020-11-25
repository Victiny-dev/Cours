(*Exceptions*)
exception tropCourte;;
exception listeVide ;;

(*-----------------------*)

let deux = fun l -> hd(tl(l));;
(*Exception non rattrapée quand la liste est trop courte.*)

(*-----------------------*)
(*Exception rattrapée quand la liste est trop courte.*)
let deux = fun
(_::b::_) -> b
| _ -> raise tropCourte;;

(*-----------------------*)
(*Liste à 3 éléments*)
let auMoinsTrois = fun
(_::_::_::_) -> true
| _ -> false ;;

(*-----------------------*)
let somme23 = fun
(_::b::c::_) -> b+c
| _ -> 0 ;;

(*-----------------------*)
let somme123 = fun
(a::b::c::_) -> a+b+c
| _ -> 0 ;;

(*-----------------------*)
let troisEstPair = fun
(a::b::c::_) -> c mod 2 = 0
| _ -> false ;;

(*-----------------------*)
let rec compteARebours = fun
0 -> [0];;
|n-> n::f(n-1)

(*-----------------------*)
let rec tailleListe = fun
(_::l) -> 1 + tailleListe(l) 
|[] -> 0 ;;

(*-----------------------*)
let rec longPair = fun
(_::_::l) -> longPair(l)
|[] -> true 
| _ -> false ;;

(*-----------------------*)
let rec rangImpair = fun
(a::_::l) -> a::rangImpair(l)
| l -> l ;;

(*-----------------------*)
let rec valeurImpaire = fun 
(a::l) -> if a mod 2 = 0 then valeurImpaire(l)
          else a::valeurImpaire(l)
|l -> l ;;

(*-----------------------*)
let rec dernier = fun
(_::l) -> dernier(l)
|[a] -> a 
|_ raise -> tropCourte ;;

(*-----------------------*)
let rec somme = fun
(a::l) -> a + somme(l)
|[] -> 0 ;;

(*-----------------------*)
let rec appartient = fun
(n, (i::l)) -> n = i or appartient(n,l)
|(n, []) -> false ;;

(*-----------------------*)
let max = fun(a,b) -> if a > b then a else b ;;
let rec maximum = fun 
[a] -> a 
|(a::l) -> max(a, maximum(l))
|_ -> raise listeVide ;;


(* Cours du 03 11 2020 *)

(* deuxieme : 'a list -> 'a qui extrait le deuxième élément [b] d’une liste *)
let deuxieme = fun(_::b::_) -> b ;;
deuxieme([1;2;3]);; (* int = 2 *) 

(* auMoinsTrois : 'a list -> bool testant si une liste a au moins trois éléments.*)
let auMoinsTrois = fun 
(_::_::_::_) -> true
|_ -> false ;;
auMoinsTrois([1;2;3]) ;;(*bool = true*)
auMoinsTrois([1;2]) ;;(*bool = false*)

exception Maisçavapas
(* sommeTrois :int list -> int qui fait la somme des trois premiers éléments d’une liste d’entiers *)
let sommeTrois = fun 
(a::b::c::_) -> a+b+c 
|_ -> raise Maisçavapas;;
sommeTrois([1;2;3]);;(*int = 6*)
sommeTrois([1;2;3;4]);;(*int = 6*)

(* troiEstPair : int list -> bool testant si le troisième élément d’une liste est pair*)
let troisEstPair = fun 
(_::_::c::_) -> c mod 2 = 0 
|_ -> failwith("MAIS ENFIN CA VA PAS??");;
troisEstPair([1;2;3]);;(*bool = false*)
troisEstPair([1;2;4]);; (*bool = true*)

(* ajoutDeuxFois : 'a * 'a list -> 'a list qui ajoute deux fois un élément en tête d’une liste*)
let ajoutDeuxFois = fun (a,b) -> a::a::b ;;
ajoutDeuxFois(2,[1;2;3;4]) ;;(* int list = [2; 2; 1; 2; 3; 4] *)

(* permute : 'a list -> 'a list qui échange les deux premiers éléments d’une liste. *)
let permute = fun (a::b::l)-> b::a::l ;;
#permute([1;2;3;4]) ;;(*int list = [2; 1; 3; 4]*)

(* construitListe : int -> int list qui, à un entier n, associe la liste [n;n−1;...;1;0] *)
let rec construitListe = fun 
0 -> [0]
|n -> n :: construitListe(n-1) ;;
construitListe(6);;(*int list = [6; 5; 4; 3; 2; 1; 0] *)

(*longueur :  'a list -> int qui calcule la longueur d’une liste.*)
let rec longueur = fun 
(_::l) -> 1 + longueur(l)
|[] -> 0 ;; 
longueur([1;2;3;4;5]);;(*int = 5*)

(*dernier : 'a list -> 'a qui donne le dernier élément d’une liste. *)
let rec dernier = fun
(a::[]) -> a
|(_::l) -> dernier(l) ;;
dernier([1;2;3;4;5]) ;;(* int = 5 *)

(*somme : int list -> int qui calcule la somme des éléments d’une liste donnée. *)
let rec somme = fun
(a::l) -> a+somme(l)
|_ -> 0 ;; 
somme([1;2;3;4;5]);;(*int = 15*)

(*taillePaire : 'a list -> bool qui teste (sans utiliser la fonction longueur) si une liste possède un nombre pair d’éléments. *)
let rec taillePaire = fun
(_::_::l) -> taillePaire(l)
|(_::_)-> false
|_ -> true ;;

(*rangImpair : 'a list -> 'a list permettant de construire la liste des éléments de rang impair d’une liste donnée*)
let rec rangImpair = fun 
(a::_::l) -> a::rangImpair(l) 
|(a::_)-> [a]
|_ -> [] ;;
rangImpair([1;2;3;4;5]) ;;(*int list = [1; 3; 5]*)

(*appartient : 'a * 'a list -> bool qui teste si un élément appartient à une liste.*)
let rec appartient = fun 
(a,b::l) -> a=b or appartient(a,l) 
|(a,_) -> false ;;
appartient(1,[2;3;4;5;6]) ;;(*bool = false*)
appartient(1,[2;3;4;5;6;1]) ;;(*bool = true*)

(*maximum : 'a list -> 'a qui calcule le maximum d’une liste d’entiers.*)
let max = fun (a,b) -> if a > b then a else b ;;
let rec maximum = fun
(a::l) -> max (a,maximum(l))
|_ -> 0 ;; 
maximum([1;2;3;4;5;6;7;8;9;8;4;5]);;(*int = 9*)

(*occurrences : 'a * 'a list -> int qui, étant donnés un élément et une liste, calcule le nombre d’occurrences de l’élément dans la liste.*)
let rec occurence = fun 
(a, b::l) -> occurence(a,l) + if a = b then 1 else 0
|_ -> 0 ;;
occurence(1,[1;2;1;3;1;6;1;5;1;4]) ;; (*int = 5*)
occurence(1,[1;2;1;3;1;6;1;5;1;4;1]) ;;(*int = 6*)

(*fois2 : int list -> int list qui, étant donnée une liste d’entiers, construit la liste des doubles des entiers de la liste*)
let rec fois2 = fun 
(a::l) -> 2*a::fois2(l) 
|_ -> [] ;;
fois2([;1;2;3]);;(*int list = [2; 4; 6]*)

(*insere : int * int list -> int list qui insère un entier dans une liste d’entiers ordonnée dans l’ordre croissant.*)
let rec insere = fun(a,b::l) -> 
if a>b 
  then b::insere(a,l) 
  else a::b::l ;;
insere(7,[1;2;3;4;5;6;8;9;10]);;(*int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] *)

(*ieme : int * 'a list -> 'a; On commence une liste par l'élément n°1*)
let rec ieme = fun
(1,b::l) -> b
|(a,b::l) -> ieme(a-1,l) ;;
ieme(2,[4554;1212;778;8998]);;(*int = 1212*)

(*prendre : int * 'a list -> 'a list qui, étant donnés un entier p et une liste l, retourne la liste des p premiers éléments de l. On commence une liste par l'élément n°1*)
exception ListePasAssezGrande ;; 
let rec prendre = fun 
(1,b::l) -> [b]
|(_,[]) -> raise ListePasAssezGrande
|(a,b::l) -> b::prendre(a-1,l) ;;
prendre(4,[1;2;3;4;5]) ;;(*int list = [1; 2; 3; 4]*)
prendre(4,[1;2;3]) ;;(*Exception non rattrapée: ListePasAssezGrande*)

(*enleve : int * 'a list -> 'a list qui, étant donnés un entier p et une liste l, retourne la liste privée des p premiers éléments de l.*)
exception ChiffreTropGrand ;;
let rec enleve = fun 
(0,b::l) -> b::enleve(0,l)
|(0,[]) -> []
|(_,[]) -> raise ChiffreTropGrand 
|(a,b::l) -> enleve(a-1,l) ;;
enleve(3,[1;2;3;4;5;6;7;8;9;10]) ;;(*int list = [4; 5; 6; 7; 8; 9; 10]*)

let rec melange = fun
([],_) -> []
|(_,[]) -> []
|(c::a,d::b) -> c::d::(melange(a,b)) ;;
melange([1;2;3],[4;5;6]) ;;(*int list = [1; 4; 2; 5; 3; 6]*)
melange([1;2;3;5;8],[4;5;6;7]) ;;(*int list = [1; 4; 2; 5; 3; 6; 5; 7]*)

let Fibonacci = fun (n) ->  
(*let rec Fibo = fun
  (1,2) -> 1::Fibo(1,1)
  |(1,1) -> [1]
  |(a,b) -> a+b::Fibo(b,a-b)

let rec Fibo1 = fun 
0 -> 1
|1 -> 1
|n -> Fibo1(n-1) + Fibo1(n-2);;

let rec Fibo2 = fun 
|1 -> (1,1)
|2 -> (2,1)
|(n) -> let (a,b) = Fibo2(n-1) in (a+b,a) ;;
*)

(*estCroissante : 'a list -> bool qui indique si les éléments consécutifs d’une liste sont bien ordonnés dans l’ordre croissant.*)
let rec estCroissante = fun 
[]-> true
|(a::b::c::[]) -> a<b & b<c
|(a::b::l) -> a<b & estCroissante(l) ;;
estCroissante([1;2;3;4]);;(*bool = true*)
estCroissante([1;2;3;4;3]);;(* bool = false*)

(* fusion : 'a list * 'a list -> 'a list qui, étant données deux listes supposées croissantes, renvoie la fusion de ces deux listes, toujours ordonnée croissante.*)
let rec fusion = fun
([],_) -> []
|(_,[]) -> []
|([],x) -> x
|(y,[]) -> y
|(c::a,d::b) -> if c<d then c::d::fusion(a,b) else d::c::fusion(a,b) ;;
fusion([1;2;4;7;9],[2;3;5;6;8]) ;;(*int list = [1; 2; 2; 3; 4; 5; 6; 7; 8; 9]*)

(*generer : int -> int list qui, étant donné un entier n, construit la liste ordonnée des entiers de 2 à n.*)
let rec generer = fun
2 -> [2]
|n-> generer(n-1)@[n] ;;
generer(7) ;; (*int list = [2; 3; 4; 5; 6; 7]*)

(*eliminer : int * int list -> int list qui, étant donnés une liste et un entier a, élimine tous les multiples de l’entier a dans la liste.*)
let rec eliminer = fun
(a,b::l) -> if b mod a = 0 then eliminer(a,l) else b::eliminer(a,l) 
|(_,[])->[] ;;
eliminer(7,[1;7;2;3;14;4;5;6;21;28;77]) ;; (*int list = [1; 2; 3; 4; 5; 6]*)

(*eratos : int -> int list qui, étant donné un nombre entier n,
construit la liste des nombres premiers inférieurs ou égaux à n. Pour cela, on utilisera la
méthode du crible d’Ératosthène : partant de la liste [2;...;n], son premier élément est
premier mais on doit éliminer tous les multiples de cet élément qui eux ne le sont pas. On
itère ce procédé jusqu’à la fin de la liste.*)
(*suppr : int list -> int list, prend le premier élément de la liste et supprime ces multiples *)
let rec suppr = fun
([])->[]
|(b::l) -> b::suppr(eliminer(b,l)) ;;

let eratos = fun n -> 
let liste = generer(n) in suppr(liste) ;;
eratos(7) ;;(*int list = [2; 3; 5; 7] *)
eratos(22) ;;(*int list = [2; 3; 5; 7; 11; 13; 17; 19]*)

(*jumeaux : int list -> (int * int) list qui, étant donnée une
liste de nombres premiers, construit la liste des couples de nombres premiers jumeaux
qu’elle contient.*)
let rec jumeaux = fun
a::b::[]) -> if b-a = 2 then [a,b] else 
|(a::b::l) -> if b-a = 2 then [a,b]@jumeaux(b::l) else jumeaux(b::l)
|[]-> [] ;;

(*listeJumeaux : int -> (int * int) list permettant de
donner la liste des couples de nombres premiers jumeaux inférieurs à une limite n fixée.*)
let listeJumeaux = fun (n) -> 
  let liste = eratos(n) in jumeaux(liste) ;;
listeJumeaux(19) ;;(* (int * int) list = [3, 5; 5, 7; 11, 13; 17, 19]*)
listeJumeaux(7) ;;(*(int * int) list = [3, 5; 5, 7]*)

(*appartient : 'a * 'a list -> bool qui détermine si un élément appartient à un
ensemble.*)
let rec appartient = fun 
(_,[]) -> false
|(a,b::l) -> a=b or appartient(a,l) ;;
appartient(3,[1;2;3]) ;;(*bool = true*)
appartient(3,[1;2;4]) ;;(*bool = false*)

(*union : 'a list * 'a list -> 'a list et intersection : 'a list * 'a list
-> 'a list qui calcule respectivement l’union et l’intersection de deux ensembles.*)
let rec union = fun 
(u,[]) -> u
|([],u) -> u
|(a::v,w) -> if appartient(a,w) 
then union(v,w) 
else a::union(v,w) ;;
union([1;2;3;4],[4;5;6;2;7;8]);;(*int list = [1; 3; 4; 5; 6; 2; 7; 8]*)

let rec intersection = fun 
(u,[]) -> []
|([],u) -> []
|(a::v,w) -> if appartient(a,w) 
  then a::intersection(v,w)
  else intersection(v,w) ;;
intersection([1;2;3;4],[4;5;6;2;7;8]);;(*int list = [2; 4]*)

(* inclus : 'a list * 'a list -> bool qui détermine si un premier ensemble est inclus dans un second.*)
let rec inclus = fun 
([],_) -> true
|(a::l,i) -> appartient(a,i) & inclus(l,i) ;;
inclus([1;2],[3;5;6;4;1;2]) ;;(* bool = true*)
inclus([1;2],[3;5;6;4;1]) ;;(* bool = false*)

(*disjoint : 'a list * 'a list -> bool qui détermine si deux ensembles sont disjoints*)
let disjoint = fun (a,b) ->
intersection(a,b) = [] ;;
disjoint([1;2],[5;3;7;8;9;6]) ;;(*bool = true*)
disjoint([1;2],[5;3;7;8;9;1]) ;; (*bool = false*)


let egaux = fun(a,b) ->
let uni=union(a,b) in 
  (uni=a or uni=b) & (list_length(a) = list_length(b));;
egaux([1;2;3],[3;2;1;4]) ;;(* bool = false*)
egaux([1;2;3],[3;2;1]) ;;(*bool = true*)

(* complement : 'a list * 'a list -> 'a list qui calcule le complémentaire d’un premier ensemble dans un second.*)
let rec complement = fun 
([],_) -> []
|(a::i,l) -> if appartient(a,l) then complement(i,l) else a:: complement(i,l) ;;
complement([1;2;3;4;5;6],[3;4;5;6;7;8;9]) ;;(*int list = [1; 2]*)

(*ensemble : 'a list -> 'a list qui, à partir d’une liste quelconque, construit une
liste contenant les mêmes éléments mais privés de leurs redondances*)
let rec ensemble = fun 
[]-> []
|(a::l) -> if appartient(a,l) then ensemble(l) else a::ensemble(l) ;;
ensemble([1;2;3;4;5;6;7;8;9;9;8;7;4;5;6;3;2;1]) ;;(*int list = [9; 8; 7; 4; 5; 6; 3; 2; 1]*)

(*parties : 'a list -> 'a list list qui construit l’ensemble des parties d’un
ensemble*)

