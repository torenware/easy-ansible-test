FROM mmumshad/ubuntu-ssh-enabled

RUN mkdir -p /var/run/sshd; apt-get update; apt-get install -y python

