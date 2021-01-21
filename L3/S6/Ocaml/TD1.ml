type 'a p1_arbre_bin =
  | Feuille of 'a
  | Noeud of 'a * 'a p1_arbre_bin * 'a p1_arbre_bin ;;

type ('a, 'b) p2_arbre_bin = 
  | Feuille of 'a
  | Noeud of 'b * ('a, 'b) p2_arbre_bin * ('a, 'b) p2_arbre_bin ;;

let rec nds_interne arbre =
  match arbre with
      | Feuille _ -> []
      | Noeud (a, f1, f2) -> a :: (nds_interne(f1) @ nds_interne(f2)) ;;

let rec nds_zero arbre =
  match arbre with
      | Feuille _ -> false
      | Noeud (a, f1, f2) -> a=0;;
      (* val nds_zero : ('a, int) p2_arbre_bin -> bool = <fun> *)
  
  
(* 
3)(a) int p1_arbre_bin -> int 
  (b) int bool p1_arbre_bin -> X marche pas (int bool)
  (c) (int * bool) p1_arbre_bin -> ça marche (Feuille (3,true) ;; 
                                  (int * bool) p1_arbre_bin = Feuille (3, true))
  (d) (int, bool) p2_arbre_bin ->  Feuille (3,false) ;;
                                  (int * bool, 'a) p2_arbre_bin = Feuille (3, false)

  (e) ('a, int) p2_arbre_bin -> Noeud(3, Feuille `a, Feuille `a) ;;
                              ([> `a ], int) p2_arbre_bin = Noeud (3, Feuille `a, Feuille `a)

  (f) int * bool p2_arbre_bin -> nope 

4)
(a) nds_interne (Feuille "BonneAnnée") -> 'a list = [] 
(b) nds_interne (Noeud (1 , Feuille true, Feuille false)) -> int list = [1]
(c) nds_interne (Noeud ('a', Feuille 1 , Feuille 2.5)) ;;-> Les feuilles doivent être du même type
                                                            ça marche


*)
      