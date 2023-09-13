#!/bin/bash

# Configure Tomcat to connect to MySQL
sudo sed -i 's/<\/Context>/<Resource name="jdbc/mydb" auth="Container" type="javax.sql.DataSource" maxTotal="20" maxIdle="5" maxWaitMillis="10000" username="db_user" password="db_password" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql:\/\/db_host:3306\/db_name"\/><\/Context>/' /opt/tomcat/conf/context.xml
