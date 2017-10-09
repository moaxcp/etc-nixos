# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./package-upgrades.nix
      ./bash.nix
      ./user/john.nix
    ];

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.extraModprobeConfig = "options nvidia-drm modeset=1";
  #boot.initrd.kernelModules = [
  #  "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"
  #];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/md/1";
      preLVM = true;
    }
    {
      name = "data";
      device = "/dev/sdc";
      preLVM = true;
    }
  ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.devices = [ "/dev/sda" "/dev/sdb" ]; # or "nodev" for efi only

  # boot.loader.grub.extraPerEntryConfig = "acpi=force";

  boot.initrd.mdadmConf = ''
    DEVICE /dev/sda1 /dev/sdb1
    DEVICE /dev/sda2 /dev/sdb2
    ARRAY /dev/md/0 metadata=1.2 UUID=2a7ffaec:fd80f34a:48cebc26:5caf521c name=g1:0
    ARRAY /dev/md/1 metadata=1.2 UUID=70e06d78:4e14590a:a4e13279:9e6e387f name=g1:1
  '';

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/0e9d6f15-288d-4071-8cd0-4c8437450938";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [ terminus_font terminus_font_ttf ];
  fonts.enableDefaultFonts = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
    chromium
    curl
    dropbox
    firefox
    gnome3.gedit
    git
    gitAndTools.gitflow
    gnome_mplayer
    gnupg
    gradle
    groovy
    htop
    inkscape
    irssi
    jetbrains.idea-community
    libnotify
    libreoffice
    lsof
    lynx
    mplayer
    networkmanagerapplet
    nixops
    notion
    nox
    nix-repl
    obnam
    openjdk
    pidgin
    psmisc
    pwgen
    python
    python3
    python35Packages.youtube-dl
    screen
    stalonetray
    tmux
    travis
    tree
    unzip
    utillinux
    vim
    virtualbox
    visualvm
    vlc
    xbindkeys
    xfce.xfce4notifyd
    xfontsel
    xorg.appres
    xorg.xclock
    xorg.xev
    xorg.xmodmap
    zip
  ];

  networking.hostName = "n1";
  #networking.wireless.enable = true;
  #networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  systemd.services.obnam = {
    description = "system backup with obnam";
    script = "PATH=${pkgs.obnam}/bin:${pkgs.coreutils}/bin ${pkgs.stdenv.shell} ${./obnam.sh}";
  };

  systemd.timers.obnam = {
    description = "run obnam every day";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  environment.etc."obnam.conf" = {
    enable = true;
    text = ''
      [config]
      repository = /data/obnam/all
      client-name = n1
      root = /
      one-file-system = yes
      exclude = /data
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wlp3s0";
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    synaptics.enable = true;
    displayManager.slim.enable = true;
    displayManager.sessionCommands = ''
      ${pkgs.stalonetray}/bin/stalonetray --parent-bg --kludges force_icons_size -i 24 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      ${pkgs.dropbox}/bin/dropbox &      
    '';
    windowManager.notion.enable = true;
    desktopManager.xfce = {
      enable = true;
      enableXfwm = false;
      noDesktop = true;
    };
    #videoDrivers = [ "nvidia" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  programs.java.enable = true;

  programs.fish = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
