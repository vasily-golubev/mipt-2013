#include <stdio.h>

int main() {
	#pragma omp parallel
	{
		printf("Hello, world!\n");
		// Switch on and show race condition.
		//printf("Bye, world!\n");
	}
	return 0;
}
