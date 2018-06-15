# CentOS7 with a glibc-2.23-r1, Oracle Java jdk8-u172 and unlimited JCE policy patch
FROM FROM centos:centos7

MAINTAINER Arpit Rastogi <frds.arastogi@gmail.com>

# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install unzip
 
# Install Oracle Java version 8
ENV JAVA_VERSION 8u172
ENV JAVA_BUILD 8u172-b11
ENV JAVA_DL_HASH a58eab1ec242421181065cdc37240b08 

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
 http://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/${JAVA_DL_HASH}/jdk-${JAVA_VERSION}-linux-x64.rpm && \
 yum localinstall -y jdk-${JAVA_VERSION}-linux-x64.rpm && \
 rm -rf jdk-${JAVA_VERSION}-linux-x64.rpm && \
 java -version

# do all in one step
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip jce_policy-8.zip -d /tmp && \
	yes | cp -rf /tmp/UnlimitedJCEPolicyJDK8/* /usr/java/jdk*/jre/lib/security/policy/unlimited && \
    rm -rf jce_policy-8.zip && \
    rm -rf /tmp/* /var/cache/yum/*
