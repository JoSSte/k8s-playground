# check status - can be omitted
kubectl cluster-info
kubectl get nodes

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# check status -can be omitted
kubectl get pods -n kube-system