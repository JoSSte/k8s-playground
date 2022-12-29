sudo kubeadm init --control-plane-endpoint=$HOSTNAME --apiserver-advertise-address=$IP_ADDR

# dump listening ports
sudo ss -ltn

mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config
