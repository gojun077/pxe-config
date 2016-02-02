PXE SERVER CONFIG FILES
=======================
This repo contains various config files including PXE
boot menu config files & kickstart files for unattended
installs over PXE boot. It does *not* contain
`/etc/dnsmasq.conf`, however, which contains PXE server
settings for dhcp, tftp boot, and detecting client
architectures (Legacy BIOS vs UEFI). *dnsmasq.conf* can
be found in my *gojun077/jun-dotfiles* repo on github.

**NOTE 2016-02-02:**
- I have defined my *tftp-root* path to be:
  `/usr/local/tftpboot/pxelinux`
- I use CentOS 7's `bootx64.efi` and `grubx64.efi` so
  this repo includes the following paths:
  + *tftp-root*/`grub.cfg`
  + BACKUP LOCATION for grub config: *tftp-root*`/EFI/BOOT/grub.cfg`
  + *tftp-root*`/uefi/bootx64.efi` (specified in `dnsmasq.conf`)
  + *tftp-root*`/grubx64.efi`
