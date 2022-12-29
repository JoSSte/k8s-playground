# check status - can be omitted
kubectl cluster-info
kubectl get nodes

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# check status -can be omitted
kubectl get pods -n kube-system

# dump listening ports
echo "checking in listening on port 6443"
sudo ss -ltn |grep 6443