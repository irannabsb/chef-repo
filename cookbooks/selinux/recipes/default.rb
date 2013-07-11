#
# Cookbook Name:: selinux
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "selinux-disable" do
  only_if "selinuxenabled"
  only_if "which selinuxenabled && selinuxenabled"
  notifies :create, "template[/etc/selinux/config]"
end

template "/etc/selinux/config" do
  source "selinux.erb"
  variables(
    :selinux => "disabled",
    :selinuxtype => "targeted"
  )
  action :nothing
end
