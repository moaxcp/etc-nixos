{...}:
{
  users.extraGroups.john.gid = 1000;
  users.extraUsers.john = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/john";
    group = "john";
    extraGroups = [ "users" "wheel" "networkmanager" "audio" ];
  };
  
  home-manager.users.john = { config, pkgs, ... }: {
    services.lorri.enable = true;
    nixpkgs.config.allowUnfree = true;
    home.packages = let
        unstable = import <nixos-unstable> {config = config.nixpkgs.config; };
        nur = import <nur> { inherit pkgs; };
      in with pkgs; [
      adoptopenjdk-bin
      ant
      bat
      cachix
      chromium
      curl
      dropbox-cli
      direnv
      gimp
      git
      glxinfo
      gnome_mplayer
      gnupg
      gradle
      graphviz
      groovy
      jbake
      unstable.jetbrains.idea-community
      libdvdcss
      libdvdnav
      libdvdread
      libnotify
      libreoffice
      lynx
      nur.repos.moaxcp.micronaut
      unstable.minecraft
      mkpasswd
      mplayer
      multimc
      netbeans
      networkmanagerapplet
      obs-studio
      python
      python3
      python35Packages.youtube-dl
      python36Packages.xdot
      screen
      skypeforlinux
      tdesktop
      travis
      virtualbox
      visualvm
      vlc
      wget
      xarchiver
      xbindkeys
      xfontsel
      xorg.appres
      xorg.xclock
      xorg.xev
      xorg.xmodmap
      xterm
    ];
    programs.bash.enable = true;
  };
  
}
