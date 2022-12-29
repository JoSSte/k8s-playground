sudo kubeadm init --control-plane-endpoint=$HOSTNAME --apiserver-advertise-address=$IP_ADDR

echo "checking in listening on port 6443"
sudo ss -ltn |grep 6443

echo "Copying kube config"
mkdir -p /home/vagrant/.kube
sudo \\cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config
