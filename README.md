# 🐧 Railway SSH - Remote Linux qua Ngrok

Dự án này giúp bạn **mở SSH tạm thời vào container Linux chạy trên Railway**  
👉 Phù hợp để học Linux, test script, hoặc debug nhanh trong môi trường cloud miễn phí.

> ⚠️ Dự án chỉ dùng cho mục đích học tập.  
> Không được sử dụng để lưu dữ liệu nhạy cảm, đào tiền ảo, spam, hay chạy RDP GUI.

---

## 🚀 Tính năng
- Container **Ubuntu 22.04**
- Dịch vụ **OpenSSH Server** cài sẵn
- **Ngrok TCP Tunnel** giúp bạn SSH từ xa vào container Railway
- **User có quyền sudo**
- **Tự động hiển thị thông tin kết nối SSH** trong log khi deploy

---

## 🧱 Cấu trúc dự án

railway-ssh/
├── Dockerfile # Định nghĩa môi trường container Ubuntu + SSH + Ngrok
├── start.sh # Script khởi động SSH + Ngrok
└── README.md # Hướng dẫn sử dụng

---

## ⚙️ Cách triển khai

### 1️⃣ Fork hoặc clone repo này
Bạn có thể fork repo này vào GitHub cá nhân, hoặc clone thủ công:
```bash
git clone https://github.com/<tên-bạn>/railway-ssh.git
cd railway-ssh
