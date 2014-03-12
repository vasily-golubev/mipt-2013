#!/bin/bash

# Coloring definitions.
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'

# Useful variables.
origin=$(pwd)
bin="./task"
cw="cw"

# Loop over student's CW folders.
for dir in */ ; do
	# Print title.
	echo -e "${blue}STUDENT: $dir$NC"
	# Safely cd in next student's folder.
	cd $dir$cw 2>/dev/null
	if [ $? -eq 1 ]; then
		#echo -e "\t${red}Failed to enter in $dir$cw${NC}"
		cd $origin
		continue
	fi

	# Loop over student's tasks.
	# FIXME Hardcoded sequence of task's numbers.
	for n in 1 2 3 4 ; do
		# Compile task.
		gcc -m32 task_$n.s -o task 2>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tTASK $n: ${green}COMPILE OK${NC}"
		else
			echo -e "\tTASK $n: ${red}COMPILE FAILED${NC}"
		fi
		# Run task.
		eval $bin 2>/dev/null 1>task.out
		if [ $? -eq 0 ]; then
			echo -e "\t\t${red}RUN OK${NC}"
		else
			echo -e "\t\t${red}RUN FAILED${NC}"
		fi
		# Clean.
		rm $bin 2>/dev/null
		rm task.out 2>/dev/null
	done
	# Return to origin folder.
	cd ../..
done
