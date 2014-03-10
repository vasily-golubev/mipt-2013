	.data
val_1:
	.long	10
val_2:
	.long	20
printf_format:
	.string	"Sum of 10 and 20 using my_extern_sum = %d\n"	
printf_format_array:
	.string	"The last element of external array is: %d\n"	
	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	val_1
	pushl	val_2
//	We know the prototype of our external function, so we can call it.
	call	my_extern_sum
	addl	$8, %esp

	pushl	%eax
	pushl	$printf_format
	call	printf
	addl	$8, %esp
	
//	We know the length and type of array so we can work with it.
	movl	$2, %eax
	pushl	my_extern_array(, %eax, 4)
	pushl	$printf_format_array
	call	printf
	addl	$8, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret
