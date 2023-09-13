#!/bin/bash

# Install Java and Tomcat
sudo apt update
sudo apt install -y default-jdk
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.52/bin/apache-tomcat-9.0.52.tar.gz
tar -xzvf apache-tomcat-9.0.52.tar.gz
sudo mv apache-tomcat-9.0.52 /opt/tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
sudo chown -R tomcat: /opt/tomcat
