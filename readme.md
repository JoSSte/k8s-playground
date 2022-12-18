# Vagrant VMS with Kubernetes

In order to experiement with kubernetes (k8s) I have created a couple of vagrantfiles to exeperiment.

They are based on [this guide](https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/).

The reasons for not just creating the VMs are three-fold:
1. The images are not easily recreatable in case I mess something up
1. The images take up more space than a couple of script files
1. Provisioning new workers/experimenting on new versions is easier with 
