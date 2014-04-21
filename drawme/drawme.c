// Plot 1D array of doubles.
#include "gnuplot_i/src/gnuplot_i.h"
int DM_plot_1d(double *array_x, double *array_y, unsigned int len, char *title) {
	gnuplot_ctrl *h;
	h = gnuplot_init();
	gnuplot_plot_xy(h, array_x, array_y, len, title);
	// FIXME Remove me.
	sleep(2);
	gnuplot_close(h);

	return 0;
}
