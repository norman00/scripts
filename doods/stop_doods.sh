#!/bin/bash

# doods.cam_front
# docker run -p 8080:8080 --name doods_front --detach snowzach/doods:latest
docker stop doods_front && docker rm doods_front

# doods.cam_back
#docker run -p 8081:8080 --name doods_back --detach snowzach/doods:latest
docker stop doods_back && docker rm doods_back

# doods.cam_hall
#docker run -p 8082:8080 --name doods_hall --detach snowzach/doods:latest
docker stop doods_hall && docker rm doods_hall
