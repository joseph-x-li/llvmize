let incr x = x + 1
let mul x y = x * y


let ident x = x

(* This doesn't work due to usage of LEA *)
(* let math x y = x + y *)
(* This doesn't work due to missing terminator? *)
(* let div x y = x / y *)

(* let rec fib n = if n < 2 then 1 else fib (n-1) + fib (n-2) *)