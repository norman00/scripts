#!/bin/bash
#
#       Author: norman00
#         Date: 12/06/2016
#
#  Description: The following script shows the errors 500 of apache logs 
#               in the last ten minutes
#
#
# = = = = = = = = = = = = = = = = = = = = = = = = =
# Variables declaration
LOGFILE=/3PIC/access_log-20161127 
COUNTER=0
PDATE=$(date)
while [  $COUNTER -lt 10 ]; do 
     PDATE=$(date --date="$COUNTER min ago" +"%d"/"%b"/"%Y":"%H":"%M")
     awk '{print}' $LOGFILE | grep $PDATE | grep --color -w "500"
     let COUNTER=COUNTER+1
done
