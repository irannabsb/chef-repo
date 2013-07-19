remote_directory "keys" do
	path "/etc/pki/rpm-gpg/"
	action :create_if_missing
end

