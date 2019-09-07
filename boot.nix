{...}:
{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.devices = ["/dev/sda" "/dev/sdb"]; # or "nodev" for efi only

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/md1";
      preLVM = true;
    }
    {
      name = "data";
      device = "/dev/sdc";
      preLVM = true;
    }
  ];

  boot.initrd.mdadmConf = ''
    DEVICE /dev/sda1 /dev/sdb1
    DEVICE /dev/sda2 /dev/sdb2

    ARRAY /dev/md0 metadata=1.2 name=nixos:0 UUID=a1f472ab:0b07dbfe:e6a53ac5:476e93fd
    ARRAY /dev/md1 metadata=1.2 name=nixos:1 UUID=b9d4a793:ff94bc55:b5365d85:cdffdb3e
  '';

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/0e9d6f15-288d-4071-8cd0-4c8437450938";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
