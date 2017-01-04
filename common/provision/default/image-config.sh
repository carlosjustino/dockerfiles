#!/bin/bash
# ------------------------------------------------------------------------
#
# Copyright 2016 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

# ------------------------------------------------------------------------

set -e

# JDK version
java_home_dir=/usr/java/default

# Add wso2user
pushd /mnt > /dev/null
groupadd wso2
useradd -r --system --shell /bin/bash --comment WSO2User -g wso2 wso2user

# Download wso2 application
source /usr/local/bin/download-wso2.sh ${WSO2_SERVER} ${WSO2_SERVER_VERSION}

# Setup
echo "unpacking ${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip to /mnt"
unzip -q /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip -d /mnt

#Mysql Driver
wget -nH -e robots=off --reject "index.html*" -nv ${HTTP_PACK_SERVER}/mysql-connector-java-5.1.38-bin.jar
mv /mnt/mysql-connector-java-5.1.38-bin.jar /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}/repository/components/lib/mysql-connector-java-5.1.38-bin.jar

#Sql Server and Postgres Drivers for DSS
# if [ $WSO2_SERVER = "wso2dss" ]; then
    wget -nH -e robots=off --reject "index.html*" -nv ${HTTP_PACK_SERVER}/jtds-1.3.1.jar
    mv /mnt/jtds-1.3.1.jar /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}/repository/components/lib/jtds-1.3.1.jar

    wget -nH -e robots=off --reject "index.html*" -nv ${HTTP_PACK_SERVER}/postgresql-9.4.1212.jre6.jar
    mv /mnt/postgresql-9.4.1212.jre6.jar /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}/repository/components/lib/postgresql-9.4.1212.jre6.jar
# fi

# Symbolic link without version number
ln -sf /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION} /mnt/${WSO2_SERVER}

# Cleanup
rm -rf /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip
rm -rfv /var/lib/apt/lists/*
chown wso2user:wso2 /usr/local/bin/*
chown -R wso2user:wso2 /mnt

# Setup environment variables
cat > /etc/profile.d/set_java_home.sh << EOF
export JAVA_HOME="${java_home_dir}"
export PATH="${java_home_dir}/bin:\$PATH"
EOF

popd > /dev/null
