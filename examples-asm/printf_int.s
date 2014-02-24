	.data
//	Label to the first byte of int.
int_label:
#	.fill	4,4,16 # repeat,size,value
	.long	256
//	Label to the printf format string.
format_string:
	.string	"%d\n"
	.text
	.globl	main
main:
//	Prolog. It is useful to save current ESP in EBP to
//	have simple access to arguments of function.
	pushl	%ebp
	movl	%esp, %ebp

//	All C functions retrieve parameters from stack. The order of
//	parameters is revesed. Prototype: int printf(conts char *format, ...);
//	We place value at address $int_label in stack.
	pushl	int_label
	pushl	$format_string
//	Now we call the function. Return value will be placed in eax, or in eax will be
//	placed the pointer to the place of stack with return value. 
	call	printf
//	We need manually to refresh the stack from our parameters.
	addl	$8, %esp

//	At the end of function we must restore stack to obtain EIP.
	movl	%ebp, %esp
	popl	%ebp
	ret
