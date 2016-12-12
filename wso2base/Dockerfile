FROM centos:7
MAINTAINER Stephan Miller <stephanmil@gmail.com>

RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

RUN yum -y install curl zip net-tools puppet iproute2 wget unzip; \
  rm -rf /var/cache/yum/*; \
  yum clean all

RUN puppet module install puppetlabs/stdlib \
    && puppet module install 7terminals-java

COPY ./download-wso2.sh /usr/local/bin/download-wso2.sh
RUN chmod a+x /usr/local/bin/download-wso2.sh

ARG JDK_VERSION=7u80
ARG JDK_BUILD_VERSION=b15

RUN curl -LO "http://download.oracle.com/otn-pub/java/jdk/$JDK_VERSION-$JDK_BUILD_VERSION/jdk-$JDK_VERSION-linux-x64.rpm" -H 'Cookie: oraclelicense=accept-securebackup-cookie'; \
  rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
