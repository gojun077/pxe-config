PXE SERVER CONFIG FILES
=======================
This repo contains various config files including PXE
boot menu config files & kickstart files for unattended
installs over PXE boot. It does *not* contain
`/etc/dnsmasq.conf`, however, which contains PXE server
settings for dhcp, tftp boot, and detecting client
architectures (Legacy BIOS vs UEFI). dnsmasq.conf can
be found in my `jun-dotfiles` repo on github. 
