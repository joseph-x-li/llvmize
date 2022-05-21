	.file ""
	.section .rodata.cst16,"aM",@progbits,16
	.align	16
caml_negf_mask:
	.quad	0x8000000000000000
	.quad	0
	.align	16
caml_absf_mask:
	.quad	0x7fffffffffffffff
	.quad	-1
	.data
	.globl	caml_startup__data_begin
caml_startup__data_begin:
	.text
	.globl	caml_startup__code_begin
caml_startup__code_begin:
	.text
	.align	16
	.globl	caml_program
caml_program:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L111:
	call	camlCamlinternalFormatBasics__entry@PLT
.L112:
	movq	caml_globals_inited@GOTPCREL(%rip), %rax
	addq	$1, (%rax)
	call	camlCamlinternalAtomic__entry@PLT
.L113:
	movq	caml_globals_inited@GOTPCREL(%rip), %rax
	addq	$1, (%rax)
	call	camlStdlib__entry@PLT
.L114:
	movq	caml_globals_inited@GOTPCREL(%rip), %rax
	addq	$1, (%rax)
	call	camlTest1__entry@PLT
.L115:
	movq	caml_globals_inited@GOTPCREL(%rip), %rax
	addq	$1, (%rax)
	call	camlStd_exit__entry@PLT
.L116:
	movq	caml_globals_inited@GOTPCREL(%rip), %rax
	addq	$1, (%rax)
	movl	$1, %eax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_program,@function
	.size caml_program,. - caml_program
	.text
	.align	16
	.globl	caml_curry4
caml_curry4:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L119:
	subq	$48, %r15
	cmpq	8(%r14), %r15
	jb	.L120
.L122:
	leaq	8(%r15), %rdi
	movq	$5367, -8(%rdi)
	movq	caml_curry4_1@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$216172782113783815, %rsi
	movq	%rsi, 8(%rdi)
	movq	caml_curry4_1_app@GOTPCREL(%rip), %rsi
	movq	%rsi, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L120:
	call	caml_call_gc@PLT
.L121:
	jmp	.L122
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry4,@function
	.size caml_curry4,. - caml_curry4
	.text
	.align	16
	.globl	caml_curry4_1_app
caml_curry4_1_app:
	.cfi_startproc
.L125:
	movq	%rax, %rcx
	movq	%rbx, %r8
	movq	%rdi, %r9
	movq	32(%rsi), %rdx
	movq	24(%rsi), %rax
	movq	16(%rdx), %r12
	movq	%rcx, %rbx
	movq	%r8, %rdi
	movq	%r9, %rsi
	jmp	*%r12
	.cfi_endproc
	.type caml_curry4_1_app,@function
	.size caml_curry4_1_app,. - caml_curry4_1_app
	.text
	.align	16
	.globl	caml_curry4_1
caml_curry4_1:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L128:
	subq	$48, %r15
	cmpq	8(%r14), %r15
	jb	.L129
.L131:
	leaq	8(%r15), %rdi
	movq	$5367, -8(%rdi)
	movq	caml_curry4_2@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$144115188075855879, %rsi
	movq	%rsi, 8(%rdi)
	movq	caml_curry4_2_app@GOTPCREL(%rip), %rsi
	movq	%rsi, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L129:
	call	caml_call_gc@PLT
.L130:
	jmp	.L131
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry4_1,@function
	.size caml_curry4_1,. - caml_curry4_1
	.text
	.align	16
	.globl	caml_curry4_2_app
caml_curry4_2_app:
	.cfi_startproc
.L134:
	movq	%rax, %rcx
	movq	%rbx, %rsi
	movq	32(%rdi), %rax
	movq	32(%rax), %rdx
	movq	24(%rdi), %rbx
	movq	24(%rax), %rax
	movq	16(%rdx), %r8
	movq	%rcx, %rdi
	jmp	*%r8
	.cfi_endproc
	.type caml_curry4_2_app,@function
	.size caml_curry4_2_app,. - caml_curry4_2_app
	.text
	.align	16
	.globl	caml_curry4_2
