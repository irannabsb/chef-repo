#
# Cookbook Name:: yum-repo
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

remote_directory "repo" do
	path "/etc/yum.repos.d/"
	action :create_if_missing
end

