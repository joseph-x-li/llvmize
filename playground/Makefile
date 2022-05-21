default: llvmize

frontend:
	ocamlopt test1.ml -o t1.exe -S -dsel -dump-into-file -save-ir-after selection -dstartup -verbose
# save after selection, scheduling, simplify_cfg

llvmize: frontend
	../_build/install/default/bin/llvmize test1.cmir-cfg-sel

original:
	../llvmize/_build/install/default/bin/llvmize test1.cmir-cfg-sel -dot -dot-detailed

asm:
	clang-13 -O3 -c test.ll
	objdump -D test.o > test.asm

clean:
	rm -f *.o *.exe* *.dot *.out *.s *.cmt *.annot *cmx* *cmi* *.ll *.asm
