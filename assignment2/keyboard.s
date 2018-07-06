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
	subl	$160, %esp
Lcfi3:
	.cfi_offset %esi, -16
Lcfi4:
	.cfi_offset %edi, -12
	calll	_register_kbd_handler
	movl	$0, -12(%ebp)
	movl	%eax, -20(%ebp)         ## 4-byte Spill
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	calll	_cli
	cmpl	$0, _myEventFlag
	movl	%eax, -24(%ebp)         ## 4-byte Spill
	je	LBB0_6
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	_myValue, %eax
	movl	%eax, -16(%ebp)
	calll	_sti
	movl	$1, %ecx
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$1, (%esp)
	movl	$10, 4(%esp)
	movl	$10, 8(%esp)
	movl	$0, 12(%esp)
	movl	%eax, -28(%ebp)         ## 4-byte Spill
	movl	%ecx, -32(%ebp)         ## 4-byte Spill
	movl	%edx, -36(%ebp)         ## 4-byte Spill
	movl	%esi, -40(%ebp)         ## 4-byte Spill
	calll	_print
	xorl	%ecx, %ecx
	movl	$10, %edx
	movl	$0, (%esp)
	movl	$10, 4(%esp)
	movl	$10, 8(%esp)
	movl	$0, 12(%esp)
	movl	%eax, -44(%ebp)         ## 4-byte Spill
	movl	%ecx, -48(%ebp)         ## 4-byte Spill
	movl	%edx, -52(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$10, %ecx
	movl	$20, %edx
	xorl	%esi, %esi
	movl	-12(%ebp), %edi
	sarl	$4, %edi
	movl	%edi, (%esp)
	movl	$10, 4(%esp)
	movl	$20, 8(%esp)
	movl	$0, 12(%esp)
	movl	%eax, -56(%ebp)         ## 4-byte Spill
	movl	%ecx, -60(%ebp)         ## 4-byte Spill
	movl	%edx, -64(%ebp)         ## 4-byte Spill
	movl	%esi, -68(%ebp)         ## 4-byte Spill
	calll	_print
	movl	$20, %ecx
	xorl	%edx, %edx
	movl	-12(%ebp), %esi
	andl	$15, %esi
	movl	%esi, (%esp)
	movl	$20, 4(%esp)
	movl	$20, 8(%esp)
	movl	$0, 12(%esp)
	movl	%eax, -72(%ebp)         ## 4-byte Spill
	movl	%ecx, -76(%ebp)         ## 4-byte Spill
	movl	%edx, -80(%ebp)         ## 4-byte Spill
	calll	_print
	movl	-16(%ebp), %ecx
	andl	$128, %ecx
	cmpl	$0, %ecx
	movl	%eax, -84(%ebp)         ## 4-byte Spill
	je	LBB0_4
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	$1, %eax
	movl	$10, %ecx
	movl	$15, %edx
	movl	$1, (%esp)
	movl	$10, 4(%esp)
	movl	$10, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -88(%ebp)         ## 4-byte Spill
	movl	%ecx, -92(%ebp)         ## 4-byte Spill
	movl	%edx, -96(%ebp)         ## 4-byte Spill
	calll	_print
	movl	%eax, -100(%ebp)        ## 4-byte Spill
	jmp	LBB0_5
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	xorl	%eax, %eax
	movl	$10, %ecx
	movl	$15, %edx
	movl	$0, (%esp)
	movl	$10, 4(%esp)
	movl	$10, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -104(%ebp)        ## 4-byte Spill
	movl	%ecx, -108(%ebp)        ## 4-byte Spill
	movl	%edx, -112(%ebp)        ## 4-byte Spill
	calll	_print
	movl	%eax, -116(%ebp)        ## 4-byte Spill
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	movl	$10, %eax
	movl	$20, %ecx
	movl	-16(%ebp), %edx
	andl	$127, %edx
	movl	%edx, -12(%ebp)
	movl	-12(%ebp), %edx
	sarl	$4, %edx
	movl	%edx, (%esp)
	movl	$10, 4(%esp)
	movl	$20, 8(%esp)
	movl	$10, 12(%esp)
	movl	%eax, -120(%ebp)        ## 4-byte Spill
	movl	%ecx, -124(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$20, %ecx
	movl	$10, %edx
	movl	-12(%ebp), %esi
	andl	$15, %esi
	movl	%esi, (%esp)
	movl	$20, 4(%esp)
	movl	$20, 8(%esp)
	movl	$10, 12(%esp)
	movl	%eax, -128(%ebp)        ## 4-byte Spill
	movl	%ecx, -132(%ebp)        ## 4-byte Spill
	movl	%edx, -136(%ebp)        ## 4-byte Spill
	calll	_print
	movl	$0, _myEventFlag
	movl	%eax, -140(%ebp)        ## 4-byte Spill
	jmp	LBB0_7
LBB0_6:                                 ##   in Loop: Header=BB0_1 Depth=1
	calll	_sti_and_halt
	movl	%eax, -144(%ebp)        ## 4-byte Spill
LBB0_7:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
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
	subl	$40, %esp
	movl	$32, %eax
	movl	$97, %ecx
	movl	$32, (%esp)
	movl	$97, 4(%esp)
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	movl	%ecx, -12(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$96, %ecx
	movl	$96, (%esp)
	movl	%eax, -16(%ebp)         ## 4-byte Spill
	movl	%ecx, -20(%ebp)         ## 4-byte Spill
	calll	_in8
	movl	%eax, _myValue
	movl	$1, _myEventFlag
	movl	-4(%ebp), %eax
	addl	$40, %esp
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
Lcfi8:
	.cfi_def_cfa_offset 8
Lcfi9:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi10:
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
Lcfi11:
	.cfi_def_cfa_offset 8
Lcfi12:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi13:
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$40, %esp
Lcfi14:
	.cfi_offset %esi, -20
Lcfi15:
	.cfi_offset %edi, -16
Lcfi16:
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
Lcfi17:
	.cfi_def_cfa_offset 8
Lcfi18:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi19:
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
Lcfi20:
	.cfi_def_cfa_offset 8
Lcfi21:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi22:
	.cfi_def_cfa_register %ebp
	pushl	%esi
	subl	$8, %esp
Lcfi23:
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
Lcfi24:
	.cfi_def_cfa_offset 8
Lcfi25:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi26:
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
Lcfi27:
	.cfi_def_cfa_offset 8
Lcfi28:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi29:
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
Lcfi30:
	.cfi_def_cfa_offset 8
Lcfi31:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi32:
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
Lcfi33:
	.cfi_def_cfa_offset 8
Lcfi34:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
Lcfi35:
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
	.globl	_myEventFlag            ## @myEventFlag
.zerofill __DATA,__common,_myEventFlag,4,2
	.globl	_myValue                ## @myValue
.zerofill __DATA,__common,_myValue,4,2
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
	.ascii	"\177\220\220\177"
	.ascii	"\377\221\221n"
	.ascii	"\377\201\201\201"
	.ascii	"\377\201\201~"
	.ascii	"\377\221\221\221"
	.ascii	"\377\220\220\220"


.subsections_via_symbols
