(* Un multi-ensemble est maintenant représenté comme une paire, la première composante est
un majorant des éléments du multi-ensemble, et la deuxième composante est un
multi-ensemble au sens de la partie précédente *)

type multiset_paire = int * (int -> int) ;;

let (m1: multiset_paire) = 3, function 
| 0 -> 2 
(*| 1 -> 0 *)
| 2 -> 3 
| 3 -> 1 
| _ -> 0 ;;

let (empty_mp : multiset_paire) = min_int,function _-> 0 ;;

let ajoute_mp (m : multiset_paire) (x : 'a) = 
  let v1,m1 = m in
    let (m2: multiset_paire) = (if v1 > x then v1 else x),function 
      y -> if y = x then (m1 x) + 1 else (m1 y) 
    in m2 ;;



let rec multipaire_of_list (li : 'a list) = match li with  
    | a::li -> ajoute_mp (multipaire_of_list li)  a
    | _ -> empty_mp  ;;
    

let rec multipaire_of_list = function 
    | a::li -> ajoute_mp (multipaire_of_list li)  a
    | _ -> empty_mp  ;;
