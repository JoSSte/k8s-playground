echo " ¤ ¤ ¤ BEGIN MASTER SCRIPT [$HOSTNAME] ¤ ¤ ¤"

sudo curl -sfL https://get.k3s.io | sh - 
export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc
mkdir /home/vagrant/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
sudo chown vagrant:vagrant "$KUBECONFIG"
sudo chmod 600 "$KUBECONFIG"

echo " * * Copy config to shared folder for worker nodes" 
cp $KUBECONFIG /tmp/shared/config
sudo sed --in-place=.bak "s#127.0.0.1#$HOSTNAME#" /tmp/shared/config

echo " * * Dump cluster config to shared folder"
kubectl cluster-info dump > /tmp/shared/cluster.json

echo " * * Dump token to shared folder"
sudo cat /var/lib/rancher/k3s/server/node-token > /tmp/shared/node-token.txt

echo " ¤ ¤ ¤ END MASTER SCRIPT [$HOSTNAME] ¤ ¤ ¤"