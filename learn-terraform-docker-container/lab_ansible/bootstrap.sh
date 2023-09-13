#!/usr/bin/env bash

# Active L'authentification 

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Mettre à jour le fichier hosts pour les 3 nœuds avec l'adresse IP fournie dans le fichier Vagrantfile

# 192.168.10.3 controller.ansible.com controller
# 192.168.10.4 managed1.ansible.com managed1
# 192.168.10.5 managed2.ansible.com managed2

echo -e "192.168.10.3 controller.anslab.com controller\n192.168.10.4 managed1.anslab.com managed1\n192.168.10.5 managed2.anslab.com managed2" >> /etc/hosts

# Installation des paquets nécessaires

sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass

# Installer Ansible en utilisant pip uniquement sur le noeud "controller"

 if [[ $(hostname) = "controller" ]]; then
   sudo pip3 install ansible
 fi
