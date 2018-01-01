# SSHD
Secure sshd in a docker container.

## SSHD
A ssh server that provides password login for one user.

To build an image provide a user and a password:
```
docker build --build-arg sshUser=john --build-arg sshUserPassword=secret -t sshd .
```

Start the container:
```
docker container run -d -p 22:22 --name secure_sshd sshd:latest
```

See also the build_restart.sh

## SSHD with keys
A ssh server that provides a login just with a key.

Connect
ssh -i keyFile user@hostname -p 22

See the build_restart.sh


## SSHD SCP with keys
A ssh server that provides a login by a key and accepts just scp commands.
See the build_restart.sh
