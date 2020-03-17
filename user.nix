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
  
  home-manager.users.john = { config, pkgs, ... }:
  let
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    nur = import <nur> { inherit pkgs; };
  in {
    nixpkgs.overlays = [
      nur.repos.moaxcp.overlays.use-adoptopenjdk11
    ];
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      nur.repos.moaxcp.adoptopenjdk-hotspot-bin-14-nightly
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
      nur.repos.moaxcp.micronaut-1_3_3
      unstable.minecraft
      mkpasswd
      mplayer
      multimc
      netbeans
      networkmanagerapplet
      unstable.niv
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
    services.lorri.enable = true;

    programs.bash = {
      enable = true;
      historyControl = ["ignoredups" "erasedups" ];
      historyFileSize = 100000;
      historySize = 10000;
      shellOptions = [ "histappend" ];
      initExtra = ''
        #change PS1 to use colors and optimize space used. PS1 will show status of previous command.
        set_prompt () {
          if [[ "$?" == 0 ]]; then
            PS1=""
          else
            PS1="\[\e[01;31m\]($?) "
          fi
          PS1+="\[\e[01;;34m\]\\\$\[\e[00m\] "
        }
        export PROMPT_COMMAND="set_prompt; history -a; history -c; history -r;"
        eval "$(direnv hook bash)"
      '';
    };
  };

