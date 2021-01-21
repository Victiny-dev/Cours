
type 'a multiset = 'a -> int ;;
(* type polymorphe *)

let (m1: int multiset) = function 
| 0 -> 2 
(*| 1 -> 0 *)
| 2 -> 3 
| 3 -> 1 
| _ -> 0 ;; 
(*  {0;0;2;2;2;3} *)

(*m1 : int multiset = <fun>*)

(*multi ensemble vide *)
let (empty_m : 'a multiset) = function _-> 0 ;;

let ajoute_m (m : 'a multiset) (x : 'a) = 
	let (m2:'a multiset) = function 
		y -> if y = x then (m x) + 1 else (m y) in 	
	m2 ;;
	
(*ajoute_m : 'a multiset -> 'a -> 'a multiset *)
let m2 = ajoute_m m1 1 ;;
(*m2 : int multiset*)

m2 0 ;;
m2 1 ;;

let rec multi_of_list (li : 'a list) = function
| a::li -> ajoute_m (multi_of_list li)  a
| _ -> empty_m  ;; (*CA NE FONCTIONNE PAS *)

(* multi_of_list : 'a list ->  'a list -> ...  *)

let rec multi_of_list (li : 'a list) = match li with  
| a::li -> ajoute_m (multi_of_list li)  a
| _ -> empty_m  ;;

(* multi_of_list : 'a list ->  'a list -> ...  *)
let rec multi_of_list = function 
| a::li -> ajoute_m (multi_of_list li)  a
| _ -> empty_m  ;;

(*CF tp1, fonction enlever, enlever tous somme etc mais en format application *)
let enleve_un (m : 'a multiset) (x : 'a) =
	let (m2:'a multiset) = function 
		y -> if y = x & (m x)!= 0 then (m x) - 1 else (m y) in 	
	m2 ;;

let enleve_tous_m	(m : 'a multiset) (x : 'a) =
	let (m2:'a multiset) = function 
		y -> if y = x then 0 else (m y) in 	
	m2 ;;

let somme_m (m1:'a multiset) (m2:'a multiset) = 
	let (m3:'a multiset) = function 
		y -> (m1 y) + (m2 y) 	in
	m3 ;;

let intersection_m (m1:'a multiset) (m2:'a multiset) = 
	let (m3:'a multiset) = function 
		y ->if (m1 y)>=(m2 y) then 
				(m2 y)
				else (m1 y)	in
	m3 ;; 

let union_m	(m1:'a multiset) (m2:'a multiset) = 
	let (m3:'a multiset) = function 
		y ->if (m1 y)>=(m2 y) then
					(m1 y)
				else
					(m2 y) in
	m3 ;; 

let difference_m (m1:'a multiset) (m2:'a multiset) = 
	let (m3:'a multiset) = function 
		y ->if (m1 y)>=(m2 y) then
					(m1 y) - (m2 y)
				else
					0
					in m3 ;; 


		