#!/bin/bash

CONTAINER_NAME="gui_app"

echo "🛑 Aturant i eliminant contenidor anterior (si existeix)..."
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

echo "🚀 Creant i arrencant contenidor..."
docker run -d --name $CONTAINER_NAME \
    -p 2222:22 \
    -p 5901:5901 \
    gui_app \
    tail -f /dev/null

# Espera un moment per assegurar que el contenidor està actiu
sleep 2

echo "🔐 Arrencant SSH al contenidor..."
docker exec $CONTAINER_NAME service ssh start

echo "🖥️ Arrencant VNC al contenidor..."
docker exec -u docker $CONTAINER_NAME vncserver :1 -geometry 1280x800 -depth 24

echo "✅ Contenidor arrencat amb èxit!"
docker ps | grep $CONTAINER_NAME
