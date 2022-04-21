let context = Llvm.global_context ()
let llmodule = Llvm.create_module context "testmodule"
let i64 = Llvm.i64_type context

(* Create a llvm function that takes two i64 and returns their sum 
   Called incr_int: i64 * i64 -> i64 *)
let llvm_dummy_func = 
   let ft = Llvm.function_type i64 (Array.make 2 i64) in
   Llvm.declare_function "incr_int" ft llmodule 

(* print out the function signature *)
