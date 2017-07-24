# vagrant-docker-python-windows
Set up a Redis database server inside a Docker container using Python and Vagrant on a Windows host.

Edited by Jessica Rankins on 6/15/2017

GOALS:
- Use Vagrant and Docker to configure a Docker container in a Vagrantfile.
- Demonstrate Infrastructure as code principles (script configures 
	and provisions environments to ensure environment parity).
- Networking: Forwarded ports to host from VM from Redis container: 
		80 to 8080 to 8080 for Redis database server demonstration
		
PREREQUISITES: ON WINDOWS HOST COMPUTER, HAD TO:
- Install VirtualBox (any version should work)
- Install Git for Windows (version 2.12.2.windows.1)
- Install Vagrant (version 1.9.4)
- Install DockerToolbox with Kitematic (version 17.04.0-ce)
- On vagrant up kept getting error:
		"A Docker command executed by Vagrant didn't complete successfully!
		The command run along with the output from the command is shown
		below. Command: ["docker", "ps", "-a", "-q", "--no-trunc", 
		{:notify=>[:stdout, :stderr]}]
		Stderr: error during connect: Get 
		http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.28/containers/json?all=1: 
		open //./pipe/docker_engine: The system cannot find the file 
		specified. In the default daemon configuration on Windows, the 
		docker client must be run elevated to connect. This error may also 
		indicate that the docker daemon is not running."
- To solve this issue, I ran "docker-machine env default"
		which said to run the following command before using docker in
		the command line after a fresh restart/start up of the computer:
		```@FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i```
- Got the error: Stderr: C:\Program Files\Docker Toolbox/docker.EXE: 
		Error response from daemon: invalid bind mount spec 
		"C:path/to/folder/holding/Vagrantfile/:/vagrant": 
		invalid mode: /vagrant.
		-> fixed when disable synced folders

TO EXECUTE:
- Start Docker Quickstart Terminal to start Docker deamon
- Run ```@FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i```
- cd to directory with Vagrantfile 
- make sure you have a folder pythonFiles with app.py and requirements
		(or change folders in Dockerfile)
- ```vagrant up```
- Have to forward port from Vagrant host to Host Machine:
    - Run the command ```VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8000,tcp,,8000,,8000"```
    - OR if you do not have VBoxManage:
			go to VirtualBox, Settings of default boot2docker container,
			Network, NAT Advanced, Port Forwarding, create new with:
			id - web, Host IP - 127.0.0.1, Host Port - 8080, Guest Port - 8080
- See example Redis web page in host browser at 127.0.0.1:8080
	
SOME USEFUL COMMAND LINE COMMANDS:
- ```vagrant up [--provider=docker]``` to create/start the container 
		corresponding to the Vagrantfile in the current directory [by using
		Docker as the provider and not VirtualBox if it does not detect it]
- ```vagrant docker-exec [VMname] -- command_to_execute``` to run a 
		one-off command against a Docker container by containername
		(error if container not running)
- ```vagrant docker-logs``` to see the logs of a running container
- ```vagrant reload [--provision]``` to reload container to include new 
		Vagrantfile commands [and reload provisions]
- ```vagrant destroy``` to shut down and deallocate resources corresponding 
		to container in this directory
- ```vagrant ssh``` to start ssh session into container in this directory 
		(end by typing "logout"); Uses Git, private key provided by Vagrant
		(Ubuntu VM supports ssh, but container does not)

EXECUTION OF VAGRANTFILE COMMANDS:
- "name" in "config.vm.define 'name' do |n|" is the same as the
		"config" variable.
- Commands placed inside the "config.vm.define 'name' do |n|" are
		applied only to the defined container (name).
- Commands placed outside this command are done to all containers.
- Commands are executed outside-in, in the order listed in the
		Vagrantfile.

SPECIFIC TO DOCKER WITH VAGRANT:			
- Mac and Windows cannot run Linux containers, so Vagrant automatically 
		creates a single "host VM" to run Docker when the first "vagrant up
		[--provider=docker]" is done. Vagrant will run multiple containers on 
		this one VM. You can alter the host VM by specifying a Vagrantfile
		to use when creating the host VM. The global-status command is used
		to control the host VM.
- VirtualBox uses the boot2docker image to create the VM. boot2docker does
		not support VirtualBox Guest Additions, so virtualbox and docker
		folder syncing implementations cannot be used. 
		Read only file system on boot2docker. Use volume in container instead
- Forwarded ports from container will be forwarded to the remote Docker 
		host VM. If you want to access ports, forward from container in Vagrantfile
		and then MANUALLY FORWARD PORTS IN VIRTUALBOX FROM VM to host.
	
