// We deal with x = [-1, 1].
#include <stdio.h>

#ifdef _OPENMP
#include <omp.h>
#else
#include <time.h>
#endif

int main() {

	#ifdef _OPENMP
	double cpu_time = omp_get_wtime();
	#else
	clock_t cpu_time = clock();
	#endif
	#define N 8000
	double curr[N] = {0, };
	double next[N] = {0, };
	double coords[N] = {0, };
	double etalon[N] = {0, };

	#define Cx 1.0
	#define k 0.5

	unsigned int M = N / Cx / k;
	double h = 2.0 / N;
	double tau = k * h / Cx;

	// Initially fill coordinates of nodes.
	unsigned int ind = 0;
	for (ind = 0; ind < N; ind ++)
		coords[ind] = -1.0 + ind * h;
	// Set intial impulse.
	for (ind = 0; ind < N; ind ++)
		if ((coords[ind] >= -0.5) && (coords[ind] <= 0.5)) {
			curr[ind] = 1.0;
			etalon[ind] = 1.0;
		}
	// Loop along time.	
	unsigned int t = 0;
	for (t = 0; t < M; t++) {
		#pragma omp parallel for
		for (ind = 0; ind < N; ind ++)
			if (0 == t % 2)
				next[ind] = curr[ind] - tau * Cx / h *
					(curr[ind] - curr[ind - 1]);
			else
				curr[ind] = next[ind] - tau * Cx / h *
					(next[ind] - next[ind - 1]);
		// Last step for calculate U[0] == U[N].
		if (0 == t % 2)
			next[0] = curr[0] - tau * Cx / h *
				(curr[0] - curr[N - 1]);
		else
			curr[0] = next[0] - tau * Cx / h *
				(next[0] - next[N - 1]);
		// Plot results for bug-tracking.
		/*if (0 == t % 2)
			DM_plot_1d(coords, next, N, "T % 2 == 0");
		else
			DM_plot_1d(coords, curr, N, "T % 2 != 0");
		*/
	}
	#ifdef _OPENMP
	cpu_time = omp_get_wtime() - cpu_time;
	printf("Elapsed time is %lf seconds.\n", cpu_time);
	#else
	cpu_time = clock() - cpu_time;
	printf("Elapsed time is %ld seconds.\n", cpu_time / CLOCKS_PER_SEC);
	#endif
	if (0 == t % 2)
		DM_plot_1d_etalon(coords, next, etalon, N, "T % 2 == 0", 0);
	else
		DM_plot_1d_etalon(coords, curr, etalon, N, "T % 2 != 0", 0);
	return 0;
}
