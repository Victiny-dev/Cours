(*multiplicite qui calcule l’ordre de multiplicité de l’élément x dans le multi-ensemble m.*)
let rec multiplicite (l:int list) (x:int) = match l with
  a::q -> if a=x then 1+ multiplicite q x else multiplicite q x 
  | _ -> 0 ;;   

(* enleve qui retire une occurrence de l’élément x d’une liste m. Si x
n’apparaît pas dans m, la liste sera retournée inchangée.*)
let rec enleve (l:int list) (x:int) = match l with
  |a::q -> if a=x then q else a:: enleve q x
  | _ -> [] ;;

(*l’ordre de multiplicité d’un élément x de (M +m N) est la somme
de son ordre de multiplicité dans M et dans N (c’est à dire
∀x,(M +m N)(x) = M(x)+ N(x))*)
let lasomme = function (m,n) -> m@n ;;
(*let rec supprOccur = function
  |([],b) -> []
  |(a::l, b) -> if a=b then supprOccur(l,b) else a::supprOccur(l,b);;
let rec generOccur (a:int) (b:int) = match b with
  0 -> []
  |b -> a::generOccur a (b-1) ;;
let rec union_l j= function 
  |(a::l) -> generOccur( a (max multiplicite a::l a multiplicite j a) )@ union_l supprOccur(l,a) supprOccur(j,a)
  |[] -> j ;;*)

let rec union_l m = function 
  | t :: q -> t :: (union_l (enleve m t) q)
  | _ -> m ;;

let rec intersection_l m = function 
  | t :: q -> if multiplicite m t > 0 then t :: (intersection_l (enleve m t) q ) else (intersection_l (enleve m t) q )
  | _ -> [] ;;

let rec difference_l m = function
  | t::q -> if multiplicite m t = 0 then t:: (difference_l (enleve m t) q ) else (difference_l (enleve m t) q )
  | _ -> m ;;

let rec insert (m: int list) (a:int) = match m with
  | b::q -> if a<b then a::b::q else b::insert q a 
  | _ -> [a] ;;

let rec sort (m:int list) = match m with
  | a::q -> insert(sort q) a 
  | _ -> [] ;;

let testegal = function (a,b) -> 
   difference_l a (b) = [];; 