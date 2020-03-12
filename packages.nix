{config, pkgs, ...}:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
      nur = import <nur> {
        inherit pkgs;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    borgbackup
    glxinfo
    git
    htop
    unstable.jetbrains.idea-community
    lsof
    nixops
    nox
    psmisc
    tree
    unetbootin
    unzip
    usbutils
    utillinux
    #vim config
    (pkgs.callPackages ./vim.nix {})
    zip
/*
    # user packages
    adoptopenjdk-bin
    ant
    bat
    cachix
    chromium
    curl
    dropbox-cli
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
    minecraft
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
    */
  ];
}
