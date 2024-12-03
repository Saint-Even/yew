#!/bin/bash

for f in *.md5
do
	echo "checking file integrity:"
	echo $f
	md5sum -c $f
	echo "completed"
	echo
done
