{config, pkgs, ...}:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixpkgs> {
        config = config.nixpkgs.config;
      };
      nur = import <nur> {
        inherit pkgs;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    adoptopenjdk-bin
    ant
    bat
    borgbackup
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
    htop
    inkscape
    irssi
    jbake
    unstable.jetbrains.idea-community
    libdvdcss
    libdvdnav
    libdvdread
    libnotify
    libreoffice
    lsof
    lynx
    nur.repos.moaxcp.micronaut
    minecraft
    mkpasswd
    mplayer
    multimc
    mysqlWorkbench
    netbeans
    networkmanagerapplet
    nixops
    nox
    obs-studio
    pidgin
    psmisc
    pwgen
    python
    python3
    python35Packages.youtube-dl
    python36Packages.xdot
    rxvt_unicode-with-plugins
    screen
    skypeforlinux
    #unstable.spring-boot
    tdesktop
    tmux
    travis
    tree
    unetbootin
    unzip
    usbutils
    utillinux
    virtualbox
    #vim config
    (pkgs.callPackages ./vim.nix {})
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
    zip
  ];
}
