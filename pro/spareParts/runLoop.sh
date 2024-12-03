#!/bin/bash

#call run.sh with key to allow no stop for approval
command="run.sh runLoop"

#delay in seconds
delay="30"

#quit loop on entry of q
quit=n

while [[ "$quit" != "q" ]]; do

    #if no pid
    if ! ps -p $pid &>/dev/null ; then
        echo "runLoop will check cassettes and start a new run if needed."
        #call, push, get pid
        ./$command &
        pid=$!
    else
        echo "the command is already running"
    fi

    echo ""
    echo "runLoop is running..."
    echo "To exit press 'q',[enter]"
    read -t ${delay} quit

done
