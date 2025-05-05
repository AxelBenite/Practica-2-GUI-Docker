#!/bin/bash

CONTAINER_NAME="gui_app"

echo "🛑 Aturant i eliminant contenidor anterior (si existeix)..."
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

docker run -d --name $CONTAINER_NAME \
    -p 2222:22 \
    -p 5901:5901 \
    gui_app \
    tail -f /dev/null


echo "✅ Contenidor arrencat amb èxit!"
docker ps | grep $CONTAINER_NAME
