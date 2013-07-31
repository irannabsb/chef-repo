remote_directory "keys" do
	path "/etc/pki/rpm-gpg/"
	action :create_if_missing
end

remote_directory "repo" do
	path "/etc/yum.repos.d/"
	action :create_if_missing
end
