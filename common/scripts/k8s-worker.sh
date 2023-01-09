echo " 🛠 🛠 🛠 WORKER SCRIPT ⚒ ⚒ ⚒"

export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc
mkdir /home/vagrant/.kube
cp /tmp/shared/config /home/vagrant/.kube

sudo chown vagrant:vagrant "$KUBECONFIG"
sudo chmod 600 "$KUBECONFIG"