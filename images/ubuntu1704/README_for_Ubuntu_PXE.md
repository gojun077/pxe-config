Ubuntu Kernel and initrd images
===============================

# Images for Desktop iso, netboot, and Server are all different

## Desktop
- Path on installation iso
  + `casper/`
- `vmlinuz.efi`
  + can be used with both UEFI and BIOS systems
- `initrd.lz`

## Netboot
- Path on installation iso
  + ...
- `linux`
  + different from desktop kernel
- `initrd.gz`
  - different from desktop initrd

## Server
- Path on installation iso
  + `install/netboot/ubuntu-installer/amd64/`
- `linux`
  + different from desktop kernel
- `initrd.gz`
  - different from desktop initrd
