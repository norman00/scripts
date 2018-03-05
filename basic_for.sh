#!/bin/bash
#list all components

APPS_LIST=$(argo component list phx --format csv | grep -v "name,longname" | awk -F "," '{print $1}')
echo "Starting bulk update of Ready_DR flag to True on phx..."

# iterate every component from the list and execute argo command

for x in ${APPS_LIST}; do
    argo component metadata put phx $x Ready_DR True
done
echo "...Completed !!!"
