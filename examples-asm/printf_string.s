	.data
//	Label to the first byte of string.
msg_string:
//	String with the end 0x0.
	.string	"Hello world.\n"
	.text
	.globl	main
main:
//	Prolog. It is useful to save current ESP in EBP to
//	have simple access to arguments of function.
	pushl	%ebp
	movl	%esp, %ebp

//	All C functions retrieve parameters from stack. The order of
//	parameters is revesed. Prototype: int printf(conts char *format, ...);
//	$msg_string is the address of first byte of msg_string.
	pushl	$msg_string
//	Now we call the function. Return value will be placed in eax, or in eax will be
//	placed the pointer to the place of stack with return value. 
	call	printf
//	We need manually to refresh the stack from our parameters.
	addl	$4, %esp

//	At the end of function we must restore stack to obtain EIP.
	movl	%ebp, %esp
	popl	%ebp
	ret
