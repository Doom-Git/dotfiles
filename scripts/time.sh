#!/usr/bin/bash

timemode=(TESTING WORK WASTED LECTURE LINUX STOP)
mode=$(printf '%s\n' ${timemode[@]} | dmenu -i -l 10 -p 'Timemode: ')

if [ $mode = "STOP" ];
then
	timew stop;
else
	timew start $mode;
fi
