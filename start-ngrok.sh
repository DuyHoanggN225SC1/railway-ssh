#!/bin/bash
echo "=== Starting SSH service ==="
service ssh start

# Detect aaPanel port dynamically
AAPANEL_PORT=$(cat /www/server/panel/data/port.pl 2>/dev/null || echo 8888)
echo "Detected aaPanel port: $AAPANEL_PORT"

# Start Serveo HTTP tunnel for aaPanel
echo "=== Starting HTTP tunnel for aaPanel via Serveo ==="
ssh -R 80:localhost:$AAPANEL_PORT serveo.net > /tmp/serveo-web.log 2>&1 &
sleep 5
echo "=== aaPanel / Web Tunnel Info ==="
tail -n 10 /tmp/serveo-web.log | grep -i "forwarding\|https" || echo "Check /tmp/serveo-web.log for the assigned URL (e.g., https://random.serveo.net)"

# Start Serveo TCP tunnel for SSH (using fixed alias for simplicity; change 'my-ssh-tunnel' if needed)
echo "=== Starting SSH tunnel via Serveo ==="
ssh -R my-ssh-tunnel:22:localhost:22 serveo.net > /tmp/serveo-ssh.log 2>&1 &
sleep 5
echo "=== SSH Tunnel Info ==="
tail -n 10 /tmp/serveo-ssh.log | grep -i "forwarding\|tcp" || echo "Check /tmp/serveo-ssh.log for the assigned tunnel (e.g., my-ssh-tunnel.serveo.net:22)"
echo "To connect: ssh -J serveo.net user@my-ssh-tunnel"

# Keep container alive
python3 -m http.server 8080 >/dev/null 2>&1 &
echo "Container keep-alive running on port 8080."
