type Point = {abs : float ; ord : float} ;;
let p1 = {abs = 0.0 ; ord = 0.0} and
p2 = {abs = 2.0 ; ord = 0.0} and
p3 = {abs = 1.0 ; ord = 2.0} and
p4 = {abs = 0.0 ; ord = 1.0} ;;

type Forme = Cercle of Point*float | Polygone of Point list ;;
let p=Polygone [p1 ;p2 ;p3 ;p4 ;p1] ;;

(*distance : calcule la distance entre deux points *)
let dis = fun (a,b) -> sqrt((b.ord -. a.ord)**2. +. (b.abs -. a.abs)**2.) ;;
dis(p3,p2) ;;(*float = 2.2360679775*)

(* longueur :Point list -> float = <fun> qui calcule la
longueur d’une ligne brisée définie par la liste de ses sommets. *)
let rec longueur = fun 
(a::b::l) -> dis(a,b) +. longueur(b::l)
|_ -> 0. ;;
longueur([p1;p2;p3]) ;;(*float = 4.2360679775*)

(*bonPoly et envPoly : bonPoly renvoit le dernier element d'une liste
 envPoly vérifie qu'elle contient au moins 4 elements et compare le premier et dernier*)
let rec dernierElem = fun
(_::a::l)-> dernierElem(a::l)
|[a]-> a ;;
(*a.abs=lp.abs & a.ord=lp.ord*)
let bonPoly = fun
(a::b::c::d::l) -> let lp = dernierElem(b::c::d::l) in a=lp
| _ -> false ;;

bonPoly([p2;p1;p3;p4;{ord = 0.0 ; abs = 2.0}]);;(*bool = true*)
bonPoly([p3;p1;p3;p4;{ord = 2.0 ; abs = 1.0}]);;(*bool = true*)
bonPoly([p1;p2;p3;p4;p1]) ;; (*bool = true*)
bonPoly([p1;p2;p3;p1]) ;;(*bool = true*)
bonPoly([p1;p2;p1]) ;;(*bool = false*)
bonPoly([p1;p2;p3;p4]) ;;(*bool = false*)

(* perimetre : Forme -> float = <fun> calculant le périmètre
d’un objet de type Forme. Dans le cas d’un polygone, on vérifiera que la liste de points
donnée vérifie bien les conditions de la question précédente. Dans le cas d’un cercle de
rayon r, rappelons que le périmètre est 2πr.*)

exception MaisCaVaPas ;;

let perimetre = fun 
(Cercle (_,x)) -> 2.*.3.14159265359*.x
|(Polygone (l)) -> if envPoly(l) then longueur(l) else raise MaisCaVaPas ;;  
perimetre p ;;(*float = 6.65028153987*)
perimetre (Cercle (p1,1.)) ;;(*float = 6.28318530718*)
perimetre (Polygone [p1 ;p2 ;p3]) ;; (*Exception non rattrapée: MaisCaVaPas*)

type CodeRVB = {R:int;V:int;B:int} ;;

type Couleur = Rouge|Bleu|Vert
               |Melange of Couleur*Couleur | RVB of int*int*int ;;

let rvbToCoul = fun c -> RVB (c.R,c.V,c.B) ;;

let rec coulToRvb = fun 
(Rouge) -> {R=255;V=0;B=0}
|(Bleu) -> {R=0;V=0;B=255}
|(Vert) -> {R=0;V=255;B=0}
|(Melange (x,y)) -> let cx =coulToRvb(x) and cy=coulToRvb(y) in
                            {R=cx.R/2 + cy.R/2;B=cx.B/2 + cy.B/2;V=cx.V/2 + cy.V/2 }
|(RVB (x,y,z)) -> {R=x;V=y;B=z} ;;

let tripletToCoul = fun (x,y,z) -> {R=x;V=y;B=z} ;;

let coulToTriplet = fun c -> c.R,c.V,c.B ;;

let peindre = fun (c) -> bandes([coulToTriplet(coulToRvb(c))]) ;;
peindre(Rouge) ;;

let peindre2 = fun (c1,c2) -> bandes([coulToTriplet(coulToRvb(c1))]@
                                     [coulToTriplet(coulToRvb(c2))]);;
                                     
let drapeau = fun (c1,c2,c3) -> bandes([coulToTriplet(coulToRvb(c1))]@
                                       [coulToTriplet(coulToRvb(c2))]@
                                       [coulToTriplet(coulToRvb(c3))]);;

exception MaisTEsPasNet ;;
let eclaircir = fun (c) -> let r,v,b = coulToTriplet(coulToRvb(c)) in
                           if r+10 > 255 or
                              v+10 > 255 or
                              b+10 > 255 
                            then raise MaisTEsPasNet
                            else RVB (r+10,v+10,b+10) ;;

let assombrir = fun (c) -> let r,v,b = coulToTriplet(coulToRvb(c)) in
                           if r-10 < 0 or
                              v-10 < 0 or
                              b-10 < 0 
                            then raise MaisTEsPasNet
                            else RVB (r-10,v-10,b-10) ;;

(*peindre2(RVB (155,70,70),RVB(50,170,50)) ;;
peindre2(eclaircir(eclaircir(RVB (155,70,70))),assombrir(RVB(50,170,50))) ;;*)
let min3 = fun(a,b,c) 
-> if a<b then 
    if a<c then a 
           else c
    else if b<c then b 
                else c ;;

let plusClaire = fun (c) -> let r,v,b = coulToTriplet(coulToRvb(c)) in
                              let maxc = min3(255-r,255-v,255-b) in RVB(r+maxc,v+maxc,b+maxc) ;;

let plusSombre = fun (c) -> let r,v,b = coulToTriplet(coulToRvb(c)) in
                              let minc = min3(r,v,b) in RVB(r-maxc,v-maxc,b-maxc) ;;
                               
(*peindre(RVB(20,70,90)) ;; 
plusClaire(RVB(20,70,90)) ;; (Couleur = RVB (185, 235, 255)*)

let rec recRouge = fun 
(255,x,y) -> [255,x,y]
|(z,x,y) -> [z,x,y]@recRouge(z+1,x,y) ;;

let nuancesRouge = fun (c) -> let r,v,b = coulToTriplet(coulToRvb(c)) in
                              recRouge(0,v,b) ;;
peindre(nuancesRouge(RVB (255,255,255))) ;;


