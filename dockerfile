FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    openssh-server \
    wget \
    curl \
    sudo \
    python3 \
    python3-pip \
    dbus-x11 \
    x11-xserver-utils


RUN apt-get install -y software-properties-common apt-transport-https
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install -y code

