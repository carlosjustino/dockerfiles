FROM centos:7
MAINTAINER Stephan Miller <stephanmil@gmail.com>

RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

RUN yum -y install curl zip net-tools puppet iproute2; \
  rm -rf /var/cache/yum/*; \
  yum clean all

RUN puppet module install puppetlabs/stdlib \
    && puppet module install 7terminals-java

# ARG JDK_VERSION=7u80
# ARG JDK_BUILD_VERSION=b15
#
# ARG MYSQL_JDBC_VERSION
# ARG POSTGRES_JDBC_VERSION
#
# ENV MYSQL_JDBC_VERSION ${MYSQL_JDBC_VERSION:-5.1.39}
# ENV POSTGRES_JDBC_VERSION ${POSTGRES_JDBC_VERSION:-9.4-1201.jdbc4}
#
# RUN mkdir -p /opt/utilities
#
# RUN curl -LO "http://download.oracle.com/otn-pub/java/jdk/$JDK_VERSION-$JDK_BUILD_VERSION/jdk-$JDK_VERSION-linux-x64.rpm" -H 'Cookie: oraclelicense=accept-securebackup-cookie'; \
#   rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm
#
# RUN curl -LOk https://jdbc.postgresql.org/download/postgresql-$POSTGRES_JDBC_VERSION.jar; \
#   mv postgresql-$POSTGRES_JDBC_VERSION.jar /opt/utilities/
#
# RUN curl -LOk https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.zip; \
#   unzip -qq mysql-connector-java-$MYSQL_JDBC_VERSION.zip && rm -f mysql-connector-java-$MYSQL_JDBC_VERSION.zip; \
#   mv /mysql-connector-java-$MYSQL_JDBC_VERSION/mysql-connector-java-$MYSQL_JDBC_VERSION-bin.jar /opt/utilities/; \
#   rm -rf mysql-connector-java-$MYSQL_JDBC_VERSION
#
# ENV JAVA_HOME /usr/java/default