caml_curry4_2:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L137:
	subq	$40, %r15
	cmpq	8(%r14), %r15
	jb	.L138
.L140:
	leaq	8(%r15), %rdi
	movq	$4343, -8(%rdi)
	movq	caml_curry4_3@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$72057594037927941, %rsi
	movq	%rsi, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rbx, 24(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L138:
	call	caml_call_gc@PLT
.L139:
	jmp	.L140
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry4_2,@function
	.size caml_curry4_2,. - caml_curry4_2
	.text
	.align	16
	.globl	caml_curry4_3
caml_curry4_3:
	.cfi_startproc
.L143:
	movq	%rax, %rsi
	movq	24(%rbx), %rax
	movq	32(%rax), %rcx
	movq	32(%rcx), %rdx
	movq	16(%rbx), %rdi
	movq	24(%rax), %rbx
	movq	24(%rcx), %rax
	movq	16(%rdx), %rcx
	jmp	*%rcx
	.cfi_endproc
	.type caml_curry4_3,@function
	.size caml_curry4_3,. - caml_curry4_3
	.text
	.align	16
	.globl	caml_curry3
caml_curry3:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L146:
	subq	$48, %r15
	cmpq	8(%r14), %r15
	jb	.L147
.L149:
	leaq	8(%r15), %rdi
	movq	$5367, -8(%rdi)
	movq	caml_curry3_1@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$144115188075855879, %rsi
	movq	%rsi, 8(%rdi)
	movq	caml_curry3_1_app@GOTPCREL(%rip), %rsi
	movq	%rsi, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L147:
	call	caml_call_gc@PLT
.L148:
	jmp	.L149
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry3,@function
	.size caml_curry3,. - caml_curry3
	.text
	.align	16
	.globl	caml_curry3_1_app
caml_curry3_1_app:
	.cfi_startproc
.L152:
	movq	%rax, %rdx
	movq	%rbx, %rcx
	movq	32(%rdi), %rsi
	movq	24(%rdi), %rax
	movq	16(%rsi), %r8
	movq	%rdx, %rbx
	movq	%rcx, %rdi
	jmp	*%r8
	.cfi_endproc
	.type caml_curry3_1_app,@function
	.size caml_curry3_1_app,. - caml_curry3_1_app
	.text
	.align	16
	.globl	caml_curry3_1
caml_curry3_1:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L155:
	subq	$40, %r15
	cmpq	8(%r14), %r15
	jb	.L156
.L158:
	leaq	8(%r15), %rdi
	movq	$4343, -8(%rdi)
	movq	caml_curry3_2@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$72057594037927941, %rsi
	movq	%rsi, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rbx, 24(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L156:
	call	caml_call_gc@PLT
.L157:
	jmp	.L158
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry3_1,@function
	.size caml_curry3_1,. - caml_curry3_1
	.text
	.align	16
	.globl	caml_curry3_2
caml_curry3_2:
	.cfi_startproc
.L161:
	movq	%rax, %rdi
	movq	24(%rbx), %rax
	movq	32(%rax), %rsi
	movq	16(%rbx), %rbx
	movq	24(%rax), %rax
	movq	16(%rsi), %rdx
	jmp	*%rdx
	.cfi_endproc
	.type caml_curry3_2,@function
	.size caml_curry3_2,. - caml_curry3_2
	.text
	.align	16
	.globl	caml_curry2
caml_curry2:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L164:
	subq	$40, %r15
	cmpq	8(%r14), %r15
	jb	.L165
.L167:
	leaq	8(%r15), %rdi
	movq	$4343, -8(%rdi)
	movq	caml_curry2_1@GOTPCREL(%rip), %rsi
	movq	%rsi, (%rdi)
	movabsq	$72057594037927941, %rsi
	movq	%rsi, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rbx, 24(%rdi)
	movq	%rdi, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L165:
	call	caml_call_gc@PLT
.L166:
	jmp	.L167
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_curry2,@function
	.size caml_curry2,. - caml_curry2
	.text
	.align	16
	.globl	caml_curry2_1
caml_curry2_1:
	.cfi_startproc
.L170:
	movq	%rax, %rsi
	movq	24(%rbx), %rdi
	movq	16(%rbx), %rax
	movq	16(%rdi), %rdx
	movq	%rsi, %rbx
	jmp	*%rdx
	.cfi_endproc
	.type caml_curry2_1,@function
	.size caml_curry2_1,. - caml_curry2_1
	.text
	.align	16
	.globl	caml_apply3
caml_apply3:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_adjust_cfa_offset 24
.L176:
	movq	8(%rsi), %rdx
	sarq	$56, %rdx
	cmpq	$3, %rdx
	jne	.L175
	movq	16(%rsi), %rdx
	addq	$24, %rsp
	.cfi_adjust_cfa_offset -24
	jmp	*%rdx
	.cfi_adjust_cfa_offset 24
	.align	4
.L175:
	movq	%rdi, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	(%rsi), %rdi
	movq	%rsi, %rbx
	call	*%rdi
.L177:
	movq	%rax, %rbx
	movq	(%rbx), %rdi
	movq	(%rsp), %rax
	call	*%rdi
.L178:
	movq	%rax, %rbx
	movq	(%rbx), %rdi
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_adjust_cfa_offset -24
	jmp	*%rdi
	.cfi_adjust_cfa_offset 24
	.cfi_adjust_cfa_offset -24
	.cfi_endproc
	.type caml_apply3,@function
	.size caml_apply3,. - caml_apply3
	.text
	.align	16
	.globl	caml_apply2
caml_apply2:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
.L184:
	movq	8(%rdi), %rsi
	sarq	$56, %rsi
	cmpq	$2, %rsi
	jne	.L183
	movq	16(%rdi), %rsi
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	*%rsi
	.cfi_adjust_cfa_offset 8
	.align	4
.L183:
	movq	%rbx, (%rsp)
	movq	(%rdi), %rsi
	movq	%rdi, %rbx
	call	*%rsi
.L185:
	movq	%rax, %rbx
	movq	(%rbx), %rdi
	movq	(%rsp), %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	*%rdi
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
	.cfi_endproc
	.type caml_apply2,@function
	.size caml_apply2,. - caml_apply2
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Out_of_memory
caml_exn_Out_of_memory:
	.quad	caml_startup__3
	.quad	-1
	.quad	3068
caml_startup__3:
	.ascii	"Out_of_memory"
	.space	2
	.byte	2
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Sys_error
caml_exn_Sys_error:
	.quad	caml_startup__4
	.quad	-3
	.quad	3068
caml_startup__4:
	.ascii	"Sys_error"
	.space	6
	.byte	6
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Failure
caml_exn_Failure:
	.quad	caml_startup__5
	.quad	-5
	.quad	2044
caml_startup__5:
	.ascii	"Failure"
	.byte	0
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Invalid_argument
caml_exn_Invalid_argument:
	.quad	caml_startup__6
	.quad	-7
	.quad	4092
caml_startup__6:
	.ascii	"Invalid_argument"
	.space	7
	.byte	7
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_End_of_file
caml_exn_End_of_file:
	.quad	caml_startup__7
	.quad	-9
	.quad	3068
caml_startup__7:
	.ascii	"End_of_file"
	.space	4
	.byte	4
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Division_by_zero
caml_exn_Division_by_zero:
	.quad	caml_startup__8
	.quad	-11
	.quad	4092
caml_startup__8:
	.ascii	"Division_by_zero"
	.space	7
	.byte	7
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Not_found
caml_exn_Not_found:
	.quad	caml_startup__9
	.quad	-13
	.quad	3068
caml_startup__9:
	.ascii	"Not_found"
	.space	6
	.byte	6
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Match_failure
caml_exn_Match_failure:
	.quad	caml_startup__10
	.quad	-15
	.quad	3068
caml_startup__10:
	.ascii	"Match_failure"
	.space	2
	.byte	2
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Stack_overflow
caml_exn_Stack_overflow:
	.quad	caml_startup__11
	.quad	-17
	.quad	3068
caml_startup__11:
	.ascii	"Stack_overflow"
	.space	1
	.byte	1
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Sys_blocked_io
caml_exn_Sys_blocked_io:
	.quad	caml_startup__12
	.quad	-19
	.quad	3068
caml_startup__12:
	.ascii	"Sys_blocked_io"
	.space	1
	.byte	1
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Assert_failure
caml_exn_Assert_failure:
	.quad	caml_startup__13
	.quad	-21
	.quad	3068
caml_startup__13:
	.ascii	"Assert_failure"
	.space	1
	.byte	1
	.data
	.align	8
	.quad	3064
	.globl	caml_exn_Undefined_recursive_module
caml_exn_Undefined_recursive_module:
	.quad	caml_startup__14
	.quad	-23
	.quad	5116
caml_startup__14:
	.ascii	"Undefined_recursive_module"
	.space	5
	.byte	5
	.data
	.align	8
	.globl	caml_globals
caml_globals:
	.quad	camlCamlinternalFormatBasics__gc_roots
	.quad	camlCamlinternalAtomic__gc_roots
	.quad	camlStdlib__gc_roots
	.quad	camlTest1__gc_roots
	.quad	camlStd_exit__gc_roots
	.quad	0
	.data
	.align	8
	.quad	180220
	.globl	caml_globals_map
caml_globals_map:
	.ascii	"\204\225\246\276\0\0\5]\0\0\0\315\0\0\3n\0\0\2\355\240\300.Stdlib__Buffer@@@\240\300,Stdlib__Weak@@@\240\300\61Stdlib__StdLabels@@@\240\300\62Stdlib__Pervasives@@@\240\300.Stdlib__Format@@@\240\300-Stdlib__Int64@@@\240\300*Stdlib__Gc@@@\240\300\63Stdlib__ArrayLabels@@@\240\300,Stdlib__Unit@@@\240\300\60Stdlib__Bigarray@@@\240\300+Stdlib__Map@@@\240\300/Stdlib__Parsing@@@\240\300.Stdlib__String@@@\240\300\64Stdlib__StringLabels@@@\240\300.Stdlib__Atomic@@@\240\300\62Stdlib__ListLabels@@@\240\300\63Stdlib__BytesLabels@@@\240\300+Stdlib__Seq@@@\240\300.Stdlib__Genlex@@@\240\300-Stdlib__Uchar@@@\240\300\60Stdlib__Filename@@@\240\300+Stdlib__Arg@@@\240\300-Stdlib__Scanf@@@\240\300\60Stdlib__Printexc@@@\240\300.Stdlib__Either@@@\240\300\60Stdlib__Callback@@@\240\300.Stdlib__Lexing@@@\240\300.Stdlib__Printf@@@\240\300+Stdlib__Int@@@\240\300,Stdlib__Bool@@@\240\300\62Stdlib__MoreLabels@@@\240\300-Stdlib__Array@@@\240\300+Stdlib__Obj@@@\240\300/Stdlib__Hashtbl@@@\240\300.Stdlib__Option@@@\240\300.Stdlib__Digest@@@\240\300-Stdlib__Queue@@@\240\300-Stdlib__Stack@@@\240\300+Stdlib__Set@@@\240\300/Stdlib__Complex@@@\240\300\61Stdlib__Nativeint@@@\240\300,Stdlib__Lazy@@@\240\300.Stdlib__Random@@@\240\300+Stdlib__Sys@@@\240\300-Stdlib__Bytes@@@\240\300-Stdlib__Int32@@@\240\300*Stdlib__Oo@@@\240\300/Stdlib__Marshal@@@\240\300,Stdlib__List@@@\240\300\61Stdlib__Ephemeron@@@\240\300-Stdlib__Float@@@\240\300+Stdlib__Fun@@@\240\300.Stdlib__Stream@@@\240\300.Stdlib__Result@@@\240\300,Stdlib__Char@@@\240\300\70CamlinternalFormatBasics\220\60\244\134%\30:\333\25\37\303\4\375\276beD\335\220\60\220*\35\134\205\60)v\257\33Rs\341\227\33\13\240\4\6@\240\300\62CamlinternalAtomic\220\60`R\334V\356\200v\247\42E\231l\205D\2\271\220\60P~1\321\223\32`\354nr\216\330\66\13\217\270\240\4\6@\240\300&Stdlib\220\60/\323Fe\303\231\305\326\0\270\354S\35\216\226h\220\60\300\20@\222\177\221\62\311h\331T\21w\216.\373\240\4\6@\240\300%Test1\220\60\345\355K\23z\5\311\312\371\373\71\256,yh[\220\60\26\177/\231\256\231\220f<\240\341y\5b]-\240\4\6@\240\300(Std_exit\220\60\270\310-\212\21\14\301R4\23|\236\215R\244y\220\60\200\336}\14\304!\241\311\345\23\327\67V/j\23\240\4\6@@"
	.space	6
	.byte	6
	.data
	.align	8
	.globl	caml_data_segments
caml_data_segments:
	.quad	caml_startup__data_begin
	.quad	caml_startup__data_end
	.quad	camlCamlinternalFormatBasics__data_begin
	.quad	camlCamlinternalFormatBasics__data_end
	.quad	camlCamlinternalAtomic__data_begin
	.quad	camlCamlinternalAtomic__data_end
	.quad	camlStdlib__data_begin
	.quad	camlStdlib__data_end
	.quad	camlTest1__data_begin
	.quad	camlTest1__data_end
	.quad	camlStd_exit__data_begin
	.quad	camlStd_exit__data_end
	.quad	0
	.data
	.align	8
	.globl	caml_code_segments
caml_code_segments:
	.quad	caml_startup__code_begin
	.quad	caml_startup__code_end
	.quad	camlCamlinternalFormatBasics__code_begin
	.quad	camlCamlinternalFormatBasics__code_end
	.quad	camlCamlinternalAtomic__code_begin
	.quad	camlCamlinternalAtomic__code_end
	.quad	camlStdlib__code_begin
	.quad	camlStdlib__code_end
	.quad	camlTest1__code_begin
	.quad	camlTest1__code_end
	.quad	camlStd_exit__code_begin
	.quad	camlStd_exit__code_end
	.quad	0
	.data
	.align	8
	.globl	caml_frametable
caml_frametable:
	.quad	caml_startup__frametable
	.quad	caml_system__frametable
	.quad	camlCamlinternalFormatBasics__frametable
	.quad	camlCamlinternalAtomic__frametable
	.quad	camlStdlib__frametable
	.quad	camlTest1__frametable
	.quad	camlStd_exit__frametable
	.quad	0
	.text
	.globl	caml_startup__code_end
caml_startup__code_end:
	.data
				/* relocation table start */
	.align	8
				/* relocation table end */
	.data
	.quad	0
	.globl	caml_startup__data_end
caml_startup__data_end:
	.quad	0
	.align	8
	.globl	caml_startup__frametable
caml_startup__frametable:
	.quad	14
	.quad	.L185
	.word	16
	.word	1
	.word	0
	.align	8
	.quad	.L178
	.word	32
	.word	1
	.word	8
	.align	8
	.quad	.L177
	.word	32
	.word	2
	.word	0
	.word	8
	.align	8
	.quad	.L166
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	3
	.align	8
	.quad	.L157
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	3
	.align	8
	.quad	.L148
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	4
	.align	8
	.quad	.L139
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	3
	.align	8
	.quad	.L130
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	4
	.align	8
	.quad	.L121
	.word	18
	.word	2
	.word	1
	.word	3
	.byte	1
	.byte	4
	.align	8
	.quad	.L116
	.word	16
	.word	0
	.align	8
	.quad	.L115
	.word	16
	.word	0
	.align	8
	.quad	.L114
	.word	16
	.word	0
	.align	8
	.quad	.L113
	.word	16
	.word	0
	.align	8
	.quad	.L112
	.word	16
	.word	0
	.align	8
	.align	8
	.size caml_startup__frametable,. - caml_startup__frametable
	.section .note.GNU-stack,"",%progbits
