#!/bin/bash

# Si erreur DPKG alors
dpkg --configure -a

# Mise à jour des dépandances et des paquets
apt update && apt upgrade -y
apt install ca-certificates curl gnupg lsb-release -y

# Ajout de la clé de signature
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Ajout du dépôt officiel de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Installation de Docker et Docker-Compose
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Activation automatique de Docker au démarrage
systemctl enable docker --now

# Affichage du status de Docker
systemctl status docker
