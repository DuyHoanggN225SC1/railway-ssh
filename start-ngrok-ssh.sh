#!/bin/bash
echo "=== Bắt đầu dịch vụ SSH ==="
service ssh start

# Kiểm tra biến môi trường NGROK_AUTH_TOKEN
if [ -z "$NGROK_AUTH_TOKEN" ]; then
  echo "⚠️  Không tìm thấy biến môi trường NGROK_AUTH_TOKEN!"
  echo "➡️  Hãy thêm token vào môi trường container hoặc Render dashboard (Environment Variables)."
  exit 1
fi

# Đăng nhập vào Ngrok bằng token môi trường
ngrok config add-authtoken "$NGROK_AUTH_TOKEN"

# Tạo tunnel TCP (port 22)
echo "=== Khởi tạo Ngrok TCP tunnel ==="
nohup ngrok tcp 22 --region ap > ngrok.log 2>&1 &

# Chờ Ngrok khởi động
sleep 5

# Hiển thị thông tin kết nối SSH
echo "=== Thông tin SSH của bạn ==="
TUNNEL_URL=$(curl -s localhost:4040/api/tunnels | grep -Eo "tcp://[0-9a-zA-Z\.-]+:[0-9]+")
if [ -n "$TUNNEL_URL" ]; then
  echo "Kết nối SSH qua: $TUNNEL_URL"
  echo "Ví dụ: ssh user@$(echo $TUNNEL_URL | sed 's#tcp://##')"
else
  echo "⚠️  Không lấy được tunnel, kiểm tra log ngrok.log."
fi

# Giữ container chạy bằng web service dummy
echo "=== Giữ container hoạt động bằng web service ảo (port 8080) ==="
python3 -m http.server 8080
