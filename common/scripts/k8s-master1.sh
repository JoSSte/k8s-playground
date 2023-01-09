echo " ¤ ¤ ¤ MASTER SCRIPT ¤ ¤ ¤👨‍✈️"

sudo curl -sfL https://get.k3s.io | sh - 
export KUBECONFIG=/home/vagrant/.kube/config
echo -e "\nexport KUBECONFIG=$KUBECONFIG\n" >> /home/vagrant/.bashrc
mkdir /home/vagrant/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
sudo chown vagrant:vagrant "$KUBECONFIG"
sudo chmod 600 "$KUBECONFIG"

# copy conifg to shared folder for worker nodes

cp $KUBECONFIG /tmp/shared/config
sed -i "s#127.0.0.1#/$SERVER_NAME#" /tmp/shared/config
