# Practica-2-GUI-Docker

Aquest Contenidor  conte un sistem ubuntu 24.04 amb un entorn grafic XFCE, un servidor ssh, un servidor vnc, visual studio core y python3.

### Conexion Remotes ###
He utilitzat el client Remmina per fer les proves.

## SSH ##
Port Host: 2222
Usuari: Docker
Pass: Docker

## VNC ##
Port Host: 5901
Pass: Docker

### Scripts ###
He fet 2 scripts en aquest proyecte.

## run.sh ##

Aquest es el script encarregat de arrancar i crear el contenidor, tambe he posat un control perque esborri el anteriors per evitar problemes, tambe fa la instancia del servidor VNC.