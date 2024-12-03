#!/usr/bin/env bash
#
# usage: ./symLinkToAll.sh file.
file=${1}
here=$(pwd)

#flags error:1, good=0
test -f "${file}"
isFile=$?

iny=$(echo "${here}" | grep "/yew")
# -n not null -z is null
test -n "${iny}"
isIn=$?

#test if path is under yew 
if [ $isFile = 0 ] && [ $isIn = 0 ]; then
	clean=$(basename "${file}") #drop path
	clean=$(echo "${clean%.*}") # drop extension
	ln -sf "${here}/${file}" ~/yew/all/"${clean}"
else
	if [ $isIn != 0 ]; then echo "ALERT: not in yew"; fi
	if [ $isFile != 0 ]; then echo "ALERT: not a file"; fi
fi
