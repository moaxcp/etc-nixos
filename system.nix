{config, pkgs, ...}:

{
  #nix.binaryCaches = [ http://n1:8080 https://cache.nixos.org ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "America/New_York";
  system.stateVersion = "20.03";
}
