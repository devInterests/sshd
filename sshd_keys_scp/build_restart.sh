#!/bin/sh

container_name="alex_nas_sshd"
image_name="alex_key_sshd"
userName="backupUser"
dockerPort="22"
yes | ssh-keygen -t ed25519 -f ./keys/authorized_keys -C $userName

#Prevent WARNING: UNPROTECTED PRIVATE KEY FILE! 
chmod 600 ./keys/authorized_keys

docker image rmi $image_name
docker build --build-arg sshUser=$userName  -t $image_name .


docker container stop $container_name
docker container rm $container_name

docker container run -d -p $dockerPort:22 --name $container_name $image_name:latest

