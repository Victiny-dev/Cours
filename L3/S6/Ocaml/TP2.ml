type 'a arbre_binaire =
  Feuille
  | Noeud of 'a * 'a arbre_binaire * 'a arbre_binaire ;;

exception PasDeRacine ;;

let racine = function 
  | Noeud(a,_,_) -> a
  | Feuille -> raise PasDeRacine ;;
  
let rec recherche (x:'a)(l: 'a arbre_binaire) = match l with
  |(Noeud (a,b,c)) -> x=a||recherche(x)(b)||recherche(x)(c) 
  |Feuille -> false ;;

let rec cherche_sous_arbre (x:'a)(l: 'a arbre_binaire) = match l with
  |(Noeud (a,b,c)) -> if x = a then Noeud(a,b,c) else 
        let arbreb = cherche_sous_arbre(x)(b) in
          if arbreb = Feuille  (* si arbreb = Feuille, la recherche a echoué*)
            then cherche_sous_arbre(x)(c)  (* *)
            else arbreb
  |Feuille -> Feuille ;;

let rec max_arbre (l:'a arbre_binaire) = match l with
  |Noeud(a,b,c) -> let maxb = max_arbre b in
                       let maxc= max_arbre c in
                        if a > maxb then 
                          if a > maxc then a 
                          else maxc
                        else if maxb>maxc then maxb
                             else maxc 
  |Feuille -> min_int ;;

let rec min_arbre (l:'a arbre_binaire) = match l with
  |Noeud(a,b,c) -> let minb = min_arbre b in
                       let minc= min_arbre c in
                        if a < minb then 
                          if a < minc then a 
                          else minc
                        else if minb<minc then minb
                             else minc 
  |Feuille -> max_int ;;


