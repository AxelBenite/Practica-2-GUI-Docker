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
    x11-xserver-utils

# Instal·lació de Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update && apt-get install -y code && \
    rm -f packages.microsoft.gpg

# Configuració de l’usuari
RUN useradd -m -s /bin/bash docker
RUN echo "docker" | chpasswd
RUN usermod -aG sudo docker
RUN groupadd docker && usermod -aG docker docker

# SSH configuració bàsica
RUN mkdir /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Configuració VNC
USER docker
RUN vncserver :1 && vncserver -kill :1 && \
    mkdir -p ~/.vnc && \
    echo "#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &" > ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

EXPOSE 22 5901

CMD ["/bin/bash", "-c", "/usr/sbin/sshd && vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null"]
