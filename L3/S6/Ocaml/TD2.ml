let rec sum (l: int list ) = match l with 
  | a :: l -> a + sum (l)
  | _ -> 0 ;;

let rec concat (l:int list list) = match l with
  | a::l -> a@concat(l)
  | _ -> [] ;; 

let rec listmap (f : 'a-> 'b) (l: 'a list) = match l with 
  | a :: l -> f (a) :: listmap f l 
  | _ -> []  ;;
(*  listmap (fun x -> x + 4) (listmap (fun x -> 2 * x) [1 ; 2 ; 3]) ;;
- : int list = [6; 8; 10] *)

let comp (f1 : 'b -> 'a) (f2: 'c -> 'b) (x :'c) = f1 (f2 x) ;;  

(* 3a) int list = [2; 4; 6]
    b) int list = [6; 8; 10]
    c) ça marche (?)  *)

