# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./user/john.nix
    ];

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
   environment.systemPackages = with pkgs; let pkgsUnstable = import (
     fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
   ) { }; in [
    obnam
    curl
    htop
    lsof
    psmisc
    pwgen
    tmux
    screen
    tree
    unzip
    zip
    utillinux
    vim
    lynx
    libnotify
    xorg.appres
    xfce.xfce4notifyd
    pkgsUnstable.notion
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
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  programs.java.enable = true;
  programs.bash = {
    enableCompletion = true;
    promptInit = ''
      #change PS1 to use colors and optimize space used. PS1 will show status of previous command.
      set_prompt () {
        Last_Command=$? # Must come first!
        Blue='\[\e[01;34m\]'
        White='\[\e[01;37m\]'
        Red='\[\e[01;31m\]'
        Green='\[\e[01;32m\]'
        Reset='\[\e[00m\]'
        FancyX='-'
        Checkmark='+'

        # Add a bright white exit status for the last command
        PS1="$White\$? "
        # If it was successful, print a green check mark. Otherwise, print
        # a red X.
        if [[ $Last_Command == 0 ]]; then
            PS1+="$Green$Checkmark "
        else
            PS1+="$Red$FancyX "
        fi
        # If root, just print the host in red. Otherwise, print the current user
        # and host in green.
        if [[ $EUID == 0 ]]; then
            PS1+="$Red\\h "
        else
            PS1+="$Green\\u@\\h "
        fi
        # Print the working directory and prompt marker in blue, and reset
        # the text color to the default.
        PS1+="$Blue\\W \\\$$Reset "
      }
      export HISTCONTROL=ignoredups:erasedups
      export HISTSIZE=10000
      export HISTFILESIZE=100000
      shopt -s histappend
      export PROMPT_COMMAND="history -a; history -c; history -r; set_prompt; $PROMPT_COMMAND"
    '';
  };
  programs.fish = {
    enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
