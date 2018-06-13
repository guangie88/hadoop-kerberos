#!/usr/bin/env bash
set -euo pipefail

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

/etc/init.d/ssh start
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts

$HADOOP_HOME/sbin/start-dfs.sh

bash "$@"
