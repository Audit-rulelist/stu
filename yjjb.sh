#!/bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;

yum update -y
apt-get update

apt-get update -y
apt-get install curl -y
yum clean all
yum make cache
yum install curl -y
# 上面中的更新以及安装;

systemctl stop firewalld.service
systemctl disable firewalld.service
# 上面中的是CentOS 7 关闭防火墙;

cd ~
sed -i 'net.ipv6.conf.all.disable_ipv6=1' /etc/sysctl.conf
sed -i 'net.ipv6.conf.default.disable_ipv6=1' /etc/sysctl.conf
sed -i 'net.ipv6.conf.lo.disable_ipv6=1' /etc/sysctl.conf
sysctl -p
# 上面中的是强制 Ipv4 访问;

echo '============================
      SSH Key Installer
	 V1.0 Alpha
	Author:Kirito
============================'
cd ~
mkdir .ssh
cd .ssh
curl https://github.com/$1.keys > authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh
cd /etc/ssh/

sed -i "/PasswordAuthentication no/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication no/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication yes/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication yes/c PubkeyAuthentication yes" sshd_config
service sshd restart
service ssh restart
systemctl restart sshd
systemctl restart ssh
cd ~
rm -rf key.sh