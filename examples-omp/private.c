#include <stdio.h>

int main() {
	int ind = 0;
	double sum = 777; // Right now it looks like shared variable.
	double src[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	#pragma omp parallel private (sum) // And here sum is private values.
	{
		sum = 0; // Don't use without initialization.
		#pragma omp for
		for (ind = 0; ind < 10; ind++)
		{
			sum += src[ind];
		}
		printf("Sum = %f\n", sum);
	}
	printf("Sum = %f\n", sum);
	return 0;
}
