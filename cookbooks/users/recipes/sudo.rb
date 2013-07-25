
remote_directory "sudo_users" do
	action :create
end

bash "sudo-users" do
	user "root"
	cwd "/var/chef/cache/cookbooks/users/files/default/sudo_users"
	code <<-EOF
	for person in $(ls /var/chef/cache/cookbooks/users/files/default/sudo_users); 
	do       
		name=$(echo $person|cut -f 1 -d .)  
		cat /etc/passwd | grep $name 2>>/dev/null
		if [ "$?" == "0" ]; then 
			usermod -aG sudoers $name
		fi
	done
	EOF
	action :run
end
