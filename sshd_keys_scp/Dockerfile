ARG rootPassword=No_Root_Access_To_SSH_Deamon_Allowed
ARG sshUser=ssh

FROM alpine:latest
LABEL maintainer "NOBODY"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

ARG rootPassword
ARG sshUser

RUN apk add --no-cache bash shadow openssh rssh \
  # Set root password
  && echo "root:${rootPassword}" | chpasswd \
  # Remove root user
  && passwd -d root \
  # Add ssh user
  && adduser -D -s /bin/ash ${sshUser} \
  # Set ssh users password
  && echo "${sshUser}:${sshUser}" | chpasswd \
  # Add rights to home directory
  && chown -R ${sshUser}:${sshUser} /home/${sshUser} \
  # Generate all host keys
  && ssh-keygen -A \
  # Create a new 4096 byte rsa host key without passphrase
  && yes | ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -P "" \
  # set rssh as users login shell
  && chsh -s /usr/bin/rssh ${sshUser}

COPY ./keys/authorized_keys.pub /etc/ssh/authorized_keys
COPY ./sshd_config.conf /etc/ssh/sshd_config
COPY ./rssh.conf /etc/rssh.conf
# Allow just ssh user to make a ssh login 
RUN  sed -i s/#AllowUsers.*/AllowUsers\ ${sshUser}/ /etc/ssh/sshd_config