#!/bin/bash
bin="./task"

for dir in */ ; do
	cd $dir + "/cw/"
	# Test task 2.
	gcc -m32 task_2.s -o task
	#$bin
	#if $bin; then
#		echo "WORKS!"
#	fi
#	rm $bin
	cd ../..
done
