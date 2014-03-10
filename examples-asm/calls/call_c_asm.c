#include <stdio.h>
int main() {
	int a = 10;
	int b = -20;
	// We know the prototype of my_extern_sub, so we can call it.
	printf("Result of (b - a) using my_extern_sub = %d\n", my_extern_sub(a, b));
	return 0;
}
