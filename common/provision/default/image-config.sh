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
# jdk_install_dir=/mnt/jdk-7u80
# java_home_dir=/opt/java
java_home_dir=/usr/java/default

# Add wso2user
pushd /mnt > /dev/null
groupadd wso2
useradd -r --system --shell /bin/bash --comment WSO2User -g wso2 wso2user

# WGET packs
yum update && yum install -y unzip wget
# wget -nH -r -e robots=off --reject "index.html*" -A "jdk*.tar.gz" -nv ${HTTP_PACK_SERVER}/
wget -nH -e robots=off --reject "index.html*" -nv ${HTTP_PACK_SERVER}/${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip

# Setup
echo "unpacking ${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip to /mnt"
unzip -q /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip -d /mnt
# mkdir -p ${jdk_install_dir}
# echo "unpacking the JDK to ${jdk_install_dir}"
# tar -xf /mnt/jdk*tar.gz -C ${jdk_install_dir} --strip-components=1
# ln -s ${jdk_install_dir} ${java_home_dir}
# echo "created symlink for java: ${java_home_dir} -> ${jdk_install_dir}"

# Cleanup
rm -rf /mnt/${WSO2_SERVER}-${WSO2_SERVER_VERSION}.zip
# rm -rf /mnt/jdk*tar.gz
yum remove -y wget unzip
rm -rfv /var/lib/apt/lists/*
chown wso2user:wso2 /usr/local/bin/*
chown -R wso2user:wso2 /mnt

# Setup environment variables
cat > /etc/profile.d/set_java_home.sh << EOF
export JAVA_HOME="${java_home_dir}"
export PATH="${java_home_dir}/bin:\$PATH"
EOF

popd > /dev/null
