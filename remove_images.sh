#!/bin/bash
#
# Remove unused docker images from list.txt
#
i=1
for image in `awk -F: '{print $1}' list.txt`
do
# replace with docker command
  rm $image && echo "image $image deleted"
done
