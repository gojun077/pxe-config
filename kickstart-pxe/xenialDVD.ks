# Kickstart file for unattended install of Ubuntu Xenial 16.04 LTS
# Last Updated: 2016-07-05
# Jun Go gojun077@gmail.com

# D-I preseed options taken from
# https://help.ubuntu.com/lts/installation-guide/example-preseed.txt
# Note that in the example preseed you must replace 'd-i' with 'preseed'
# for these cmd's to work in this kickstart

install
url --url http://192.168.95.97:8080/ubuntu/


##########################
# Ubuntu Kickstart Syntax
##########################
preseed debian-installer/locale string en_US
preseed debian-installer/language string en
preseed debian-installer/country string KR

# Disable automatic (interactive) keymap detection.
preseed console-setup/ask_detect boolean false
preseed keyboard-configuration/xkb-keymap select us

### Network configuration
# netcfg will choose an interface that has link if possible. This makes it
# skip displaying a list if there is more than one interface.
preseed netcfg/choose_interface select auto
# To pick a particular interface instead:
#preseed netcfg/choose_interface select eth0

# If you prefer to configure the network manually, uncomment this line and
# the static network configuration below.
#preseed netcfg/disable_autoconfig boolean true

# If you want the preconfiguration file to work on systems both with and
# without a dhcp server, uncomment these lines and the static network
# configuration below.
#preseed netcfg/dhcp_failed note
#preseed netcfg/dhcp_options select Configure network manually

# Static network configuration.
preseed netcfg/get_nameservers string unassigned-nameserver
#preseed netcfg/get_ipaddress string 10.10.10.10
#d-i netcfg/get_netmask string 255.255.255.0
#d-i netcfg/get_gateway string 192.168.1.1
#d-i netcfg/confirm_static boolean true

# To set a different link detection timeout (default is 3 seconds).
# Values are interpreted as seconds.
#preseed netcfg/link_wait_timeout string 10

# Use an option only available via preseed to tell
# Ubuntu's installer not to make a non-root user during install
preseed passwd/make-user boolean true

# Any hostname and domain names assigned from dhcp take precedence over
# values set here. However, setting the values still prevents the questions
# from being shown, even if values come from dhcp.
preseed netcfg/get_hostname string unassigned-hostname
preseed netcfg/get_domain string unassigned-domain

### Network console
# Use the following settings if you wish to make use of the network-console
# component for remote installation over SSH. This only makes sense if you
# intend to perform the remainder of the installation manually.
#preseed anna/choose_modules string network-console
#preseed network-console/authorized_keys_url string http://10.0.0.1/openssh-key
#preseed network-console/password password r00tme
#preseed network-console/password-again password r00tme
# Use this instead if you prefer to use key-based authentication
#preseed network-console/authorized_keys_url http://host/authorized_keys

### Mirror settings
# If you select ftp, the mirror/country string does not need to be set.
#preseed mirror/protocol string ftp
#preseed mirror/country string kr
#preseed mirror/http/hostname string archive.ubuntu.com
#preseed mirror/http/directory string /ubuntu
#preseed mirror/http/proxy string

# local repo settings
preseed mirror/country string manual
preseed mirror/http/hostname string 192.168.95.97:8080
preseed mirror/http/directory string /ubuntu

### Apt setup
# You can choose to install restricted and universe software, or to install
# software from the backports repository.
preseed apt-setup/restricted boolean false
preseed apt-setup/universe boolean false
preseed apt-setup/backports boolean false
# Uncomment this if you don't want to use a network mirror.
preseed apt-setup/use_mirror boolean false
# Select which update services to use; define the mirrors to be used.
# Values shown below are the normal defaults.
#d-i apt-setup/services-select multiselect security
#d-i apt-setup/security_host string security.ubuntu.com
#d-i apt-setup/security_path string /ubuntu

# Additional repositories, local[0-9] available
preseed apt-setup/local0/repository string \
       http://192.168.95.97:8080/ubuntu xenial main
preseed apt-setup/local0/comment string Xenial DVD files
# Enable deb-src lines
preseed apt-setup/local0/source boolean false
# URL to the public key of the local repository; you must provide a key or
# apt will complain about the unauthenticated repository and so the
# sources.list line will be left commented out
#d-i apt-setup/local0/key string http://local.server/key

