#!/bin/bash
# Usage: ./sendlogs.sh localdirwherelogsresides hostname/IP remotedir 
# Example: ./sendlogs.sh /var/log/httpd/access_logs 192.168.56.102 /logs
# Version: 2.0

#Local variables
localdir=$1
host=$2
destdir=$3

# ssh-agent to do passwordless auth between local server and remote server
eval `/usr/bin/ssh-agent -s` 
/usr/bin/ssh-add

# Function that transfer logs to remote server.
sendlogs () { 

	echo "Sending logs to remote server: $host ....."
	echo "Logs files to copy on $(date):"
        ls -1 $localdir$(date +"%Y_%m_%d_"){18..20}.log
        /usr/bin/scp -i /root/.ssh/id_rsa $localdir$(date +"%Y_%m_%d_"){18..20}.log root@$host:$destdir

	if [ $? -eq 0 ]; then 
	echo "Files copied/synched successfully to remote server $host"
	else
	echo "Log files were not copied/synched successfully to server $host"
	fi

	    }


#This condition evaluates if the script has 3 parameters before it runs.
if [[  ( -f $localdir$(date +"%Y_%m_%d_")18.log ) || ( -f $localdir$(date +"%Y_%m_%d_")19.log ) || ( -f $localdir$(date +"%Y_%m_%d_")20.log ) ]]; then
	if [ $# -lt 3 ]; then 
	echo -e "This script runs olny whith 3 parameters:\n1- Local Directory where logs resides\n2- Remote server\n3- Destination directory on Remote Server\n 
	Usage: ./sendlogs.sh localdirwherelogsresides hostname/IP remotedir\n 
	Example: ./sendlogs.sh /var/log/httpd/access_logs 192.168.56.102 /logs\n"
	else
	sendlogs
	/usr/bin/ssh-agent -k
	fi
else
echo "The are no logs to transfer today in this directory"
fi
exit 0
