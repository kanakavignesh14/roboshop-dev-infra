#!/bin/bash
component=$1
environment=$2
#install ansible
dnf install ansible -y

REPO_URL=https://github.com/kanakavignesh14/ansible-roboshop-roles.tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles.tf  # if cloned before mens we will have like this

#setting up ansible folder where we going to clone ansible-roles folder to cofigure server
mkdir -p $REPO_DIR
#cd $REPO_DIR

#setting up logs files
mkdir -p /var/log/roboshop/
touch /var/log/roboshop/ansible.log

if [ "$component" == "payment" ]; then
    #echo "Installing Openssl packages for component :$component"
    dnf update openssl openssl-libs openssh openssh-server openssh-clients -y
    
fi 
#chnge to ansible folder
cd $REPO_DIR

# check if ansible repo is already cloned or not

if [ -d $ANSIBLE_DIR ]; then # if ok, cloned before, jus neefd to pull

    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL # we are clong using url
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=$component -e env=$environment main.yaml