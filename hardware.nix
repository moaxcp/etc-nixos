{config, lib, pkgs, ...}:

{
  sound.enable = true;
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.enableRedistributableFirmware = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 34816;
    }
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/efb2c8a0-169b-4d4f-b09f-f656f617a49e";
  boot.kernelParams = [ "resume_offset=21317632" ];
}
