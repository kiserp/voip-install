apt update ; apt upgrade -y ; apt -y install build-essential ; apt install -y vim wget  git 
cat >  /etc/sysctl.d/90-voip.conf << EOF
#размеры буферов
net.core.rmem_max = 67108864
net.core.wmem_max = 33554432
net.core.rmem_default = 31457280
net.core.wmem_default = 31457280


net.ipv4.tcp_rmem = 10240 87380 10485760
net.ipv4.tcp_wmem= 10240 87380 10485760


# Увеличить размер возможного буфера
net.ipv4.udp_rmem_min = 131072
net.ipv4.udp_wmem_min = 131072
net.ipv4.udp_mem = 19257652 19257652 19257652
net.ipv4.tcp_mem = 786432 1048576 26777216

net.core.optmem_max = 25165824

# Подключаться к виртуальному адресу
net.ipv4.ip_nonlocal_bind = 1

# откючить ipv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 0

net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_max_syn_backlog = 300000

net.core.somaxconn = 65535

net.core.netdev_max_backlog = 300000

net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1

#проверка соединения
net.ipv4.tcp_keepalive_time = 60
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 60

net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_syn_retries = 5

#max of (должно быть в 3-4 раза больше  /proc/sys/fs/inode-max)
fs.file-max = 500000

vm.swappiness = 10
vm.dirty_ratio = 60
vm.dirty_background_ratio = 2
vm.max_map_count=262144

net.ipv4.ip_local_port_range = 1024 65535

fs.protected_hardlinks=1
fs.protected_symlinks=1

kernel.kptr_restrict=1

kernel.yama.ptrace_scope=1
kernel.perf_event_paranoid=2

net.ipv4.tcp_syncookies=1

net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0

net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.secure_redirects=1
net.ipv4.conf.default.secure_redirects=1

net.ipv4.ip_forward=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0

net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1

net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.icmp_ignore_bogus_error_responses=1

net.ipv4.conf.all.log_martians=1
net.ipv4.conf.default.log_martians=1

net.ipv4.tcp_rfc1337=1

kernel.randomize_va_space=2

kernel.panic=10
EOF

cp /etc/security/limits.conf  /etc/security/limits.conf.bk 
cat > /etc/security/limits.conf << EOF
#
# Limits configuration for ulimit.
#
# Version 1.0 - 2018-02-21
# Rebtel - <oussama.hammami@rebtel.com>
#
# This file should be saved in /etc/security/limits.d and can be activated by closing all
# active sessions of the concerned user:
# ulimit -a
#
# maximum number of open files
# don't use value upper than fs.file-max
root       soft    nofile         102400
root       hard    nofile         102400
# limits the core file size (KB)
root       soft    core            unlimited
# maximum data size (KB)
root       soft    data            unlimited
# maximum filesize (KB)
root       soft    fsize           unlimited
# maximum locked-in-memory address space (KB)
root       soft    memlock         unlimited
root       hard    memlock         unlimited
# maximum resident set size (KB) (Ignored in Linux 2.4.30 and higher)
# root       soft    rss             unlimited
# maximum stack size (KB)
root       soft    stack           unlimited
root       hard    stack           unlimited
# maximum CPU time (minutes)
root       soft    cpu             unlimited
# maximum number of processes
root       soft    nproc           unlimited
root       hard    nproc           unlimited
# address space limit (KB)
root       soft    as              unlimited
# the priority to run user process with (negative values boost process priority)
root       soft    priority        -11
# maximum locked files (Linux 2.4 and higher)
root       soft    locks           unlimited
# maximum number of pending signals (Linux 2.6 and higher)
root       soft    sigpending      unlimited
root       hard    sigpending      unlimited
# maximum memory used by POSIX message queues (bytes) (Linux 2.6 and higher)
root       soft    msgqueue        unlimited
root       hard    msgqueue        unlimited
# maximum nice priority allowed to raise to (Linux 2.6.12 and higher) values: [-20,19]
root       soft    nice            -11
EOF

echo ""
echo ""
echo ""
echo "Если запускать приложение не от рута, то надо завести на пользователя лимиты:"
echo "cp /etc/security/limits.conf /etc/security/limits.d/51-USERNAME.limits.conf"
echo "sed -i 's/root/USERNAME/g' 51-USERNAME.limits.conf"
echo ""
echo ""
echo ""
echo "в systemd тоже надо добавить лимиты"
echo "LimitCORE=infinity      "
echo "LimitNPROC=infinity     "
echo "LimitAS=infinity        "
echo "LimitRSS=infinity       "
echo "LimitDATA=infinity      "
echo "LimitFSIZE=infinity     "
echo "TimeoutSec=300          "
echo "LimitNOFILE=1024000     "
echo "LimitSTACK=infinity     "
echo "TasksMax=infinity       "
echo "LimitRTPRIO=70          "
echo "MemoryLimit=infinity    "
echo "LimitSIGPENDING=infinity"
echo "LimitMSGQUEUE=infinity  "
echo "LimitMEMLOCK=infinity   "
echo ""
echo ""
echo ""
echo ""