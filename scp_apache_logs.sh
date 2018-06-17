#!/bin/bash
#
#       Author: norman00
#         Date: 12/06/2016
#
#  Description: The following script copies apache logs 
#               from 6pm to 9pm to a remote server
#
#               Variables explanation
#
#          LOG: Log name, to be copied to remote server
#           IP: Remote server IP address  
# LOGDIRECTORY: Local directory were apache logs reside
#  TRANSFERLOG: Local file that logs transfer history and status
#            U: Username to make secure copy
#        STORE: Directory on remote server were logs are stored
#
# = = = = = = = = = = = = = = = = = = = = = = = = =
LOG=$(date +"%Y_%m_%d_%H".log)
IP=192.168.56.104
LOGDIRECTORY=/home/erascong/Documents/jail/3pic/logs
TRANSFERLOG=/home/erascong/Documents/jail/3pic/transfer.log
U=operator
STORE=/archive/logs/
/usr/bin/touch $TRANSFERLOG
date >> $TRANSFERLOG
scp $LOGDIRECTORY/$LOG $U@$IP:$STORE && echo $LOG" successfully saved" >> $TRANSFERLOG
# End of script
