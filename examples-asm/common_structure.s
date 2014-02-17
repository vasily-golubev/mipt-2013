//	Data section. May contains initialized, unitialized data with labels.	
	.data
//	Code section. May contains instructions.
	.text
//	Export name "main" for visibility from other files.
	.globl	main
//	Point of entrance in program.
main:
//	Prolog. It is useful to save current ESP in EBP to
//	have simple access to arguments of function.
	pushl	%ebp
	movl	%esp, %ebp

//	At the end of function we must restore stack to obtain correct EIP.
	movl	%ebp, %esp
	popl	%ebp
	ret
