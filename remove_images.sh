#!/bin/bash
#
# Remove unused docker images from delete.list
#
# To populate delete.list run:
# $ docker images | awk 'NR>1 {print $3}' > delete.list
# Exclude images if necessary
#
i=1
for image in `awk -F: '{print $1}' delete.list`
  do
    # deleting images
    docker rmi $image
    # test deletion
    # echo "image $image will be deleted"
done
