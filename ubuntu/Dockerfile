FROM ubuntu:bionic

ARG HADOOP_VERS
RUN apt-get update && apt-get install -y curl
RUN curl -SLO http://apache.mirrors.tds.net/hadoop/common/hadoop-${HADOOP_VERS}/hadoop-${HADOOP_VERS}.tar.gz
RUN tar xzf hadoop-${HADOOP_VERS}.tar.gz

ARG HADOOP_HOME=/opt/hadoop
ENV HADOOP_HOME=${HADOOP_HOME}

RUN mv hadoop-${HADOOP_VERS} ${HADOOP_HOME}
RUN apt-get install -y openjdk-8-jdk
RUN echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::')" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
ENV PATH=${HADOOP_HOME}/bin:$PATH

RUN apt-get install -y openssh-server

# ARG USER=hadoop
# USER ${USER}

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

RUN echo "\
<configuration>\n\
    <property>\n\
        <name>fs.defaultFS</name>\n\
        <value>hdfs://localhost:9000</value>\n\
    </property>\n\
</configuration>"\
> ${HADOOP_HOME}/etc/hadoop/core-site.xml

RUN echo "\
<configuration>\n\
    <property>\n\
        <name>dfs.replication</name>\n\
        <value>1</value>\n\
    </property>\n\
</configuration>"\
> ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml

RUN hdfs namenode -format \
    && /etc/init.d/ssh start \
    && ssh-keyscan -H localhost >> ~/.ssh/known_hosts \
    && ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts \
    && $HADOOP_HOME/sbin/start-dfs.sh \
    && rm -rf /opt/hadoop/logs/*
