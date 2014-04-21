#!/bin/bash

# Build gnuplot_i sources.
cd ./gnuplot_i
make
cd ..

# Build standalone version.
gcc standalone.c drawme.c gnuplot_i/gnuplot_i.o -o standalone


# TODO Add -fopenmp as 1st parameter if want.
# Build test (advection).
cd tests
gcc advection.c ../drawme.c ../gnuplot_i/gnuplot_i.o $1 -o advection
cd ..
