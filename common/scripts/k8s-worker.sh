echo " 🛠 🛠 🛠 WORKER SCRIPT ⚒ ⚒ ⚒"

export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc

cp $KUBECONFIG /tmp/shared/config

sudo chown vagrant:vagrant "$KUBECONFIG"
sudo chmod 600 "$KUBECONFIG"