# By default the installer requires that repositories be authenticated
# using a known gpg key. This setting can be used to disable that
# authentication. Warning: Insecure, not recommended.
preseed debian-installer/allow_unauthenticated boolean true

### Account setup
# Skip creation of a root account (normal user account will be able to
# use sudo). The default is false; preseed this to true if you want to set
# a root password.
#preseed passwd/root-login boolean false
# Alternatively, to skip creation of a normal user account.
#preseed passwd/make-user boolean false

# Root password, either in clear text
#preseed passwd/root-password password r00tme
#preseed passwd/root-password-again password r00tme
# or encrypted using a crypt(3)  hash.
#preseed passwd/root-password-crypted password [crypt(3) hash]

# To create a normal user account.
preseed passwd/user-fullname string Ubuntu User
preseed passwd/username string ubuntu
# Normal user's password, either in clear text
preseed passwd/user-password password growin
preseed passwd/user-password-again password growin
# or encrypted using a crypt(3) hash.
#d-i passwd/user-password-crypted password [crypt(3) hash]
# Create the first user with the specified UID instead of the default.
#d-i passwd/user-uid string 1010
# The installer will warn about weak passwords. If you are sure you know
# what you're doing and want to override it, uncomment this.
#d-i user-setup/allow-password-weak boolean true

# The user account will be added to some standard initial groups. To
# override that, use this.
#d-i passwd/user-default-groups string audio cdrom video

# Set to true if you want to encrypt the first user's home directory.
preseed user-setup/encrypt-home boolean false

### Clock and time zone setup
# Controls whether or not the hardware clock is set to UTC.
preseed clock-setup/utc boolean true

# You may set this to any valid setting for $TZ; see the contents of
# /usr/share/zoneinfo/ for valid values.
preseed time/zone string Asia/Seoul

# Controls whether to use NTP to set the clock during the install
d-i clock-setup/ntp boolean true
# NTP server to use. The default is almost always fine here.
#d-i clock-setup/ntp-server string ntp.example.com

### Partitioning
preseed partman-auto/disk string /dev/sda
preseed partman-auto/method string regular
#preseed partman-auto/method string lvm
preseed partman/default_filesystem string ext4
# This makes partman automatically partition without confirmation, provided
# that you told it what to do using one of the methods above.
preseed partman-partitioning/confirm_write_new_label boolean true
preseed partman/choose_partition select finish
preseed partman/confirm boolean true
preseed partman/confirm_nooverwrite boolean false

### Package selection
#preseed tasksel/first multiselect ubuntu-desktop
preseed tasksel/first multiselect ubuntu-server
#preseed tasksel/first multiselect lamp-server print-server


# Individual additional packages to install
preseed pkgsel/include string openssh-server build-essential
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
#d-i pkgsel/upgrade select none

# Check "Install any security updates automatically"
#preseed pkgsel/update-policy select unattended-upgrades

# This is fairly safe to set, it makes grub install automatically to the MBR
# if no other operating system is detected on the machine.
preseed grub-installer/only_debian boolean true

### Finishing up the installation
# During installations from serial console, the regular virtual consoles
# (VT1-VT6) are normally disabled in /etc/inittab. Uncomment the next
# line to prevent this.
#d-i finish-install/keep-consoles boolean true

# Avoid that last message about the install being complete.
preseed finish-install/reboot_in_progress note

# This is how to make the installer shutdown when finished, but not
# reboot into the installed system.
#d-i debian-installer/exit/halt boolean true
# This will power off the machine instead of just halting it.
#d-i debian-installer/exit/poweroff boolean true

##########################
# Normal Kickstart Syntax
##########################
# Configure authentication
#auth --useshadow --enablemd5

### Partitioning
# clearpart --initlabel --all
# zerombr
# part /boot       --fstype ext4 --size=512      --ondisk=sda --asprimary
# part swap                      --size=1024     --ondisk=sda --asprimary
# part /           --fstype ext4 --size=8192     --ondisk=sda --asprimary
# part /usr        --fstype ext4 --size=20480    --ondisk=sda
# part /usr/local  --fstype ext4 --size=30720    --ondisk=sda
# part /workspace  --fstype ext4 --size=2048     --ondisk=sda
# part /var        --fstype ext4 --size=18432    --ondisk=sda
# part /var/crash  --fstype ext4 --size=6144     --ondisk=sda
# part /home       --fstype ext4 --size=100      --ondisk=sda --grow