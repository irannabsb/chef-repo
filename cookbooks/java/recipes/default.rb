#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#


remote_directory "java" do
	action :create
end

bash "install-java" do
	user "root"
	cwd "/var/chef/cache/cookbooks/java/files/default/java"
	code <<-EOH
	tar -xzvf java.tar.gz
	cd java
	chmod +x jdk-6u45-linux-x64-rpm.bin
	./jdk-6u45-linux-x64-rpm.bin
 
	alternatives --install /usr/bin/java java /usr/java/jdk1.6.0_45/jre/bin/java 20000
	alternatives --install /usr/bin/jar jar /usr/java/jdk1.6.0_45/bin/jar 20000
	alternatives --install /usr/bin/javac javac /usr/java/jdk1.6.0_45/bin/javac 20000
	alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.6.0_45/jre/bin/javaws 20000

	alternatives --set java /usr/java/jdk1.6.0_45/jre/bin/java
	alternatives --set javaws /usr/java/jdk1.6.0_45/jre/bin/javaws
	alternatives --set javac /usr/java/jdk1.6.0_45/bin/javac
	alternatives --set jar /usr/java/jdk1.6.0_45/bin/jar

	cat > /etc/profile.d/java.sh
	export JAVA_HOME=/usr/java/latest
	export JAVA_BIN=$JAVA_HOME/bin
	export JAVA_PATH=$JAVA_HOME
	export PATH=$PATH:$JAVA_HOME/bin
	source /etc/profile.d/java.sh
	EOH
end

