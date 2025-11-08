FROM ubuntu:22.04

# Cài OpenSSH Server + Ngrok
RUN apt update && apt install -y openssh-server curl wget unzip sudo && \
    mkdir /var/run/sshd

# Tạo user 'user' có thể sudo
RUN useradd -m user && echo "user:password" | chpasswd && adduser user sudo

# Cấu hình SSH
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'ClientAliveInterval 60' >> /etc/ssh/sshd_config && \
    echo 'ClientAliveCountMax 3' >> /etc/ssh/sshd_config

# Tải ngrok (v3)
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -xzf ngrok-v3-stable-linux-amd64.tgz && mv ngrok /usr/local/bin/

# Copy script khởi động
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway yêu cầu expose 1 port để giữ service online
EXPOSE 8080

CMD ["/start.sh"]
