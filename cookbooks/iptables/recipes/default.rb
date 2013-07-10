#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
 
execute "iptables-off" do
	#command "/etc/init.d/iptables save"
	command "/etc/init.d/iptables start"
	action :run
end
