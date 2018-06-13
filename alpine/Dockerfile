FROM alpine:3.7

# required arguments
# e.g. --build-arg HADOOP_VERS=2.7.6
ARG HADOOP_VERS

# default arguments
ARG HDFS_NAMENODE_PORT=9200

ARG HADOOP_HOME=/opt/hadoop
ENV HADOOP_HOME=${HADOOP_HOME}

ARG USER=hadoop
ENV USER=${USER}

ARG GROUP=hadoop
ENV GROUP=${GROUP}

ENV PATH=${HADOOP_HOME}/bin:$PATH

RUN apk add --no-cache bash curl openjdk8 openssh openssh-server shadow \
    && groupadd -r "${GROUP}" && useradd -rmg "${GROUP}" "${USER}" \
    && curl -SLO http://apache.mirrors.tds.net/hadoop/common/hadoop-${HADOOP_VERS}/hadoop-${HADOOP_VERS}.tar.gz \
    && tar xf hadoop-${HADOOP_VERS}.tar.gz \
    && mkdir -p ${HADOOP_HOME} \
    && mv hadoop-${HADOOP_VERS}/* ${HADOOP_HOME} && rmdir hadoop-${HADOOP_VERS} \
    && echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::')" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh \
    && echo "\
<configuration>\n\
    <property>\n\
        <name>fs.defaultFS</name>\n\
        <value>hdfs://localhost:${HDFS_NAMENODE_PORT}</value>\n\
    </property>\n\
</configuration>"\
> ${HADOOP_HOME}/etc/hadoop/core-site.xml \
    && echo "\
<configuration>\n\
    <property>\n\
        <name>dfs.replication</name>\n\
        <value>1</value>\n\
    </property>\n\
</configuration>"\
> ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml \
    && hdfs namenode -format

COPY ./run.sh /

ENTRYPOINT ["/run.sh"]
