#!/bin/bash

#script to initialize a box to use as the base for kubernetes master and workers.

BOX_ID="JoSSte/k8sBasic"
FILENAME=`echo $BOX_ID | sed -r 's/\//_/g'`
vagrant destroy -f
set -e
vagrant up # Start the box and run any defined scripts
vagrant package --output ${FILENAME}.box # Store the virtual machine with all the software installed into a box file.
vagrant box add --force "${BOX_ID}" ${FILENAME}.box # Add the box to the vagrant repo using the given id.
vagrant destroy -f # Stop the vagrant instance
rm ${FILENAME}.box # Remove the file 
