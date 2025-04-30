#!bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo docker pull 891377155005.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
sudo docker run -d -p 80:5000 891377155005.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest