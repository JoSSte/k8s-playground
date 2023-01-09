echo " 🛠 🛠 🛠 WORKER SCRIPT ⚒ ⚒ ⚒"

export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc
mkdir /home/vagrant/.kube
cp /tmp/shared/config /home/vagrant/.kube

NODE_TOKEN=`cat /tmp/shared/node-token.txt`

curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_SERVER_NAME:6443 K3S_TOKEN=$NODE_TOKEN sh -

sudo chown vagrant:vagrant "$KUBECONFIG"
sudo chmod 600 "$KUBECONFIG"