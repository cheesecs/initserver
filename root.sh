#!/bin/bash

# 确保脚本以root身份运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root身份运行" 1>&2
   exit 1
fi

# 生成随机密码
PASSWORD=$(openssl rand -base64 12)

# 解锁root账户
passwd -u root

# 设置root用户密码
echo "root:$PASSWORD" | chpasswd

# 打印生成的密码
echo "Root password is: $PASSWORD"

# 允许root通过SSH登录
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 重启SSH服务
systemctl restart sshd

echo "Root login enabled and SSH service restarted."
