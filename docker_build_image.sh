
# Docker installation and configuration

#!/bin/bash
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update
sudo apt-get install -y docker-ce
sudo docker run hello-world
# Linux post-install
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# build docker image
#sudo docker build -t dpc .

# login to docker hub account
#cat ~/passwd.txt | sudo docker login --username dennar --password-stdin

#  use the docker tag command to give the image a new name

#sudo docker tag dcp dennar/myapp

# push the image to the image to your docker repository
#sudo docker push dennar/myapp

# start the container to test the image
sudo docker run -dp 8080:80 nginx:latest