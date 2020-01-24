#! /bin/bash

read -p "I gonna to clear everything starting from cluster creation. Continue? " repl
echo

if [ "$repl" = "y" ]
then

  kubeadm reset -f

  systemctl stop nirmata-agent.service
  systemctl disable nirmata-agent.service
  rm -rf /etc/systemd/system/nirmata-agent.service

  rm -rf cleanup-cluster.sh
  wget https://raw.githubusercontent.com/nirmata/custom-scripts/master/cleanup-cluster.sh
  chmod 755 cleanup-cluster.sh
  ./cleanup-cluster.sh

  apt -y --allow-change-held-packages remove kubeadm kubectl kubelet kubernetes-cni kube*
  apt -y autoremove
  rm -rf ~/.kube

  rm -rf cleanup-cluster.sh

fi

echo
