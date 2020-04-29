{pkgs, ...}:
{
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.dockerRegistry = {
    enable = true;
    enableDelete = true;
    enableGarbageCollect = true;
  };

  virtualisation.docker = {
    enable = true;
  };

  services.ntp.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.lightdm = {
      enable = true;
    };
    displayManager.sessionCommands = ''
      #${pkgs.stalonetray}/bin/stalonetray --parent-bg --kludges force_icons_size -i 24 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      ${pkgs.dropbox-cli}/bin/dropbox start &
    '';
    #windowManager.notion.enable = true;
    desktopManager.xfce = {
      enable = true;
      #enableXfwm = false;
      #noDesktop = true;
      thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
    };
  };
}
