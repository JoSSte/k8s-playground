sudo kubeadm init --control-plane-endpoint=$SERVER_NAME
sudo shutdown -r now
mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown $(id -u):$(id -g) /home/vagrant/.kube/config

# check status - can be omitted
kubectl cluster-info
kubectl get nodes

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# check status -can be omitted
kubectl get pods -n kube-system