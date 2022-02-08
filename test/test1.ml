let[@cold] inline_never2 _x _y = ()

let useless_movs x y =
  inline_never2 (x - y) x

let swap x y =
  inline_never2 y x

let foldable_adds () =
  let x = ref 0 in
  x := !x + 1;
  x := !x + 2;
  !x

let identities x =
  (x - x) lor 0

module Hot_path_reload = struct

  let [@cold] inline_never () = ()

  let example k =
    let k = k + 1 in
    if k = 100
    then inline_never ();
    k + 2
end

module Bitmasks = struct
  let [@cold] two_ors k =
    0
    lor (1 lsl 3)
    lor (1 lsl k)
    lor (1 lsl 1)
end

module Code_motion : sig
  type t = A | B
  val lift_function : t -> int -> int -> int
end = struct
  type t = A | B

  let value_exn x =
    if x = Int.min_int || x = Int.max_int
    then failwith ""
    else x

  let [@cold] lift_function t x1 x2 =
    match t with
    | A -> value_exn x1
    | B -> value_exn x2
end

module Register_lifetimes = struct
  type t =
    { mutable a : int
    ; mutable b : int
    }

  let [@cold] foo t =
    let a = t.a in
    let b = t.b in
    t.a <- a + 1;
    a + b

  let [@cold] bar t =
    let a = t.a + 1 in
    t.a <- a;
    a + t.b
end

module Fold_fields = struct
  type t =
    { mutable a : int
    ; mutable b : int
    ; mutable c : int
    }

  let fold t ~init ~a:a_fun ~b:b_fun ~c:c_fun =
    c_fun (b_fun (a_fun init t.a) t.b) t.c

  let [@cold] all_zero t =
    let check_zero acc x = x = 0 && acc in
    fold ~init:true t
      ~a:check_zero
      ~b:check_zero
      ~c:check_zero

  let simple_record x =
    let t = Sys.opaque_identity { a = x; b = x; c = x } in
    Bool.to_int (all_zero t)
end

module Comparisons = struct
  type t = A | B | C

  let to_rank = function | A -> 0 | B -> 1 | C -> 2
  let [@cold] compare t0 t1 = Int.compare (to_rank t0) (to_rank t1)
  let [@cold] equal t0 t1 = compare t0 t1 = 0
end


let () =
  Printf.printf "Hello World!\n"
