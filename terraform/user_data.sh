#!bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo docker pull your-aws-account-id.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
sudo docker run -d -p 80:5000 your-aws-account-id.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest