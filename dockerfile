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
RUN wget -O /tmp/code.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable && \
    apt install -y /tmp/code.deb && \
    rm /tmp/code.deb
RUN mv /usr/bin/code /usr/bin/code-bin && \
    echo -e '#!/bin/bash\nexec /usr/bin/code-bin --no-sandbox "$@"' > /usr/bin/code && \
    chmod +x /usr/bin/code



# SSH configuració bàsica
RUN mkdir /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config


USER docker
RUN mkdir -p /home/docker/.vnc && \
    echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /home/docker/.vnc/xstartup && \
    chmod +x /home/docker/.vnc/xstartup && \
    echo "docker" | vncpasswd -f > /home/docker/.vnc/passwd && \
    chmod 600 /home/docker/.vnc/passwd

# Opertura de Ports
USER root
EXPOSE 22 5901