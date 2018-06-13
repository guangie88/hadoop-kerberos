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
ENV PATH ${HADOOP_HOME}/bin:$PATH
