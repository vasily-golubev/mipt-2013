//	Useful info: В.И. Юров "Assembler 2е издание" с. 447 - 508.
//	http://ru.wikipedia.org/wiki/Число_одинарной_точности

//	There are 8 floating point registers st0..st7 (each 80 bits). They are
//	placed as a stack. We can work with this stack and registers only with
//	special instructions.

	.data
//	We can use .float (s) or .single (32 bits), .double (l) (64 bits), .tfloat (t) (80 bits)
//	to specify input of float data.
val:
	.double 32.75
//	.float	32.75
//	In memory it is equal to 0x42030000 = 0|10000100|00000110000000000000000.
//	A = (-1)^s * 2 ^(q - 127) * M. s = 0 (+), q = 10000100 = 132, M = 1 + 1/32 * [1/2 + 1/4].
//	For double: q - 1023, q (11), M(63 + 1).
a:
	.float	1.2
b:
	.float	2.3
val_for_comparison:
	.float	0.4
val_reference:
	.float	0.5
printf_str:
	.string "%f\n"
t_equal:
	.string	"Equal\n"
t_lower:
	.string	"Lower\n"
t_greater:
	.string	"Greater\n"
	.globl main
	.text
main:
	pushl	%ebp
	movl	%esp, %ebp

//	Load and store values.
	subl	$8, %esp
//	According to the convention there are modifiers for commands (s = .single or .float,
//	l = .double, t = .tfloat).

//	Initialize device.
	finit
//	Load in st(0) from memory.
	fldl	val
	//fldl	val
	//faddp
//	Store from st(0) in memory and pop.
	fstpl	(%esp)
//	Waited by processor.
	wait

//	Print argument is always double.
	pushl	$printf_str
	call	printf
	addl	$12, %esp

//	Add/sub/mul/div of two values.
//	gdb info all-registers
	flds	a
	flds	b
	faddp
//	Load 0.
	fldz
	fsubp
//	Load 1.
	fld1
	fmulp
//	Load PI.
	fldpi
	fdivp


	flds	val_reference
//	Example of comparison and using the result of it.
	fcoms	val_for_comparison
//	Now C3, C2, C0 at SWR = 
//	1. 000 if ST(0) > val_for_comparison
//	2. 001 if ST(0) < val_for_comparison
//	3. 100 if ST(0) = val_for_comparison

//	Save SWR register in register.
	fstsw	%ax
//	Make the situation when CF=C0, PF=C2, ZF=C3.
	sahf
//	Test the result of comparison.
	jnc	l_greater_or_equal
	pushl	$t_lower
	jmp	l_res_of_comp
l_greater_or_equal:
	jz	l_equal
	pushl	$t_greater
	jmp	l_res_of_comp
l_equal:
	pushl	$t_equal
l_res_of_comp:
	call	printf
	addl	$4, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret
