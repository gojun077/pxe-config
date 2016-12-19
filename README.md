PXE SERVER CONFIG FILES
=======================

Last updated 2016-07-10
Jun Go gojun077@gmail.com

This repo contains various config files including PXE
boot menu configs, kickstart files, and Debian-Installer
preseed files for unattended installs over PXE netboot.
It does *not* contain `/etc/dnsmasq.conf`, however, which
contains PXE server settings for dhcp, tftp boot, and detecting
client architectures (Legacy BIOS or UEFI). *dnsmasq.conf* can
be found in my *gojun077/jun-dotfiles* repo on github.

# PATHS
- I have defined my *tftp-root* path to be:
  `/usr/local/tftpboot/pxelinux`
- I use CentOS 7's `bootx64.efi` and `grubx64.efi` so
  this repo includes the following paths:
  + *tftp-root*/`grub.cfg`
  + BACKUP LOCATION for grub config: *tftp-root*`/EFI/BOOT/grub.cfg`
  + *tftp-root*`/uefi/bootx64.efi` (specified in `dnsmasq.conf`)
  + *tftp-root*`/grubx64.efi`
- Note: you must copy all the syslinux .c32 files, boot roms
  such as pxelinux.0, etc into ../pxelinux for BIOS pxe netbooting
  to work

# location of netboot kernels and initial ramdisk images
- Ubuntu: the path to netboot kernels and initrd in the ISO is
  `/ubuntu/install/netboot/ubuntu-installer/amd64`
  Copy `linux` and `initrd.gz` to the appropriate /images/...
  subdirectory in your *tftp-root*
- Fedora: path to netboot kernels and initrd in the ISO:
  `/images/pxeboot{vmlinuz,initrd.img}`
  Copy these files to the appropriate /images/... subdir
  in your */tfpt-root*

# Setting up the PXE server directory
1. `git clone` this repository into some directory owned by localuser
   I clone the pxe-config repo into `/usr/local/tftpboot/pxelinux`
   but use whatever directory names you're used to. This directory
   will be your *tftp-root* directory
2. Copy syslinux boot images into your *tftp-root*
   * Fedora
     - `dnf install syslinux`
     - cp /usr/share/syslinux/{pxelinux.0,\
       vesamenu.c32,ldlinux.c32,libcom32.c32,\
       libutil.c32} /path/to/tftp/root
3. Create *tftp-root* subdir's
   * images - kernel and initrd files from installation iso's
   * images/{foo1,foo2} - where *foo* is the name of some OS whose
     kernel and initial ramdisk images you will store in the sub-dir

# Running a PXE server
- PXE server launch environment in GNU Screen
  clone my bin files repository and use `screen_pxe.sh`
  https://gojun077@bitbucket.org/gojun077/bin-scripts.git
- dnsmasq config file for dhcp, dns, tftp used during PXE
  clone my dotfiles repository and refer to the file `dnsmasq`
  https://github.com/gojun077/jun-dotfiles.git
