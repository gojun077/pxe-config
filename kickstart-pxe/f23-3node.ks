#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use network installation
url --url="http://192.168.95.97:8080"
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda,sdb
# Keyboard layout
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=enp3s0 --ipv6=auto --activate
network  --bootproto=dhcp --device=enp4s0 --ipv6=auto --activate
network  --hostname=fx8350no
# Root password
rootpw --iscrypted $6$92s6YmzzFHcqVq1C$mRJ9Hl40.szgrcu1VG1wDKHF8sjBLcnfvhadXI2cM6HZRYNY7corhE3mDnddrWLjIJbKhGbxYzORjHH4FywBC0
# System timezone
timezone Asia/Seoul --isUtc
selinux --permissive
user --groups=wheel --name=fedjun --password=$6$/PNIJOls2G8gzEZt$swngpGaZp9bt2AFXlunOnZvuVhUA93wqTJOQKLX7eY1kuuZvyLFYpLDEDA.o.g7KpYMsFYHx2.N/bdwiBxsqn. --iscrypted --gecos="fedjun"
# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --all --initlabel --drives=sda,sdb
zerombr
# Disk partitioning information
part /boot --fstype="ext4" --ondisk=sda --size=512 --label=f23boot
part pv.768 --fstype="lvmpv" --ondisk=sda --size=602120
volgroup fedora_fx8350no3 --pesize=4096 pv.768
logvol /var  --fstype="xfs" --size=532480 --name=var --vgname=fedora_fx8350no3
logvol /home  --fstype="xfs" --size=30720 --name=home --vgname=fedora_fx8350no3
logvol swap  --fstype="swap" --size=8192 --name=swap --vgname=fedora_fx8350no3
logvol /  --fstype="xfs" --size=30720 --name=root --vgname=fedora_fx8350no3

# Create LVM Physical Volume in the remaining space on /dev/sda
part pv.769 --fstype="lvmpv" --ondisk=sda --size=1 --grow
# Create 480GB LVM PV on /dev/sdb
part pv.770 --fstype="lvmlpv" --ondisk=sdb --size=491520
# Create VG "cinder-volumes" on pv.769 and pv.770
volgroup cinder-volumes --pesize=4096 pv.769 pv.770

%packages
@^server-product-environment

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end

%anaconda
pwpolicy root --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy user --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
%end
