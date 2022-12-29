# check status - can be omitted
kubectl cluster-info
kubectl get nodes

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# check status -can be omitted
kubectl get pods -n kube-system

# dump listening ports
echo "Checking in listening on port 2379,6443,8080,10250,10257,10259"
sudo ss -ltn |grep '2379\|6443\|8080\|10250\|10257\|10259'