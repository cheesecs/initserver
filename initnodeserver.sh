#!/bin/bash
# 该脚本将为您的 Debian 系统安装 curl、docker，然后更改时区，启用 BBR，并安装 Python、Rclone、Screen 以及 fail2ban。

# 更新系统
echo "开始更新系统..."
sudo apt update && sudo apt upgrade -y
if [ $? -eq 0 ]; then
    echo "完成更新系统"
else
    echo "更新系统失败，请检查网络连接或手动进行系统更新。"
    exit 1
fi

# 安装 curl 
echo "开始安装 curl..."
sudo apt install -y curl
if [ $? -eq 0 ]; then
    echo "完成安装 curl"
else
    echo "安装 curl 失败，请检查网络连接或手动安装 curl。"
    exit 1
fi

# 修改系统时区为 Asia/Shanghai
echo "开始修改系统时区为 Asia/Shanghai..."
sudo timedatectl set-timezone Asia/Shanghai
echo "完成时区修改"

# 开启 BBR
echo "开始启用 BBR..."
sudo bash -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
sudo bash -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'
sudo sysctl -p
lsmod | grep bbr
echo "完成启用 BBR"

# 安装 Python 3 和 pip
echo "开始安装 Python 3 和 pip..."
sudo apt install -y python3 python3-pip
if [ $? -eq 0 ]; then
    echo "完成安装 Python 3 和 pip"
else
    echo "安装 Python 3 和 pip 失败，请检查网络连接或手动安装 Python 3 和 pip。"
    exit 1
fi

# 安装 fail2ban
echo "开始安装 fail2ban..."
sudo apt install fail2ban -y
echo "完成安装 fail2ban"
