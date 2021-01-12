{...}:
{
  users.extraGroups.john.gid = 1000;
  users.users.john = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/john";
    group = "john";
    extraGroups = [ "users" "wheel" "video" ];
  };
  imports = [ <home-manager/nixos> ];
  home-manager.users.john = {config, pkgs, ... }:
  let
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    nur = import <nur> { inherit pkgs; };
  in {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      nur.repos.moaxcp.overlays.use-moaxcp-nur-packages
      nur.repos.moaxcp.overlays.use-latest
    ];
    home.sessionPath = [
        ".npm-packages/bin"
    ];
    home.packages = with pkgs; let
      adoptopenjdk-hotspot-bin-11-low = adoptopenjdk-hotspot-bin-11.overrideAttrs(oldAttrs: {
        meta.priority = 10;
      });
    in [
      adoptopenjdk-bin
      adoptopenjdk-hotspot-bin-11-low
      ant
      bat
      cachix
      curl
      dropbox-cli
      gimp
      gnome_mplayer
      gnupg
      gradle
      graphviz
      groovy
      inkscape
      jbake
      jbang-0_58_0
      unstable.jetbrains.idea-community
      libdvdcss
      libdvdnav
      libdvdread
      libnotify
      libreoffice
      lynx
      micronaut-cli
      unstable.minecraft
      mkpasswd
      mplayer
      netbeans
      networkmanagerapplet
      nodejs-14_x
      nodePackages.vue-cli
      unstable.niv
      obs-studio
      pdfmod
      python3
      python37Packages.pip
      yarn
      youtube-dl
      python36Packages.xdot
      screen
      skypeforlinux
      tdesktop
      travis
      virtualbox
      visualvm
      vlc
      vscode
      wget
      xarchiver
      xbindkeys
      xdotool
      xfontsel
      xorg.appres
      xorg.xclock
      xorg.xev
      xorg.xmodmap
      xterm 
    ];
  };
}
