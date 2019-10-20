
#!/bin/bash

# assign variables
ACTION=${1}

# version of file
version=2.0

function backup(){
ls *.txt
for f in *.txt; do cp $f "$f.bak"; done
}

function aws_cli(){
touch awscli.txt
aws ec2 describe-instances --filters Name=instance.group-name,Values=midterm  >> awscli.txt
aws ec2 describe-security-groups --filters Name=group-name,Values=midterm  >> awscli.txt
}

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
        -b|--backup)
                backup
                ;;
	-a|--aws)
		aws_cli
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
	echo "${0} -b|-a|-v|"
	exit 1
esac



