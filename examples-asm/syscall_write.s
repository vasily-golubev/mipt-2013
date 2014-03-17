//	Data section. May contains memory allocation.
	.data
start_of_string:
	.string	"Hello world.\n"
length_of_string:
//	. - means current address. -1 = end of string is 0x0.
	.long	. - start_of_string - 1
//	Code section. May contains instructions.
	.text
//	Export name main for visibility from other files.
	.globl	main
//	Point of entrance in program.
main:
//	Prolog. It is useful to save current ESP in EBP to
//	have simple access to arguments of function.
	pushl	%ebp
	movl	%esp, %ebp

//	At /usr/include/asm/unistd_32.h we can indentify the number of syscall.
//	Prototype of syscall can be achieved by: man 2 name_of_syscall.
//	Number of syscal at %eax. All parameters at %ebx, %ecx, etc. in direct order.

	movl	$4, %eax
//	File descriptor of stdout = 1.
	movl	$1, %ebx
//	Address of string.
	movl	$start_of_string, %ecx
//	Number of symbols.
	movl	length_of_string, %edx
//	Call interruption with number 0x80.
	int	$0x80

//	We will not reach this string.

//	At the end of function we must restore stack for obtain EIP.
	movl	%ebp, %esp
	popl	%ebp
	ret
