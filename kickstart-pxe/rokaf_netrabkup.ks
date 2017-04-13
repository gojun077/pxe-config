#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use network installation
url --url="http://10.10.10.97:8080"
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --disable
ignoredisk --only-use=sda,sdb
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=enp3s0f0 --onboot=yes --ipv6=auto
network  --bootproto=none --device=enp3s0f1 --onboot=no --no-activate
network  --hostname=localhost.localdomain

# Root password
rootpw --iscrypted $6$YvMSFAwlccylBnIA$PN89nQc0ok7UTcUQ98AZKGIO8ywk4NmlkrUL6LPswoX6ENl/sTk9iyeYDddb02jEHzdk/bXueNVSqBfqq4/UC0
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York --isUtc
user --groups=wheel --name=super --password=$6$BA9TIqcMgsDTSyFt$UcxmOUbovIY1YyTQJMChegScdZsj.AFUlABVe5A5ZQzgb3t/bElBze4O/d.aQsMlNksuVLQEL0kg7EoT4CU/s. --iscrypted --gecos="super"
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot --fstype="ext4" --size=1024
part pv.360 --fstype="lvmpv" --ondisk=sdb --size=1907198
part pv.354 --fstype="lvmpv" --ondisk=sda --size=260766
volgroup cl --pesize=4096 pv.354 pv.360
logvol swap  --fstype="swap" --size=7629 --name=swap --vgname=cl
logvol /  --fstype="ext4" --size=259900 --name=root --vgname=cl
logvol /var  --fstype="xfs" --size=28610 --name=var --vgname=cl
logvol /home  --fstype="xfs" --size=28610 --name=home --vgname=cl
logvol /opt  --fstype="xfs" --size=1843196 --name=opt --vgname=cl

%packages
@^minimal
@core
chrony
kexec-tools
rsync
vim-common

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy luks --minlen=6 --minquality=50 --notstrict --nochanges --notempty
%end
