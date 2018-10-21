#!/bin/bash

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd
export LD_PRELOAD=/usr/lib/libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group

nohup /usr/sbin/sshd -D > ssh.log 2>&1 &
wetty -p 8080 --sshport $SSHPORT
