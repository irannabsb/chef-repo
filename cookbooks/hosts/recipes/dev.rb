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
	path "/tmp/etc/"
	action :create
end


bash "host-sync" do
	user "root"
	cwd "/tmp/etc"
	code <<-EOH
	if [ -d /tmp/etc/ ]; then
        	if [ -f /tmp/etc/dev_hosts ]; then
                cp /tmp/etc/dev_hosts /tmp/etc/tmphosts
                while read line; do
                        sed -i "/$line/d" /tmp/etc/tmphosts 2>>/dev/null
                done < /etc/hosts
                cat /tmp/etc/tmphosts >> /etc/hosts
                grep -v "^$" /etc/hosts > /tmp/etc/tmphosts
                cp /tmp/etc/tmphosts /etc/hosts
                rm /tmp/etc/tmphosts
        else
                echo "Failed to merge";
        fi
	fi
	EOH
end


