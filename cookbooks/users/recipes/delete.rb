#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "users-delete" do
	command "{
	for person in $(ls /delete_users/);
	do
	flag=0
        name=$(echo $person|cut -f 1 -d .)
        for uname in $(awk -F':' '{ print $1}' /etc/passwd);
	do
		if [  \"$uname\" == \"$name\" ]; then	
	 	flag=1;
		fi
	done;
	if [ \"$flag\" == \"1\" ]; then
		userdel -r $name
	else
		echo \"$name user not exists\"
        fi;
	done;
	}"
	action :run
end

