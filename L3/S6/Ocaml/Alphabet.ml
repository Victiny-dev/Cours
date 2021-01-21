let w = ['a' ;'b' ;'b' ;'a'] ;;
let rec conversion = function
  | "" -> [] 
  | chaine -> chaine.[0]::conversion(String.sub chaine 1 (String.length chaine -1 )  ) ;;


let rec teste_lettre (l:'a list) (a:'a)= match l with 
  | i::q -> i=a || teste_lettre q a 
  | _ -> false ;;

let rec teste_mot (l:'a list) (dico:'a list) = match l with
  | i::q -> teste_lettre dico i && teste_mot q dico
  | _ -> true ;;

let rec egalite = function
  | (a::l1,b::l2) -> a=b && egalite(l1,l2)
  | (_::_,_) -> false 
  | (_,_::_) -> false 
  | (_,_) -> true ;;
let egalite = function(w1,w2) -> w1=w2 ;;

let concaten (l1:'a list) (l2:'a list) -> l1@l2 ;;

let rec puissance (w:'a list) (p:int) = match p with 
  | 0 -> []
  | p -> w@puissance w (p-1) ;;

exception CaMarchePas ;;

let rec prefixe_reste ((v: 'a list), (w: 'a list)) = match (v,w) with
    (a::l1, b::l2) -> if a = b then (prefixe_reste(l1, l2)) else raise CaMarchePas
    | (a::l1, _) -> raise CaMarchePas
    | (_, b) -> b;;

let rec est_puiss ((w:'a list),(mot : 'a list)) = match w with
  [] -> true 
  |l1 -> (try
            let reste = prefixe_reste (mot,l1) in est_puiss(reste,mot)
          with
          CaMarchePas -> false 
          );;