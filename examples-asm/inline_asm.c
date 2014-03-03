//      Информация на примере процессора ARM: http://www.ethernut.de/en/documents/arm-inline-asm.html
//      Полезные ссылки: http://www.lysium.de/blog/index.php?/archives/135-Gcc-inline-assembler-howto-summary.html
//      http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html
#include <stdio.h>
//int x = 1;
//int y = 0;

int a[5] = {1, 2, 3, 4, 5};
int N = 5;
int i = 0;
int sum = 0;

//int b = 1;

// Пример записи функции, содержащей inline assembly.
//int IncreaseInt( int val) {
//	asm volatile (
//		"incl	%[res]"
//		: [res] "+m" (val)
//		:
//		: "memory"
//	);
//	return val;
//}

int main() {
        // Пример использования basic inline assembly.
        //asm("movl     %eax, %eax");
        // Эквивалентный вариант, если имя asm уже у вас занято.
        //__asm__("movl %ebx, %ebx");
        // Для исключения этой части кода из оптимизации.
        //asm volatile("movl    %eax, %eax");
        // И так тоже можно.
        //__asm__ __volatile__("movl    %ebx, %ebx");
        // Пример многострочной вставки.
        //asm(
        //      "movl   %eax, %eax\n\t"
        //      "movl   %eax, %eax\n\t"
        //      "movl   %eax, %eax\n\t"
        //      "movl   %eax, %eax"
        //);
        // Общий синтаксис вставки.
        // asm("code" : output operand list : input operand list : clobber list);
        // Реализация y = x.
        //asm(
        //      "movl   %[input], %[output]"
        //      : [output] "=m" (y) // Вывод результата в y, можно сразу в память.
        //      : [input] "r" (x) // Чтение из x в регистр.
        //      : "memory" // Наши действия могут менять данные в памяти, не переставлять!
        //);
        //printf("Now y = %d\n", y);
        // Можно нумеровать просто цифрами, при этом первый output параметр это %0.
        //asm(
        //      "movl   %1, %0"
        //      : "=m" (y) // Вывод результата в y, можно сразу в память.
        //      : "r" (x) // Чтение из x в регистр.
        //      : "memory" // Наши действия могут менять данные в памяти, не переставлять!
        //);
        //printf("Now y = %d\n", y);
        // clobber list может включать: "memory" - память, "cc" - регистр флагов, "имя регистра".
        // Ограничения (constrains) могут включать: "r" - помещать в регистр, "a" - в %eax,
        // "b" - в %ebx, "c" - в %ecx, "d" - в %edx, "S" - в %esi, "D" - в %edi, "m" - в память,
        // "цифра" - переменная и в input и в output, etc.
        // Также применимы идентификаторы "=" - используется только для записи, "&" - будет
        // перезаписан до считывания всех input, "+" - и чтение и запись.
        // Пример y = y + x.
        //asm(
        //      "addl   %[input], %[output]"
        //      : [output] "+r" (y)
        //      : [input] "r" (x)
        //      : "memory"
        //);
        // Пример загрузки константы в регистр.
        //asm(
        //      "movl   $1, %%eax"
        //      :
        //      :
        //      : "%eax"
        //);
        // Пример суммирования элементов массива sum = a1 + a2 + ... + aN.
        for (i = 0; i < N; i++) {
                //sum = sum + a[i];
                asm(
                        "addl   %[a_i], %[res]"
                        : [res] "+r" (sum)
                        : [a_i] "r" (a[i])
                        : "memory"
                );
        }
        //printf("Sum = %d\n", sum);
	// Пример записи макроса с inline assembly.
	//#define DEC_INT(val) \
	//	__asm__ __volatile__ ( \
	//		"decl	%[res]" \
	//		: [res] "+m" (val) \
	//		: \
	//		: "memory" \
	//	);
	//DEC_INT(b);
	// Вызов функции, содержащей inline assembly.
	//printf("Now 2 + 1 = %d\n", IncreaseInt(2));
        return 0;
}
/*      .data
        .globl  main
        .text
main:
        pushl   %ebp
        movl    %esp, %ebp

        movl    %ebp, %esp
        popl    %ebp
        ret
*/

