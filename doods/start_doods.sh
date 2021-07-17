#!/bin/bash
# Start Dedicated Outside Object Detection Service
# https://hub.docker.com/r/snowzach/doods

# pull latest doods image
docker pull snowzach/doods:latest

# doods.cam_front
docker run -p 8080:8080 --name doods_front --detach snowzach/doods:latest
# doods.cam_back
docker run -p 8081:8080 --name doods_back --detach snowzach/doods:latest
# doods.cam_hall
docker run -p 8082:8080 --name doods_hall --detach snowzach/doods:latest
