
# Docker installation and configuration

#!/bin/bash
sudo yum update -yum
sudo amazon-linux-extras install docker -y 
sudo service docker start
sudo systemctl enable docker 

# build docker image
sudo docker build -t dpc .

# login to docker hub account
cat ~/mypasswd.txt | sudo docker login --username dennar --password-stdin

#  use the docker tag command to give the image a new name

sudo docker tag dcp dennar/myapp

# push the image to the image to your docker repository
sudo docker push dennar/myapp

# start the container to test the image
sudo docker run -dp 80:80 dennar/myapp