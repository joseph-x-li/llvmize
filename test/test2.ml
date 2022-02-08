(* open Core
 *
 * module Redundant_loads = struct
 *   type t = { x0 : int; x1 : int; x2 : int }
 *
 *   let [@cold] sad_codegen t buf =
 *     let { x0; x1; x2 } = t in
 *     let poke = Iobuf.Unsafe.Poke.int64_le in
 *     poke buf ~pos:(8*0) x0;
 *     poke buf ~pos:(8*1) x2;
 *     poke buf ~pos:(8*2) x1
 *
 *   let write_a_packet i =
 *     let buf = Iobuf.create ~len:(16*3) in
 *     let t = { x0 = 0; x1 = 0; x2 = 0 } in
 *     sad_codegen t buf;
 *     ignore (Sys.opaque_identity buf : (_, _) Iobuf.t);
 *     i
 * end *)
