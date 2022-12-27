#!/bin/bash

# https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/

sudo apt-get install -qy screenfetch
echo "if [ -f /usr/bin/screenfetch ]; then screenfetch; fi" >> ~/.bashrc
sudo apt-get update
sudo apt-get upgrade -qy
sudo apt-get autoremove
sudo hostnamectl set-hostname "$SERVER_NAME"
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

>&2 echo -e "\n * * * * * * * * * * * * * * * * * *    1    * * * * * * * * * * * * * * * * * * \n"

sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

>&2 echo -e "\n * * * * * * * * * * * * * * * * * *    2    * * * * * * * * * * * * * * * * * * \n"

sudo sysctl --system
sudo apt-get install -qy curl gnupg2 software-properties-common apt-transport-https ca-certificates
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#sudo apt-get update
sudo apt-get install -qy containerd.io
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

>&2 echo -e "\n * * * * * * * * * * * * * * * * * *    3    * * * * * * * * * * * * * * * * * * \n"

sudo systemctl restart containerd
sudo systemctl enable containerd
# consider updating this according to the answers here: https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
#sudo apt-get update
sudo apt-get install -qy kubelet kubeadm kubectl

>&2 echo -e "\n * * * * * * * * * * * * * * * * * *    4    * * * * * * * * * * * * * * * * * * \n"

sudo apt-mark hold kubelet kubeadm kubectl
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd


>&2 echo -e "\n * * * * * * * * * * * * * * * * * *    5    * * * * * * * * * * * * * * * * * * \n"

sudo apt-get update
sudo apt-get upgrade -qy