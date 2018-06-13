#!/usr/bin/env sh
set -euo pipefail

# set up user and group
getent group ${GROUP} || groupadd -r ${GROUP}
id ${USER} || useradd -rmg ${GROUP} ${USER}
chown -R "${USER}" ${HADOOP_HOME}

# set up SSH auth
ssh-keygen -A && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# start SSH server
/usr/sbin/sshd
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts

# start Hadoop services
${HADOOP_HOME}/sbin/start-dfs.sh

sh "$@"
