# -*- mode: ruby -*-
# vi: set ft=ruby :
# Docker Redis container edited by Jessica Rankins 6/15/2017

  # All Vagrant configuration is done below. The "2" in Vagrant.configure
  # is the configuration version.
Vagrant.configure("2") do |config|

  config.vm.synced_folder Dir.pwd, "/vagrant", disabled: true
  
  #config.vm.network "forwarded_port", guest: 8080, host: 8080, id: "Web"
  # Have to do this by going to VirtualBox, Settings of default boot2docker
    # container, Network, NAT Advanced, Port Forwarding, create new with:
	# id - Web, Host IP - 127.0.0.1, Host Port - 8080, Guest Port - 8080
  # OR.. 'VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8000,tcp,,8000,,8000"'
	# after vagrant up
	
  config.vm.provider "docker" do |d|
    # Can specify an image or a Dockerfile: 
    d.build_dir = "."
    d.build_args = [ "-t", "myimage" ]
    d.create_args = [ "-i", "-t" ]
    d.has_ssh = false
	d.ports = [ "8080:80" ] #80 container->8080 VM
    d.name = "myrediscontainer"
  end

  config.vm.post_up_message = "Successfully started.
 
  		TO GET THINGS UP AND RUNNING:
		Have to forward port from Vagrant host to Host Machine:
			Run the command 
				'VBoxManage controlvm ''boot2docker-vm'' natpf1 ''tcp-port8000,tcp,,8000,,8000'' '
			OR if you do not have VBoxManage:
				go to VirtualBox, Settings of default boot2docker container,
				Network, NAT Advanced, Port Forwarding, create new with:
				id - Web, Host IP - 127.0.0.1, Host Port - 8080, Guest Port - 8080
		See example Redis web page in host browser at 127.0.0.1:8080"
	
end    # End configuring