#!/bin/bash
LOG=logs/doods.log

# Pull latest image
sudo docker pull snowzach/doods

# Restart doods containers
echo "[$(date +%F_%T)] - Restarting  doods service" >> $LOG
# Stop containers
echo "[$(date +%F_%T)] - Stopping  doods containers . . ." >> $LOG
# doods.cam_front
sudo docker stop doods_front && sudo docker rm doods_front >> $LOG
# doods.cam_back
sudo docker stop doods_back && sudo docker rm doods_back >> $LOG
# doods.cam_hall
sudo docker stop doods_hall && sudo docker rm doods_hall >> $LOG

# Restart docker service
sudo systemctl restart docker.service >> $LOG

# Start containers
echo "[$(date +%F_%T)] - Starting doods containers . . . " >> $LOG
# doods.cam_front
sudo docker run -p 8080:8080 --name doods_front --detach snowzach/doods:latest >> $LOG
# doods.cam_back
sudo docker run -p 8081:8080 --name doods_back --detach snowzach/doods:latest >> $LOG
# doods.cam_hall
sudo docker run -p 8082:8080 --name doods_hall --detach snowzach/doods:latest >> $LOG

echo "---------------------------------------------------" >> $LOG
