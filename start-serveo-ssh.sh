#!/bin/bash
echo "=== Bắt đầu dịch vụ SSH ==="
service ssh start

# Tạo tunnel TCP (port 22) qua Serveo
echo "=== Khởi tạo Serveo TCP tunnel ==="
ssh -R my-ssh-tunnel:22:localhost:22 serveo.net > serveo.log 2>&1 &
# Chờ Serveo khởi động
sleep 5
# Hiển thị thông tin kết nối SSH
echo "=== Thông tin SSH của bạn ==="
TUNNEL_INFO=$(tail -n 10 serveo.log | grep -i "forwarding\|tcp" | head -1)
if [ -n "$TUNNEL_INFO" ]; then
  echo "Kết nối SSH qua: my-ssh-tunnel.serveo.net:22"
  echo "Ví dụ: ssh -J serveo.net xduyhoangg@my-ssh-tunnel"
  echo "Mật khẩu: hoang1234"
else
  echo "⚠️ Không lấy được tunnel, kiểm tra log serveo.log."
  echo "Hoặc xem trực tiếp: tail -f serveo.log"
fi

# Giữ container chạy bằng web service dummy
echo "=== Giữ container hoạt động bằng web service ảo (port 8080) ==="
python3 -m http.server 8080
