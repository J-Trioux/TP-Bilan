<center><h1>TP Bilan (TRIOUX Jimmy)</h1></center>


- - - 

<h2>Contexte</h2>

Sur cette page, vous pourrez retrouver un script d'installation de Docker et Docker-Compose ainsi que les fichiers docker-compose permettant de générer rapidement deux services : <b>Wordpress</b> et <b>Zabbix</b>.

- - -

<h2>Étape 1 : Création du script d'installation</h2>

<p>
  Le script a été généré entièrement par moi-même, voici le code source :
</p>

```bash
#!/bin/bash

# Si erreur DPKG alors
dpkg --configure -a

# Mise à jour des dépandances et des paquets
apt update && apt upgrade -y
apt install ca-certificates curl gnupg lsb-release -y

# Ajout du dépôt et de la clé signature officiel de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.c>
apt update

# Installation de Docker et Docker-Compose
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Activation automatique de Docker au démarrage
systemctl enable docker --now

# Affichage du status de Docker
systemctl status docker
```

- - -

<h2>Étape 2 : Mise en service d'un Wordpress</h2>

<p>
  Nous créerons dans un premier temps le répertoire correspondant, et à l'intérieur de celui-ci nous irons créer un fichier <b>docker-compose.yml</b>.
</p>

```bash
root@groupe4:~/ mkdir ~/wordpress && cd ~/wordpress
root@groupe4:~/ nano docker-compose.yml
```

<p>
  À l'intérieur du fichier docker-compose, tapez ce fichier de configuration. (<b>Source</b> : <a href="https://help.ovhcloud.com/csm/fr-vps-install-wordpress-docker?id=kb_article_view&sysparm_article=KB0062053">OVH</a>)<br>
</p>

```bash
version: '3.8'

services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
    volumes:
      - wordpress_data:/var/www/html

volumes:
  db_data: {}
  wordpress_data: {}
```

<p>
  Ensuite, après avoir enregistrer votre fichier, tapez la commande "docker-compose up -d", cette commande démarre le conteneurs que nous avons définis dans le <b>docker-compose</b>.
</p>

```bash
root@groupe4:~/wordpress# docker-compose up -d
root@groupe4:~/wordpress# docker run --rm wordpress:latest php -v
```
<p>
  Il ne reste plus qu'à se connecter sur l'adresse suivante : <b>http://votre-ip:8000</b>
</p>

<img src="https://raw.githubusercontent.com/J-Trioux/TP-Bilan/main/wordpress.png>" alt="Image de la page d'accueil de Wordpress" />
