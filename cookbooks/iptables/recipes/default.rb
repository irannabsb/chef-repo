#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
 
execute "iptables-off" do
	command "chkconfig iptables off"
	action :run
end
