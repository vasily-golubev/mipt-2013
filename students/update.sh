#!/bin/bash
cd ..
git submodule update
cd "students"
for dir in */ ; do
	cd $dir
	# Pull latest data from student's repo.
	git submodule update
	git merge origin/master
	cd ..
done
