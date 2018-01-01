#!/bin/sh

image_name="sshd_keys"
container_name="sshd_keys"
userName="user"
dockerPort="22"

#Build

#Create key to be used
ssh-keygen -t ed25519 -f ./keys/authorized_keys -C $userName

#Prevent WARNING: UNPROTECTED PRIVATE KEY FILE! 
chmod 600 ./keys/authorized_keys

docker image rmi $image_name
docker build --build-arg sshUser=$user -t $image_name .

#Restart

docker container stop $container_name
docker container rm $container_name

docker container run -d -p $dockerPort:22 --name $container_name $image_name:latest