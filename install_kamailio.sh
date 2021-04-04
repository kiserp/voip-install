# install kamailio

cat >> /etc/apt/sources.list < EOF
deb     http://deb.kamailio.org/kamailio54 buster main
deb-src http://deb.kamailio.org/kamailio54 buster main
EOF
wget -O- https://deb.kamailio.org/kamailiodebkey.gpg | sudo apt-key add -

sudo apt update
sudo apt -y install kamailio ngcp-rtpengine-iptables ngcp-rtpengine-daemon  kamcli kamailio-utils-modules kamailio-utils-modules kamailio-postgres-modules kamailio-tls-modules kamailio-nth kamailio-extra-modules
