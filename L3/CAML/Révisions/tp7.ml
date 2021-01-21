type couleur = Blanc|Noir|Rouge|Vert|Bleu|Cyan|Magenta ;;

let est_colore = fun 
(Noir) -> false
|(Blanc) -> false
|_-> true ;;

(*Complementaire skipped*)

type nombreNR = N of int|R of float ;;

let somme = fun 
(N n1, N n2) -> N (n1+n2)
|(N n1, R n2) -> R (float_of_int(n1) +. n2)
|(R n1, N n2) -> R (float_of_int(n2) +. n1)
|(R n1, R n2) -> R (n1 +. n2) ;;

let produit = fun 
(N n1, N n2) -> N (n1*n2)
|(N n1, R n2) -> R (float_of_int(n1) *. n2)
|(R n1, N n2) -> R (float_of_int(n2) *. n1)
|(R n1, R n2) -> R (n1 *. n2) ;;

type nombreRC = R of float| C of float*float ;;

let sommeC = fun 
(R n1, R n2) -> R (n1+.n2)
|(R n1, C (n2,im2)) -> C (n1+.n2,im2)
|(C (n1,im1), R n2) -> C (n1+.n2,im1)
|(C (n1,im1), C (n2,im2)) -> C (n1+.n2,im1+.im2) ;;

let produitC = fun 
(R n1, R n2) -> R (n1*.n2)
|(R n1, C (n2,im2)) -> C (n1*.n2,im2)
|(C (n1,im1), R n2) -> C (n1*.n2,im1)
|(C (n1,im1), C (n2,im2)) -> C (n1*.n2 +. im1*.im2 ,n1*.im2 +. n2*.im1) ;;

type exprLogique =
  Vrai | Faux
  | Non of exprLogique
  | Et of exprLogique*exprLogique
  | Ou of exprLogique*exprLogique ;;

let exp = Ou ( Et(Vrai,Vrai) ,Et ( Non( Ou (Faux, Non(Vrai) ) ) , Vrai ) ) ;;

let rec echange = fun
(Vrai) -> Faux
| (Faux) -> Vrai
| (Non (e1)) -> Non(echange(e1))
| (Ou (e1,e2)) -> Ou (echange(e1),echange(e2))
| (Et (e1,e2)) -> Et (echange(e1),echange(e2)) ;;

let rec evalue = fun
(Vrai) -> true
|(Faux) -> false
| (Non (e1)) -> not evalue(e1)
| (Et (e1,e2)) -> evalue(e1) & evalue(e2)
| (Ou (e1,e2)) -> evalue(e1) or evalue(e2) ;;

