sudo kubeadm init --control-plane-endpoint=$HOSTNAME --apiserver-advertise-address=$IP_ADDR

mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown $(id -u):$(id -g) /home/vagrant/.kube/config
