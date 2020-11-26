(*TP N°7 sur les sommes en caml*)

(*type énuméré couleur contenant les constantes : Blanc, Noir, Rouge, Vert,
Bleu, Jaune, Cyan et Magenta*)
type couleur = Blanc|Noir|Rouge|Vert|Bleu|Jaune|Cyan|Magenta ;;

(*est_colore : couleur -> bool qui renvoie faux pour Noir et
Blanc, et vrai pour les autres couleurs du type couleur.*)
let est_colore = fun (t) -> not(t=Noir or t=Blanc) ;;
let est_colore = fun 
Blanc -> false
| Noir -> false
| _ -> true ;;
est_colore(Blanc);;(*bool = false*)

let complementaire = fun
Rouge -> Cyan
|Cyan -> Rouge
|Magenta -> Vert
|Vert -> Magenta 
|Bleu -> Jaune 
|Jaune -> Bleu 
|_ -> failwith("Pas une couleur") ;;

type nombreNR = N of int| R of float;;

let somme = fun 
(N x, N y) -> N (x + y)
|(N x, R y) ->R (float_of_int(x)+. y)   
|(R x, N y) ->R (x+.float_of_int(y))
|(R x, R y) ->R (x+.y);;
somme(R 1.4,R 5.2);;(*nombreNR = R 6.6*)
somme(R 1.4,N 5);;(*nombreNR = R 6.4*)
somme(N 1,R 5.2);;(*nombreNR = R 6.2*)


let prod = fun 
(N x, N y) -> N (x * y)
|(N x, R y) ->R (float_of_int(x)*. y)   
|(R x, N y) ->R (x*.float_of_int(y))
|(R x, R y) ->R (x*.y);;

type nombreRC= R of float| C of (float*float) ;;

let somme = fun
(R x, R y) -> R (x+.y) 
|(R x, C (a,b)) -> C(x+.a,b)
|(C (a,b), R y) -> C(a+.y,b)
|(C (a,b), C (x,y)) -> C(a+.x , b+.y);;
somme(C (3.14,1.7),R (1.86)) ;;(*nombreRC = C (5.0, 1.7)*)
somme(C (3.14,1.7),C (1.86,2.3)) ;;(* nombreRC = C (5.0, 4.0)*)

type exprLogique =
  Vrai | Faux
  | Non of exprLogique
  | Et of exprLogique*exprLogique
  | Ou of exprLogique*exprLogique ;;
  
let exp=Ou(Et(Vrai,Vrai),Et(Non(Ou(Faux,Non(Vrai))),Vrai));;

(*echange : type récursif inversant le vrai et faux*)
let rec echange = fun
Vrai -> Faux
|Faux -> Vrai
|(Non(e1) )-> Non(echange(e1)) 
|(Ou(e1,e2) )-> Ou(echange(e1),echange(e2))
|(Et(e1,e2) )-> Et(echange(e1),echange(e2));;
let exp2=echange(exp) ;;
(*exp2 : exprLogique = Ou (Et (Faux, Faux), Et (Non (Ou (Vrai, Non Faux)), Faux))*)

let rec evalue = fun
Vrai->true
|Faux -> false
|(Non(e1)) -> not(evalue(e1))
|(Ou(e1,e2)) -> evalue(e1) or evalue(e2)
|(Et(e1,e2)) -> evalue(e1) & evalue(e2) ;;

type arbre = Feuille of int
| Noeud of int*arbre*arbre ;;
let t= Noeud (4, Noeud (2, Noeud (3, Feuille 0, Feuille 1), Feuille 2),
Noeud (1, Feuille 2, Noeud (3, Feuille 1, Feuille 2))) ;;

let max = fun (a,b) -> if a>b then a else b;;

let rec profondeur = fun
(Feuille x) -> 0
|(Noeud (x,y,z)) -> 1+max(profondeur(y),profondeur(z)) ;;

let rec complet = fun
(0,n) -> Feuille n
|(x,n) -> Noeud(n,complet(x-1,n),complet(x-1,n)) ;;

let rec liste = fun
(Feuille x) -> [x]
|(Noeud (x,y,z)) -> [x]@(liste(y))@liste(z) ;;
liste(t) ;;(*int list = [4; 2; 3; 0; 1; 2; 1; 2; 3; 1; 2]*)

type expArithm = Nb of int
| Oper of char*expArithm *expArithm ;;

let exp =Oper(`+`,Oper (`*`,Oper (`+`,Nb 0, Nb 1),Nb 2),Oper(`/`,Nb 2, Oper(`-`,Nb 1 , Nb 2))) ;;

let rec nbOper = fun 
(Nb _) -> 0
|(Oper (_,b,c)) -> 1 + nbOper(b) + nbOper(c) ;;

let rec evalue = fun 
(Nb x) -> x
|(Oper (`+`,b,c)) ->evalue(b) + evalue(c)
|(Oper (`-`,b,c)) ->evalue(b) - evalue(c)
|(Oper (`*`,b,c)) ->evalue(b) * evalue(c)
|(Oper (`/`,b,c)) ->evalue(b) / evalue(c) ;;

type objet = Chat|Clown|Mouton ;;
type mobile = Feuille of objet| Noeud of (int*int*mobile*mobile) ;;

let poids_f = fun
Chat -> 1 
| Clown -> 3
| Mouton -> 2 ;;

let fait_mob_simple = fun (n,x) -> Noeud(n,n,Feuille x, Feuille x) ;;

let rec poids_m = fun 
(Feuille x) -> poids_f(x)
|(Noeud (_,_,o1,o2)) -> poids_m(o1) + poids_m(o2) ;;

let rec agrandir_m = fun
(Feuille x) -> Feuille x
|(Noeud (a,b,o1,o2)) -> Noeud(2*a,2*b,agrandir_m(o1),agrandir_m(o2)) ;;


