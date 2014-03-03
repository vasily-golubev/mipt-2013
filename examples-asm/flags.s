//	jcc label
//	e - равенство, n - неравенство, g - больше (со знаком), l - меньше (со знаком),
//	a - больше (без знака), b - меньше (без знака).
//	jne - не равно, jmp - перейти в любом случае.
//	Команда сравнения cmp %eax, %ebx. Она выполняет %ebx - %eax и устанавливает флаги.
//	Результат нигде не сохраняется!
//	Регист eflags: cf - флаг переноса, zf - флаг нуля, of - флаг переполнения, df - флаг направления.
	.data
var_1:
	.long	20
var_2:
	.long	10
str_equal:
	.string	"Equal.\n"
str_less:
	.string	"Less.\n"
str_more:
	.string	"More.\n"
	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	movl	(var_1), %eax
	movl	(var_2), %ebx
	cmpl	%eax, %ebx
	je	l_equal
	jg	l_more
l_less:
	pushl	$str_less
	jmp	l_printf
l_more:
	pushl	$str_more
	jmp	l_printf
l_equal:
	pushl	$str_equal
l_printf:
	call	printf
	addl	$4, %esp
	movl	%ebp, %esp
	popl	%ebp
	ret
