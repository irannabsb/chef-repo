#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_directory "delete-users" do
        action :create
end

bash "delete-users" do
        user "root"
        cwd "/var/chef/cache/cookbooks/users/files/default/delete-users"
        code <<-EOF
        for person in $(ls); 
        do         
        flag=0;                 
        name=$(echo $person|cut -f 1 -d .)     
        for uname in $(awk -F':' '{ print $1}' /etc/passwd)
        do                 
        if [  "$uname" == "$name" ]; 
        then                
        flag=1;                 
        fi; 
        done;   
        if [ "$flag" == "1" ]; 
        then
		userdel -r $name 
	else
		echo "$name user not exists"
        fi;
	done;
	EOF
	action :run
end

