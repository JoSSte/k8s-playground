#!/bin/bash

# Script to initialize a box to use as the base for kubernetes master and workers.

BOX_ID="JoSSte/k8sBasic"
BOX_FILENAME=`echo $BOX_ID | sed -r 's/\//_/g'`
vagrant destroy -f
set -e

# Start the box
vagrant up

# Store the virtual machine with all the software installed into a box file.
vagrant package --output ${BOX_FILENAME}.box

# Add the box to the vagrant repo using the given id. --force is because we are reusing the ID.
vagrant box add --force "${BOX_ID}" ${BOX_FILENAME}.box

# Stop the vagrant instance to conserve disk space
vagrant destroy -f 

# Remove the file to save disk space
rm ${BOX_FILENAME}.box
