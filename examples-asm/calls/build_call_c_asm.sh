#!/bin/sh
# Run: ./build_call_c_asm.sh
# 1 step - produce object file with our external function from asm source.
gcc -g -m32 -c call_c_asm.s
# 2 step - produce binary file using c source + object file.
gcc -g -m32 call_c_asm.o call_c_asm.c -o call_c_asm
# remove object file.
rm call_c_asm.o
