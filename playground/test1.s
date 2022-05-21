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
	.globl	camlTest1__data_begin
camlTest1__data_begin:
	.text
	.globl	camlTest1__code_begin
camlTest1__code_begin:
	.data
	.align	8
	.data
	.align	8
	.quad	3063
camlTest1__2:
	.quad	camlTest1__incr_261
	.quad	0x100000000000005
	.data
	.align	8
	.quad	3063
camlTest1__1:
	.quad	camlTest1__ident_263
	.quad	0x100000000000005
	.data
	.align	8
	.quad	2816
	.globl	camlTest1
camlTest1:
	.quad	1
	.quad	1
	.data
	.align	8
	.globl	camlTest1__gc_roots
camlTest1__gc_roots:
	.quad	camlTest1
	.quad	0
	.text
	.align	16
	.globl	camlTest1__incr_261
camlTest1__incr_261:
	.cfi_startproc
.L102:
	addq	$2, %rax
	ret
	.cfi_endproc
	.type camlTest1__incr_261,@function
	.size camlTest1__incr_261,. - camlTest1__incr_261
	.text
	.align	16
	.globl	camlTest1__ident_263
camlTest1__ident_263:
	.cfi_startproc
.L105:
	ret
	.cfi_endproc
	.type camlTest1__ident_263,@function
	.size camlTest1__ident_263,. - camlTest1__ident_263
	.text
	.align	16
	.globl	camlTest1__entry
camlTest1__entry:
	.cfi_startproc
.L108:
	movq	camlTest1__2@GOTPCREL(%rip), %rax
	movq	camlTest1@GOTPCREL(%rip), %rbx
	movq	%rax, (%rbx)
	movq	camlTest1__1@GOTPCREL(%rip), %rax
	movq	%rax, 8(%rbx)
	movl	$1, %eax
	ret
	.cfi_endproc
	.type camlTest1__entry,@function
	.size camlTest1__entry,. - camlTest1__entry
	.data
	.align	8
	.text
	.globl	camlTest1__code_end
camlTest1__code_end:
	.data
				/* relocation table start */
	.align	8
				/* relocation table end */
	.data
	.quad	0
	.globl	camlTest1__data_end
camlTest1__data_end:
	.quad	0
	.align	8
	.globl	camlTest1__frametable
camlTest1__frametable:
	.quad	0
	.align	8
	.size camlTest1__frametable,. - camlTest1__frametable
	.section .note.GNU-stack,"",%progbits
