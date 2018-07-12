/*
  This file defines the following functions:

  void context_switch(int* old_context, int* new_context)
  void make_thread(int* context, char* stack, void (*func)(int),
                    int arg1, int arg2)

  context must be a pointer to an integer array of size 5.
*/

	.text
	.align 2
	.globl _context_switch
_context_switch:
	movl	4(%esp),%edx	/* %edx <= old context */
	movl	%ebx,  0(%edx)	/* ebx, esp, ebp, esi, and edi are saved. */
	movl	%esp,  4(%edx)
	movl	%ebp,  8(%edx)
	movl	%esi, 12(%edx)
	movl	%edi, 16(%edx)
	movl	8(%esp), %edx	/* %edx <= new context */
	movl	0(%edx), %ebx
	movl	4(%edx), %esp
	movl	8(%edx), %ebp
	movl	12(%edx),%esi
	movl	16(%edx),%edi
	ret

	.text
	.align 2
	.globl _make_thread
_make_thread:
	movl	8(%esp),%edx
	movl	16(%esp),%eax	/* arg1 */
	movl	%eax, -8(%edx)
	movl	20(%esp),%eax	/* arg2 */
	movl	%eax, -4(%edx)
	xorl	%eax, %eax	/* %eax <= 0 */
	movl	%eax, -12(%edx)	/* no more caller function */
	movl	12(%esp), %eax	/* return address */
	movl	%eax, -16(%edx)
	movl	4(%esp), %eax	/* context */
	movl	%edx, 8(%eax)	/* %ebp */
	subl	$16, %edx
	movl	%edx, 4(%eax)	/* %esp */
	ret
