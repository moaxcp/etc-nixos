{pkgs, ...}:

{
  services = {
    blueman.enable = true;
    openssh.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.epson-escpr2 ];
    thermald.enable = true;
    #ntp.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.xfce = {
        enable = true;
        thunarPlugins = [
          pkgs.xfce.thunar-archive-plugin
          pkgs.xfce.thunar-dropbox-plugin
          pkgs.xfce.thunar-volman
        ];
      };
    };
    picom = {
      enable = true;
      fade = true;
      inactiveOpacity = 0.9;
      shadow = true;
      fadeDelta = 4;
    };
  };
}
