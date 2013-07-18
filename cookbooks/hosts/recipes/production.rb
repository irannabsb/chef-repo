#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
remote_directory "etc" do
	action :create
end


bash "host-sync" do
	user "root"
	cwd "/var/chef/cache/cookbooks/hosts/files/default/etc"
	code <<-EOH
	if [ -d /var/chef/cache/cookbooks/hosts/files/default/etc ]; then
        	if [ -f /var/chef/cache/cookbooks/hosts/files/default/etc/pro_hosts ]; then
                cp /var/chef/cache/cookbooks/hosts/files/default/etc/pro_hosts /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts
                while read line; do
                        sed -i "/$line/d" /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts 2>>/dev/null
                done < /etc/hosts
                cat /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts >> /etc/hosts
                grep -v "^$" /etc/hosts > /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts
                cp /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts /etc/hosts
                rm /var/chef/cache/cookbooks/hosts/files/default/etc/tmphosts
        else
                echo "Failed to merge";
        fi
	fi
	EOH
end


