//	We wrote my_extern_sub with prototype: int my_extern_sub(int a, int b)
//	that returns b - a.
	.text
	.globl	my_extern_sub
my_extern_sub:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	popl	%ebx
	
	movl	%ebp, %esp
	popl	%ebp
	ret
