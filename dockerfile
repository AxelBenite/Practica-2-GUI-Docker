# Dockerfile
FROM ubuntu:24.04

# Instal·lació de paquets bàsics i actualització
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    openssh-server \
    sudo \
    dbus-x11 \
    x11-xserver-utils \
    net-tools \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libasound2t64 \
    libpangocairo-1.0-0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libxss1

# Configuració de l’usuari
RUN useradd -m -s /bin/bash docker && \
    echo "docker:docker" | chpasswd && \
    usermod -aG sudo docker && \
    groupadd -f docker && usermod -aG docker docker


ENV USER=docker \
    HOME=/home/docker

# Instal·lació de Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update && apt-get install -y code && \
    rm -f packages.microsoft.gpg


# SSH configuració bàsica
RUN mkdir /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config


USER docker
RUN mkdir -p /home/docker/.vnc && \
    echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /home/docker/.vnc/xstartup && \
    chmod +x /home/docker/.vnc/xstartup && \
    echo "docker" | vncpasswd -f > /home/docker/.vnc/passwd && \
    chmod 600 /home/docker/.vnc/passwd

USER root

EXPOSE 22 5901