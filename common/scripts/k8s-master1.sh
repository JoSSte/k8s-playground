sudo curl -sfL https://get.k3s.io | sh - 
export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc
mkdir /home/vagrant/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
cp $KUBECONFIG /tmp/shared/config
chmod 600 "$KUBECONFIG"