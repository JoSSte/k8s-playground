BOX_ID="JoSSte/k8sBasic"
vagrant destroy -f
set -e
vagrant up # Start the box and run any defined scripts
vagrant package --output ${BOX_ID}.box # Store the virtual machine with all the software installed into a box file.
vagrant box add --force ${BOX_ID} ${BOX_ID}.box # Add the box to the vagrant repo using the given id.
vagrant destroy -f # Stop the vagrant instance
rm ${BOX_ID}.box # Remove the file 