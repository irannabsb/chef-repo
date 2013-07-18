#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

remote_directory "create_users" do
	action :create
end

bash "create-users" do
	user "root"
	cwd "/var/chef/cache/cookbooks/users/files/default/create_users"
	code <<-EOF
	for person in $(ls /var/chef/cache/cookbooks/users/files/default/create_users); 
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
        if [ "$flag" != "1" ]; then  
               useradd -s /bin/bash -m $name;
               mkdir /home/$name/.ssh; 
               chmod 700 /home/$name/.ssh;    
               cat /var/chef/cache/cookbooks/users/files/default/create_users/$person > /home/$name/.ssh/authorized_keys;   
               chmod 600 /home/$name/.ssh/authorized_keys;  
               chown -R $name:$name /home/$name/.ssh;
	       
               echo "Users created sucessfully";
        else    
              echo "$name user already exists";           		
        fi;
        done;	
	EOF
	action :run
end
