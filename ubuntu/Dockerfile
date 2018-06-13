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

RUN hdfs namenode -format
COPY ./run.sh /

ENTRYPOINT ["/run.sh"]
