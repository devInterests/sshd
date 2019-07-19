#!/bin/sh

container_name="container_nas_sshd"
image_name="image_key_sshd"
userName="scpUser"
dockerPort="22"
yes | ssh-keygen -t ed25519 -f ./keys/authorized_keys -C $userName

#Prevent WARNING: UNPROTECTED PRIVATE KEY FILE! 
chmod 600 ./keys/authorized_keys

docker image rmi $image_name
docker build --build-arg sshUser=$userName  -t $image_name .


docker container stop $container_name
docker container rm $container_name

docker container run -d -p $dockerPort:22 --name $container_name $image_name:latest

