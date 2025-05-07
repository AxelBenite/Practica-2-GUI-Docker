#!/bin/bash

export USER=docker
export HOME=/home/docker

service ssh start

vncserver :1 -geometry 1280x800 -depth 24

tail -f /home/docker/.vnc/*.log
