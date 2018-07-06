.org 0x8200

	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_boot2                  ## -- Begin function boot2
	.p2align	4, 0x90
_boot2:                                 ## @boot2
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi0:
	.cfi_def_cfa_offset 8
Lcfi1:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi2:
	.cfi_def_cfa_register %ebp
	pushl	%edi
	pushl	%esi
	subl	$272, %esp              ## imm = 0x110
Lcfi3:
	.cfi_offset %esi, -16
Lcfi4:
	.cfi_offset %edi, -12
	xorl	%eax, %eax
	movl	$10, %ecx
	movl	$50, %edx
	movl	$15, %esi
	movl	$0, (%esp)
	movl	$10, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	movl	%ecx, -24(%ebp)         ## 4-byte Spill
	movl	%edx, -28(%ebp)         ## 4-byte Spill
	movl	%esi, -32(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$1, %ecx
	movl	$20, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$1, (%esp)
	movl	$20, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, -40(%ebp)         ## 4-byte Spill
	movl	%edx, -44(%ebp)         ## 4-byte Spill
	movl	%esi, -48(%ebp)         ## 4-byte Spill
	movl	%edi, -52(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$2, %ecx
	movl	$30, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$2, (%esp)
	movl	$30, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -56(%ebp)         ## 4-byte Spill
	movl	%ecx, -60(%ebp)         ## 4-byte Spill
	movl	%edx, -64(%ebp)         ## 4-byte Spill
	movl	%esi, -68(%ebp)         ## 4-byte Spill
	movl	%edi, -72(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$3, %ecx
	movl	$40, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$3, (%esp)
	movl	$40, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -76(%ebp)         ## 4-byte Spill
	movl	%ecx, -80(%ebp)         ## 4-byte Spill
	movl	%edx, -84(%ebp)         ## 4-byte Spill
	movl	%esi, -88(%ebp)         ## 4-byte Spill
	movl	%edi, -92(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$4, %ecx
	movl	$50, %edx
	movl	$15, %esi
	movl	$4, (%esp)
	movl	$50, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -96(%ebp)         ## 4-byte Spill
	movl	%ecx, -100(%ebp)        ## 4-byte Spill
	movl	%edx, -104(%ebp)        ## 4-byte Spill
	movl	%esi, -108(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$5, %ecx
	movl	$60, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$5, (%esp)
	movl	$60, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -112(%ebp)        ## 4-byte Spill
	movl	%ecx, -116(%ebp)        ## 4-byte Spill
	movl	%edx, -120(%ebp)        ## 4-byte Spill
	movl	%esi, -124(%ebp)        ## 4-byte Spill
	movl	%edi, -128(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$6, %ecx
	movl	$70, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$6, (%esp)
	movl	$70, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -132(%ebp)        ## 4-byte Spill
	movl	%ecx, -136(%ebp)        ## 4-byte Spill
	movl	%edx, -140(%ebp)        ## 4-byte Spill
	movl	%esi, -144(%ebp)        ## 4-byte Spill
	movl	%edi, -148(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$7, %ecx
	movl	$80, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$7, (%esp)
	movl	$80, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -152(%ebp)        ## 4-byte Spill
	movl	%ecx, -156(%ebp)        ## 4-byte Spill
	movl	%edx, -160(%ebp)        ## 4-byte Spill
	movl	%esi, -164(%ebp)        ## 4-byte Spill
	movl	%edi, -168(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$8, %ecx
	movl	$90, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$8, (%esp)
	movl	$90, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -172(%ebp)        ## 4-byte Spill
	movl	%ecx, -176(%ebp)        ## 4-byte Spill
	movl	%edx, -180(%ebp)        ## 4-byte Spill
	movl	%esi, -184(%ebp)        ## 4-byte Spill
	movl	%edi, -188(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$9, %ecx
	movl	$110, %edx
	movl	$50, %esi
	movl	$15, %edi
	movl	$9, (%esp)
	movl	$110, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -192(%ebp)        ## 4-byte Spill
	movl	%ecx, -196(%ebp)        ## 4-byte Spill
	movl	%edx, -200(%ebp)        ## 4-byte Spill
	movl	%esi, -204(%ebp)        ## 4-byte Spill
	movl	%edi, -208(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$96, %ecx
	movl	$96, (%esp)
	movl	%eax, -212(%ebp)        ## 4-byte Spill
	movl	%ecx, -216(%ebp)        ## 4-byte Spill
	calll	_in8
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$128, %eax
	cmpl	$0, %eax
	je	LBB0_2
## BB#1:
	movl	$1, %eax
	movl	$100, %ecx
	movl	$50, %edx
	movl	$15, %esi
	movl	$1, (%esp)
	movl	$100, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -220(%ebp)        ## 4-byte Spill
	movl	%ecx, -224(%ebp)        ## 4-byte Spill
	movl	%edx, -228(%ebp)        ## 4-byte Spill
	movl	%esi, -232(%ebp)        ## 4-byte Spill
	calll	_print
	movl	%eax, -236(%ebp)        ## 4-byte Spill
	jmp	LBB0_3
LBB0_2:
	xorl	%eax, %eax
	movl	$100, %ecx
	movl	$50, %edx
	movl	$15, %esi
	movl	$0, (%esp)
	movl	$100, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -240(%ebp)        ## 4-byte Spill
	movl	%ecx, -244(%ebp)        ## 4-byte Spill
	movl	%edx, -248(%ebp)        ## 4-byte Spill
	movl	%esi, -252(%ebp)        ## 4-byte Spill
	calll	_print
	movl	%eax, -256(%ebp)        ## 4-byte Spill
LBB0_3:
	movl	-12(%ebp), %eax
	andl	$127, %eax
	movl	%eax, -16(%ebp)
	calll	_halt
	movl	%eax, -260(%ebp)        ## 4-byte Spill
	addl	$272, %esp              ## imm = 0x110
	popl	%esi
	popl	%edi
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_kbd_handler            ## -- Begin function kbd_handler
	.p2align	4, 0x90
_kbd_handler:                           ## @kbd_handler
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi5:
	.cfi_def_cfa_offset 8
Lcfi6:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi7:
	.cfi_def_cfa_register %ebp
	pushl	%esi
	subl	$68, %esp
Lcfi8:
	.cfi_offset %esi, -12
	movl	$32, %eax
	movl	$97, %ecx
	movl	$32, (%esp)
	movl	$97, 4(%esp)
	movl	%eax, -16(%ebp)         ## 4-byte Spill
	movl	%ecx, -20(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$96, %ecx
	movl	$96, (%esp)
	movl	%eax, -24(%ebp)         ## 4-byte Spill
	movl	%ecx, -28(%ebp)         ## 4-byte Spill
	calll	_in8
	xorl	%ecx, %ecx
	movl	$60, %edx
	movl	$14, %esi
	movl	%eax, -12(%ebp)
	movl	_xpos, %eax
	movl	$0, (%esp)
	movl	%eax, 4(%esp)
	movl	$60, 8(%esp)
	movl	$14, 12(%esp)
	movl	%esi, -32(%ebp)         ## 4-byte Spill
	movl	%ecx, -36(%ebp)         ## 4-byte Spill
	movl	%edx, -40(%ebp)         ## 4-byte Spill
	calll	_print
	movl	_xpos, %ecx
	addl	$5, %ecx
	movl	%ecx, _xpos
	movl	-8(%ebp), %ecx
	movl	%eax, -44(%ebp)         ## 4-byte Spill
	movl	%ecx, %eax
	addl	$68, %esp
	popl	%esi
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_register_kbd_handler   ## -- Begin function register_kbd_handler
	.p2align	4, 0x90
_register_kbd_handler:                  ## @register_kbd_handler
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi9:
	.cfi_def_cfa_offset 8
Lcfi10:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi11:
	.cfi_def_cfa_register %ebp
	subl	$56, %esp
	leal	_kbd_handler, %eax
	movl	$32256, %ecx            ## imm = 0x7E00
	movl	%ecx, -8(%ebp)
	movl	-8(%ebp), %ecx
	movl	%eax, (%ecx)
	calll	_sti
	movl	$33, %ecx
	movl	$249, %edx
	movl	$33, (%esp)
	movl	$249, 4(%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	movl	%ecx, -16(%ebp)         ## 4-byte Spill
	movl	%edx, -20(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$161, %ecx
	movl	$255, %edx
	movl	$161, (%esp)
	movl	$255, 4(%esp)
	movl	%eax, -24(%ebp)         ## 4-byte Spill
	movl	%ecx, -28(%ebp)         ## 4-byte Spill
	movl	%edx, -32(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	-4(%ebp), %ecx
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, %eax
	addl	$56, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_print                  ## -- Begin function print
	.p2align	4, 0x90
_print:                                 ## @print
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi12:
	.cfi_def_cfa_offset 8
Lcfi13:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi14:
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$40, %esp
Lcfi15:
	.cfi_offset %esi, -20
Lcfi16:
	.cfi_offset %edi, -16
Lcfi17:
	.cfi_offset %ebx, -12
	movl	20(%ebp), %eax
	movl	16(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	8(%ebp), %esi
	leal	_print.bitmaps, %edi
	movl	$655360, %ebx           ## imm = 0xA0000
	movl	%ebx, -24(%ebp)
	movl	8(%ebp), %ebx
	shll	$2, %ebx
	addl	%ebx, %edi
	movl	%edi, -28(%ebp)
	imull	$320, 16(%ebp), %edi    ## imm = 0x140
	addl	12(%ebp), %edi
	addl	-24(%ebp), %edi
	movl	%edi, -24(%ebp)
	movl	$0, -16(%ebp)
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, -40(%ebp)         ## 4-byte Spill
	movl	%edx, -44(%ebp)         ## 4-byte Spill
	movl	%esi, -48(%ebp)         ## 4-byte Spill
LBB3_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB3_3 Depth 2
	cmpl	$8, -16(%ebp)
	jge	LBB3_10
## BB#2:                                ##   in Loop: Header=BB3_1 Depth=1
	movl	$0, -20(%ebp)
LBB3_3:                                 ##   Parent Loop BB3_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$4, -20(%ebp)
	jge	LBB3_8
## BB#4:                                ##   in Loop: Header=BB3_3 Depth=2
	movl	$128, %eax
	movl	-28(%ebp), %ecx
	movl	-20(%ebp), %edx
	movb	(%ecx,%edx), %bl
	movb	%bl, -29(%ebp)
	movsbl	-29(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%ecx, -52(%ebp)         ## 4-byte Spill
	movl	%edx, %ecx
                                        ## kill: %CL<def> %ECX<kill>
	sarl	%cl, %eax
	movl	-52(%ebp), %edx         ## 4-byte Reload
	andl	%eax, %edx
	cmpl	$0, %edx
	je	LBB3_6
## BB#5:                                ##   in Loop: Header=BB3_3 Depth=2
	movl	20(%ebp), %eax
	movb	%al, %cl
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	movb	%cl, (%eax,%edx)
LBB3_6:                                 ##   in Loop: Header=BB3_3 Depth=2
	jmp	LBB3_7
LBB3_7:                                 ##   in Loop: Header=BB3_3 Depth=2
	movl	-20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -20(%ebp)
	jmp	LBB3_3
LBB3_8:                                 ##   in Loop: Header=BB3_1 Depth=1
	movl	-24(%ebp), %eax
	addl	$320, %eax              ## imm = 0x140
	movl	%eax, -24(%ebp)
## BB#9:                                ##   in Loop: Header=BB3_1 Depth=1
	movl	-16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -16(%ebp)
	jmp	LBB3_1
LBB3_10:
	xorl	%eax, %eax
	addl	$40, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_in8                    ## -- Begin function in8
	.p2align	4, 0x90
_in8:                                   ## @in8
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi18:
	.cfi_def_cfa_offset 8
Lcfi19:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi20:
	.cfi_def_cfa_register %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	## InlineAsm Start
	movl	$0, %eax
	inb	%dx, %al
	## InlineAsm End
	movl	%edx, -4(%ebp)
	movl	-4(%ebp), %edx
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	movl	%edx, %eax
	addl	$8, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_out8                   ## -- Begin function out8
	.p2align	4, 0x90
_out8:                                  ## @out8
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi21:
	.cfi_def_cfa_offset 8
Lcfi22:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi23:
	.cfi_def_cfa_register %ebp
	pushl	%esi
	subl	$8, %esp
Lcfi24:
	.cfi_offset %esi, -12
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	8(%ebp), %edx
	movl	12(%ebp), %esi
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	movl	%esi, %eax
	## InlineAsm Start
	outb	%al, %dx
	## InlineAsm End
	xorl	%eax, %eax
	movl	%ecx, -12(%ebp)         ## 4-byte Spill
	addl	$8, %esp
	popl	%esi
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti                    ## -- Begin function sti
	.p2align	4, 0x90
_sti:                                   ## @sti
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi25:
	.cfi_def_cfa_offset 8
Lcfi26:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi27:
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_cli                    ## -- Begin function cli
	.p2align	4, 0x90
_cli:                                   ## @cli
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi28:
	.cfi_def_cfa_offset 8
Lcfi29:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi30:
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	cli
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_halt                   ## -- Begin function halt
	.p2align	4, 0x90
_halt:                                  ## @halt
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi31:
	.cfi_def_cfa_offset 8
Lcfi32:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi33:
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti_and_halt           ## -- Begin function sti_and_halt
	.p2align	4, 0x90
_sti_and_halt:                          ## @sti_and_halt
	.cfi_startproc
## BB#0:
	pushl	%ebp
Lcfi34:
	.cfi_def_cfa_offset 8
Lcfi35:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi36:
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__data
	.globl	_xpos                   ## @xpos
	.p2align	2
_xpos:
	.long	100                     ## 0x64

_print.bitmaps:                         ## @print.bitmaps
	.ascii	"~\201\201~"
	.ascii	"\000A\377\001"
	.ascii	"a\203\205y"
	.ascii	"B\221\231f"
	.ascii	"\370\b\377\b"
	.ascii	"\361\221\211\217"
	.ascii	"\377\211\211\217"
	.ascii	"\300\200\200\377"
	.ascii	"f\231\231f"
	.ascii	"\360\220\220\377"


.subsections_via_symbols
