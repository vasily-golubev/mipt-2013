#!/bin/bash

# Build gnuplot_i sources.
cd ./gnuplot_i
make
cd ..

# Build standalone version.
gcc standalone.c drawme.c gnuplot_i/gnuplot_i.o
