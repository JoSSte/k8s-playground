sudo kubeadm init --control-plane-endpoint=$HOSTNAME --apiserver-advertise-address=$IP_ADDR

echo "Checking in listening on port 2379,6443,8080,10250,10257,10259"
sudo ss -ltn |grep '2379\|6443\|8080\|10250\|10257\|10259'

echo "Copying kube config"
mkdir -p /home/vagrant/.kube
sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config
