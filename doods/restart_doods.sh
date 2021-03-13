#!/bin/bash
LOG=logs/doods.log

# Restart doods containers
echo "[$(date +%F_%T)] - Restarting  doods service" >> $LOG

# Stop containers
echo "[$(date +%F_%T)] - Stopping  doods containers . . ." >> $LOG
# doods.cam_front
docker stop doods_front && docker rm doods_front >> $LOG
# doods.cam_back
docker stop doods_back && docker rm doods_back >> $LOG
# doods.cam_hall
docker stop doods_hall && docker rm doods_hall >> $LOG

# Restart docker service
sudo systemctl restart docker.service >> $LOG

# Pull latest image
docker pull snowzach/doods

# Start containers
echo "[$(date +%F_%T)] - Starting doods containers . . . " >> $LOG
# doods.cam_front
docker run -p 8080:8080 --name doods_front --detach snowzach/doods:latest >> $LOG
# doods.cam_back
docker run -p 8081:8080 --name doods_back --detach snowzach/doods:latest >> $LOG
# doods.cam_hall
docker run -p 8082:8080 --name doods_hall --detach snowzach/doods:latest >> $LOG

echo "---------------------------------------------------" >> $LOG
