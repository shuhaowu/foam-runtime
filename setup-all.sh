#!/bin/bash

if [ ! -f inventory ]; then
  echo "ERROR: missing inventory file in current directory." >&2
  exit 1
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
  echo "ERROR: you must run this with a SSH connection with agent forwarding" >&2
  exit 1
fi

set -e

################################
# Generating SSH key for login #
################################

if [ ! -f roles/openfoam-base/files/id_rsa ]; then
  mkdir -p roles/openfoam-base/files
  ssh-keygen -f roles/openfoam-base/files/id_rsa -N ""
fi

#######################################
# Setting up present node for ansible #
#######################################

echo "sudo is required to install ansible"

sudo apt-get update
sudo apt-get install -y python python3-pip libssl-dev
sudo pip3 install -U ansible cryptography

# Assume we are working in a secure network such that this is not a problem.
# Otherwise we'll get spammed by a bunch of ssh key verifications from all
# the hosts.
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i inventory -e 'ansible_python_interpreter=/usr/bin/python3' provision.yml
