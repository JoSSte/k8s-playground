sudo kubeadm init --control-plane-endpoint=k8s-master
sudo shutdown -r now
mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown $(id -u):$(id -g) /home/vagrant/.kube/config
kubectl cluster-info
kubectl get nodes
curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml
kubectl get pods -n kube-system