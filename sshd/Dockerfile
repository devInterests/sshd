ARG rootPassword=No_Root_Access_To_SSH_Deamon_Allowed
ARG sshUser=provideUser
ARG sshUserPassword=providePassowrd

FROM alpine:latest
LABEL maintainer "NOBODY"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

ARG rootPassword
ARG sshUser
ARG sshUserPassword

RUN apk add --no-cache bash openssh \
  # Allow just a one user to make a ssh login 
  && sed -i "/#Port 22/i AllowUsers ${sshUser}" /etc/ssh/sshd_config \
  # Use ssh version 2
  && sed -i "/#Port 22/i Protocol 2" /etc/ssh/sshd_config \
  # Do not allow root user to login
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config \
  #  Maximum login attempts per connection
  && sed -i s/#MaxAuthTries.*/MaxAuthTries\ 4/ /etc/ssh/sshd_config \
  # Number of unauthenticated connections before start dropping
  && sed -i s/#MaxStartups.*/MaxStartups\ 2/ /etc/ssh/sshd_config \
  # Sets a time limit for the user authentication process
  && sed -i s/#LoginGraceTime.*/LoginGraceTime\ 30s/ /etc/ssh/sshd_config \
  # Set root password
  && echo "root:${rootPassword}" | chpasswd \
  # Remove root user
  && passwd -d root \
  # Add ssh user
  && adduser -D -s /bin/ash ${sshUser} \
  # Set ssh users password
  && echo "${sshUser}:${sshUserPassword}" | chpasswd \
  # Add rights to home directory
  && chown -R ${sshUser}:${sshUser} /home/${sshUser} \
  # Generate all host keys
  && ssh-keygen -A \
  # Create a new 4096 byte rsa host key without passphrase
  && yes | ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -P ""