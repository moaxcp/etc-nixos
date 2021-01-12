{pkgs, ...}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.useOSProber = true;
    };
  };
}
