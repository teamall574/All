#!/bin/bash
sleep 60
sudo apt-get update -y
sleep 20
sudo curl https://get.docker.com | bash
docker pull mongo 
sudo docker run -d -p 27017:27017 -e username=mongoadmin -e mongo_password=password -e mango_database=test  mongo
docker ps