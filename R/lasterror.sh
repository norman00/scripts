#!/bin/bash
# Usage: ./lasterror.sh 
# Version: 2.0

#Declare local variables

logdir="/var/log/httpd/customlogs/"
logfile="$(date +"%Y_%m_%d_%H").log"
oldlogfile="$(date -d "1 hour ago" +"%Y_%m_%d_%H").log"

declare -i currentmin=$((10#$(date +%M)))
declare -i min=10 min1=10
export min min1

# This function filters only the log of the current hour
filterlog () {
	echo "Filtering requests with all HTTP responses with status code 500 within the last 10 min in file $logfile and $oldlogfile" 
	for i in $(seq $min -1 0)
        do
        grep --color -w  "$(/usr/bin/date -d "$i min ago" +"%d/%b/%Y:%H:%M")" $logdir$oldlogfile | egrep --color "\ 500\ "
        grep --color -w  "$(/usr/bin/date -d "$i min ago" +"%d/%b/%Y:%H:%M")" $logdir$logfile | egrep --color "\ 500\ "
	done
	}
# This function filters both logs ( current hour log and the last hour log ) , this function is used  only when the script runs from min 00 until min 09 of any hour. 
filterbothlogs () {
	echo "Filtering requests with all HTTP responses with status code 500 within the last 10 min in file $logfile" 
	for i in $(seq $min1 -1 0)
        do
        grep --color -w  "$(/usr/bin/date -d "$i min ago" +"%d/%b/%Y:%H:%M")" $logdir$logfile /dev/null | egrep --color "\ 500\ "
        done
	}

#This condition runs the script only if it founds log files within the directory variable "logdir".
if [[ (-e $logdir$logfile) && (-e $logdir$oldlogfile) ]]; then 
	if [ $currentmin -lt 10 ]; then
	filterlog 
	else
	filterbothlogs 
	fi
else
echo "There are no log files to filter in this directory"
fi

exit 0 
