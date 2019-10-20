
#!/bin/bash

# assign variables
ACTION=${1}

# version of file
version=1.0

function save_metadata(){
touch metadata.txt
curl http://169.254.169.254/latest/meta-data/ami-id -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/instance-id -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/hostname -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/security-groups -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/public-hostname -w "\n" >> metadata.txt
}


function show_version(){
echo "$version"
}

function update_system_packages() {
sudo yum update -y
}


case "$ACTION" in
	-h|--help)
		display_help
		;;
	-m|--metadata)
		save_metadata
		;;
	-v|--version)
		show_version
		;;
	("")
	    	update_system_packages
		;;
	*)
	echo "${0} -v"
	exit 1
esac



