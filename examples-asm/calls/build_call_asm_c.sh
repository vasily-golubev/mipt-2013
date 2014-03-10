#!/bin/sh
# Run: ./build_call_asm_c.sh
# 1 step - produce object file with our external function and array.
gcc -g -m32 -c call_asm_c.c
# 2 step - produce binary file using asm source + object file.
gcc -g -m32 call_asm_c.o call_asm_c.s -o call_asm_c
# remove object file.
rm call_asm_c.o
