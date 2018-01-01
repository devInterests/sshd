#!/bin/sh

image_name="secure_sshd"
container_name="secure_sshd"
userName="ssh"
usersPassowrd="a"
dockerPort="2222"

docker image rmi $image_name
docker build --build-arg sshUser=$userName --build-arg sshUserPassword=$usersPassowrd -t $image_name .

docker container stop $container_name
docker container rm $container_name

docker container run -d -p $dockerPort:22 --name $container_name $image_name:latest
