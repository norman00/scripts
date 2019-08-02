#!/bin/bash

set +x

DOCKER_REGISTRY="url.com/project"
TYPE="image-name image-name2"
DEFAULT="latest"
TAG=${1:-$DEFAULT}
DIR="/path/to/dir"

# This cycle reads files from a directory.

for file in $DIR/*; do
        ls -l $DIR/$(basename "$file")
done
