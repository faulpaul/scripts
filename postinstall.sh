# get the script
# wget https://raw.githubusercontent.com/faulpaul/scripts/master/postinstall.sh

# install needed software
dnf -y remove vim-minimal
dnf -y install fail2ban docker dnf-automatic screen docker-compose git vim sudo nmap

# set automatic update
sed -i -e 's/apply_updates = no/apply_updates = yes/g' /etc/dnf/automatic.conf
systemctl enable dnf-automatic.timer && systemctl start dnf-automatic.timer

# create docker
systemctl start docker
systemctl enable docker
mkdir -p /docker/mysql/data
cd /docker
git clone https://github.com/faulpaul/dockercompose.git
git clone https://github.com/faulpaul/birding.git
git clone https://github.com/faulpaul/goessinger.eu.git
git clone https://github.com/faulpaul/ornitho-crawler.git
cd dockercompose
docker-compose up -d

# add local user
useradd paul

# sudoers
echo "paul    ALL=(ALL)       ALL" >> /etc/sudoers

# disable SELinux
sed -i -e 's/enforcing/permissive/g' /etc/selinux/config

# set iptables for ornitho.de blacklist
iptables -t nat -A POSTROUTING --destination 79.125.20.157 -j SNAT --to-source 188.68.45.14

# other todos:
echo "SET PW FOR paul, CHANGE root PW, ADD MYSQL FILE" 